BUILD_DIR 	= 	build 

.PHONY: clean infantry list re

all: infantry

infantry:
	mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR} && cmake -DCMAKE_TOOLCHAIN_FILE=STM32F427xx.cmake .. && make -j && mv iRM2018.elf infantry.elf && cd ..
	

clean:
	rm -rf ${BUILD_DIR}

list:
	@echo "available target"
	@echo ""
	@echo "all: 		infantry + ..."
	@echo "infantry: 	build infantry elf"

re: clean all
