@echo on
REM Run the application container in the foreground

docker run -it --rm ^
	--publish 5632:5632 ^
	--publish 3000:3000 ^
	--publish 8009:8009 ^
	--name acu_app_interactive ^
	--volume "%CD%\SharedContainerDirectory":"C:\SharedContainerDirectory" ^
	microfocus/extend-app:win_10.5.0_x64