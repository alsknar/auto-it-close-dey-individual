;
;
;           Закрытие дня (физ. лица)
;
;        разработчик: Лаврененко А.Л.
;        дата создания: 19.05.2010
;        дата последнего изменения: 19.05.2010
;
;
;
; считывание данных с ini-файла
$sessions = IniRead("Закінчення дня_фіз.ini", "sessions", "sessions_off", "NotFound")	; признак уничтожения сесии
$abonent = IniRead("Закінчення дня_фіз.ini", "proccess", "abonent", "NotFound") 		; название процесса абонентской
$admin = IniRead("Закінчення дня_фіз.ini", "proccess", "admin", "NotFound")     		; название процесса администратора
$exe1 = IniRead("Закінчення дня_фіз.ini", "exe", "admin", "NotFound")           		; полный путь к exe-файлу абонентской
$exe2 = IniRead("Закінчення дня_фіз.ini", "exe", "abonent", "NotFound")         		; полный путь к exe-файлу администратора
$base = IniRead("Закінчення дня_фіз.ini", "base", "base", "NotFound")           		; полный путь к базе
$pack = IniRead("Закінчення дня_фіз.ini", "pack", "pack", "NotFound")          			; полный путь к папке с архивами
$user = "Лаврененко А.Л."                                                       		; пользователь
$password = ""    				                                                  		; пароль

if $sessions = 1 Then
; уничтожение всех существующих процессов абонентскй и админинстратора
	RunWait(@SystemDir & "\taskkill.exe /F /IM " & $abonent, @SystemDir, @SW_HIDE)
	RunWait(@SystemDir & "\taskkill.exe /F /IM " & $admin, @SystemDir, @SW_HIDE)
EndIf

; полный контроль в администраторе
run($exe1 & " /D" & $base & "/N" & $user & "/P" & $password)
WinWaitActive('Абоненти')
sleep(10000)
send('{ALT}')
send('{DOWN}')
send('{RIGHT}')
send('{DOWN}')
send('{DOWN}')
send('{DOWN}')
send('{DOWN}')
send('{ENTER}')
send('{ENTER}')
WinWaitActive('Абонент','РЕЖИМ: Створення таблиці, якщо не існує')
send('!x')
sleep(5000)
; перерасчет базы данных
run($exe2 & " /D" & $base & "/N" & $user & "/P" & $password)
WinWaitActive('Абоненти')
send('{ALT}')
send('{DOWN}')
send('{RIGHT}')
send('{DOWN}')
send('{ENTER}')
send('{ENTER}')
WinWaitActive("Виконання формули розрахунку (ОСНОВНА)",'OK')
send('{ENTER}')
send('{ALT}')
send('{RIGHT}')
send('{RIGHT}')
send('{RIGHT}')
send('{RIGHT}')
send('{DOWN}')
send('{DOWN}')
send('{DOWN}')
send('{DOWN}')
send('{DOWN}')
send('{DOWN}')
send('{DOWN}')
send('{ENTER}')
$date = @YEAR & "_" & @MON & "_" & @MDAY
WinWaitActive('Збереження даних')
; создание архива
send($pack & $date)
send('{ENTER}')
Sleep(5000)
WinWaitActive('Абоненти')
send('!x')
