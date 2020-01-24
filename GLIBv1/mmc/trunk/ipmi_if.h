//*****************************************************************************
// Copyright (C) 2007 DESY(Deutsches-Elektronen Synchrotron) 
//
// File Name	: ipmi_if.h
// 
// Title		: IPMI interface header file
// Revision		: 1.1
// Notes		:	
// Target MCU	: Atmel AVR series
//
// Author       : Vahan Petrosyan (vahan_petrosyan@desy.de)
// Modified by  : Markus Joos (markus.joos@cern.ch)
//
// Description : IPMI interface general definitions and structures
//					
//
// This code is distributed under the GNU Public License
//		which can be found at http://www.gnu.org/licenses/gpl.txt
//*****************************************************************************

#ifndef _IPMI_IF_H
#define _IPMI_IF_H

#include "avrlibtypes.h"


// Constants
#define IPMC_ADDRESS	   0x20   // carrier's slave address
#define BUFFER_LENGTH      32
//#define MAX_IPMI_DATA_SIZE 0x20   // MJ: not used??

//three states of pins
#define GROUNDED 0
#define POWERED 1
#define UNCONNECTED 2

//Types
typedef struct buffer
{
    u08 Buffer[BUFFER_LENGTH];
    u08 Length;
} LocalBuffer;

// A raw IPMI message without any addressing.  This covers both
// commands and responses.  The completion code is always the first
// byte of data in the response (as the spec shows the messages laid
// out).

typedef struct ipmi_msg
{
    u08 netfn;
    u08 lun;
    u08 cmd;
    u16 data_len;
    u08 data[25];
} ipmi_msg_t;

typedef struct status
{
    u08 ipmb_rqs :1;
    u08 event :1;
    u08 event_pending :1;
    u08 connected :1;
} ipmi_status;

//typedef struct ipmi_event   // MJ: not used
//{
//    u08 sensor_type;
//    u08 sensor_number;
//    u08 event_dir;
//    u08 event_data;
//} ipmi_event_msg;


// IPMI commands
// Chassis netfn (0x00)
#define IPMI_GET_CHASSIS_CAPABILITIES_CMD	                    0x00
#define IPMI_GET_CHASSIS_STATUS_CMD		                        0x01
#define IPMI_CHASSIS_CONTROL_CMD		                        0x02
#define IPMI_CHASSIS_RESET_CMD			                        0x03
#define IPMI_CHASSIS_IDENTIFY_CMD		                        0x04
#define IPMI_SET_CHASSIS_CAPABILITIES_CMD	                    0x05
#define IPMI_SET_POWER_RESTORE_POLICY_CMD	                    0x06
#define IPMI_GET_SYSTEM_RESTART_CAUSE_CMD	                    0x07
#define IPMI_SET_SYSTEM_BOOT_OPTIONS_CMD	                    0x08
#define IPMI_GET_SYSTEM_BOOT_OPTIONS_CMD	                    0x09
#define IPMI_GET_POH_COUNTER_CMD		                        0x0f

