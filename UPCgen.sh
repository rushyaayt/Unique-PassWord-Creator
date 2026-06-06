#!/bin/bash

# Unique password pattern generator with optional platform tag

echo "Enter any words (use + to separate multiple):"
read input

# Convert '+' to spaces
words=$(echo "$input" | tr '+' ' ')

# Ask for optional platform
echo "Enter the platform name (optional, press Enter to skip):"
read platform

# Create a random hash from words + current time
seed="${words}$(date +%s%N)$RANDOM"
hash=$(echo -n "$seed" | sha256sum | cut -c1-32)

# Break hash into chunks and insert random symbols
symbols="!@#$%^&*()-_=+[]{}<>?"
pattern=""
for chunk in $(echo $hash | fold -w4); do
    rand_symbol=$(echo $symbols | fold -w1 | shuf | head -n1)
    pattern+="${chunk}${rand_symbol}"
done

# Add platform tag if provided
if [ -n "$platform" ]; then
    pattern="${pattern}_${platform}"
fi

echo "Generated unique pattern:"
echo "$pattern"

# Optional: save to file
echo "$pattern" >> password_patterns.txt
echo "Pattern saved to password_patterns.txt"
