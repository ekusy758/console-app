rem ****************************************************************************
rem   ミラーリング処理実行バッチ
rem   作成日: 2025/08/22
rem ****************************************************************************

rem コピー元、コピー先を指定
set src="C:\Test"
set dst="D:\Test"

rem スクリプトフォルダへ移動
set cur=%~dp0
cd %cur%

rem 実行ログ出力先設定
set outdir="%cur%\mirror_logs"
if not exist "%outdir%" ( mkdir %outdir% )

set logpath=%outdir%\%date:/=%_yusuk.log

rem ミラーリング処理実行 (除外: AppData)
robocopy %src% %dst% /MIR /R:0 /W:0 /NP /TEE /XJD /XJF /DCOPY:DAT ^
	/XD "%src%\AppData" ^
	/LOG+:%logpath%

pause
