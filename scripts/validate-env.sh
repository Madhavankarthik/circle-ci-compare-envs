#!/bin/sh -el

FILE_NAME=${1}
JOB_1_NAME=${2}
JOB_2_ENV_NAME=${3}

# Parse YAML file and extract environment variables
get_env_var_names() {
  local file="$1"
  yq eval '.jobs.'$2'.environment[] | split(":")[0]' "$file"
}

# Compare environment variables
compare_env_vars() {
  local file="$1"
  local job1="$2"
  local job2="$3"

  # Get environment variables for job1
  env_vars1=$(get_env_var_names "$file" "$job1")

  # Get environment variables for job2
  env_vars2=$(get_env_var_names "$file" "$job2")

  # Compare environment variables
  if [[ "$env_vars1" == "$env_vars2" ]]; then
    echo "Environment variables names for $job1 and $job2 are the same."
  else
    echo "Environment variables names for $job1 and $job2 are different."
  fi
}

compare_env_vars "$FILE_NAME" "$JOB_1_NAME" "$JOB_2_ENV_NAME"