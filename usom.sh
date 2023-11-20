#!/bin/bash

# Define the working directory
CTI_DIR="/root/cti"

# Step 1: Change to the CTI directory
cd "$CTI_DIR" || exit 1

# Step 2: Download the URL list
wget -q https://www.usom.gov.tr/url-list.txt -O url-list.txt

# Step 3: Insert 'data' at the beginning of the file
sed -i '1 i\data' url-list.txt

# Step 4: Change to the QRadar bin directory
QRADAR_BIN_DIR="/opt/qradar/bin"
cd "$QRADAR_BIN_DIR" || exit 1

# Step 5: Purge existing data in QRadar
./ReferenceDataUtil.sh purge usom_url_list

# Step 6: Load the modified URL list into QRadar
./ReferenceDataUtil.sh load usom_url_list "$USOM_DIR/url-list.txt"

