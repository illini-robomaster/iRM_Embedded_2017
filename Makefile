BUILD_DIR = build
TOOLCHAIN_FILE = STM32F427xx.cmake
DEBUG ?= 0
ifneq ($(DEBUG), 0)
    DEBUG_FLAG = -DDEBUG=ON
    FILE_NAME_DEBUG = _debug
endif

.PHONY: clean how remake cmake infantry1 infantry2 infantry3

# Rules to create all
all: infantry1 infantry2 infantry3 engineering

# Rules to create each robot and inject macros.
# Do not forget to add cooresponding macros to rm_config.h and CMakeLists.txt
infantry1: ROBOT = -DINFANTRY1=ON
infantry1: FILE_NAME = Infantry1
infantry1: cmake

infantry2: ROBOT = -DINFANTRY2=ON
infantry2: FILE_NAME = Infantry2
infantry2: cmake

infantry3: ROBOT = -DINFANTRY3=ON
infantry3: FILE_NAME = Infantry3
infantry3: cmake

engineering: ROBOT = -DENGINEERING=ON
engineering: FILE_NAME = Engineering
engineering: cmake

# Rules to clean
clean:
	rm -rf ${BUILD_DIR}
	rm -f *.elf
	rm -f *.bin

# Rules to display helper
how:
	@echo "Available targets:"
	@echo ""
	@echo "all: 		Build All Robot Images"
	@echo "infantry1: 	Build Infantry1.elf"
	@echo "infantry2: 	Build Infantry2.elf"
	@echo "infantry3: 	Build Infantry3.elf"
	@echo "engineering: 	Build Engineering.elf"
	@echo ""
	@echo "Add \"DEBUG=1\" to inject DEBUG macro"

# Rules to remake
remake: clean all

# Actual rule to make the targets
cmake:
	mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR} && cmake -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} ${ROBOT} ${DEBUG_FLAG} .. && make -j && mv iRM2018.bin ../${FILE_NAME}${FILE_NAME_DEBUG}.bin && cd ..
	@echo ""
	@echo "${FILE_NAME}${FILE_NAME_DEBUG}.bin created."