// Bridge netfn (0x00)
#define IPMI_GET_BRIDGE_STATE_CMD		                        0x00
#define IPMI_SET_BRIDGE_STATE_CMD		                        0x01
#define IPMI_GET_ICMB_ADDRESS_CMD		                        0x02
#define IPMI_SET_ICMB_ADDRESS_CMD		                        0x03
#define IPMI_SET_BRIDGE_PROXY_ADDRESS_CMD	                    0x04
#define IPMI_GET_BRIDGE_STATISTICS_CMD		                    0x05
#define IPMI_GET_ICMB_CAPABILITIES_CMD	                        0x06
#define IPMI_CLEAR_BRIDGE_STATISTICS_CMD	                    0x08
#define IPMI_GET_BRIDGE_PROXY_ADDRESS_CMD	                    0x09
#define IPMI_GET_ICMB_CONNECTOR_INFO_CMD	                    0x0a
#define IPMI_SET_ICMB_CONNECTOR_INFO_CMD	                    0x0b
#define IPMI_SEND_ICMB_CONNECTION_ID_CMD	                    0x0c
#define IPMI_PREPARE_FOR_DISCOVERY_CMD		                    0x10
#define IPMI_GET_ADDRESSES_CMD			                        0x11
#define IPMI_SET_DISCOVERED_CMD			                        0x12
#define IPMI_GET_CHASSIS_DEVICE_ID_CMD		                    0x13
#define IPMI_SET_CHASSIS_DEVICE_ID_CMD		                    0x14
#define IPMI_BRIDGE_REQUEST_CMD			                        0x20
#define IPMI_BRIDGE_MESSAGE_CMD			                        0x21
#define IPMI_GET_EVENT_COUNT_CMD		                        0x30
#define IPMI_SET_EVENT_DESTINATION_CMD		                    0x31
#define IPMI_SET_EVENT_RECEPTION_STATE_CMD	                    0x32
#define IPMI_SEND_ICMB_EVENT_MESSAGE_CMD	                    0x33
#define IPMI_GET_EVENT_DESTIATION_CMD		                    0x34
#define IPMI_GET_EVENT_RECEPTION_STATE_CMD	                    0x35
#define IPMI_ERROR_REPORT_CMD			                        0xff

// Sensor/Event netfn (0x04)
#define IPMI_SET_EVENT_RECEIVER_CMD		                        0x00
#define IPMI_GET_EVENT_RECEIVER_CMD		                        0x01
#define IPMI_PLATFORM_EVENT_CMD			                        0x02
#define IPMI_GET_PEF_CAPABILITIES_CMD		                    0x10
#define IPMI_ARM_PEF_POSTPONE_TIMER_CMD		                    0x11
#define IPMI_SET_PEF_CONFIG_PARMS_CMD		                    0x12
#define IPMI_GET_PEF_CONFIG_PARMS_CMD		                    0x13
#define IPMI_SET_LAST_PROCESSED_EVENT_ID_CMD	                0x14
#define IPMI_GET_LAST_PROCESSED_EVENT_ID_CMD	                0x15
#define IPMI_ALERT_IMMEDIATE_CMD		                        0x16
#define IPMI_PET_ACKNOWLEDGE_CMD		                        0x17
#define IPMI_GET_DEVICE_SDR_INFO_CMD		                    0x20
#define IPMI_GET_DEVICE_SDR_CMD			                        0x21
#define IPMI_RESERVE_DEVICE_SDR_REPOSITORY_CMD	                0x22
#define IPMI_GET_SENSOR_READING_FACTORS_CMD	                    0x23
#define IPMI_SET_SENSOR_HYSTERESIS_CMD		                    0x24
#define IPMI_GET_SENSOR_HYSTERESIS_CMD		                    0x25
#define IPMI_SET_SENSOR_THRESHOLD_CMD		                    0x26
#define IPMI_GET_SENSOR_THRESHOLD_CMD		                    0x27
#define IPMI_SET_SENSOR_EVENT_ENABLE_CMD	                    0x28
#define IPMI_GET_SENSOR_EVENT_ENABLE_CMD	                    0x29
#define IPMI_REARM_SENSOR_EVENTS_CMD		                    0x2a
#define IPMI_GET_SENSOR_EVENT_STATUS_CMD	                    0x2b
#define IPMI_GET_SENSOR_READING_CMD		                        0x2d
#define IPMI_SET_SENSOR_TYPE_CMD		                        0x2e
#define IPMI_GET_SENSOR_TYPE_CMD		                        0x2f

