#!/bin/bash

# This test file will be executed against after building a container with the
# 'my_favorite_color_is_green' scenario in 'test/test/color/scenarios.json'.
#
# For more information, see: https://github.com/devcontainers/cli/blob/main/docs/features/test.md
#
# This scenario first uses the 'common-utils' Features to add a new user 'octocat'. 
# It then installs the 'color' Feature with the FAVORITE option set to 'green' (the default FAVORITE value if none provided is 'red').
#
# 
# This test (as well as any of the other scenarios in 'scenarios.json') can be run with the following command:
#
#    devcontainer features test \ 
#               --features color \
#               --skip-autogenerated \
#               /path/to/this/repo

set -e

# Optional: Import test library bundled with the devcontainer CLI
# Provides the 'check' and 'reportResults' commands.
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "validate favorite color" color | grep 'my favorite color is green'

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
