#!/bin/sh -el

FILE_NAME=${1}
JOB_1_NAME=${2}
JOB_2_NAME=${3}

# Parse YAML file and extract environment variables
get_env_var_names() {
  yq eval '.jobs.'$1'.environment[] | keys' .circleci/config.yml
}

# Compare environment variables
compare_env_vars() {
  # Get environment variables for job1
  env_vars1=$(get_env_var_names "$JOB_1_NAME")

  # Get environment variables for job2
  env_vars2=$(get_env_var_names "$JOB_2_NAME")

  # Compare environment variables
  if [[ "$env_vars1" == "$env_vars2" ]]; then
    echo "Environment variables names for $job1 and $job2 are the same."
  else
    echo "Environment variables names for $job1 and $job2 are different."
  fi
}

compare_env_vars