// App netfn (0x06)
#define IPMI_GET_DEVICE_ID_CMD			                        0x01
#define IPMI_BROADCAST_GET_DEVICE_ID_CMD	                    0x01
#define IPMI_COLD_RESET_CMD			                            0x02
#define IPMI_WARM_RESET_CMD			                            0x03
#define IPMI_GET_SELF_TEST_RESULTS_CMD		                    0x04
#define IPMI_MANUFACTURING_TEST_ON_CMD		                    0x05
#define IPMI_SET_ACPI_POWER_STATE_CMD		                    0x06
#define IPMI_GET_ACPI_POWER_STATE_CMD		                    0x07
#define IPMI_GET_DEVICE_GUID_CMD		                        0x08
#define IPMI_RESET_WATCHDOG_TIMER_CMD		                    0x22
#define IPMI_SET_WATCHDOG_TIMER_CMD		                        0x24
#define IPMI_GET_WATCHDOG_TIMER_CMD		                        0x25
#define IPMI_SET_BMC_GLOBAL_ENABLES_CMD		                    0x2e
#define IPMI_GET_BMC_GLOBAL_ENABLES_CMD	                	    0x2f
#define IPMI_CLEAR_MSG_FLAGS_CMD		                        0x30
#define IPMI_GET_MSG_FLAGS_CMD			                        0x31
#define IPMI_ENABLE_MESSAGE_CHANNEL_RCV_CMD	                    0x32
#define IPMI_GET_MSG_CMD			                            0x33
#define IPMI_SEND_MSG_CMD			                            0x34
#define IPMI_READ_EVENT_MSG_BUFFER_CMD		                    0x35
#define IPMI_GET_BT_INTERFACE_CAPABILITIES_CMD	                0x36
#define IPMI_GET_SYSTEM_GUID_CMD		                        0x37
#define IPMI_GET_CHANNEL_AUTH_CAPABILITIES_CMD                	0x38
#define IPMI_GET_SESSION_CHALLENGE_CMD	                	    0x39
#define IPMI_ACTIVATE_SESSION_CMD		                        0x3a
#define IPMI_SET_SESSION_PRIVILEGE_CMD	                  	    0x3b
#define IPMI_CLOSE_SESSION_CMD			                        0x3c
#define IPMI_GET_SESSION_INFO_CMD		                        0x3d
#define IPMI_GET_AUTHCODE_CMD			                        0x3f
#define IPMI_SET_CHANNEL_ACCESS_CMD		                        0x40
#define IPMI_GET_CHANNEL_ACCESS_CMD		                        0x41
#define IPMI_GET_CHANNEL_INFO_CMD		                        0x42
#define IPMI_SET_USER_ACCESS_CMD		                        0x43
#define IPMI_GET_USER_ACCESS_CMD		                        0x44
#define IPMI_SET_USER_NAME_CMD			                        0x45
#define IPMI_GET_USER_NAME_CMD			                        0x46
#define IPMI_SET_USER_PASSWORD_CMD		                        0x47
#define IPMI_ACTIVATE_PAYLOAD_CMD		                        0x48
#define IPMI_DEACTIVATE_PAYLOAD_CMD	                	        0x49
#define IPMI_GET_PAYLOAD_ACTIVATION_STATUS_CMD	                0x4a
#define IPMI_GET_PAYLOAD_INSTANCE_INFO_CMD	                    0x4b
#define IPMI_SET_USER_PAYLOAD_ACCESS_CMD	                    0x4c
#define IPMI_GET_USER_PAYLOAD_ACCESS_CMD	                    0x4d
#define IPMI_GET_CHANNEL_PAYLOAD_SUPPORT_CMD	                0x4e
#define IPMI_GET_CHANNEL_PAYLOAD_VERSION_CMD	                0x4f
#define IPMI_GET_CHANNEL_OEM_PAYLOAD_INFO_CMD	                0x50
#define IPMI_MASTER_READ_WRITE_CMD		                        0x52
#define IPMI_GET_CHANNEL_CIPHER_SUITES_CMD	                    0x54
#define IPMI_SUSPEND_RESUME_PAYLOAD_ENCRYPTION_CMD              0x55
#define IPMI_SET_CHANNEL_SECURITY_KEY_CMD	                    0x56
#define IPMI_GET_SYSTEM_INTERFACE_CAPABILITIES_CMD              0x57

