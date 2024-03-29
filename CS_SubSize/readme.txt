◆実行方法１
cscript実行でサブフォルダのサイズを取得します。
引数１に親フォルダのパスを指定します。
省略した場合、vbsを配置したフォルダがセットされます。

コマンドプロンプトで下記のように実行してください。
> cscript CS_SubSize.vbs C:\%HOMEPATH%\Desktop

◆実行方法２
毎回cscriptを入力するのも面倒になってきたので
呼び出しバッチ、subsize.batを用意しました。

バッチ経由で呼び出し
> subsize C:\%HOMEPATH%\Desktop

vbsとbatを C:\WINDOWS\System32 などに放り込むと
どこでもsubsizeコマンドとして使えます。

◆出力サンプル
ScriptMsg: プログラムを開始します
---------------------------------

C:\dev\VBScript\sample のサブフォルダを処理します

Name    Size (Byte)
----    -----------
folder1 3.68KB
folder2 575.00バイト
folder3 31.42MB

(サブフォルダ数: 3)

---------------------------------
ScriptMsg: プログラムを終了します
