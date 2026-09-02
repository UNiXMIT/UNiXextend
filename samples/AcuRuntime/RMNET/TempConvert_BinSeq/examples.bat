REM Ensure that the ACU extend 'bin' directory is in your PATH
for %%F in (*.cbl) do ccbl32 -Cr -Sr -Ze -Gz -Ga -Sp "C:\Users\Public\Documents\Micro Focus\extend 10.4.0\sample\xmlext" -Ze %%F
for %%F in (*.acu) do start /w wrun32 -y xmlif.dll -y rmnet.dll %%F
