@ECHO OFF
title 科技空岛生存服务端整合包 by @lzykaifu123v
set t=%date% %time:~0,2%:%time:~3,2% 
echo.
echo         欢迎使用[科技空岛生存服务端整合包]!
echo                 作者QQ:1744290859
echo *************************************************
echo.
echo       现在的时间是:%t%
echo    温馨提示:输入stop就能保存数据并关闭服务器!
echo.
echo *************************************************
::判断是否第一次启动
if not exist %~dp0server.properties (
	echo 本程序检测到您是第一次启动!
	echo 待核心文件释放完毕,请重启本程序.
	java -Xincgc -Xmx2048M -jar Thermos-1.7.10-1614-57-server.jar
	echo 释放完毕,正在重启!
	call run.bat
)
::内存智能分配开始
echo 正在为您的服务端智能分配内存...
echo.
systeminfo|find "物理内存总量" 
FOR /F "eol=; tokens=2,2 delims==" %%i IN ('findstr /i "max-players" server.properties') DO set max-players=%%i    
set /a RAM=2048+%max-players%*64
systeminfo|find "可用的物理内存"
for /f "tokens=2" %%a in ('systeminfo^|findstr 可用的物理内存') do (
   for /f "tokens=1,2 delims=," %%y in ("%%a") do if %%y%%z lss %RAM% (
	echo 内存不足，请将设定人数减少!当前人数:%max-players% 
	pause
	start %~dp0server.properties
	exit
) else (
	echo 内存分配成功!分配内存:%RAM% MB
)
)
::内存智能分配结束
echo.
echo =================================================
echo.
pause
set startime=%t%

java -Xincgc -Xmx%RAM%M -jar Thermos-1.7.10-1614-57-server.jar
set endtime=%t%
pause
echo 开始时间%startime%，结束时间%endtime%
pause