set(PRJ_NAME iRM2018)
set(MCU_FAMILY STM32F4xx)
set(MCU_LINE STM32F427xx)
set(MCU_LINKER_SCRIPT STM32F427IIHx_FLASH.ld)
set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
set(CMAKE_CXX_FLAGS -lm)

cmake_minimum_required(VERSION 3.6)

project(${PRJ_NAME} C ASM)

add_definitions(-D${MCU_LINE})
add_definitions(-DUSE_HAL_LIBRARY)

option(INFANTRY1 "Set to generate infantry1 image" OFF)
option(INFANTRY2 "Set to generate infantry2 image" OFF)
option(INFANTRY3 "Set to generate infantry3 image" OFF)
option(ENGINEERING "Set to generate engineering image" OFF)
option(DEBUG "Set to ON to show debug information" OFF)

file(GLOB_RECURSE LIB_SOURCES
        Src/*.c
        Middlewares/Third_Party/FreeRTOS/Source/*.c
        Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS/cmsis_os.c
        Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.c
        Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.c
        Middlewares/Third_Party/FatFs/src/*.c
        Drivers/STM32F4xx_HAL_Driver/Src/*.c
        )

file(GLOB_RECURSE USER_SOURCES Applications/Libraries/pid.c)
file(GLOB_RECURSE USER_SOURCES_BSP Applications/BSP/*.c)
file(GLOB_RECURSE CMSIS_STARTUP startup/startup_stm32f427xx.s)

set(SOURCE_FILES ${LIB_SOURCES} ${USER_SOURCES} ${USER_SOURCES_BSP} ${CMSIS_STARTUP})
#set(SOURCE_FILES ${LIB_SOURCES} ${CMSIS_STARTUP})

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
include_directories(Applications)
include_directories(Applications/BSP)
include_directories(Applications/Libraries)
include_directories(Applications/Tasks)

add_executable(${PROJECT_NAME}.elf ${SOURCE_FILES})
target_link_libraries(${PROJECT_NAME}.elf m)

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-Map=${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.map")
set(HEX_FILE ${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.bin)
add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
        COMMAND arm-none-eabi-objcopy -Oihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${HEX_FILE}
        COMMAND arm-none-eabi-objcopy -Obinary $<TARGET_FILE:${PROJECT_NAME}.elf> ${BIN_FILE}
        COMMENT "Building ${HEX_FILE} \nBuilding ${BIN_FILE}")

if (INFANTRY1)
    add_definitions(-DINFANTRY1)
endif()

if (INFANTRY2)
    add_definitions(-DINFANTRY2)
endif()

if (INFANTRY3)
    add_definitions(-DINFANTRY3)
endif()

if (ENGINEERING)
    add_definitions(-DENGINEERING)
endif()

if (DEBUG)
    add_definitions(-DDEBUG)
endif()
