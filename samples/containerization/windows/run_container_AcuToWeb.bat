@echo on
REM Run the program specified by --entrypoint in a detached container.

docker run -d --rm ^
	--entrypoint "C:\AppContainerDirectory\start_acutoweb.bat" ^
	--publish 5632:5632 ^
	--publish 3000:3000 ^
	--publish 8009:8009 ^
	--name acu_acutoweb ^
	--volume "%CD%\SharedContainerDirectory":"C:\SharedContainerDirectory" ^
	microfocus/extend-app:win_10.5.0_x64