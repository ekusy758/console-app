@echo off
rem ---------------------------------------------------------------------------
rem  [ミラーリング処理実行バッチ] 
rem  使い方: cmdで引数にコピー元、コピー先を指定し実行する
rem  作成日: 2025/08/26
rem ---------------------------------------------------------------------------

rem コピー元、コピー先を設定
set src="%1"
set dst="%2"
if %src% == "" ( goto :ABEND )
if %dst% == "" ( goto :ABEND )

rem スクリプトフォルダへ移動
set cur=%~dp0
cd %cur%

rem ログファイル設定 (mirlogs/YYMMDD_HHMMSS_mir.logに出力)
set logdir="%cur%\mirlogs"
if not exist "%logdir%" ( mkdir %logdir% )

rem " "を"0"に変換する操作を追加
set datetime=%date:/=%_%time:~0,8%
set datetime=%datetime::=%
set datetime=%datetime: =0%
set logfile=%logdir%\%datetime%_mir.log

rem ミラーリング処理実行 (除外フォルダがあれば、/XDに指定)
robocopy %src% %dst% /MIR /R:0 /W:0 /NP /TEE /XJD /XJF /DCOPY:DAT ^
  /XD "AppData" ^
  /LOG+:%logfile%

pause
exit /b 0

rem エラー処理定義
:ABEND
  echo エラー: 引数が正しくありません。
  echo 第1引数にコピー元フォルダを指定します。値: %src%
  echo 第2引数にコピー先フォルダを指定します。値: %dst%
  exit /b -1
