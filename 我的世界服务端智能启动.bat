@ECHO OFF
title [����������] by [�����û���],@lzykaifu123v
set t=%date% %time:~0,2%:%time:~3,2% 
echo.
echo         ��ӭʹ��[���ϰ�����]!
echo               ����QQ:[QQ����]
echo *************************************************
echo.
echo       ���ڵ�ʱ����:%t%
echo    ��ܰ��ʾ:����stop���ܱ������ݲ��رշ�����!
echo.
echo *************************************************
::�ж��Ƿ��һ������
if not exist %~dp0server.properties (
	echo �������⵽���ǵ�һ������!
	echo �������ļ��ͷ����,������������.
	java -Xincgc -Xmx2048M -jar Thermos-1.7.10-1614-57-server.jar
	echo �ͷ����,��������!
	call run.bat
)
::�ڴ����ܷ��俪ʼ
echo ����Ϊ���ķ�������ܷ����ڴ�...
echo.
systeminfo|find "�����ڴ�����" 
FOR /F "eol=; tokens=2,2 delims==" %%i IN ('findstr /i "max-players" server.properties') DO set max-players=%%i    
set /a RAM=[��������ռ���ڴ�(��MBΪ��λ��ֻд����)]+%max-players%*[���������ռ�÷�������Դ�ڴ�(��MBΪ��λ��ֻд����)]
systeminfo|find "���õ������ڴ�"
for /f "tokens=2" %%a in ('systeminfo^|findstr ���õ������ڴ�') do (
   for /f "tokens=1,2 delims=," %%y in ("%%a") do if %%y%%z lss %RAM% (
	echo �ڴ治�㣬�뽫�趨��������! 
	pause
	start %~dp0server.properties
	exit
) else (
	echo �ڴ����ɹ�!�����ڴ�:%RAM% MB
)
)
::�ڴ����ܷ������
echo.
echo =================================================
echo.
pause
set startime=%t%

java -Xincgc -Xmx%RAM%M -jar <�����ļ�����>.jar
set endtime=%t%
pause
echo ��ʼʱ��%startime%������ʱ��%endtime%
pause