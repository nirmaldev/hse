#!/bin/bash

ERROR_LOG="error.log"

# Function to compress the directory based on the compression algorithm
compress_backup() {
    DIR=$1
    COMPRESSION=$2
    OUTPUT=$3

    # Create the tar archive without compression
    tar -cf "$OUTPUT" "$DIR" 2>>error.log

    # Apply compression based on the specified option
    case $COMPRESSION in
        gzip) gzip "$OUTPUT" 2>>error.log ;;
        bzip2) bzip2 "$OUTPUT" 2>>error.log ;;
        xz) xz "$OUTPUT" 2>>error.log ;;
        none) echo "No compression applied." ;;
        *) echo "Unsupported compression: $COMPRESSION" >> error.log; exit 1 ;;
    esac
}

# Encrypt the backup file
encrypt_backup() {
    OUTPUT=$1

    # Encrypt using OpenSSL and provide passphrase non-interactively
    if [[ -f "$OUTPUT" ]]; then
        openssl enc -aes-256-cbc -salt -in "$OUTPUT" -out "${OUTPUT}.enc" -pass pass:your_passphrase 2>>error.log
        rm "$OUTPUT"
    else
        echo "Error: File $OUTPUT does not exist." >> error.log
        exit 1
    fi
}

# Check if file exists and prompt for overwrite
check_and_prompt() {
    FILE=$1
    if [[ -f "$FILE" ]]; then
        read -p "$FILE already exists. Overwrite? (y/n): " choice
        case "$choice" in
            y|Y) return 0 ;;
            n|N) echo "Operation aborted by user." ; exit 0 ;;
            *) echo "Invalid choice. Exiting." ; exit 1 ;;
        esac
    fi
}

# Main script execution
COMMAND=$1
shift

if [[ "$COMMAND" == "compress_backup" ]]; then
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -d) DIR="$2"; shift ;;
            -c) COMP="$2"; shift ;;
            -o) OUT="$2"; shift ;;
            *) echo "Invalid option: $1" >> error.log; exit 1 ;;
        esac
        shift
    done

    # Ensure the required arguments are provided
    if [[ -z "$DIR" || -z "$COMP" || -z "$OUT" ]]; then
        echo "Error: Missing required arguments." >> error.log
        exit 1
    fi

    # Check for existing output files
    check_and_prompt "$OUT"

    compress_backup "$DIR" "$COMP" "$OUT"
    encrypt_backup "$OUT"

elif [[ "$COMMAND" == "-h" || "$COMMAND" == "--help" ]]; then
    echo "Usage: $0 {compress_backup} -d DIRECTORY -c COMPRESSION -o OUTPUT"
    echo "Commands:"
    echo "  compress_backup    Compress and encrypt the directory"
    echo ""
    echo "Options:"
    echo "  -d DIRECTORY       Directory to back up"
    echo "  -c COMPRESSION     Compression algorithm (none, gzip, bzip2, xz)"
    echo "  -o OUTPUT          Output file name"
    exit 0
else
    echo "Unknown command: $COMMAND" >> error.log
    exit 1
fi
