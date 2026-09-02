REM Ensure that the ACU extend 'bin' directory is in your PATH

for %%F in (*.cbl) do ccbl32 -Ga -Ze %%F
for %%F in (*.acu) do start /w wrun32 -d -y xmlif.dll -y rmnet.dll %%F
