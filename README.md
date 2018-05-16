# Illini RoboMaster Embedded Control

This repository hosted low level hardware protocol & control algrithms implemented with STM32F427 embedded platform.

## Git Usage Rule
* Always **`pull`** first!!!
* Communicate before modifying codes with a marked author.
* Open a new branch or directory if you want to make significant changes.
* You can use command line to manage your code. Or, you can use [Github Desktop](https://desktop.github.com/), which will be easier to manage if you don't have any previous git experience.
* Don't `push` any file larger than **5Mb**. You should create / add `gitignore` for the large files stored in your local repository. If you don't know or are not sure about how `gitignore` works, consult Alvin Sun or Nickel Liang.

## Important File Structure

* [Applications](https://github.com/NickelLiang/iRM_Embedded/tree/master/Applications) - User Level Codes

* [STM32F427xx.cmake](https://github.com/NickelLiang/iRM_Embedded/blob/master/STM32F427xx.cmake) - CMake Toolchain File

* iRM_Embedded.ioc - Hardware Pin Definition Generated From STM32CubeMX

* HAL / Driver Level Libs - Should NOT Be Modified
	* Inc / Src - Header & source files for HAL libraries
	* Middlewares - FreeRTOS, FatFS, and other 3rd party libraries
	* Drivers - Low Level Drivers

## IDE Choices
* CLion - recommanded for under experienced coder
	- [x] CMake Integration
	- [x] Auto Completion

* vim - recommended by Alvin. Mouse free editing experience helps achieve maximum productivity
	- [ ] CMake Integration
	- [x] Auto Completion

* atom / sublime text / VSCode / etc - suit yourself
	- [ ] CMake Integration
	- [ ] Auto Completion

## Dependency
* Unix Based Environment - MacOS / Linux

* Build Essentials
	* Cmake 3.11.0 or higher
	* ARM Toolchain

* [stlink](https://github.com/texane/stlink) - optional for single command flashing

* [OpenOCD]() - optional for debug purposes

## Tutorials
* [How to install ARM Toolchain](https://github.com/NickelLiang/iRM_Embedded/tree/master/tutorials/ARM_TOOLCHAIN.md)
* [How to compile the code](https://github.com/NickelLiang/iRM_Embedded/tree/master/tutorials/COMPILE.md)
* [How to flash binary files onto the micro controller](https://github.com/NickelLiang/iRM_Embedded/tree/master/tutorials/FLASH.md)
* [How to use gbd with on chip debugger](https://github.com/NickelLiang/iRM_Embedded/tree/master/tutorials/DEBUG.md)
