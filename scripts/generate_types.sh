#!/bin/bash
set -e

# Ensure we are in the sdk root or handle paths correctly
# This script assumes it's run from the cli/elixir-sdk directory or we can find the schema relative to it.

SCHEMA_PATH="../../apps/docs/public/api-reference.json"
TEMP_DIR=".openapi-temp"
TYPES_OUTPUT_DIR="lib/unsent/model"

echo "Generating Elixir types from ${SCHEMA_PATH}..."

# check if schema exists
if [ ! -f "$SCHEMA_PATH" ]; then
    echo "Error: Schema file not found at $SCHEMA_PATH"
    exit 1
fi

# Check if pnpm is available
if ! command -v pnpm &> /dev/null; then
    echo "Error: pnpm not found. Please install Node.js and pnpm."
    exit 1
fi

# Clean up temp directory if it exists
rm -rf "$TEMP_DIR"

# Generate Elixir client using openapi-generator-cli to temp directory
# We only want the models
pnpm dlx @openapitools/openapi-generator-cli generate \
  -i "$SCHEMA_PATH" \
  -g elixir \
  -o "$TEMP_DIR" \
  --global-property models,modelDocs=false,modelTests=false \
  --additional-properties=packageName=unsent,moduleName=Unsent

# Clean output dir
rm -rf "$TYPES_OUTPUT_DIR"
mkdir -p "$TYPES_OUTPUT_DIR"

# Copy generated models
if [ -d "$TEMP_DIR/lib/unsent/model" ]; then
    cp -r "$TEMP_DIR/lib/unsent/model/"* "$TYPES_OUTPUT_DIR/"
else
    echo "Warning: Could not find generated models in expected locations. checking $TEMP_DIR"
    find "$TEMP_DIR" -maxdepth 4
fi

# Cleanup
rm -rf "$TEMP_DIR"

echo ""
echo "✓ Types generated at ${TYPES_OUTPUT_DIR}"
