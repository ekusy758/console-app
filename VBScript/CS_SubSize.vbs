'--------------------------------------------------------------------------
' <CS_SubSize.vbs> Encode:S-JIS
'  �T�v�FCScript ���s�ŃT�u�t�H���_�̃T�C�Y���擾����
'  �����F�����P�Őe�p�X���w��A����������Script����
'--------------------------------------------------------------------------

Option Explicit
Call Main()

'--------------------------------------------------------------------------
' <Main>
'  �T�v�F�v���O�����J�n�^�I���𐧌�
'--------------------------------------------------------------------------
Sub Main()

    WScript.Echo("ScriptMsg: �v���O�������J�n���܂�")
    WScript.Echo("---------------------------------")
    WScript.Echo("")

    Call Process()

    WScript.Echo("")
    WScript.Echo("---------------------------------")
    WScript.Echo("ScriptMsg: �v���O�������I�����܂�")

    WScript.Quit(0)

End Sub

'--------------------------------------------------------------------------
' <Process>
'  �T�v�F�v���O�����̎葱���𐧌�A��ƃf�B���N�g���ݒ�
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
        WScript.Echo(workDir & " �̃T�u�t�H���_���������܂�" & vbCrLf)
        WScript.Echo("Name" & vbTab & "Size (Byte)")
        WScript.Echo("----" & vbTab & "-----------")
        Call SubSizeLogic(workDir)
    Else
        WScript.Echo(workDir & " ��������܂���")
    End If

End Sub

'--------------------------------------------------------------------------
' <SubSizeLogic>
'  �T�v�F�T�u�t�H���_�̃T�C�Y���o�͂��郍�W�b�N
'  �����F�e�t�H���_�̃p�X
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
            ' �A�N�Z�X�ł��Ȃ��t�H���_ (���s���G���[: �������݂ł��܂���B)
            WScript.Echo(f.Name & " �̓T�C�Y���擾�ł��܂���")
        End If
    Next

    On Error Goto 0

    WScript.Echo(vbCrLf & "(�T�u�t�H���_��: " & count & ")")

End Sub

'--------------------------------------------------------------------------
' <FormatSize>
'  �T�v�F�o�C�g���l���œK�ȒP�ʂɕϊ����� (GB/MB/KB/�o�C�g)
'  �����F�o�C�g���l
'  ���l�F�W��FormatNumber�֐��̈���
'        ��P����  �t�H�[�}�b�g���鐔�l���w��
'        ��Q����  �����_�ȉ��̕\������
'        ��R����  �����_�̍�����0��\�����邽��-1���w��
'        ��S����  ���̒l��()�ň͂܂Ȃ�����0���w��
'        ��T����  ����؂�L����\�����Ȃ�����0���w��
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
        FormatSize = FormatNumber(byteSize, 2, -1, 0, 0) & "�o�C�g"
    End If

End Function