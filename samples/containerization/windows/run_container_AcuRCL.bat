@echo on
REM Run the program specified by --entrypoint in a detached container.

docker run -d --rm ^
	--entrypoint "C:\AppContainerDirectory\start_acurcl.bat" ^
	--publish 5632:5632 ^
	--name acu_acurcl ^
	--volume "%CD%\SharedContainerDirectory":"C:\SharedContainerDirectory" ^
	microfocus/extend-app:win_10.5.0_x64