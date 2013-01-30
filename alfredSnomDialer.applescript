-- Setup your phone IP and credentials:
property snomIP : "192.168.1.xxx"
property snomLogin : "snom"
property snomPW : "12345"


on alfred_script(q)
  set inputNumber to q as string
  set snomNumber to CleanInput(inputNumber)  
  set commandURL to "http://" & snomLogin & ":" & snomPW & "@"
  set commandURL to commandURL & snomIP & "/command.htm?number=" & snomNumber
  
  do shell script "curl \"" & commandURL & "\""  
end alfred_script

on CleanInput(inputNumber)
  set allowedDigits to {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}
  set snomNumber to ""
  repeat with i from 1 to length of inputNumber
    set j to (character i of inputNumber)
    if j = "+" then set snomNumber to snomNumber & "00"
    if j is in allowedDigits then set snomNumber to snomNumber & j
  end repeat
  return snomNumber
end CleanInput