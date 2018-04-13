/******************************************************************************
	Description
		STM32 TX2 protocol
    Log
		12/02/17  Jeff Ma      the thread to communicate with protocol
*******************************************************************************/
#include "taskProtocol.h"

uint16_t PRO_STATUS;

void SetProStatusIvalid(void){
    PRO_STATUS = STATUS_DATA_INVALID;
}
void SetProStatusValid(void){
    PRO_STATUS = STATUS_DATA_VALID;
}
uint16_t CheckProStatus(void){
    return PRO_STATUS;
}
/******************************************************************************
	Input:
	Output
	Description
		protocol task
	Log
		2018/04/08 Ke Sun
*******************************************************************************/
void StartProtocolTask(void const *argument) {
    uint32_t protocol_wake_time = osKernelSysTick();
    uint8_t f = 0;
    PRO_STATUS = STATUS_DATA_VALID;
    // for protocol initialiation
    protoInit();
    // protocol task formally start now!
    //RM_PRINTF("START PROTOCOL TASK!! \n\r");
    // This function should be called from gimbal.c
    // called here for debugging
    while(1){
        // check if there is a request to process
        if ( protoRequest() == REQUEST_SUCC ) {
            // if yes, then a request message should already
            // be sent to TX2 then should wait for valid data
            // to set to the
            f=0;
            SetProStatusIvalid();
            // here, first set the protocol data's status to be invalid
            // the interrupt-mode UART receiver should update the data
            // status to be valid again
        }
        //
        if(CheckProStatus()==STATUS_DATA_VALID && f==0) {
            RM_PRINTF("%u %u\t", Yaw_data, Pitch_data);
            f=1;
            // This function should be called from gimbal.c
            // called here for debugging
        }
        //
        osDelayUntil(&protocol_wake_time, 20);
    }
}