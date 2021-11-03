#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir% 
ARDUINO_Port     = COM4
ARDUINO_Baud     = 9600
ARDUINO_Parity   = N
ARDUINO_Data     = 8
ARDUINO_Stop     = 1
arduino_setup()

slashTimerActive := 0
SetTimer, ArdReadT, 200 ; Call the sub every 200ms

mode := 0
discordMode := true

F16::
mode := !mode
if (mode == true) {
TrayTip, Boss Detector, MODE: NOTIFY`nDISCORD: %discordMode%, 20, 17
} else {
TrayTip, Boss Detector, MODE: CLEAR`nDISCORD: %discordMode%, 20, 17
}
return

F17::
discordMode := !discordMode
if (mode == true) {
TrayTip, Boss Detector, MODE: NOTIFY`nDISCORD: %discordMode%, 20, 17
} else {
TrayTip, Boss Detector, MODE: CLEAR`nDISCORD: %discordMode%, 20, 17
}
return


ArdReadT:
ardRead := arduino_read()
if (ardRead = 59) { ; if arduino sends a "Y"
		; send discord
        if (discordMode) {
            whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
            whr.Open("POST", "<webhook URL>")
            whr.SetRequestHeader("Content-Type", "application/json")
            body = {"username": "Boss Detector", "content": "BOSS DETECTED"}
            whr.Send(body)
        }


        ;mode check
        if (mode == 1) {
    		TrayTip, Boss Detector, BOSS DETECTED, 20, 17
        } else if (mode == 0) {
            Send, #d
            run "code" "%A_ScriptDir%\im_working_boss.txt"
        }

		Sleep, 2000
        Pause
        Suspend
}

return


OnExit:
	arduino_close()
ExitApp
#include %A_ScriptDir%\include\Arduino.ahk
