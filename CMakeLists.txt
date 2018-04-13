set(PRJ_NAME iRM2018)
set(MCU_FAMILY STM32F4xx)
set(MCU_LINE STM32F427xx)
set(MCU_LINKER_SCRIPT STM32F427IIHx_FLASH.ld)
SET(CMAKE_CXX_FLAGS -lm)

cmake_minimum_required(VERSION 3.6)

project(${PRJ_NAME} C ASM)

add_definitions(-D${MCU_LINE})
add_definitions(-DUSE_HAL_LIBRARY)

file(GLOB_RECURSE LIB_SOURCES
        Src/*.c
        Middlewares/Third_Party/FreeRTOS/Source/*.c
        Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS/cmsis_os.c
        Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.c
        Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.c
        Middlewares/Third_Party/FatFs/src/*.c
        Drivers/STM32F4xx_HAL_Driver/Src/*.c
        )

#file(GLOB_RECURSE USER_SOURCES ./Application/Src/*.c)
file(GLOB_RECURSE CMSIS_STARTUP startup/startup_stm32f427xx.s)

#set(SOURCE_FILES ${LIB_SOURCES} ${USER_SOURCES} ${CMSIS_STARTUP})
set(SOURCE_FILES ${LIB_SOURCES} ${CMSIS_STARTUP})

include_directories(Inc)
include_directories(Drivers/STM32F4xx_HAL_Driver/Inc)
include_directories(Drivers/STM32F4xx_HAL_Driver/Inc/Legacy)
include_directories(Drivers/STM32F4xx_HAL_Driver/)
include_directories(Drivers/CMSIS/Device/ST/STM32F4xx/Include)
include_directories(Drivers/CMSIS/Include)
include_directories(Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F)
include_directories(Middlewares/Third_Party/FreeRTOS/Source/include)
include_directories(Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS)
include_directories(Middlewares/Third_Party/FatFs/src/drivers)
include_directories(Middlewares/Third_Party/FatFs/src)
#include_directories(./Application/Inc)

add_executable(${PROJECT_NAME}.elf ${SOURCE_FILES})
target_link_libraries(${PROJECT_NAME}.elf m)

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-Map=${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.map")
set(HEX_FILE ${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.bin)
add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${HEX_FILE}
        COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${PROJECT_NAME}.elf> ${BIN_FILE}
        COMMENT "Building ${HEX_FILE} \nBuilding ${BIN_FILE}")
