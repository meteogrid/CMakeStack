function (add_stack_build)
  set (oneValueArgs STACK_YAML)
  set (multiValueArgs EXECUTABLES DEPENDS)
  cmake_parse_arguments (arg "${flagArgs}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  set (OUTPUTS)
  foreach(executable ${arg_EXECUTABLES})
    set (output ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${executable}${CMAKE_EXECUTABLE_SUFFIX})
    list(APPEND OUTPUTS ${output})
    add_custom_target (${executable} ALL DEPENDS ${output})
    install (PROGRAMS ${output} DESTINATION bin)
  endforeach(executable)

  get_filename_component(STACK_YAML ${arg_STACK_YAML} ABSOLUTE)
  set (STACK_ARGS
        --install-ghc
        --no-terminal
        --local-bin-path ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
        --stack-yaml ${STACK_YAML})

  list (APPEND arg_DEPENDS ${arg_STACK_YAML})
  add_custom_command (
    COMMAND ${STACK_EXECUTABLE} ${STACK_ARGS} install
    DEPENDS ${arg_DEPENDS}
    OUTPUT ${OUTPUTS})
endfunction()
