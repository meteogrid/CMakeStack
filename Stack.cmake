find_package (Stack 0.1.10.1 REQUIRED)

function (add_stack_build)
  set (oneValueArgs STACK_YAML)
  set (multiValueArgs EXECUTABLES DEPENDS STACK_ARGS)
  cmake_parse_arguments (arg "${flagArgs}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if (NOT arg_STACK_YAML)
    set(arg_STACK_YAML "stack.yaml")
  endif()
  get_filename_component(STACK_YAML ${arg_STACK_YAML} ABSOLUTE)

  foreach(executable ${arg_EXECUTABLES})
    set (output ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${executable}${CMAKE_EXECUTABLE_SUFFIX})
    add_custom_target (${executable} ALL DEPENDS ${PROJECT_NAME}_build)
    install (PROGRAMS ${output} DESTINATION bin)
  endforeach(executable)

  list (INSERT arg_STACK_ARGS 0
        --install-ghc
        --no-terminal
        --local-bin-path ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
        --stack-yaml ${STACK_YAML})

  list (APPEND arg_DEPENDS ${arg_STACK_YAML})
  add_custom_target (${PROJECT_NAME}_build
    COMMAND ${STACK_EXECUTABLE} install ${arg_STACK_ARGS}
    DEPENDS ${arg_DEPENDS})
endfunction()