// Storage netfn (0x0a)
#define IPMI_GET_FRU_INVENTORY_AREA_INFO_CMD	                0x10
#define IPMI_READ_FRU_DATA_CMD			                        0x11
#define IPMI_WRITE_FRU_DATA_CMD			                        0x12
#define IPMI_GET_SDR_REPOSITORY_INFO_CMD	                    0x20
#define IPMI_GET_SDR_REPOSITORY_ALLOC_INFO_CMD	                0x21
#define IPMI_RESERVE_SDR_REPOSITORY_CMD		                    0x22
#define IPMI_GET_SDR_CMD			                            0x23
#define IPMI_ADD_SDR_CMD			                            0x24
#define IPMI_PARTIAL_ADD_SDR_CMD		                        0x25
#define IPMI_DELETE_SDR_CMD			                            0x26
#define IPMI_CLEAR_SDR_REPOSITORY_CMD		                    0x27
#define IPMI_GET_SDR_REPOSITORY_TIME_CMD	                    0x28
#define IPMI_SET_SDR_REPOSITORY_TIME_CMD	                    0x29
#define IPMI_ENTER_SDR_REPOSITORY_UPDATE_CMD	                0x2a
#define IPMI_EXIT_SDR_REPOSITORY_UPDATE_CMD	                    0x2b
#define IPMI_RUN_INITIALIZATION_AGENT_CMD	                    0x2c
#define IPMI_GET_SEL_INFO_CMD			                        0x40
#define IPMI_GET_SEL_ALLOCATION_INFO_CMD   	                    0x41
#define IPMI_RESERVE_SEL_CMD			                        0x42
#define IPMI_GET_SEL_ENTRY_CMD			                        0x43
#define IPMI_ADD_SEL_ENTRY_CMD			                        0x44
#define IPMI_PARTIAL_ADD_SEL_ENTRY_CMD		                    0x45
#define IPMI_DELETE_SEL_ENTRY_CMD		                        0x46
#define IPMI_CLEAR_SEL_CMD			                            0x47
#define IPMI_GET_SEL_TIME_CMD			                        0x48
#define IPMI_SET_SEL_TIME_CMD			                        0x49
#define IPMI_GET_AUXILIARY_LOG_STATUS_CMD	                    0x5a
#define IPMI_SET_AUXILIARY_LOG_STATUS_CMD	                    0x5b

// Transport netfn (0x0c)
#define IPMI_SET_LAN_CONFIG_PARMS_CMD		                    0x01
#define IPMI_GET_LAN_CONFIG_PARMS_CMD		                    0x02
#define IPMI_SUSPEND_BMC_ARPS_CMD		                        0x03
#define IPMI_GET_IP_UDP_RMCP_STATS_CMD		                    0x04
#define IPMI_SET_SERIAL_MODEM_CONFIG_CMD                   	    0x10
#define IPMI_GET_SERIAL_MODEM_CONFIG_CMD	                    0x11
#define IPMI_SET_SERIAL_MODEM_MUX_CMD		                    0x12
#define IPMI_GET_TAP_RESPONSE_CODES_CMD		                    0x13
#define IPMI_SET_PPP_UDP_PROXY_XMIT_DATA_CMD	                0x14
#define IPMI_GET_PPP_UDP_PROXY_XMIT_DATA_CMD	                0x15
#define IPMI_SEND_PPP_UDP_PROXY_PACKET_CMD	                    0x16
#define IPMI_GET_PPP_UDP_PROXY_RECV_DATA_CMD	                0x17
#define IPMI_SERIAL_MODEM_CONN_ACTIVE_CMD	                    0x18
#define IPMI_CALLBACK_CMD			                            0x19
#define IPMI_SET_USER_CALLBACK_OPTIONS_CMD	                    0x1a
#define IPMI_GET_USER_CALLBACK_OPTIONS_CMD	                    0x1b
#define IPMI_SOL_ACTIVATING_CMD			                        0x20
#define IPMI_SET_SOL_CONFIGURATION_PARAMETERS	                0x21
#define IPMI_GET_SOL_CONFIGURATION_PARAMETERS	                0x22

// The Group Extension defined for PICMG.
#define IPMI_PICMG_GRP_EXT		                                0

