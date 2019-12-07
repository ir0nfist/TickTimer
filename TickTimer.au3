#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=kisspng-clock-face-digital-clock-clip-art-free-clock-vector-5aaaba065f72f2.117429051521138182391.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WinAPISysWin.au3>
#include <WindowsConstants.au3>

#NoTrayIcon

;~ Global $fRunOne = False

;~ HotKeySet("!^=", "Main")
;~ HotKeySet("!^-","RunTime")


Opt("GUIOnEventMode", 1) ; event mode, with events specified in gui area

If Not FileExists("settings.ini") Then
	IniWrite("settings.ini", "TickTimer", "MS", "6000")
	IniWrite("settings.ini", "TickTimer", "FCOLOR", "0x000000")
	IniWrite("settings.ini", "TickTimer", "BGCOLOR", "0xABCDEF")
	IniWrite("settings.ini", "TickTimer", "TRANS", "255")
	IniWrite("settings.ini", "TickTimer", "XPOS", @DesktopWidth / 2 - 135 / 2)
	IniWrite("settings.ini", "TickTimer", "YPOS", @DesktopHeight / 2 - 63 / 2)
	IniWrite("settings.ini", "TickTimer", "FSIZE", "16")
EndIf
$howmany = 0
$i = 6
$ms = IniRead("settings.ini", "TickTimer", "MS", "6000")
Dim $Input1
Dim $Input2
Dim $Input3
Dim $Button1
$fcolor = IniRead("settings.ini", "TickTimer", "FCOLOR", "0x000000")
$bgcolor = IniRead("settings.ini", "TickTimer", "BGCOLOR", "0xABCDEF")
$trans = IniRead("settings.ini", "TickTimer", "TRANS", "255")
$xpos = IniRead("settings.ini", "TickTimer", "XPOS", @DesktopWidth / 2 - 135 / 2)
$ypos = IniRead("settings.ini", "TickTimer", "YPOS", @DesktopHeight / 2 - 63 / 2)
$fsize = IniRead("settings.ini", "TickTimer", "FSIZE", "16")
$toggle = 0

$hGui = GUICreate("TickTimer", 136, 95, $xpos, $ypos, -1, $WS_EX_LAYERED + $WS_EX_TOPMOST)
GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEButton")
$ticker = GUICtrlCreateLabel("6", 10, 10, 58, 52, -1, $GUI_WS_EX_PARENTDRAG)
;~ $Input1 = GUICtrlCreateInput("Input1", 72, 10, 0, 0)
;~ $Input1 = GUICtrlCreateInput("Input1", 72, 10, 49, 20)
GUICtrlSetOnEvent($ticker, "Panel")
GUICtrlSetFont($ticker, $fsize)
GUICtrlSetColor($ticker, $fcolor)
GUICtrlSetTip(-1, "Drag me")
GUISetBkColor($bgcolor)
;~ _WinAPI_SetLayeredWindowAttributes($hGui, 0x010101, $trans)
_WinAPI_SetLayeredWindowAttributes($hGui, 0xABCDEF, $trans)
GUISetStyle($WS_POPUP, -1, $hGui)
GUISetState(@SW_SHOW)
$Timer = TimerInit()
While 1
;~ 	$Timer = TimerInit()
;~ 	GUICtrlSetData ( $ticker, size
;~ 	If $fRunOne Then
	; Now start the "real" function from within the main code
;~ 		Global $fRunOne = False
;~ 		Main()
;~ 	EndIf

	Main()

;~ 	Local $aExtMsg = GUIGetMsg(1)
;~ 	Local $iMsg = $aExtMsg[0]
;~ 	Switch $aExtMsg[1]
;~ 		Case $hGui
;~ 			Select
;~ 				Case $iMsg = $GUI_EVENT_CLOSE
;~ 					Exit
;~ 			EndSelect
;~ 	EndSwitch
WEnd

Func RunTime()
	$Delay = TimerDiff($Timer)
	$howmany = $howmany + $Delay
	MsgBox(0,"RunTime",$howmany/1000)
	$howmany = 0
	$Timer = TimerInit()
EndFunc

Func Main()
	$Delay = TimerDiff($Timer)
	$DelayTime = ($ms / 6) ; user input ms / 6 seconds
	If $Delay >= $DelayTime Then ; delay greater than 1/6th of ms tick time
		$i = $i - 1
		If $i = 0 Then $i = 6
		GUICtrlSetData($ticker, $i)
		$howmany = $howmany + $Delay
		$Timer = TimerInit()
	EndIf
;~ 	For $i = 6 To 1 Step -1
;~ 	If $fRunOne Then
	; Now start the "real" function from within the main code
;~ 		Global $fRunOne = False
;~ 		Main()
;~ 	EndIf
;~ 		GUICtrlSetData($ticker, $i)
;~ 		Sleep($ms / 6)
;~ 			If $fRunOne Then
	; Now start the "real" function from within the main code
;~ 		Global $fRunOne = False
;~ 		Main()

;~ 	EndIf
;~ 	Next
EndFunc   ;==>Main

Func Panel()
	If $toggle = 0 Then
		$toggle = 1
		$Input1 = GUICtrlCreateInput($ms, 72, 42, 49, 21)
		GUICtrlSetOnEvent($Input1, "ResetMS")
		$Input2 = GUICtrlCreateInput($fcolor, 72, 66, 49, 21)
		GUICtrlSetOnEvent($Input2, "ResetColor")
		$Input3 = GUICtrlCreateInput($fsize, 72, 18, 49, 21)
		GUICtrlSetOnEvent($Input3, "SetFSize")
		$Button1 = GUICtrlCreateButton("Reset", 10, 66, 49, 21)
		GUICtrlSetOnEvent($Button1, "ResetTick")
	Else

		$winpos = WinGetPos("TickTimer")
		IniWrite("settings.ini", "TickTimer", "MS", GUICtrlRead($Input1))
		IniWrite("settings.ini", "TickTimer", "FCOLOR", GUICtrlRead($Input2))
		IniWrite("settings.ini", "TickTimer", "FSIZE", GUICtrlRead($Input3))
		IniWrite("settings.ini", "TickTimer", "XPOS", $winpos[0])
		IniWrite("settings.ini", "TickTimer", "YPOS", $winpos[1])
		$toggle = 0
		GUICtrlDelete($Input1)
		GUICtrlDelete($Input2)
		GUICtrlDelete($Input3)
		GUICtrlDelete($Button1)
		GUICtrlSetFont($ticker, $fsize)
	EndIf
EndFunc   ;==>Panel

Func ResetMS()
	$ms = GUICtrlRead($Input1)
EndFunc   ;==>ResetMS

Func ResetTick()
	$ms = GUICtrlRead($Input1)
	$i = 6
	GUICtrlSetData($ticker, $i)
	$Timer = TimerInit()
EndFunc   ;==>ResetTick

Func SetFSize()
	$fsize = GUICtrlRead($Input3)
	GUICtrlSetFont($ticker, $fsize)
EndFunc   ;==>SetFSize

Func ResetColor()
	$fcolor = GUICtrlRead($Input2)
	GUICtrlSetColor($ticker, $fcolor)
EndFunc   ;==>ResetColor

Func CLOSEButton()
    ; Note: At this point @GUI_CtrlId would equal $GUI_EVENT_CLOSE,
    ; and @GUI_WinHandle would equal $hMainGUI
;~     MsgBox($MB_OK, "GUI Event", "You selected CLOSE! Exiting...")
    Exit
EndFunc
