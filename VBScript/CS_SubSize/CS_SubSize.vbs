'--------------------------------------------------------------------------
' <CS_SubSize.vbs> Encode:S-JIS
'  概要：CScript 実行でサブフォルダのサイズを取得する
'  引数：引数１で親パスを指定、引数無しはScript直下
'--------------------------------------------------------------------------

Option Explicit
Call Main()

'--------------------------------------------------------------------------
' <Main>
'  概要：プログラム開始／終了を制御
'--------------------------------------------------------------------------
Sub Main()

    WScript.Echo("ScriptMsg: プログラムを開始します")
    WScript.Echo("---------------------------------")
    WScript.Echo("")

    Call Process()

    WScript.Echo("")
    WScript.Echo("---------------------------------")
    WScript.Echo("ScriptMsg: プログラムを終了します")

    WScript.Quit(0)

End Sub

'--------------------------------------------------------------------------
' <Process>
'  概要：プログラムの手続きを制御、作業ディレクトリ設定
'--------------------------------------------------------------------------
Sub Process()

    Dim argc
    argc = WScript.Arguments.Count

    Dim fso
    Set fso = CreateObject("Scripting.FileSystemObject")

    Dim vbsDir
    vbsDir = fso.GetParentFolderName(WScript.ScriptFullName)

    Dim workDir
    If (argc > 0) Then
        workDir = WScript.Arguments(0)
    Else
        workDir = vbsDir
    End If

    If (fso.FolderExists(workDir)) Then
        WScript.Echo(workDir & " のサブフォルダを処理します" & vbCrLf)
        WScript.Echo("Name" & vbTab & "Size (Byte)")
        WScript.Echo("----" & vbTab & "-----------")
        Call SubSizeLogic(workDir)
    Else
        WScript.Echo(workDir & " が見つかりません")
    End If

End Sub

'--------------------------------------------------------------------------
' <SubSizeLogic>
'  概要：サブフォルダのサイズを出力するロジック
'  引数：親フォルダのパス
'--------------------------------------------------------------------------
Sub SubSizeLogic(path)

    Dim folder, f, count
    Set folder = CreateObject("Scripting.FileSystemObject").GetFolder(path)
    count = 0

    On Error Resume Next

    For Each f In folder.SubFolders
        count = count + 1
        If Not (Err.Number = 70) Then
            WScript.Echo(f.Name & vbTab & FormatSize(f.Size))
        Else
            ' アクセスできないフォルダ (実行時エラー: 書き込みできません。)
            WScript.Echo(f.Name & " はサイズを取得できません")
        End If
    Next

    On Error Goto 0

    WScript.Echo(vbCrLf & "(サブフォルダ数: " & count & ")")

End Sub

'--------------------------------------------------------------------------
' <FormatSize>
'  概要：バイト数値を最適な単位に変換する (GB/MB/KB/バイト)
'  引数：バイト数値
'  備考：標準FormatNumber関数の引数
'        第１引数  フォーマットする数値を指定
'        第２引数  小数点以下の表示桁数
'        第３引数  小数点の左側の0を表示するため-1を指定
'        第４引数  負の値を()で囲まないため0を指定
'        第５引数  桁区切り記号を表示しないため0を指定
'--------------------------------------------------------------------------
Function FormatSize(byteSize)

    Const GB_Size = 1073741824
    Const MB_Size = 1048576
    Const KB_Size = 1024

    If (byteSize >= GB_Size) Then
        FormatSize = FormatNumber(byteSize / GB_Size, 2, -1, 0, 0) & "GB"
    ElseIf (byteSize >= MB_Size) Then
        FormatSize = FormatNumber(byteSize / MB_Size, 2, -1, 0, 0) & "MB"
    ElseIf (byteSize >= KB_Size) Then
        FormatSize = FormatNumber(byteSize / KB_Size, 2, -1, 0, 0) & "KB"
    Else
        FormatSize = FormatNumber(byteSize, 2, -1, 0, 0) & "バイト"
    End If

End Function