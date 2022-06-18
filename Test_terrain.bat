@echo off
color 2f
setlocal enabledelayedexpansion
mode con cols=238 lines=83

set npierre=1
:b
cls
set /a startx=%random%%%100
set /a starty=%random%%%50
for /l %%b in (1,1,1) do (
	call :setpierre %%b
)
pause>nul
goto :b

:setpierre

set /a randpierre=%random%%%1

if %randpierre%==0 (

	
	set x1%1=%startx%
	set /a x2%1=%startx%+1
	set /a x3%1=%startx%-1
	set /a x4%1=%startx%+2
	set /a x5%1=%startx%-2
	set /a x6%1=%startx%+3
	set /a x7%1=%startx%-3
	
	set y1%1=%starty%
	set /a y2%1=%starty%-1
	set /a y3%1=%starty%-2
	set /a y4%1=%starty%-3
	
	
	set bp1%1=!x1%1!a!y1%1!
	set bp2%1=!x2%1!a!y1%1!
	set bp3%1=!x3%1!a!y1%1!
	set bp4%1=!x4%1!a!y1%1!
	set bp5%1=!x5%1!a!y1%1!
	set bp6%1=!x1%1!a!y2%1!
	set bp7%1=!x2%1!a!y2%1!
	set bp8%1=!x3%1!a!y2%1!
	set bp9%1=!x4%1!a!y2%1!
	set bp10%1=!x5%1!a!y3%1!
	set bp11%1=!x1%1!a!y3%1!
	set bp12%1=!x2%1!a!y3%1!
	set bp13%1=!x3%1!a!y3%1!
	
	set bp14%1=!x6%1!a!y1%1!
	set bp15%1=!x7%1!a!y1%1!
	set bp16%1=!x6%1!a!y2%1!
	set bp17%1=!x7%1!a!y2%1!
	set bp16%1=!x4%1!a!y3%1!
	set bp17%1=!x5%1!a!y3%1!
	
	
	batbox /g !x1%1! !y1%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x2%1! !y1%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x3%1! !y1%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x4%1! !y1%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x5%1! !y1%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x1%1! !y2%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x2%1! !y2%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x3%1! !y2%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x4%1! !y2%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x5%1! !y2%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x1%1! !y3%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x2%1! !y3%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x3%1! !y3%1! /c 0x28 /a 178 /c 0x2f
	
	batbox /g !x6%1! !y1%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x7%1! !y1%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x6%1! !y2%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x7%1! !y2%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x4%1! !y3%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x5%1! !y3%1! /c 0x28 /a 178 /c 0x2f
	
	
	goto :eof
	
)

if %randpierre%==1 (

	
	set x1%1=%startx%
	set /a x2%1=%startx%+1
	set /a x3%1=%startx%-1
	set /a x4%1=%startx%+2
	set /a x5%1=%startx%-2
	set /a x6%1=%startx%+3
	set /a x7%1=%startx%-3
	
	set y1%1=%starty%
	set /a y2%1=%starty%-1
	set /a y3%1=%starty%-2
	set /a y4%1=%starty%-3
	
	
	set bp1%1=!x1%1!a!y1%1!
	set bp2%1=!x2%1!a!y1%1!
	set bp3%1=!x3%1!a!y1%1!
	set bp4%1=!x4%1!a!y1%1!
	set bp5%1=!x5%1!a!y1%1!
	set bp6%1=!x1%1!a!y2%1!
	set bp7%1=!x2%1!a!y2%1!
	set bp8%1=!x3%1!a!y2%1!
	set bp9%1=!x4%1!a!y2%1!
	set bp10%1=!x5%1!a!y3%1!
	set bp11%1=!x1%1!a!y3%1!
	set bp12%1=!x2%1!a!y3%1!
	set bp13%1=!x3%1!a!y3%1!
	
	
	
	batbox /g !x1%1! !y1%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x2%1! !y1%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x3%1! !y1%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x4%1! !y1%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x5%1! !y1%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x1%1! !y2%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x2%1! !y2%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x3%1! !y2%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x4%1! !y2%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x5%1! !y2%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x1%1! !y3%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x2%1! !y3%1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x3%1! !y3%1! /c 0x28 /a 178 /c 0x2f
	
	goto :eof
)