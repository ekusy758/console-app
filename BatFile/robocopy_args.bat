@echo off
rem ---------------------------------------------------------------------------
rem  [�~���[�����O�������s�o�b�`] 
rem  �g����: cmd�ň����ɃR�s�[���A�R�s�[����w�肵���s����
rem  �쐬��: 2025/08/26
rem ---------------------------------------------------------------------------

rem �R�s�[���A�R�s�[���ݒ�
set src="%1"
set dst="%2"
if %src% == "" ( goto :ABEND )
if %dst% == "" ( goto :ABEND )

rem �X�N���v�g�t�H���_�ֈړ�
set cur=%~dp0
cd %cur%

rem ���s�����O�o�͐ݒ� (mirlogs/YYMMDD_HHMMSS_mir.log)
set logdir="%cur%\mirlogs"
if not exist "%logdir%" ( mkdir %logdir% )

set datetime=%date:/=%_%time:~,8%
set datetime=%datetime::=%
set logfile=%logdir%\%datetime%_mir.log

rem �~���[�����O�������s (���O�t�H���_������΁A/XD�Ɏw��)
robocopy %src% %dst% /MIR /R:0 /W:0 /NP /TEE /XJD /XJF /DCOPY:DAT ^
  /XD "" ^
  /LOG+:%logfile%

pause
exit /b 0

rem �G���[������`
:ABEND
  echo �G���[: ����������������܂���B
  echo ��1�����ɃR�s�[���t�H���_���w�肵�܂��B�l: %src%
  echo ��2�����ɃR�s�[��t�H���_���w�肵�܂��B�l: %dst%
  exit /b -1
