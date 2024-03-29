@Echo Off
Rem subsize.bat (Encode:S-JIS)
Rem CS_SubSize.vbs ŒÄ‚Ño‚µƒoƒbƒ`

Set BatDir=%~dp0
Set Arg=%1
If "%Arg%" == "" (
    Set Arg=%BatDir%
)
Echo subsize.bat: CScript /nologo %BatDir%CS_SubSize.vbs %Arg%
Echo;
CScript /nologo %BatDir%CS_SubSize.vbs %Arg%