// PICMG Commands
#define IPMI_PICMG_CMD_GET_PROPERTIES							0x00
#define IPMI_PICMG_CMD_GET_ADDRESS_INFO							0x01
#define IPMI_PICMG_CMD_GET_SHELF_ADDRESS_INFO					0x02
#define IPMI_PICMG_CMD_SET_SHELF_ADDRESS_INFO					0x03
#define IPMI_PICMG_CMD_FRU_CONTROL								0x04
#define IPMI_PICMG_CMD_GET_FRU_LED_PROPERTIES					0x05
#define IPMI_PICMG_CMD_GET_LED_COLOR_CAPABILITIES				0x06
#define IPMI_PICMG_CMD_SET_FRU_LED_STATE						0x07
#define IPMI_PICMG_CMD_GET_FRU_LED_STATE						0x08
#define IPMI_PICMG_CMD_SET_IPMB_STATE							0x09
#define IPMI_PICMG_CMD_SET_FRU_ACTIVATION_POLICY				0x0a
#define IPMI_PICMG_CMD_GET_FRU_ACTIVATION_POLICY				0x0b
#define IPMI_PICMG_CMD_SET_FRU_ACTIVATION						0x0c
#define IPMI_PICMG_CMD_GET_DEVICE_LOCATOR_RECORD				0x0d
#define IPMI_PICMG_CMD_SET_PORT_STATE							0x0e
#define IPMI_PICMG_CMD_GET_PORT_STATE							0x0f
#define IPMI_PICMG_CMD_COMPUTE_POWER_PROPERTIES					0x10
#define IPMI_PICMG_CMD_SET_POWER_LEVEL							0x11
#define IPMI_PICMG_CMD_GET_POWER_LEVEL							0x12
#define IPMI_PICMG_CMD_RENEGOTIATE_POWER						0x13
#define IPMI_PICMG_CMD_GET_FAN_SPEED_PROPERTIES					0x14
#define IPMI_PICMG_CMD_SET_FAN_LEVEL							0x15
#define IPMI_PICMG_CMD_GET_FAN_LEVEL							0x16
#define IPMI_PICMG_CMD_BUSED_RESOURCE							0x17
#define IPMI_PICMG_CMD_IPMB_LINK_INFO							0x18
#define IPMI_PICMG_CMD_SET_AMC_PORT_STATE               		0x19
#define IPMI_PICMG_CMD_GET_AMC_PORT_STATE               		0x1a
#define IPMI_PICMG_CMD_SHELF_MANAGER_IPMB_ADDRESS				0x1b
#define IPMI_PICMG_CMD_SET_FAN_POLICY							0x1c
#define IPMI_PICMG_CMD_GET_FAN_POLICY							0x1d
#define IPMI_PICMG_CMD_FRU_CONTROL_CAPABILITIES					0x1e
#define IPMI_PICMG_CMD_FRU_INVENTORY_DEVICE_LOCK_CONTROL		0x1f
#define IPMI_PICMG_CMD_FRU_INVENTORY_DEVICE_WRITE				0x20
#define IPMI_PICMG_CMD_GET_SHELF_MANAGER_IP_ADDRESSES			0x21
#define IPMI_PICMG_CMD_SHELF_POWER_ALLOCATION           		0x22


// NetFNs
#define IPMI_CHASSIS_NETFN			                            0x00
#define IPMI_BRIDGE_NETFN			                            0x02
#define IPMI_SENSOR_EVENT_NETFN	            	                0x04
#define IPMI_APP_NETFN				                            0x06
#define IPMI_FIRMWARE_NETFN			                            0x08
#define IPMI_STORAGE_NETFN			                            0x0a
#define IPMI_TRANSPORT_NETFN		                            0x0c
#define IPMI_GROUP_EXTENSION_NETFN	                            0x2c
#define IPMI_OEM_GROUP_NETFN		                            0x2e
#define IPMI_CONTROLLER_SPECIFIC                                0x30

