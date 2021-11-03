#include %A_ScriptDir%\include\Serial.ahk
; Arduino AHK Library
arduino_setup(){
	global
	ARDUINO_Settings = %ARDUINO_Port%:baud=%ARDUINO_Baud% parity=%ARDUINO_Parity% data=%ARDUINO_Data% stop=%ARDUINO_Stop% dtr=off
	ARDUINO_Handle := Serial_Initialize(ARDUINO_Settings)
}

arduino_read(){
	global ARDUINO_Handle
	return Serial_Read(ARDUINO_Handle, "0x1", Bytes_Received)
}

arduino_close(){
	global ARDUINO_Handle
	Sleep, 100
	Serial_Close(ARDUINO_Handle)
}