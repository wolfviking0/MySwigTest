SET(JAVASCRIPT_DIR ${CMAKE_CURRENT_BINARY_DIR}/gen/javascript/)

SET(BINDING ${JAVASCRIPT_DIR}/binding.gyp)

# Create directory
IF (EXISTS ${JAVASCRIPT_DIR})
    FILE(REMOVE_RECURSE ${JAVASCRIPT_DIR})
ENDIF()
FILE(MAKE_DIRECTORY ${JAVASCRIPT_DIR})

STRING(REPLACE "|" ";" SRCS ${SRCS})
STRING(REPLACE "|" ";" INCS ${INCS})

SET(BINDING_GYP
"{
    \"targets\":
    [
        {
            \"target_name\": \"MySwig\",
            \"cflags!\": [ \"-fno-exceptions\" ],
            \"cflags_cc!\": [ \"-fno-exceptions\" ],
            \"sources\":
            [
")


FOREACH(FIL ${SRCS})

    GET_FILENAME_COMPONENT(DEP_NAME ${FIL} NAME)

    EXECUTE_PROCESS (
        COMMAND ${CMAKE_COMMAND} -E copy ${FIL} ${DEP_NAME}
        WORKING_DIRECTORY ${JAVASCRIPT_DIR}
    )

    SET(BINDING_GYP
        "${BINDING_GYP}\"${DEP_NAME}\",\n"
    )
ENDFOREACH()

SET(BINDING_GYP
"${BINDING_GYP}            ],
            \"include_dirs\":
            [
")

FOREACH(FIL ${INCS})
    SET(BINDING_GYP
        "${BINDING_GYP}\"${FIL}\",\n"
    )
ENDFOREACH()

SET(BINDING_GYP
"${BINDING_GYP}            ],
            \"libraries\":
            [
")

FOREACH(FIL ${LIBS})
    SET(BINDING_GYP
        "${BINDING_GYP}\"${FIL}\",\n"
    )
ENDFOREACH()

SET(BINDING_GYP
"${BINDING_GYP}            ],
            \"conditions\":
            [
                [
                    \"OS=='mac'\", {
                        \"xcode_settings\": {
                            \"GCC_ENABLE_CPP_EXCEPTIONS\": \"YES\"
                        }
                    }
                ]
            ]
        }
    ]
}"
)

FILE(WRITE ${BINDING} ${BINDING_GYP})

EXECUTE_PROCESS (
    COMMAND npm install -g node-gyp
    WORKING_DIRECTORY ${JAVASCRIPT_DIR}
)

EXECUTE_PROCESS (
    COMMAND node-gyp configure
    WORKING_DIRECTORY ${JAVASCRIPT_DIR}
)

EXECUTE_PROCESS (
    COMMAND node-gyp build
    WORKING_DIRECTORY ${JAVASCRIPT_DIR}
)

EXECUTE_PROCESS (
    COMMAND ${CMAKE_COMMAND} -E copy ${JAVASCRIPT_DIR}/build/Release/MySwig.node MySwig.node
    WORKING_DIRECTORY ${OUTPUT_DIR}
)
