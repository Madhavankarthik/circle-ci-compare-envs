#!/bin/sh -el

FILE_NAME=${1}
JOB_1_NAME=${2}
JOB_2_NAME=${3}

# Parse YAML file and extract environment variables
get_env_var_names() {
  yq eval '.jobs.'$1'.environment[] | keys' "$FILE_NAME"
}

compare_env_vars() {
  env_vars1=$(get_env_var_names "$JOB_1_NAME")
  env_vars2=$(get_env_var_names "$JOB_2_NAME")
  if [[ "$env_vars1" == "$env_vars2" ]]; then
    echo "Environment variables names for $JOB_1_NAME and $JOB_2_NAME are the same."
  else
    echo "Environment variables names for $JOB_1_NAME and $JOB_2_NAME are different."
    echo "Environment variables names for $JOB_1_NAME: $env_vars1"
    echo "Environment variables names for $JOB_2_NAME: $env_vars2"
    exit 1
  fi
}

compare_env_vars