// CC
// IPMI specification table 5-2 Generic Completion Codes
#define IPMI_CC_OK                                              0x00
#define IPMI_CC_NODE_BUSY                                       0xc0
#define IPMI_CC_INV_CMD                                         0xc1
#define IPMI_CC_INV_CMD_FOR_LUN                                 0xc2
#define IPMI_CC_TIMEOUT                                         0xc3
#define IPMI_CC_OUT_OF_SPACE                                    0xc4
#define IPMI_CC_RES_CANCELED                                    0xc5
#define IPMI_CC_REQ_DATA_TRUNC                                  0xc6
#define IPMI_CC_REQ_DATA_INV_LENGTH                             0xc7
#define IPMI_CC_REQ_DATA_FIELD_EXCEED                           0xc8
#define IPMI_CC_PARAM_OUT_OF_RANGE                              0xc9
#define IPMI_CC_CANT_RET_NUM_REQ_BYTES                          0xca
#define IPMI_CC_REQ_DATA_NOT_PRESENT                            0xcb
#define IPMI_CC_INV_DATA_FIELD_IN_REQ                           0xcc
#define IPMI_CC_ILL_SENSOR_OR_RECORD                            0xcd
#define IPMI_CC_RESP_COULD_NOT_BE_PRV                           0xce
#define IPMI_CC_CANT_RESP_DUPLI_REQ                             0xcf
#define IPMI_CC_CANT_RESP_SDRR_UPDATE                           0xd0
#define IPMI_CC_CANT_RESP_FIRM_UPDATE                           0xd1
#define IPMI_CC_CANT_RESP_BMC_INIT                              0xd2
#define IPMI_CC_DESTINATION_UNAVAILABLE                         0xd3
#define IPMI_CC_INSUFFICIENT_PRIVILEGES                         0xd4
#define IPMI_CC_NOT_SUPPORTED_PRESENT_STATE                     0xd5
#define IPMI_CC_ILLEGAL_COMMAND_DISABLED                        0xd6
#define IPMI_CC_UNSPECIFIED_ERROR                               0xff

// IPMI Temperature Sensor Events
#define IPMI_THRESHOLD_LNC_GL	                                0x00  // lower non critical going low
#define IPMI_THRESHOLD_LNC_GH	                                0x01  // lower non critical going high
#define IPMI_THRESHOLD_LC_GL	                                0x02  // lower critical going low
#define IPMI_THRESHOLD_LC_GH	                                0x03  // lower critical going HIGH
#define IPMI_THRESHOLD_LNR_GL	                                0x04  // lower non recoverable going low
#define IPMI_THRESHOLD_LNR_GH	                                0x05  // lower non recoverable going high
#define IPMI_THRESHOLD_UNC_GL	                                0x06  // upper non critical going low
#define IPMI_THRESHOLD_UNC_GH	                                0x07  // upper non critical going high
#define IPMI_THRESHOLD_UC_GL	                                0x08  // upper critical going low
#define IPMI_THRESHOLD_UC_GH	                                0x09  // upper critical going HIGH
#define IPMI_THRESHOLD_UNR_GL	                                0x0a  // upper non recoverable going low
#define IPMI_THRESHOLD_UNR_GH                                   0x0b  // upper non recoverable going high


// Function prototypes
void ipmi_init();
void ipmi_check_request();
void ipmi_response_send();
void ipmi_check_event_respond();
void ipmi_hot_swap_send(u08 event);
void ipmi_event_send(u08 sensor_number, u08 evData);
void ipmi_set_event_receiver(u08 address);
void ipmb_get(u08 receiveDataLength, u08* receiveData);       // IPMB message receive
void ipmb_send_rsp(u08 error);                                // send IPMB message
void ipmb_send_event();                                       // send event message
u08 ipmi_get_device_id();
u08 checksum_clc(u08* buf, u08 length);                       // calculate checksum
u08 checsum_verify(u08* buf, u08 length, u08 checksum);       // verify checksum
u08 get_address();                                            // obtain geographical address of IPMB
u08 get_event_request_ok();




#endif //_IPMI_IF_H
