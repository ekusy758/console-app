rem ****************************************************************************
rem   �~���[�����O�������s�o�b�`
rem   �쐬��: 2025/08/22
rem ****************************************************************************

rem �R�s�[���A�R�s�[����w��
set src="C:\Test"
set dst="D:\Test"

rem �X�N���v�g�t�H���_�ֈړ�
set cur=%~dp0
cd %cur%

rem ���s���O�o�͐�ݒ�
set outdir="%cur%\mirror_logs"
if not exist "%outdir%" ( mkdir %outdir% )

set logpath=%outdir%\%date:/=%_yusuk.log

rem �~���[�����O�������s (���O: AppData)
robocopy %src% %dst% /MIR /R:0 /W:0 /NP /TEE /XJD /XJF /DCOPY:DAT ^
	/XD "%src%\AppData" ^
	/LOG+:%logpath%

pause
