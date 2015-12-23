include (FindPackageHandleStandardArgs)

find_program (STACK_EXECUTABLE stack PATH_SUFFIXES bin)

if (STACK_EXECUTABLE)
  execute_process (
    COMMAND "${STACK_EXECUTABLE}" --numeric-version
    OUTPUT_VARIABLE STACK_VERSION
      ERROR_QUIET)
  string (REGEX REPLACE "\n" "" STACK_VERSION "${STACK_VERSION}")
endif()

find_package_handle_standard_args (Stack
  "Couldn't find the required version of stack. See http://docs.haskellstack.org/en/stable/install_and_upgrade.html#ubuntu"
STACK_EXECUTABLE STACK_VERSION)

mark_as_advanced (STACK_EXECUTABLE)
