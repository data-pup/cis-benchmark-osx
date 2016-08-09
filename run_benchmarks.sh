#!/bin/bash

# This script is based on the CIS Security Benchmarks for OS X 10.11.
# It will print out different information, as well as the expected
# output. If the output does not match, use the remedial command listed.
# Note that this script was written using Benchmark v.1.0.0.

# Print a header:
echo "Performing security audit...\n\n"

# TODO: Invoke scripts...
source benchmark_section_1.sh
source benchmark_section_2.sh
source benchmark_section_3.sh
source benchmark_section_4.sh
source benchmark_section_5.sh
source benchmark_section_6.sh
