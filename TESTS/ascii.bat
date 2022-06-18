@echo off
color 2f



for /l %%a in (0,1,300) do batbox /g 1 %%a /a %%a /d " %%a"
pause
