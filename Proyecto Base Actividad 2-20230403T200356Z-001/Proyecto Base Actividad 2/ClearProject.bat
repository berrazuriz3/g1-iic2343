for /D %%f in (*.Xil) do rmdir "%%f" /s /q
for /D %%f in (*.cache) do rmdir "%%f" /s /q
for /D %%f in (*.hw) do rmdir "%%f" /s /q
for /D %%f in (*.runs) do rmdir "%%f" /s /q
for /D %%f in (*.sim) do rmdir "%%f" /s /q
for /D %%f in (*.ip_user_files) do rmdir "%%f" /s /q
del *.tmp /q
del *.dmp /q
del *.log /q
del *.jou /q
del *.str /q
del *.zip /q
del *.debug /q