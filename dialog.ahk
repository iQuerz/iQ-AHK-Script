#SingleInstance Force

Gui, Font, cBlack
Gui, Add, Text,, New version of script is available. Would you like to update?
Gui, Add, Link,, <a href="https://github.com/iQuerz/MyAHKScript">Read about new version</a>
Gui, Font, cBlack
Gui, Add, Button, Default h33 w100  gClose,  I'll Update myself
Gui, Add, Button,  x+80		h33 w100  gUpdate, Update it for me
Gui, Show, CenterAutosize, Update
Return

Update:
	request := ComObjCreate("Msxml2.XMLHTTP")
	request.Open("GET", "https://raw.githubusercontent.com/iQuerz/MyAHKScript/main/script.ahk", true)
	request.Send()
	while (request.readyState != 4 && A_Index <= 50)    ; Wait for response 5s max (50*100 = 5000ms).
		sleep 100
	if request.readyState != 4 {
		MsgBox, Connection to the server failed, try to update later.
		if request.readyState != 4  ; We could  get the response while user was reading msgbox's text.
			ExitApp
		else MsgBox, A miracle has just happened, we've got the update!
	}
  	text := request.ResponseText
	FileDelete, script.ahk
	FileAppend, % text, script.ahk
	Run script.ahk

GuiClose:
Close:
	ExitApp
