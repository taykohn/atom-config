#!/bin/bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Taylor Kohn
#   file:      atom_setup.sh
#   created:   9/19/2018
#   version:   1.0
# -----------------------------------------------------------------------------
# Description:
#   Setup my preferred atom editor packages, keymap, snippets and configuration.
# Usage:
#   ./atom_setup.sh
# -----------------------------------------------------------------------------
# Script:

# Newlinw
newline(){
    printf "\n"
}

# Copy configuration files to atom directory
copy_config_files(){
  newline
  echo "--- Setting up config, keymap, and snippets files ---"
  cp -v config.cson keymap.cson snippets.cson ~/.atom
}

# Install packages listed in file
# @param $1 - text file containing list of packages
install_packages(){
  newline
  echo "--- Installing packages ---"
  while read package
  do
    echo "Installing: "
    echo "$package"
    apm install "$package"
  done < "$1"
}

# Get list of packages that aren't currently installed
# Store them in temp file
installed_vs_listed_packages(){
  # Get the list of currently installed packages
  tmp_current_packages=$(mktemp)
  # Create temp file listing currently installed packages (ignore README)
  ls ~/.atom/packages -I README.md > "$tmp_current_packages"

  # Sort the desired packages for comparison
  tmp_desired_packages=$(mktemp)
  < "$packages_list" sort > "$tmp_desired_packages"

  # Compare the list of currently installed packages with the list of desired packages
  tmp_to_be_installed=$(mktemp)

  # -3 suppresses lines that appear in both files
  # -1 suppresses lines that are unique to tmp_current_packages
  comm -13 "$tmp_current_packages" "$tmp_desired_packages" > "$tmp_to_be_installed"
}

main(){
  # File containing the names of the desired packages
  packages_list=packages.txt

  copy_config_files

  # Install only those packages listed in the text file that aren't
  # already installed
  installed_vs_listed_packages
  install_packages "$tmp_to_be_installed"
}

main

exit 0
