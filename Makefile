BUILD_DIR 	= 	build 

.PHONY: all clean

all:
	mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR} && cmake -DCMAKE_TOOLCHAIN_FILE=STM32F427xx.cmake .. && make -j && cd ..

clean:
	rm -rf ${BUILD_DIR}
