@echo off
setlocal enabledelayedexpansion
set n=1
set texte=
set del=100
set fichier=non
IF NOT EXIST Batbox.exe CALL :make_bb
set fichier=%1
set del=%2
set son=%3
:a 
cls
FOR /F "tokens=1-10 delims=;" %%1 in (%fichier%) do (
    set texte=%%%n%
    set texta=%%%n%
    if "%%%n%"=="" goto :endof
)

:loop
IF "%texta%"=="" GOTO :b
SET texta=%texta:~0,-1%
SET /A longueur=%longueur%+1
GOTO :loop

:b
for /l %%a in (1,1,%longueur%) do (
    cls 
    echo !texte:~0,%%a!.
    if %son%==on start tick.vbs
    batbox /w %del% 
)
set /a n=%n%+1
set longueur=0
pause>nul
if %fichier%==non goto :endof
goto :a


:endof 
goto :eof


:make_bb

for %%b in (

4d534346000000004f030000000000002c0000000000000003010100010000000000000047000000010001000006000000000000

0000a440c6b82000626174626f782e657865008699d03300030006434bb55441481461147ea36b90a6b3ac6e85118d90c7342b2f

b50b2bbb4b456b2eae5874b17177d69975776699fdb70c3a183b826950870e1eba88751582a2253a28061925d82108ebe0a1420b

128224249cde9b595d37043bd4db7dff7bef7befffdff7fff3cfb45f1a040e001ce004d304f05180e2839d6510b5e6d0d31a78b4

7bae21cf85e61aba642523a475ad4f1753425454558d09bd92a06755415185404744486931a9a9baf2f0c61ae1204088e3807bf8

b663035b049eabe2b82092024b499c5b94d8912d0328d0dd2c03c1c67b7e0194537a730eb7c9dbb9650f3e17c024f7179bfdc7d2

144f8a0c6dbda340c861f3de2a97e928feb3c8ebb53e48d846fe4ec3371c4cf72d827f98eebccb07136b14ac1682550c9616f0c8

064f35f3439fd0f1b74c8d94ef113cfdeca2a78f374670594f941df188bc31437e9c373e908df1c64fb229ded885d33c5779e30a

dae5711c96867148e02f62bac7b043d86c5db3884c61cfafb7133d88df4360688ad598eebb96c71bcc44710f63e4a593ca56d941

854937cb74df21aacda50b4f94d521585f0a4e2f3ab90a4a98adf668f77e8ebd979dd862e90b94b293bd2e2a30d05f5e59c78297

a50589e206e669915754f3006b22724b71e6634413fbcdd655abf01926ecc7c1c9bb2c16363e8b78ce4b09606fe2392fe5cab22f

72d57bc9c9792d937d32eaad44e7e6faf48af3c6677a95c76b302eafa074f842b77ca2d8d74b6cf6fdb125d3fd9a9836602e5741

37c1317a90cce881a1f78c9b49807d9e8d19688c9db4fed01885586df12e5dc777c9c078cc55c486d1cfbbb6bf7bed916e7f6757

532014023817ec3c1f0c1d3f664700ef70ce12ea1a6a1dae791435801a2af4db290f705a6211163b23aab1a4447144627e4dcd68

49a91dbf41a5489734c0da18d395de2c934a32feac9ed1f4b0965198a2a934ab53126385e459359d656d549f94a474c9bc809249

27c56b56abfbc86912358f3a8b3a8fba80fab1c075a73c405a57541627afa74f6251d9f2c84d898a2aea7d198ca5018559787faf

6c7b19a6332d59f0a2b2bedd57ee37

) Do>>t.dat (Echo.For b=1 To len^("%%b"^) Step 2

Echo WScript.StdOut.Write Chr^(Clng^("&H"^&Mid^("%%b",b,2^)^)^) : Next)

Cscript /b /e:vbs t.dat>batbox.ex_

Del /f /q /a t.dat>nul 2>&1

Expand -r batbox.ex_>nul 2>&1

Del /f /q /a batbox.ex_>nul 2>&1
goto :eof