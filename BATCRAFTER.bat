@echo off
setlocal enabledelayedexpansion
title BATCRAFTER
color 2f
::----------récupération de la résolution d'écran------------------------
for /f "delims=" %%# in  ('"wmic path Win32_VideoController  get CurrentHorizontalResolution,CurrentVerticalResolution /format:value"') do (
  set "%%#">nul
)

if %CurrentHorizontalResolution%==1920 if %CurrentVerticalResolution%==1080 (
set maxcol=238
set maxline=83
set maxcol1=236
set maxline1=81
set maxcol2=237
set maxline2=82
set maxcolspr=1888
set maxlinespr=972
)
if %CurrentHorizontalResolution%==1600 if %CurrentVerticalResolution%==900 (
set maxcol=200
set maxline=69
set maxcol1=198
set maxline1=67
set maxcol2=199
set maxline2=68
set maxcolspr=1584
set maxlinespr=816
)
::-----------------------------------------------------------------------
::definition des valeurs

mode con cols=%maxcol% lines=%maxline%
set /a coinbasx=%maxcol%-32
set /a coinbasy=%maxline%-1
set select=jouer
set m=0
set mpierre=0
set mfour=0
set zriv=non
set zone=overworld
set nriv=0
set c1=20
set spre=o
set l1=11
set color1=2f
set color2=22
set xspr=160
set yspr=132
set n4=0
set mt=0
set tick=0
set nar=21
set nbloc=0
set rot=h
set lastdir=bas
set position=1pl
set nfl=50
set hitengage=non
set zx=0
set zxa=0
set zya=0
set n12=0
set mp=0
set mpr=0
set zy=0
set biome=plaine
set hitengagep=non
set 0=0
set sons=on
set me=0
set mexs=0 
set loadest=load
set gendest=generation
set tapxs=0
set nar1=20
set color3=28
set dest=%zx%%zy%
::check si BATBOX existe


::check si les vbs fonctionnent 
start %CD%\Sons\test.vbs
if %errorlevel% neq 0 set sons=off

::check si le dossier "saves" existe 
IF not exist "%CD%\saves\*.*" MD %CD%\saves
::check si le dossier "config" existe 
IF not exist "%CD%\config.txt" call :Makeconfig
::check pour la sauvegarde de val 
if not exist "%CD%\saves\val.save" echo !m!;!mt!;!mp!;!me!;!mpr!;!mpierre!;!mfour!>%CD%\saves\val.save
::check pour la sauvegarde de pos
if not exist "%CD%\saves\player.save" echo !zx!;!zy!;!c1!;!l1!>%CD%\saves\player.save
::check pour le fichier temp 
if not exist "%CD%\saves\temp.t" echo jouer;>%CD%\saves\temp.t
::check pour la sauvegarde d'inventaire 
if not exist "%CD%\saves\inventaire.save" (
    echo slot1;vide;!0!>>%CD%\saves\inventaire.save
    echo slot2;vide;!0!>>%CD%\saves\inventaire.save
    echo slot3;vide;!0!>>%CD%\saves\inventaire.save
    echo slot4;vide;!0!>>%CD%\saves\inventaire.save
    echo slot5;vide;!0!>>%CD%\saves\inventaire.save
    echo slot6;vide;!0!>>%CD%\saves\inventaire.save
    echo slot7;vide;!0!>>%CD%\saves\inventaire.save
    echo slot8;vide;!0!>>%CD%\saves\inventaire.save

)

for /f "tokens=1-4 delims=;" %%g in (%CD%\saves\player.save) do (
    set zx=%%g
    set zy=%%h
    set c1=%%i
    set l1=%%j
    set /a xspr=%%i*8
    set /a yspr=%%j*12
)
for /f "tokens=1,2 delims=:" %%g in (%CD%\config.txt) do (
	if %%g==taux_generation_rivieres set config_randriviere=%%h
	if %%g==taux_generation_forets set config_randforet=%%h
	if %%g==nombre_arbres_generation set config_arbres=%%h
	if %%g==nombre_fleurs_generation set config_fleurs=%%h
	if %%g==nombre_pierres_generation set config_pierre=%%h
	if %%g==probabilite_biomes set config_biomes=%%h
	if %%g==probabilite_mines set config_mines=%%h
	if !config_randriviere!==0 set config_randriviere=9999999
	if !config_randforet!==0 set config_randforet=9999999
    if !config_biomes!==0 set config_biomes=9999999

)



::check pour une sauvegarde
if exist %CD%\saves\%zx%%zy%.save goto :load

for /f "tokens=1,2 delims=;" %%g in (%CD%\saves\zoneinfo.save) do (
	if a%zx%%zy%==%%g set zarbre=%%h 
	if r%zx%%zy%==%%g set zriv=oui
	if f%zx%%zy%==%%g set zfleur=%%h
	if nr%zx%%zy%==%%g set nbriv=%%h
)
for /f "tokens=1,2,3 delims=;" %%g in (%CD%\saves\inventaire.save) do (
    if slot1==%%g (
        set invslot1=%%h
        set i1nb=%%i
    )
    if slot2==%%g (
        set invslot2=%%h
        set i2nb=%%i
    )
    if slot3==%%g (
        set invslot3=%%h
        set i3nb=%%i
    )
    if slot4==%%g (
        set invslot4=%%h
        set i4nb=%%i
    )   
    if slot5==%%g (
        set invslot5=%%h
        set i5nb=%%i
    )
    if slot6==%%g (
        set invslot6=%%h
        set i6nb=%%i
    )
    if slot7==%%g (
        set invslot7=%%h
        set i7nb=%%i
    )
    if slot8==%%g (
        set invslot8=%%h
        set i8nb=%%i
    )     

)

goto :generation


:Makeconfig
echo CONFIGURER LA GENERATION DU TERRAIN>>config.txt
echo ----------------------------------->>config.txt
echo valeur a "0" = option desactivee>>config.txt
echo. >>config.txt
echo taux_generation_rivieres:5>>config.txt
echo probabilite_biomes:10>>config.txt
echo probabilite_mines:5>>config.txt
echo nombre_arbres_generation:10>>config.txt
echo nombre_fleurs_generation:15>>config.txt
echo nombre_pierres_generation:8>>config.txt
goto :eof

::------------------------------------------------------------------------------------------------------------------------------------------------------------
:tableau
batbox /g %coinbasx% %coinbasy% /d "BATCRAFTER ALPHA BY SPEEDCOOKIE"
batbox /g 113 0 /c 0x%color1% /d "biome:%biome%"

:tableau1

if %select%==jouer (
batbox /g 0 0 /c 0x%color2% /d 000000000000000000000000000000000000000000 /c %color1%
batbox /g 0 1 /c 0x%color2%  /d 0000000000000 /c %color1%
)

if not %select%==jouer (
batbox /g 0 0 /c 0x%color1% /d "!invslot%slotselect%! !i%slotselect%nb!"
batbox /g 0 1 /c 0x%color1% /d ROTATION
batbox /g 0 2 /c 0x%color1% /d QUITTER 
)

if %select%==jouer goto :sprite

::check pour un clic

for /f "tokens=1,2,3 delims=:" %%a in ('batbox /m') do (
set c=%%c
set y=%%b
set x=%%a
)

if %select%==construction (
	if %nbloc%==0 goto :fingame
)

if %c%==3 (
	 if %x% gtr 0 if %x% lss 9 if %y%==1 (
     if %rot%==h set rot=v
     if %rot%==v set rot=h
     goto :tableau1
    )
    if %x% gtr 0 if %x% lss 9 if %y%==2 (
        set select=jouer 
        goto :save
    )
    if %select%==construction goto :AddMur
    
) 

if %c%==6 (
    goto :CasserMur
)


goto :tableau1

:fingame
set invslot%slotselect%=vide
set i%slotselect%nb=0
del %CD%\saves\inventaire.save
echo slot1;%invslot1%;!i1nb!>>%CD%\saves\inventaire.save
echo slot2;%invslot2%;!i2nb!>>%CD%\saves\inventaire.save
echo slot3;%invslot3%;!i3nb!>>%CD%\saves\inventaire.save
echo slot4;%invslot4%;!i4nb!>>%CD%\saves\inventaire.save
echo slot5;%invslot5%;!i5nb!>>%CD%\saves\inventaire.save
echo slot6;%invslot6%;!i6nb!>>%CD%\saves\inventaire.save
echo slot7;%invslot7%;!i7nb!>>%CD%\saves\inventaire.save
echo slot8;%invslot8%;!i8nb!>>%CD%\saves\inventaire.save
set select=jouer
goto :save

:sprite
:: mouvements du sprite
batbox /g 0 0
if %c1% gtr %maxcol2% goto :zdroite
if %c1% lss 0 goto :zgauche
if %l1% gtr %maxline2% goto :zbas
if %l1% lss 0 goto :zhaut
if %position%==1pl INSERTBMP /p:"textures\perso.bmp" /x:%xspr% /y:%yspr%

::check passage derriere arbre 

for /l %%a in (0,1,%nar%) do (
    if %c1%%l1%==!xa%%a!!yaa%%a! batbox /g %c1% %l1% /c 0x26 /a 219 /c 0x2f & goto :keys
    if %c1%%l1%==!xa%%a!!yab%%a! batbox /g %c1% %l1% /c 0x26 /a 219 /c 0x2f & goto :keys
    if %c1%%l1%==!xa%%a!!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f & goto :keys
    if %c1%%l1%==!xac%%a!!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f & goto :keys
    if %c1%%l1%==!xad%%a!!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f & goto :keys
    if %c1%%l1%==!xa%%a!!yad%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f & goto :keys
    if %c1%%l1%==!posfexa%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f & goto :keys
    if %c1%%l1%==!posfexb%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f & goto :keys
)

if %position%==1pl INSERTBMP /p:"textures\perso.bmp" /x:%xspr% /y:%yspr%

goto :keys

:keys

::detection touches mouvement
batbox /k_
if %errorlevel%==327 goto :haut
if %errorlevel%==335 goto :bas
if %errorlevel%==330 goto :gauche
if %errorlevel%==332 goto :droite 
if %errorlevel%==122 goto :haut
if %errorlevel%==115 goto :bas
if %errorlevel%==113 goto :gauche
if %errorlevel%==100 goto :droite 
if %errorlevel%==32 goto :hit
if %errorlevel%==101 goto :action
if %errorlevel%==105 goto :openinv
if %errorlevel%==9 goto :save
goto :sprite


:openinv

if %i1nb%==0 (
	set invslot1aff=%invslot1%
	) else (
	set invslot1aff=%invslot1%    %i1nb%
	)
if %i2nb%==0 (
	set invslot2aff=%invslot2%
	) else (
	set invslot2aff=%invslot2%    %i2nb%
	)
if %i3nb%==0 (
	set invslot3aff=%invslot3%
	) else (
	set invslot3aff=%invslot3%    %i3nb%
	)
if %i4nb%==0 (
	set invslot4aff=%invslot4%
	) else (
	set invslot4aff=%invslot4%    %i4nb%
	)
if %i5nb%==0 (
    set invslot5aff=%invslot5%
    ) else (
    set invslot5aff=%invslot5%    %i5nb%
    )
if %i6nb%==0 (
    set invslot6aff=%invslot6%
    ) else (
    set invslot6aff=%invslot6%    %i6nb%
    )
if %i7nb%==0 (
    set invslot7aff=%invslot7%
    ) else (
    set invslot7aff=%invslot7%    %i7nb%
    )
if %i8nb%==0 (
    set invslot8aff=%invslot8%
    ) else (
    set invslot8aff=%invslot8%    %i8nb%
    )

CALL :ShowGui_ "%~0" #Inventaire
if %slot1%==1 (
set slotselect=1
goto :select_%invslot1%
)
if %slot2%==1 (
set slotselect=2
goto :select_%invslot2%
)
if %slot3%==1 (
set slotselect=3
goto :select_%invslot3%
)
if %slot4%==1 (
set slotselect=4
goto :select_%invslot4%
)
if %slot5%==1 (
set slotselect=5
goto :select_%invslot5%
)
if %slot6%==1 (
set slotselect=6
goto :select_%invslot6%
)
if %slot7%==1 (
set slotselect=7
goto :select_%invslot7%
)
if %slot8%==1 (
set slotselect=8
goto :select_%invslot8%
)

if %detruire%==1 (
set select=detruire
goto :tableau
)
if %craft%==1 (
	goto :craft_inv
	)
goto :sprite

::#Inventaire
::Window "INVENTAIRE" 295 350
::Button "Retour" "Retour" 100 250 80 30
::Button "detruire" "Detruire" 50 210 80 30
::Button "craft" "Craft" 150 210 80 30
::Button "slot8" "%invslot8aff%" 150 160 120 35
::Button "slot6" "%invslot6aff%" 150 110 120 35
::Button "slot4" "%invslot4aff%" 150 60 120 35
::Button "slot2" "%invslot2aff%" 150 10 120 35
::Button "slot7" "%invslot7aff%" 10 160 120 35
::Button "slot5" "%invslot5aff%" 10 110 120 35
::Button "slot3" "%invslot3aff%" 10 60 120 35
::Button "slot1" "%invslot1aff%" 10 10 120 35
::#EndGui



:craft_inv
set zcr=craft_inv
CALL :ShowGui_ "%~0" #craft_inv

if %Craft_planches%==1 (
set craft=planches
set ncraft1=2
goto :howmuch
)

if %Craft_etabli%==1 (
set craft=etabli
set ncraft1=1
goto :howmuch
)

if %retour%==1 goto :openinv

goto :tableau

::#craft_inv
::Window "CRAFT" 400 320
::Text "Besoin" 195 10 50 30
::Text "Planches de bois x2" 10 50 150 15
::Text "Buche x1" 190 50 100 15
::Text "Etabli x1" 10 90 150 15
::Text "Planches x8" 190 90 100 15
::Button "Craft_planches" "Crafter" 300 40 70 30
::Button "Craft_etabli" "Crafter" 300 80 70 30
::Button "Retour" "Retour" 150 200 80 30

::#EndGui





:howmuch
CALL :ShowGui_ "%~0" #combien

set nbcraft=%nbcraft%
if %OK%==1 goto :craft_%craft%
goto :%zcr%
::#combien
::Window "" 250 110
::Edit "nbcraft" "" 80 10 60 20
::Text "Combien?" 10 10 60 15
::Text "x%ncraft1% %craft%" 150 12 200 15
::Button "OK" "Valider" 10 35 70 30
::Button "retour" "Retour" 95 35 70 30
::#EndGui



:open_etabli
set zcr=open_etabli
CALL :ShowGui_ "%~0" #craft_etabli

if %Craft_planches%==1 (
set craft=planches
set ncraft1=2
goto :howmuch
)

if %Craft_etabli%==1 (
set craft=etabli
set ncraft1=1
goto :howmuch
)

if %Craft_porte%==1 (
set craft=porte
set ncraft1=1
goto :howmuch
)

if %Craft_four%==1 (
set craft=four
set ncraft1=1
goto :howmuch
)

goto :tableau

::#craft_etabli
::Window "ETABLI" 400 320
::Text "Besoin" 195 10 50 30
::Text "Planches de bois x2" 10 50 150 15
::Text "Buche x1" 190 50 100 15
::Text "Etabli x1" 10 90 150 15
::Text "Planches x8" 190 90 100 15
::Text "pierre x8" 190 170 100 15
::Text "Porte x1" 10 130 130 15
::Text "Four x1" 10 170 130 15
::Text "Planches x8" 190 130 100 15
::Button "Craft_planches" "Crafter" 300 40 70 30
::Button "Craft_etabli" "Crafter" 300 80 70 30
::Button "Craft_porte" "Crafter" 300 120 70 30
::Button "Craft_four" "Crafter" 300 160 70 30
::Button "Retour" "Retour" 150 240 80 30
::#EndGui



:select_buche
set bloc=buche
set select=construction
set nbloc=!i%slotselect%nb!
goto :tableau

:select_planches
set bloc=planches
set select=construction
set nbloc=!i%slotselect%nb!
goto :tableau

:select_etabli
set bloc=etabli
set select=construction
set nbloc=!i%slotselect%nb!
goto :tableau

:select_porte
set bloc=porte
set select=construction
set nbloc=!i%slotselect%nb!
goto :tableau

:select_pierre
set bloc=pierre
set select=construction
set nbloc=!i%slotselect%nb!
goto :tableau

:select_four
set bloc=four
set select=construction
set nbloc=!i%slotselect%nb!
goto :tableau



:craft_planches
set objmq=buche
set /a craft_tot=%nbcraft%
set /a nbcraftfin=2*%nbcraft%
if %invslot1%==buche (
    set tot_item=%i1nb%
    set slotselect=1
    goto :next_craft3
)
if %invslot2%==buche (
    set tot_item=%i2nb%
    set slotselect=2
    goto :next_craft3
)
if %invslot3%==buche (
    set tot_item=%i3nb%
    set slotselect=3
    goto :next_craft3
)
if %invslot4%==buche (
    set tot_item=%i4nb%
    set slotselect=4
    goto :next_craft3
)
if %invslot5%==buche (
    set tot_item=%i5nb%
    set slotselect=5
    goto :next_craft3
)
if %invslot6%==buche (
    set tot_item=%i6nb%
    set slotselect=6
    goto :next_craft3
)
if %invslot7%==buche (
    set tot_item=%i7nb%
    set slotselect=7
    goto :next_craft3
)
if %invslot8%==buche (
    set tot_item=%i8nb%
    set slotselect=8
    goto :next_craft3
)

goto :pas_dutout

:Craft_etabli
set objmq=planches
set /a craft_tot=8*%nbcraft%
set /a nbcraftfin=%nbcraft%
if %invslot1%==planches (
    set tot_item=%i1nb%
    set slotselect=1
    goto :next_craft3
)
if %invslot2%==planches (
    set tot_item=%i2nb%
    set slotselect=2
    goto :next_craft3
)
if %invslot3%==planches (
    set tot_item=%i3nb%
    set slotselect=3
    goto :next_craft3
)
if %invslot4%==planches (
    set tot_item=%i4nb%
    set slotselect=4
    goto :next_craft3
)
if %invslot5%==planches (
    set tot_item=%i5nb%
    set slotselect=5
    goto :next_craft3
)
if %invslot6%==planches (
    set tot_item=%i6nb%
    set slotselect=6
    goto :next_craft3
)
if %invslot7%==planches (
    set tot_item=%i7nb%
    set slotselect=7
    goto :next_craft3
)
if %invslot8%==planches (
    set tot_item=%i8nb%
    set slotselect=8
    goto :next_craft3
)

goto :pas_dutout

:Craft_porte
set objmq=planches
set /a craft_tot=8*%nbcraft%
set /a nbcraftfin=%nbcraft%
if %invslot1%==planches (
    set tot_item=%i1nb%
    set slotselect=1
    goto :next_craft3
)
if %invslot2%==planches (
    set tot_item=%i2nb%
    set slotselect=2
    goto :next_craft3
)
if %invslot3%==planches (
    set tot_item=%i3nb%
    set slotselect=3
    goto :next_craft3
)
if %invslot4%==planches (
    set tot_item=%i4nb%
    set slotselect=4
    goto :next_craft3
)
if %invslot5%==planches (
    set tot_item=%i5nb%
    set slotselect=5
    goto :next_craft3
)
if %invslot6%==planches (
    set tot_item=%i6nb%
    set slotselect=6
    goto :next_craft3
)
if %invslot7%==planches (
    set tot_item=%i7nb%
    set slotselect=7
    goto :next_craft3
)
if %invslot8%==planches (
    set tot_item=%i8nb%
    set slotselect=8
    goto :next_craft3
)

goto :pas_dutout


:Craft_four
set objmq=pierre
set /a craft_tot=8*%nbcraft%
set /a nbcraftfin=%nbcraft%
if %invslot1%==pierre (
    set tot_item=%i1nb%
    set slotselect=1
    goto :next_craft3
)
if %invslot2%==pierre (
    set tot_item=%i2nb%
    set slotselect=2
    goto :next_craft3
)
if %invslot3%==pierre (
    set tot_item=%i3nb%
    set slotselect=3
    goto :next_craft3
)
if %invslot4%==pierre (
    set tot_item=%i4nb%
    set slotselect=4
    goto :next_craft3
)
if %invslot5%==pierre (
    set tot_item=%i5nb%
    set slotselect=5
    goto :next_craft3
)
if %invslot6%==pierre (
    set tot_item=%i6nb%
    set slotselect=6
    goto :next_craft3
)
if %invslot7%==pierre (
    set tot_item=%i7nb%
    set slotselect=7
    goto :next_craft3
)
if %invslot8%==pierre (
    set tot_item=%i8nb%
    set slotselect=8
    goto :next_craft3
)

goto :pas_dutout



:next_craft3
if %tot_item% lss %craft_tot% (
	goto :pas_assez
)

set /a i%slotselect%nb=!i%slotselect%nb!-%craft_tot%
goto :next_craft




:next_craft
if %i1nb%==0 (
	set invslot1=vide
	goto :next_craft2
)
if %i2nb%==0 (
	set invslot2=vide
	goto :next_craft2
)
if %i3nb%==0 (
	set invslot3=vide
	goto :next_craft2
)
if %i4nb%==0 (
	set invslot4=vide
	goto :next_craft2
)
if %i5nb%==0 (
    set invslot5=vide
    goto :next_craft2
)
if %i6nb%==0 (
    set invslot6=vide
    goto :next_craft2
)
if %i7nb%==0 (
    set invslot7=vide
    goto :next_craft2
)
if %i8nb%==0 (
    set invslot8=vide
    goto :next_craft2
)

:next_craft2

if %invslot1%==%craft% (
    set /a i1nb=%nbcraftfin%+%i1nb%
    goto :save
)
if %invslot2%==%craft% (
    set /a i2nb=%nbcraftfin%+%i2nb%
    goto :save
)
if %invslot3%==%craft% (
    set /a i3nb=%nbcraftfin%+%i3nb%
    goto :save
)
if %invslot4%==%craft% (
    set /a i4nb=%nbcraftfin%+%i4nb%
 	goto :save
)
if %invslot5%==%craft% (
    set /a i5nb=%nbcraftfin%+%i5nb%
    goto :save
)
if %invslot6%==%craft% (
    set /a i6nb=%nbcraftfin%+%i6nb%
    goto :save
)
if %invslot7%==%craft% (
    set /a i7nb=%nbcraftfin%+%i7nb%
    goto :save
)
if %invslot8%==%craft% (
    set /a i8nb=%nbcraftfin%+%i8nb%
    goto :save
)



if %invslot1%==vide (
    set invslot1=%craft%
    set i1nb=%nbcraftfin%
    goto :save
)
if %invslot2%==vide (
    set invslot2=%craft%
    set i2nb=%nbcraftfin%
    goto :save
)
if %invslot3%==vide (
    set invslot3=%craft%
    set i3nb=%nbcraftfin%
    goto :save
)
if %invslot4%==vide (
    set invslot4=%craft%
    set i4nb=%nbcraftfin%
 	goto :save
)
if %invslot5%==vide (
    set invslot5=%craft%
    set i5nb=%nbcraftfin%
    goto :save
)
if %invslot6%==vide (
    set invslot6=%craft%
    set i6nb=%nbcraftfin%
    goto :save
)
if %invslot7%==vide (
    set invslot7=%craft%
    set i7nb=%nbcraftfin%
    goto :save
)
if %invslot8%==vide (
    set invslot8=%craft%
    set i8nb=%nbcraftfin%
    goto :save
)
goto :inv_full



:pas_assez
CALL AGRAF "%~0" #pas_assez
::#pas_assez
::Window "" 200 100
::Text "Pas assez de %objmq%!" 35 25 500 15
::#EndGui
goto :howmuch



:inv_full 
CALL AGRAF "%~0" #full
::#full
::Window "AGraf - Fenêtre" 200 100
::Text "Inventaire plein!" 50 25 500 15
::#EndGui
goto :openinv

:pas_dutout
CALL AGRAF "%~0" #pas_dutout
::#pas_dutout
::Window "" 200 100
::Text "Vous n'avez pas de %objmq%!" 23 25 500 15
::#EndGui
goto :openinv


::-------------------------CHANGEMENT D'ECRAN-----------------------------
:zdroite
start %CD%\Sons\woosh2.vbs
cls
if %zone%==underworld set chmunder=0
set zxa=%zx%
set zya=%zy%
set /a zx=%zx%+1
if %zone%==overworld set dest=%zx%%zy%
if %zone%==underworld set dest=u%zx%%zy%
set c1=1
set xspr=8
if exist %CD%\saves\!dest!.save goto :!loadest!
goto :!gendest!

:zgauche
start %CD%\Sons\woosh2.vbs
cls
if %zone%==underworld set chmunder=0
set zxa=%zx%
set zya=%zy%
set /a zx=%zx%-1
if %zone%==overworld set dest=%zx%%zy%
if %zone%==underworld set dest=u%zx%%zy%
set c1=%maxcol1%
set xspr=%maxcolspr%
if exist %CD%\saves\!dest!.save goto :!loadest!
goto :!gendest!

:zhaut
start %CD%\Sons\woosh2.vbs
cls
if %zone%==underworld set chmunder=0
set zxa=%zx%
set zya=%zy%
set l1=%maxline1%
set /a zy=%zy%-1
if %zone%==overworld set dest=%zx%%zy%
if %zone%==underworld set dest=u%zx%%zy%
set yspr=%maxlinespr%
if exist %CD%\saves\!dest!.save goto :!loadest!
goto :!gendest!

:zbas
start %CD%\Sons\woosh2.vbs
cls
if %zone%==underworld set chmunder=0
set zxa=%zx%
set zya=%zy%
set l1=1
set /a zy=%zy%+1
if %zone%==overworld set dest=%zx%%zy%
if %zone%==underworld set dest=u%zx%%zy%
set yspr=12
if exist %CD%\saves\!dest!.save goto :!loadest!
goto :!gendest!

::-----------------------------------------------------------------------------ENTREE UNDERWORLD---------------------------------------------------------------------------

:entreemine
cls
if %zone%==underworld goto :entreover
if %zone%==overworld goto :entreunder


:entreover
color 2f
set chmunder=0
set /a l1=%l1%+1
set /a yspr=%yspr%+12
set zone=overworld
set dest=%zx%%zy%
set loadest=load
set gendest=generation
set color1=2f
set color2=22
set color3=28
set spre=o
if not exist %CD%\saves\%zx%%zy%.save goto :generation
goto :load

:entreunder
color 8f
set biome=mine
echo %zx%%zy%;!biome!>>%CD%\saves\biomes.save
set chmunder=1
set /a l1=%l1%+1
set /a yspr=%yspr%+12
set zone=underworld
set dest=u!zx!!zy!
set loadest=loadunder
set gendest=genunder
set color1=8f
set color2=88
set color3=78
set spre=u
if not exist %CD%\saves\u!zx!!zy!.save goto :genunder
goto :loadunder




:genunder
set np=30
set npierre=30
set zpierre=30
set dest=u%zx%%zy%
if not exist u%zx%%zy% if %chmunder%==1 call :setmine2
if not exist u%zx%%zy% if %chmunder%==0 call :setmine
if exist %CD%\saves\u%zx%%zy%.save (
	for /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u!zx!!zy!.save) DO (
		if mine==%%g (
		set startxm=%%h
		set startym=%%i
		set x1%1=!startxm!
		set /a x2=!startxm!+1
		set /a x3=!startxm!-1
		set /a x4=!startxm!+2
		set /a x5=!startxm!-2
		set /a x6=!startxm!+3
		set /a x7=!startxm!-3
		
		set y1=!startym!
		set /a y2=!startym!-1
		set /a y3=!startym!-2
		set /a y4=!startym!-3
		
		
		set emine1=!x1!a!y1!
		set emine2=!x2!a!y1!
		set emine3=!x3!a!y1!
		set bp40=!x4!a!y1!
		set bp50=!x5!a!y1!
		set emine6=!x1!a!y2!
		set emine7=!x2!a!y2!
		set emine8=!x3!a!y2!
		set bp90=!x4!a!y2!
		set bp100=!x5!a!y2!
		set bp110=!x1!a!y3!
		set bp120=!x2!a!y3!
		set bp130=!x3!a!y3!
		
		
		batbox /g !x1! !y1! /c 0x22 /a 178 /c 0x2f
		batbox /g !x2! !y1! /c 0x22 /a 178 /c 0x2f
		batbox /g !x3! !y1! /c 0x22 /a 178 /c 0x2f
		batbox /g !x4! !y1! /c 0x88 /a 178 /c 0x2f
		batbox /g !x5! !y1! /c 0x88 /a 178 /c 0x2f
		batbox /g !x1! !y2! /c 0x22 /a 178 /c 0x2f
		batbox /g !x2! !y2! /c 0x22 /a 178 /c 0x2f
		batbox /g !x3! !y2! /c 0x22 /a 178 /c 0x2f
		batbox /g !x4! !y2! /c 0x88 /a 178 /c 0x2f
		batbox /g !x5! !y2! /c 0x88 /a 178 /c 0x2f
		batbox /g !x1! !y3! /c 0x88 /a 178 /c 0x2f
		batbox /g !x2! !y3! /c 0x88 /a 178 /c 0x2f
		batbox /g !x3! !y3! /c 0x88 /a 178 /c 0x2f
		)
	)
)
call :genpierre
goto :tableau


:setmine2
for /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
	if mine==%%g echo mine;%%h;%%i>>%CD%\saves\u!zx!!zy!.save
	)
goto :eof




:loadunder


for /f "tokens=1,2 delims=;" %%g in (%CD%\saves\zoneinfo.save) do (
	if au%zx%%zy%==%%g set zarbre=%%h 
	if ru%zx%%zy%==%%g set zriv=oui
	if fu%zx%%zy%==%%g set zfleur=%%h
	if nru%zx%%zy%==%%g set nbriv=%%h
	if piu%zx%%zy%==%%g set zpierre=%%h

)

if not exist u%zx%%zy% (
	FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u!zx!!zy!.save) DO (
	    for /l %%b in (0,1,%m%) do (
	        if murbois%%b==%%g (
	            batbox /g !xmurbois%%b! !ymurbois%%b! /c 0x00 /d O /c 0x2f
	            set xmurbois%%b=0
	            set ymurbois%%b=0
	            set murbois%%b=0
				set /a xs%%b=%%h*8
	            set /a ys%%b=%%i*12
	
	        )
	    )
	)
	
	FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u!zx!!zy!.save) DO (
	    for /l %%b in (0,1,%mp%) do (
	        if murplanche%%b==%%g (
	            batbox /g !xmurplanche%%b! !ymurplanche%%b! /c 0x00 /d O /c 0x2f
	            set xmurplanche%%b=0
	            set ymurplanche%%b=0
	            set murplanche%%b=0
	            set /a xs%%b=%%h*8
	            set /a ys%%b=%%i*12
	
	        )
	    )
	)
	
	FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u!zx!!zy!.save) DO (
	    for /l %%b in (0,1,%me%) do (
	        if etabli%%b==%%g (
	        	batbox /g !xetabli%%b! !yetabli%%b! /c 0x00 /d O /c 0x2f
	            set xetabli%%b=0
	            set yetabli%%b=0
	            set etabli%%b=0
	            set /a xs%%b=%%h*8
	            set /a ys%%b=%%i*12
	
	        )
	    )
	)

if exist %CD%\saves\%zx%%zy%.save (
	for /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
    	for /l %%a in (0,1,10) do (
    	    set bp1%%a=0
    	    set bp2%%a=0
    	    set bp3%%a=0
    	    set bp4%%a=0
    	    set bp5%%a=0
    	    set bp6%%a=0
    	    set bp7%%a=0
    	    set bp8%%a=0
    	    set bp9%%a=0
    	    set bp10%%a=0
    	    set bp11%%a=0
    	    set bp12%%a=0
    	    set bp13%%a=0
    	    set bp14%%a=0
    	    set bp15%%a=0
    	    set bp16%%a=0
    	    set bp17%%a=0
    	    set bp18%%a=0
    	    set bp19%%a=0
			)
		)
	)

	FOR /F "tokens=1,2,3,4 delims=;" %%g IN (%CD%\saves\u!zx!!zy!.save) DO (
	    for /l %%b in (0,1,%mpr%) do (
	        if porte%%b==%%g (
	        	batbox /g !xporte%%b! !yporte%%b! /c 0x00 /d O /c 0x2f
	            set xporte%%b=0
	            set yporte%%b=0
	            set porte%%b=0
	            set rot%%b=%%j
	            set etporte%%b=fermee
	            set /a xs%%b=%%h*8
	            set /a ys%%b=%%i*12
	        )
	    )
	)
	
	FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u!zx!!zy!.save) DO (
	    for /l %%b in (0,1,%mt%) do (
	        if tapis%%b==%%g (
	        	batbox /g !xtap%%b! !ytap%%b! /c 0x00 /d O /c 0x2f
	            set xtap%%b=0
	            set ytap%%b=0
	            set tapis%%b=0
	        )
	    )
	)
)


if exist %CD%\saves\u%zx%%zy%.save (
	FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u!zxa!!zya!.save) DO (
	    for /l %%b in (0,1,%m%) do (
	        if murbois%%b==%%g (
	            batbox /g !xmurbois%%b! !ymurbois%%b! /c 0x00 /d O /c 0x2f
	            set xmurbois%%b=0
	            set ymurbois%%b=0
	            set murbois%%b=0
				set /a xs%%b=%%h*8
	            set /a ys%%b=%%i*12
	
	        )
	    )
	)
	
	FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u!zxa!!zya!.save) DO (
	    for /l %%b in (0,1,%mp%) do (
	        if murplanche%%b==%%g (
	            batbox /g !xmurplanche%%b! !ymurplanche%%b! /c 0x00 /d O /c 0x2f
	            set xmurplanche%%b=0
	            set ymurplanche%%b=0
	            set murplanche%%b=0
	            set /a xs%%b=%%h*8
	            set /a ys%%b=%%i*12
	
	        )
	    )
	)
	
	FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u!zxa!!zya!.save) DO (
	    for /l %%b in (0,1,%me%) do (
	        if etabli%%b==%%g (
	        	batbox /g !xetabli%%b! !yetabli%%b! /c 0x00 /d O /c 0x2f
	            set xetabli%%b=0
	            set yetabli%%b=0
	            set etabli%%b=0
	            set /a xs%%b=%%h*8
	            set /a ys%%b=%%i*12
	
	        )
	    )
	)
	
	FOR /F "tokens=1,2,3,4 delims=;" %%g IN (%CD%\saves\u!zxa!!zya!.save) DO (
	    for /l %%b in (0,1,%mpr%) do (
	        if porte%%b==%%g (
	        	batbox /g !xporte%%b! !yporte%%b! /c 0x00 /d O /c 0x2f
	            set xporte%%b=0
	            set yporte%%b=0
	            set porte%%b=0
	            set rot%%b=%%j
	            set etporte%%b=fermee
	            set /a xs%%b=%%h*8
	            set /a ys%%b=%%i*12
	        )
	    )
	)
	
	FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u!zxa!!zya!.save) DO (
	    for /l %%b in (0,1,%mt%) do (
	        if tapis%%b==%%g (
	        	batbox /g !xtap%%b! !ytap%%b! /c 0x00 /d O /c 0x2f
	            set xtap%%b=0
	            set ytap%%b=0
	            set tapis%%b=0
	        )
	    )
	)
)
if exist %CD%\saves\%zx%%zy%.save (
	FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
	    for /l %%a in (0,1,30) do (
	    if garbre%%a==%%g (
	    set xa%%a=0
	    set yaa%%a=0
	
	    set /a yab%%a=0
	    set /a yac%%a=0
	    set /a xac%%a=0
	    set /a xad%%a=0
	    set /a yad%%a=0
	    set arbre%%a=0
	    set posfexax%%a=0
	    set posfexbx%%a=0
	    set posfexay%%a=0
	    set posfexby%%a=0
	    
	
	)    
	 if parbre%%a==%%g (
	    set xa%%a=0
	    set yaa%%a=0
	    
	    set /a yab%%a=0
	    set /a yac%%a=0
	    set /a xac%%a=0
	    set /a xad%%a=0
	    set /a yad%%a=0
	    set /a yab%%a=0
	    set /a yac%%a=0
	    set /a xac%%a=0
	    set /a xad%%a=0
	    set /a yad%%a=0
	
	    set arbre%%a=0
	
	        )
	    )
	)

	FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
   		 for /l %%a in (0,1,%zfleur%) do (
   		     if jfleur%%a==%%g (
   		     	set randxf%%a=0
   		     	set randyf%%a=0
					set fleur%%a=0
   		    )
   		    	if rfleur%%a==%%g (
   		     	set randxf%%a=0
   		     	set randyf%%a=0
					set fleur%%a=0
		
   		    )
   		 )
	)     
)

if exist %CD%\saves\u%zx%%zy%.save (
	for /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u%zx%%zy%.save) DO (
		if mine==%%g (
		set startxm=%%h
		set startym=%%i
		set x1%1=!startxm!
		set /a x2=!startxm!+1
		set /a x3=!startxm!-1
		set /a x4=!startxm!+2
		set /a x5=!startxm!-2
		set /a x6=!startxm!+3
		set /a x7=!startxm!-3
		
		set y1=!startym!
		set /a y2=!startym!-1
		set /a y3=!startym!-2
		set /a y4=!startym!-3
		
		
		set emine1=!x1!a!y1!
		set emine2=!x2!a!y1!
		set emine3=!x3!a!y1!
		set bp4a0=!x4!a!y1!
		set bp5a0=!x5!a!y1!
		set emine6=!x1!a!y2!
		set emine7=!x2!a!y2!
		set emine8=!x3!a!y2!
		set bp9a0=!x4!a!y2!
		set bp10a0=!x5!a!y2!
		set bp11a0=!x1!a!y3!
		set bp12a0=!x2!a!y3!
		set bp13a0=!x3!a!y3!
		
		
		batbox /g !x1! !y1! /c 0x22 /a 178 /c 0x2f
		batbox /g !x2! !y1! /c 0x22 /a 178 /c 0x2f
		batbox /g !x3! !y1! /c 0x22 /a 178 /c 0x2f
		batbox /g !x4! !y1! /c 0x08 /a 178 /c 0x2f
		batbox /g !x5! !y1! /c 0x08 /a 178 /c 0x2f
		batbox /g !x1! !y2! /c 0x22 /a 178 /c 0x2f
		batbox /g !x2! !y2! /c 0x22 /a 178 /c 0x2f
		batbox /g !x3! !y2! /c 0x22 /a 178 /c 0x2f
		batbox /g !x4! !y2! /c 0x08 /a 178 /c 0x2f
		batbox /g !x5! !y2! /c 0x08 /a 178 /c 0x2f
		batbox /g !x1! !y3! /c 0x08 /a 178 /c 0x2f
		batbox /g !x2! !y3! /c 0x08 /a 178 /c 0x2f
		batbox /g !x3! !y3! /c 0x08 /a 178 /c 0x2f
		)
	)
)


for /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u%zx%%zy%.save) DO (
    for /l %%a in (0,1,30) do (
    if gpierre%%a==%%g (
    	set startx%%a=%%h
    	set starty%%a=%%i
		set x1%%a=!startx%%a!
		set /a x2%%a=!startx%%a!+1
		set /a x3%%a=!startx%%a!-1
		set /a x4%%a=!startx%%a!+2
		set /a x5%%a=!startx%%a!-2
		set /a x6%%a=!startx%%a!+3
		set /a x7%%a=!startx%%a!-3
		
		set y1%%a=!starty%%a!
		set /a y2%%a=!starty%%a!-1
		set /a y3%%a=!starty%%a!-2
		set /a y4%%a=!starty%%a!-3
		
		
        set bp1%%a=!x1%%a!a!y1%%a!
        set bp2%%a=!x2%%a!a!y1%%a!
        set bp3%%a=!x3%%a!a!y1%%a!
        set bp4%%a=!x4%%a!a!y1%%a!
        set bp5%%a=!x5%%a!a!y1%%a!
        set bp6%%a=!x1%%a!a!y2%%a!
        set bp7%%a=!x2%%a!a!y2%%a!
        set bp8%%a=!x3%%a!a!y2%%a!
        set bp9%%a=!x4%%a!a!y2%%a!
        set bp10%%a=!x5%%a!a!y2%%a!
        set bp11%%a=!x1%%a!a!y3%%a!
        set bp12%%a=!x2%%a!a!y3%%a!
        set bp13%%a=!x3%%a!a!y3%%a!
       
        set bp14%%a=!x6%%a!a!y1%%a!
        set bp15%%a=!x7%%a!a!y1%%a!
        set bp16%%a=!x6%%a!a!y2%%a!
        set bp17%%a=!x7%%a!a!y2%%a!
        set bp18%%a=!x4%%a!a!y3%%a!
        set bp19%%a=!x5%%a!a!y3%%a!
   
   
        batbox /g !x1%%a! !y1%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x2%%a! !y1%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x3%%a! !y1%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x4%%a! !y1%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x5%%a! !y1%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x1%%a! !y2%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x2%%a! !y2%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x3%%a! !y2%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x4%%a! !y2%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x5%%a! !y2%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x1%%a! !y3%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x2%%a! !y3%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x3%%a! !y3%%a! /c 0x08 /a 178 /c 0xf0
       
        batbox /g !x6%%a! !y1%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x7%%a! !y1%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x6%%a! !y2%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x7%%a! !y2%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x4%%a! !y3%%a! /c 0x08 /a 178 /c 0xf0
        batbox /g !x5%%a! !y3%%a! /c 0x08 /a 178 /c 0xf0
		)

	if ppierre%%a==%%g (
    	set startx%%a=%%h
    	set starty%%a=%%i
		set x1%%a=!startx%%a!
		set /a x2%%a=!startx%%a!+1
		set /a x3%%a=!startx%%a!-1
		set /a x4%%a=!startx%%a!+2
		set /a x5%%a=!startx%%a!-2
		set /a x6%%a=!startx%%a!+3
		set /a x7%%a=!startx%%a!-3
		
		set y1%%a=!starty%%a!
		set /a y2%%a=!starty%%a!-1
		set /a y3%%a=!starty%%a!-2
		set /a y4%%a=!starty%%a!-3
		
		
		set bp1%%a=!x1%%a!a!y1%%a!
		set bp2%%a=!x2%%a!a!y1%%a!
		set bp3%%a=!x3%%a!a!y1%%a!
		set bp4%%a=!x4%%a!a!y1%%a!
		set bp5%%a=!x5%%a!a!y1%%a!
		set bp6%%a=!x1%%a!a!y2%%a!
		set bp7%%a=!x2%%a!a!y2%%a!
		set bp8%%a=!x3%%a!a!y2%%a!
		set bp9%%a=!x4%%a!a!y2%%a!
		set bp10%%a=!x5%%a!a!y2%%a!
		set bp11%%a=!x1%%a!a!y3%%a!
		set bp12%%a=!x2%%a!a!y3%%a!
		set bp13%%a=!x3%%a!a!y3%%a!
	
		
		
		batbox /g !x1%%a! !y1%%a! /c 0x08 /a 178 /c 0xf0
		batbox /g !x2%%a! !y1%%a! /c 0x08 /a 178 /c 0xf0
		batbox /g !x3%%a! !y1%%a! /c 0x08 /a 178 /c 0xf0
		batbox /g !x4%%a! !y1%%a! /c 0x08 /a 178 /c 0xf0
		batbox /g !x5%%a! !y1%%a! /c 0x08 /a 178 /c 0xf0
		batbox /g !x1%%a! !y2%%a! /c 0x08 /a 178 /c 0xf0
		batbox /g !x2%%a! !y2%%a! /c 0x08 /a 178 /c 0xf0
		batbox /g !x3%%a! !y2%%a! /c 0x08 /a 178 /c 0xf0
		batbox /g !x4%%a! !y2%%a! /c 0x08 /a 178 /c 0xf0
		batbox /g !x5%%a! !y2%%a! /c 0x08 /a 178 /c 0xf0
		batbox /g !x1%%a! !y3%%a! /c 0x08 /a 178 /c 0xf0
		batbox /g !x2%%a! !y3%%a! /c 0x08 /a 178 /c 0xf0
		batbox /g !x3%%a! !y3%%a! /c 0x08 /a 178 /c 0xf0

		)
	)
)


FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u%zx%%zy%.save) DO (
    for /l %%b in (0,1,%m%) do (
        if murbois%%b==%%g (
            set xmurbois%%b=%%h
            set ymurbois%%b=%%i
            set murbois%%b=%%ha%%i
			set /a xs%%b=%%h*8
            set /a ys%%b=%%i*12
            INSERTBMP /p:"textures\buche.bmp" /x:!xs%%b! /y:!ys%%b!
        )
    )
)

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u%zx%%zy%.save) DO (
    for /l %%b in (0,1,%mpierre%) do (
        if murpierre%%b==%%g (
            set xmurpierre%%b=%%h
            set ymurpierre%%b=%%i
            set murpierre%%b=%%ha%%i
			set /a xs%%b=%%h*8
            set /a ys%%b=%%i*12
            INSERTBMP /p:"textures\pierre.bmp" /x:!xs%%b! /y:!ys%%b!
        )
    )
)


FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u%zx%%zy%.save) DO (
    for /l %%b in (0,1,%mp%) do (
        if murplanche%%b==%%g (
            set xmurplanche%%b=%%h
            set ymurplanche%%b=%%i
            set murplanche%%b=%%ha%%i
            set /a xs%%b=%%h*8
            set /a ys%%b=%%i*12
            INSERTBMP /p:"textures\planches.bmp" /x:!xs%%b! /y:!ys%%b!
        )
    )
)

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u%zx%%zy%.save) DO (
    for /l %%b in (0,1,%me%) do (
        if etabli%%b==%%g (
            set xetabli%%b=%%h
            set yetabli%%b=%%i
            set etabli%%b=%%ha%%i
            set /a xs%%b=%%h*8
            set /a ys%%b=%%i*12
            INSERTBMP /p:"textures\etabli!spre!.bmp" /x:!xs%%b! /y:!ys%%b!
        )
    )
)


FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u%zx%%zy%.save) DO (
    for /l %%b in (0,1,%mfour%) do (
        if murfour%%b==%%g (
            set xmurfour%%b=%%h
            set ymurfour%%b=%%i
            set murfour%%b=%%ha%%i
			set /a xs%%b=%%h*8
            set /a ys%%b=%%i*12
            INSERTBMP /p:"textures\four.bmp" /x:!xs%%b! /y:!ys%%b!
        )
    )
)


FOR /F "tokens=1,2,3,4 delims=;" %%g IN (%CD%\saves\u%zx%%zy%.save) DO (
    for /l %%b in (0,1,%mpr%) do (
        if porte%%b==%%g (
            set xporte%%b=%%h
            set yporte%%b=%%i
            set porte%%b=%%ha%%i
            set rot%%b=%%j
            set etporte%%b=fermee
            set /a xs%%b=%%h*8
            set /a ys%%b=%%i*12
            INSERTBMP /p:"textures\porte!rot%%b!!spre!.bmp" /x:!xs%%b! /y:!ys%%b!
        )
    )
)

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\u%zx%%zy%.save) DO (
    for /l %%b in (0,1,%mt%) do (
        if tapis%%b==%%g (
            set xtap%%b=%%h
            set ytap%%b=%%i
            set tapis%%b=%%ha%%i
            batbox /g !xtap%%b! !ytap%%b! /c 0x84 /a 178 /c 0x2f 
        )
    )
)




goto :tableau

:generation
cls
set dest=%zx%%zy%
set biome=plaine
set nar1=!config_arbres!
set nfl=!config_fleurs!
set np=!config_pierre!
set /a randbiome=%random%%%!config_biomes!
if "%zx%%zy%"=="11" set randbiome=10
if %randbiome%==1 set nar1=50 & set biome=foret

if not %biome%==plaine_rocheuse set /a randarbre=%random%%%10
set /a nar1=%nar1%+%randarbre%
echo a%zx%%zy%;!nar1!>>saves\zoneinfo.save
echo %zx%%zy%;!biome!>>%CD%\saves\biomes.save
if not %biome%==plaine_rocheuse set /a randfl=%random%%%20
set /a nfl=%nfl%+%randfl%
echo f%zx%%zy%;!nfl!>>saves\zoneinfo.save


::appelle la generation de mine 
set /a randminea=%random%%%!config_mines!
if "%zx%%zy%"=="00" set randminea=0
if %randminea%==0 call :setmine

::appelle la generation de fleur
for /l %%a in (1,1,%nfl%) do (
    call :setf %%a
)


::appelle la generation de riviere
set /a randrivb=%random%%%!config_randriviere!
if %randrivb%==0 goto :genriviereh

::appelle la generation de pierres 
if %randbiome%==0 (
    set biome=plaine_rocheuse
    set nar1=0
    set randarbre=3
    set nfl=0
    set randfl=0
    set np=20
    set npierre=20
)
call :genpierre



:contgen


::appelle la generation des arbres
for /l %%a in (1,1,%nar1%) do (
    call :seta %%a
)

for /f "tokens=1,2 delims=;" %%g in (%CD%\saves\zoneinfo.save) do (
	if a%zx%%zy%==%%g set zarbre=%%h 
	if r%zx%%zy%==%%g set zriv=oui
	if f%zx%%zy%==%%g set zfleur=%%h
	if nr%zx%%zy%==%%g set nbriv=%%h
)
goto :tableau


:genriviereh
set /a randdirriv=%random%%%2

if %randdirriv%==0 goto :rivbas
if %randdirriv%==1 goto :rivhaut

:rivhaut 
set nr=0
set /a yriv=%random%%%!maxline!
set xriv=0
echo r%zx%%zy%;oui>>%CD%\saves\zoneinfo.save
for /l %%a in (0,1,350) do (
	call :rivhaut2 %%a
)
:contgena
echo nr%zx%%zy%;!nr!>>%CD%\saves\zoneinfo.save
goto :contgen

:rivhaut2 
batbox /g !xriv! !yriv! /c 0x23 /a 219 /c 0x2f

echo riv%1;!xriv!;!yriv!;%zx%%zy%>>%CD%\saves\%zx%%zy%.save
set riv%1=%xriv%a%yriv%a%zx%%zy%


set /a randomriva=%random%%%5
if %randomriva%==0 set /a yriv=!yriv!-1
if %randomriva%==1 set /a xriv=!xriv!+1
if %randomriva%==2 set /a xriv=!xriv!+1
if %randomriva%==3 set /a xriv=!xriv!+1
if %randomriva%==4 set /a xriv=!xriv!+1
set /a nr=%nr%+1
if !xriv! gtr %maxcol2% goto :contgena
if !yriv! lss 0 goto :contgena
goto :eof


:rivbas 
set nr=0
set /a yriv=%random%%%!maxline!
set xriv=0
echo r%zx%%zy%;oui>>%CD%\saves\zoneinfo.save
for /l %%a in (0,1,350) do (
	call :rivbas2 %%a
)

:contgenb 
echo nr%zx%%zy%;!nr!>>%CD%\saves\zoneinfo.save
goto :contgen

:rivbas2 

batbox /g !xriv! !yriv! /c 0x23 /a 219 /c 0x2f
echo riv%1;!xriv!;!yriv!;%zx%%zy%>>%CD%\saves\%zx%%zy%.save
set riv%1=%xriv%a%yriv%a%zx%%zy%


set /a randomriva=%random%%%5
if %randomriva%==0 set /a yriv=!yriv!+1
if %randomriva%==1 set /a xriv=!xriv!+1
if %randomriva%==2 set /a xriv=!xriv!+1
if %randomriva%==3 set /a xriv=!xriv!+1
if %randomriva%==4 set /a xriv=!xriv!+1
set /a nr=%nr%+1
if !xriv! gtr %maxcol2% goto :contgenb
if !yriv! gtr %maxline2% goto :contgenb
goto :eof



:genpierre
if %biome% neq plaine_rocheuse (
	if %zone% neq underworld set /a npierre=%random%%%!np!)

for /l %%a in (1,1,%npierre%) do (
	call :setpierre %%a
)
set /a npierre2=%npierre%+1
echo pi!dest!;!npierre2!>>saves\zoneinfo.save
set zpierre=%npierre2%
goto :eof




:action 
set /a l1a=%l1%-1
set /a l1b=%l1%+1
set /a c1a=%c1%-1
set /a c1b=%c1%+1
set /a l1as=%l1a%*12
set /a l1bs=%l1b%*12
set /a c1as=%c1a%*8
set /a c1bs=%c1b%*8
::-------------------
if %lastdir%==haut (
		for /l %%a in (0,1,%me%) do (
	    if %c1%a%l1a%==!etabli%%a! goto :open_etabli
	)
	for /l %%a in (0,1,%mpr%) do (
	    if %c1%a%l1a%==!porte%%a! (
	    	set psel=%%a
	    	goto :open_porte
	    )
	)
	for /l %%a in (0,1,%mfour%) do (
	    if %c1%a%l1a%==!murfour%%a! (
	    	set psel=%%a
	    	goto :open_four
	    )
	)
)

if %lastdir%==bas (
	for /l %%a in (0,1,%me%) do (
	    if %c1%a%l1b%==!etabli%%a! goto :open_etabli
	)
	for /l %%a in (0,1,%mpr%) do (
	    if %c1%a%l1b%==!porte%%a! (
	    	set psel=%%a
	    	goto :open_porte
	    )
	)
	 for /l %%a in (0,1,%mfour%) do (
	    if %c1%a%l1b%==!murfour%%a! (
	    	set psel=%%a
	    	goto :open_four
	    )
	)
)

if %lastdir%==gauche (
	for /l %%a in (0,1,%me%) do (
	    if %c1a%a%l1%==!etabli%%a! goto :open_etabli
	)
	for /l %%a in (0,1,%mpr%) do (
	    if %c1a%a%l1%==!porte%%a! (
	    	set psel=%%a
	    	goto :open_porte
	    )
	)
	for /l %%a in (0,1,%mfour%) do (
	    if %c1a%a%l1%==!murfour%%a! (
	    	set psel=%%a
	    	goto :open_four
	    )
	)
)

if %lastdir%==droite (
	for /l %%a in (0,1,%me%) do (
	    if %c1b%a%l1%==!etabli%%a! goto :open_etabli
	)
	for /l %%a in (0,1,%mpr%) do (
	    if %c1b%a%l1%==!porte%%a! (
	    	set psel=%%a
	    	goto :open_porte
	    )
	)
	for /l %%a in (0,1,%mfour%) do (
	    if %c1b%a%l1%==!murfour%%a! (
	    	set psel=%%a
	    	goto :open_four
	    )
	)
)

goto :tableau
:hit

::definiton de l'attaque
set /a l1a=%l1%-1
set /a l1b=%l1%+1
set /a c1a=%c1%-1
set /a c1b=%c1%+1
set /a l1as=%l1a%*12
set /a l1bs=%l1b%*12
set /a c1as=%c1a%*8
set /a c1bs=%c1b%*8
::-------------------------------------------------HIT HAUT-------------------------------------------------------------
if %lastdir%==haut (
:: attaque sur arbre
for /l %%a in (0,1,%zarbre%) do (
    if %c1%a%l1a%==!arbre%%a! call :setarbre %%a & goto :hitarbre1

    if %c1%a%l1a%==!xa%%a!a!yab%%a! goto :hidehit
    if %c1%a%l1a%==!xa%%a!a!yac%%a! goto :hidehit
    if %c1%a%l1a%==!xac%%a!a!yac%%a! goto :hidehit
    if %c1%a%l1a%==!xad%%a!a!yac%%a! goto :hidehit
    if %c1%a%l1a%==!xa%%a!a!yad%%a! goto :hidehit
    if %c1%a%l1a%==!posfexax%%a!a!posfexay%%a! goto :hidehit
    if %c1%a%l1a%==!posfexbx%%a!a!posfexby%%a! goto :hidehit
    )
::attaque sur un mur
for /l %%a in (0,1,%m%) do (
    if %c1%a%l1a%==!murbois%%a! goto :sprite
)
for /l %%a in (0,1,%mp%) do (
    if %c1%a%l1a%==!murplanche%%a! goto :sprite
)

for /l %%a in (0,1,%me%) do (
    if %c1%a%l1a%==!etabli%%a! goto :sprite
)
for /l %%a in (0,1,%mpr%) do (
    if %c1%a%l1a%==!porte%%a! goto :sprite
)

for /l %%a in (0,1,%mpierre%) do (
    if %c1%a%l1a%==!murpierre%%a! goto :sprite
)

for /l %%a in (0,1,%mfour%) do (
    if %c1%a%l1a%==!murfour%%a! goto :sprite
)


::pierre
for /l %%a in (1,1,%zpierre%) do (
	for /l %%b in (1,1,20) do (
   	 	if %c1%a%l1a%==!bp%%b%%a! call :setpierrea %%a & goto :hitpierre1
	)
)

for /l %%b in (1,1,20) do (
   	 if %c1%a%l1a%==!bp%%ba0! goto :sprite
   	 if %c1%a%l1a%==!emine%%b! goto :sprite
)


set hitengage=non
if %sons%==on start %CD%\Sons\woosh.vbs
INSERTBMP /p:"textures\epeeh!spre!.bmp" /x:%xspr% /y:%l1as%

::fleur jaune
for /l %%a in (0,1,%zfleur%) do (
    if j%c1%a%l1a%==!fleur%%a! (
    	batbox /g %c1% %l1a% /c 0x22 /d 0 /c 0x2f
    	set fleursel=%%a
    	call :hitfleurj
    	) 
    	)


::fleur rouge
for /l %%a in (0,1,%zfleur%) do (
    if r%c1%a%l1a%==!fleur%%a! (
    	batbox /g %c1% %l1a% /c 0x22 /d 0 /c 0x2f
    	set fleursel=%%a
    	call :hitfleurr
    	) 
    	)

::tapis
for /l %%a in (0,1,%mt%) do (
    if %c1%a%l1a%==!tapis%%a! batbox /g %c1% %l1a% /c 0x84 /a 178 /c 0x2f )
::riviere 
for /l %%a in (0,1,%nbriv%) do (
    if %c1%a%l1a%a%zx%%zy%==!riv%%a! batbox /g %c1% %l1a% /c 0x23 /a 219 /c 0x2f )
      

batbox /w 200
batbox /g %c1% %l1a% /c 0x%color2% /a 179 /c 0x%color1%
batbox /w 500

goto :sprite 
)
::-------------------------------------------------HIT BAS-------------------------------------------------------------
if %lastdir%==bas (
for /l %%a in (0,1,%zarbre%) do (
    if %c1%a%l1b%==!arbre%%a! call :setarbre %%a & goto :hitarbre1

    if %c1%a%l1b%==!xa%%a!a!yab%%a! goto :hidehit
    if %c1%a%l1b%==!xa%%a!a!yac%%a! goto :hidehit
    if %c1%a%l1b%==!xac%%a!a!yac%%a! goto :hidehit
    if %c1%a%l1b%==!xad%%a!a!yac%%a! goto :hidehit
    if %c1%a%l1b%==!xa%%a!a!yad%%a! goto :hidehit
    if %c1%a%l1b%==!posfexax%%a!a!posfexay%%a! goto :hidehit
    if %c1%a%l1b%==!posfexbx%%a!a!posfexby%%a! goto :hidehit
    )
::attaque sur un mur
for /l %%a in (0,1,%m%) do (
    if %c1%a%l1b%==!murbois%%a! goto :sprite
)
for /l %%a in (0,1,%mp%) do (
    if %c1%a%l1b%==!murplanche%%a! goto :sprite
)
for /l %%a in (0,1,%me%) do (
    if %c1%a%l1b%==!etabli%%a! goto :sprite
)
for /l %%a in (0,1,%mpr%) do (
    if %c1%a%l1b%==!porte%%a! goto :sprite
)

for /l %%a in (0,1,%mpierre%) do (
    if %c1%a%l1b%==!murpierre%%a! goto :sprite
)

for /l %%a in (0,1,%mfour%) do (
    if %c1%a%l1b%==!murfour%%a! goto :sprite
)


::pierre
for /l %%a in (1,1,%zpierre%) do (
	for /l %%b in (1,1,20) do (
   	 	if %c1%a%l1b%==!bp%%b%%a! call :setpierrea %%a & goto :hitpierre1
	)
)
for /l %%b in (1,1,20) do (
   	 if %c1%a%l1b%==!bp%%ba0! goto :sprite
   	 if %c1%a%l1b%==!emine%%b! goto :sprite
)


set hitengage=non
if %sons%==on start %CD%\Sons\woosh.vbs
INSERTBMP /p:"textures\epeeb!spre!.bmp" /x:%xspr% /y:%l1bs%

::fleur jaune
for /l %%a in (0,1,%zfleur%) do (
    if j%c1%a%l1b%==!fleur%%a! (
    	batbox /g %c1% %l1b% /c 0x22 /d 0 /c 0x2f
    	set fleursel=%%a
    	call :hitfleurj
    	) 
    	)

::fleur rouge
for /l %%a in (0,1,%zfleur%) do (
    if r%c1%a%l1b%==!fleur%%a! (
    	batbox /g %c1% %l1b% /c 0x22 /d 0 /c 0x2f
    	set fleursel=%%a
    	call :hitfleurr
    	) 
    	)
::tapis
for /l %%a in (0,1,%mt%) do (
    if %c1%a%l1b%==!tapis%%a! batbox /g %c1% %l1b% /c 0x84 /a 178 /c 0x2f )
::riviere 
for /l %%a in (0,1,%nbriv%) do (
    if %c1%a%l1b%a%zx%%zy%==!riv%%a! batbox /g %c1% %l1b% /c 0x23 /a 219 /c 0x2f )
	
batbox /w 200
batbox /g %c1% %l1b% /c 0x%color2% /a 179 /c 0x%color1%
batbox /w 500
goto :sprite 
)
::------------------------------------------------HIT GAUCHE-----------------------------------------------------------
if %lastdir%==gauche (
for /l %%a in (0,1,%zarbre%) do (
    if %c1a%a%l1%==!arbre%%a! call :setarbre %%a & goto :hitarbre1

    if %c1a%a%l1%==!xa%%a!a!yab%%a! goto :hidehit
    if %c1a%a%l1%==!xa%%a!a!yac%%a! goto :hidehit
    if %c1a%a%l1%==!xac%%a!a!yac%%a! goto :hidehit
    if %c1a%a%l1%==!xad%%a!a!yac%%a! goto :hidehit
    if %c1a%a%l1%==!xa%%a!a!yad%%a! goto :hidehit
    if %c1a%a%l1%==!posfexax%%a!a!posfexay%%a! goto :hidehit
    if %c1a%a%l1%==!posfexbx%%a!a!posfexby%%a! goto :hidehit
    )
::attaque sur un mur
for /l %%a in (0,1,%m%) do (
    if %c1a%a%l1%==!murbois%%a! goto :sprite
)
for /l %%a in (0,1,%mp%) do (
    if %c1a%a%l1%==!murplanche%%a! goto :sprite
)
for /l %%a in (0,1,%me%) do (
    if %c1a%a%l1%==!etabli%%a! goto :sprite
)
for /l %%a in (0,1,%mpr%) do (
    if %c1a%a%l1%==!porte%%a! goto :sprite
)
for /l %%a in (0,1,%mpierre%) do (
    if %c1a%a%l1%==!murpierre%%a! goto :sprite
)

for /l %%a in (0,1,%mfour%) do (
    if %c1a%a%l1%==!murfour%%a! goto :sprite
)

::pierre
for /l %%a in (1,1,%zpierre%) do (
	for /l %%b in (1,1,20) do (
   	 	if %c1a%a%l1%==!bp%%b%%a! call :setpierrea %%a & goto :hitpierre1
	)
)
for /l %%b in (1,1,20) do (
   	 if %c1a%a%l1%==!bp%%ba0! goto :sprite
   	 if %c1a%a%l1%==!emine%%b! goto :sprite
)

set hitengage=non
if %sons%==on start %CD%\Sons\woosh.vbs
INSERTBMP /p:"textures\epeeg!spre!.bmp" /x:%c1as% /y:%yspr%

::fleur jaune
for /l %%a in (0,1,%zfleur%) do (
    if j%c1a%a%l1%==!fleur%%a! (
    	batbox /g %c1a% %l1% /c 0x22 /d 0 /c 0x2f
    	set fleursel=%%a
    	call :hitfleurj
    	) 
    	)

::fleur rouge
for /l %%a in (0,1,%zfleur%) do (
    if r%c1a%a%l1%==!fleur%%a! (
    	batbox /g %c1a% %l1% /c 0x22 /d 0 /c 0x2f
    	set fleursel=%%a
    	call :hitfleurr
    	) 
    	)
::tapis
for /l %%a in (0,1,%mt%) do (
    if %c1a%a%l1%==!tapis%%a! batbox /g %c1a% %l1% /c 0x84 /a 178 /c 0x2f )
	::riviere 
for /l %%a in (0,1,%nbriv%) do (
    if %c1a%a%l1%a%zx%%zy%==!riv%%a! batbox /g %c1a% %l1% /c 0x23 /a 219 /c 0x2f )
batbox /w 200
batbox /g %c1a% %l1% /c 0x%color2% /a 196 /c 0x%color1%
batbox /w 500
goto :sprite  
)
::------------------------------------------------HIT DROITE-----------------------------------------------------------
if %lastdir%==droite (
for /l %%a in (0,1,%zarbre%) do (
    if %c1b%a%l1%==!arbre%%a! call :setarbre %%a & goto :hitarbre1
    if %c1b%a%l1%==!xa%%a!a!yab%%a! goto :hidehit
    if %c1b%a%l1%==!xa%%a!a!yac%%a! goto :hidehit
    if %c1b%a%l1%==!xac%%a!a!yac%%a! goto :hidehit
    if %c1b%a%l1%==!xad%%a!a!yac%%a! goto :hidehit
    if %c1b%a%l1%==!xa%%a!a!yad%%a! goto :hidehit
    if %c1b%a%l1%==!posfexax%%a!a!posfexay%%a! goto :hidehit
    if %c1b%a%l1%==!posfexbx%%a!a!posfexby%%a! goto :hidehit
    )
::attaque sur un mur
for /l %%a in (0,1,%m%) do (
    if %c1b%a%l1%==!murbois%%a! goto :sprite
)
for /l %%a in (0,1,%mp%) do (
    if %c1b%a%l1%==!murplanche%%a! goto :sprite
)
for /l %%a in (0,1,%me%) do (
    if %c1b%a%l1%==!etabli%%a! goto :sprite
)
for /l %%a in (0,1,%mpr%) do (
    if %c1b%a%l1%==!porte%%a! goto :sprite
)
for /l %%a in (0,1,%mpierre%) do (
    if %c1b%a%l1%==!murpierre%%a! goto :sprite
)

for /l %%a in (0,1,%mfour%) do (
    if %c1b%a%l1%==!murfour%%a! goto :sprite
)

::pierre
for /l %%a in (1,1,%zpierre%) do (
	for /l %%b in (1,1,20) do (
   	 	if %c1b%a%l1%==!bp%%b%%a! call :setpierrea %%a & goto :hitpierre1
	)
)
for /l %%b in (1,1,20) do (
   	 if %c1b%a%l1%==!bp%%ba0! goto :sprite
   	 if %c1b%a%l1%==!emine%%b! goto :sprite
)

set hitengage=non
if %sons%==on start %CD%\Sons\woosh.vbs
INSERTBMP /p:"textures\epeed!spre!.bmp" /x:%c1bs% /y:%yspr%

::fleur jaune
for /l %%a in (0,1,%zfleur%) do (
    if j%c1b%a%l1%==!fleur%%a! (
    	batbox /g %c1b% %l1% /c 0x22 /d 0 /c 0x2f
    	set fleursel=%%a
    	call :hitfleurj
    	) 
    	)

::fleur rouge
for /l %%a in (0,1,%zfleur%) do (
    if r%c1b%a%l1%==!fleur%%a! (
    	batbox /g %c1b% %l1% /c 0x22 /d 0 /c 0x2f
    	set fleursel=%%a
    	call :hitfleurr
    	) 
    	)
::tapis
for /l %%a in (0,1,%mt%) do (
    if %c1b%a%l1%==!tapis%%a! batbox /g %c1b% %l1% /c 0x84 /a 178 /c 0x2f )
	::riviere 
for /l %%a in (0,1,%nbriv%) do (
    if %c1b%a%l1%a%zx%%zy%==!riv%%a! batbox /g %c1b% %l1% /c 0x23 /a 219 /c 0x2f )
batbox /w 200
batbox /g %c1b% %l1% /c 0x%color2% /a 196 /c 0x%color1%
batbox /w 500
goto :sprite 
)
goto :sprite

:hidehit
if %sons%==on start %CD%\Sons\woosh.vbs
goto :sprite

:setarbre
set xarbre=!xa%1!
set yarbre=!yaa%1!
set narbre=%1
goto :eof

:setpierrea
for /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\!dest!.save) DO (
    if gpierre%1==%%g set tpierre=g
	if ppierre%1==%%g set tpierre=p
)

set xpierrec=!startx%1!
set ypierrec=!starty%1!
set psel=%1

goto :eof

:hitarbre1
::check si on attaque un arbre
if %hitengage%==oui goto :hitarbre2
if %hitengage%==non set hitengage=oui
set hitsa=0
set /a hitsmaxrand=%random%%%3
set /a hitsmax=4+%hitsmaxrand%


goto :hitarbre2

:hitarbre2
::finalisation attaque sur arbre
if %sons%==on start %CD%\Sons\wood_hit.vbs
set /a hitsa=%hitsa%+1
if %hitsa%==%hitsmax% goto :arbrecasse
timeout /t 1 /nobreak >nul
goto :sprite


:hitpierre1
if %hitengagep%==oui goto :hitpierre2
if %hitengagep%==non set hitengagep=oui
set hitsa=0
set /a hitsmaxrand=%random%%%5
set /a hitsmax=7+%hitsmaxrand%
goto :hitpierre2


:hitpierre2
if %sons%==on start %CD%\Sons\stone_hit.vbs
set /a hitsa=%hitsa%+1
if %hitsa%==%hitsmax% goto :pierrecasse
timeout /t 1 /nobreak >nul
goto :sprite


:pierrecasse
set hitengagep=non
if %sons%==on start %CD%\Sons\rocks_falling.vbs
set x1=!xpierrec!
set /a x2=!xpierrec!+1
set /a x3=!xpierrec!-1
set /a x4=!xpierrec!+2
set /a x5=!xpierrec!-2
set /a x6=!xpierrec!+3
set /a x7=!xpierrec!-3

set y1=!ypierrec!
set /a y2=!ypierrec!-1
set /a y3=!ypierrec!-2
set /a y4=!ypierrec!-3
set bp1!psel!=0
set bp2!psel!=0
set bp3!psel!=0
set bp4!psel!=0
set bp5!psel!=0
set bp6!psel!=0
set bp7!psel!=0
set bp8!psel!=0
set bp9!psel!=0
set bp10!psel!=0
set bp11!psel!=0
set bp12!psel!=0
set bp13!psel!=0

set bp14!psel!=0
set bp15!psel!=0
set bp16!psel!=0
set bp17!psel!=0
set bp18!psel!=0
set bp19!psel!=0


batbox /g !x1! !y1! /c 0x%color2% /d 0 /c 0x%color1%
batbox /g !x2! !y1! /c 0x%color2% /d 0 /c 0x%color1%
batbox /g !x3! !y1! /c 0x%color2% /d 0 /c 0x%color1%
batbox /g !x4! !y1! /c 0x%color2% /d 0 /c 0x%color1%
batbox /g !x5! !y1! /c 0x%color2% /d 0 /c 0x%color1%
batbox /g !x1! !y2! /c 0x%color2% /d 0 /c 0x%color1%
batbox /g !x2! !y2! /c 0x%color2% /d 0 /c 0x%color1%
batbox /g !x3! !y2! /c 0x%color2% /d 0 /c 0x%color1%
batbox /g !x4! !y2! /c 0x%color2% /d 0 /c 0x%color1%
batbox /g !x5! !y2! /c 0x%color2% /d 0 /c 0x%color1%
batbox /g !x1! !y3! /c 0x%color2% /d 0 /c 0x%color1%
batbox /g !x2! !y3! /c 0x%color2% /d 0 /c 0x%color1%
batbox /g !x3! !y3! /c 0x%color2% /d 0 /c 0x%color1%

if %tpierre%==g (
	batbox /g !x6! !y1! /c 0x%color2% /d 0 /c 0x%color1%
	batbox /g !x7! !y1! /c 0x%color2% /d 0 /c 0x%color1%
	batbox /g !x6! !y2! /c 0x%color2% /d 0 /c 0x%color1%
	batbox /g !x7! !y2! /c 0x%color2% /d 0 /c 0x%color1%
	batbox /g !x4! !y3! /c 0x%color2% /d 0 /c 0x%color1%
	batbox /g !x5! !y3! /c 0x%color2% /d 0 /c 0x%color1%
)

set startx%psel%=0
set starty%psel%=0

if %tpierre%==g set randpierre3=8
if %tpierre%==p set randpierre3=5

set /a randpierre1=%random%%%6
set /a randpierre2=%randpierre1%+!randpierre3!

if %invslot1%==pierre (
    set /a i1nb=%i1nb%+%randpierre2%
    goto :save
)
if %invslot2%==pierre (
    set /a i2nb=%i1nb%+%randpierre2%
    goto :save
)
if %invslot3%==pierre (
    set /a i3nb=%i1nb%+%randpierre2%
    goto :save
)
if %invslot4%==pierre (
    set /a i4nb=%i1nb%+%randpierre2%
    goto :save
)
if %invslot5%==pierre (
    set /a i5nb=%i5nb%+%randpierre2%
    goto :save
)
if %invslot6%==pierre (
    set /a i6nb=%i6nb%+%randpierre2%
    goto :save
)
if %invslot7%==pierre (
    set /a i7nb=%i7nb%+%randpierre2%
    goto :save
)
if %invslot8%==pierre (
    set /a i8nb=%i8nb%+%randpierre2%
    goto :save
)


if %invslot1%==vide (
    set invslot1=pierre
    set i1nb=%randpierre2%
    goto :save
)
if %invslot2%==vide (
    set invslot2=pierre
    set i2nb=%randpierre2%
    goto :save
)

if %invslot3%==vide (
    set invslot3=pierre
    set i3nb=%randpierre2%
    goto :save
)

if %invslot4%==vide (
    set invslot4=pierre
    set i4nb=%randpierre2%
    goto :save
)
if %invslot5%==vide (
    set invslot5=pierre
    set i5nb=%randpierre2%
    goto :save
)
if %invslot6%==vide (
    set invslot6=pierre
    set i6nb=%randpierre2%
    goto :save
)

if %invslot7%==vide (
    set invslot7=pierre
    set i7nb=%randpierre2%
    goto :save
)

if %invslot8%==vide (
    set invslot8=pierre
    set i8nb=%randpierre2%
    goto :save
)


goto :save


:open_porte
if !etporte%psel%!==fermee (
	set etporte%psel%=ouverte
	goto :next12
	)
if !etporte%psel%!==ouverte (
	set etporte%psel%=fermee
	goto :next12
	)
:next12
if %sons%==on (
	if !etporte%psel%!==ouverte start %CD%\Sons\door_open.vbs
	if !etporte%psel%!==fermee start %CD%\Sons\door_close.vbs
)
    set /a xsprp=!xporte%psel%!*8
    set /a ysprp=!yporte%psel%!*12
    if !etporte%psel%!==ouverte batbox /g !xporte%psel%! !yporte%psel%! /c 0x%color2% /d O /c 0x%color1%
	if !etporte%psel%!==fermee INSERTBMP /p:"textures\porte!rot%psel%!!spre!.bmp" /x:%xsprp% /y:%ysprp%
goto :tableau1


:hitfleurj
if %sons%==on start %CD%\Sons\pick_fleurs.vbs
set randxf%fleursel%=0
set randyf%fleursel%=0
set fleur%fleursel%=0
if %invslot1%==fibres-jaunes (
	set /a i1nb=%i1nb%+1
	goto :eof
	)
if %invslot2%==fibres-jaunes (
	set /a i2nb=%i2nb%+1
	goto :eof
)
if %invslot3%==fibres-jaunes (
	set /a i3nb=%i3nb%+1
	goto :eof
)
if %invslot4%==fibres-jaunes (
	set /a i4nb=%i4nb%+1
	goto :eof
)
if %invslot5%==fibres-jaunes (
    set /a i5nb=%i5nb%+1
    goto :eof
    )
if %invslot6%==fibres-jaunes (
    set /a i6nb=%i6nb%+1
    goto :eof
)
if %invslot7%==fibres-jaunes (
    set /a i7nb=%i7nb%+1
    goto :eof
)
if %invslot8%==fibres-jaunes (
    set /a i8nb=%i8nb%+1
    goto :eof
)

if %invslot1%==vide (
    set invslot1=fibres-jaunes
	set i1nb=1
	goto :eof
)
if %invslot2%==vide (
    set invslot2=fibres-jaunes
	set i2nb=1
	goto :eof
)
if %invslot3%==vide (
    set invslot3=fibres-jaunes
	set i3nb=1
	goto :eof
)
if %invslot4%==vide (
    set invslot4=fibres-jaunes
	set i4nb=1
	goto :eof
)
if %invslot5%==vide (
    set invslot5=fibres-jaunes
    set i5nb=1
    goto :eof
)
if %invslot6%==vide (
    set invslot6=fibres-jaunes
    set i6nb=1
    goto :eof
)
if %invslot7%==vide (
    set invslot7=fibres-jaunes
    set i7nb=1
    goto :eof
)
if %invslot8%==vide (
    set invslot8=fibres-jaunes
    set i8nb=1
    goto :eof
)

goto :eof 

:hitfleurr
if %sons%==on start %CD%\Sons\pick_fleurs.vbs
set randxf%fleursel%=0
set randyf%fleursel%=0
set fleur%fleursel%=0
if %invslot1%==fibres-rouges (
	set /a i1nb=%i1nb%+1
	goto :eof
	)
if %invslot2%==fibres-rouges (
	set /a i2nb=%i2nb%+1
	goto :eof
)
if %invslot3%==fibres-rouges (
	set /a i3nb=%i3nb%+1
	goto :eof
)
if %invslot4%==fibres-rouges (
	set /a i4nb=%i4nb%+1
	goto :eof
)
if %invslot1%==vide (
    set invslot1=fibres-rouges
	set i1nb=1
	goto :eof
)
if %invslot5%==fibres-rouges (
    set /a i5nb=%i5nb%+1
    goto :eof
    )
if %invslot6%==fibres-rouges (
    set /a i6nb=%i6nb%+1
    goto :eof
)
if %invslot7%==fibres-rouges (
    set /a i7nb=%i7nb%+1
    goto :eof
)
if %invslot8%==fibres-rouges (
    set /a i8nb=%i8nb%+1
    goto :eof
)

if %invslot1%==vide (
    set invslot1=fibres-rouges
    set i1nb=1
    goto :eof
)
if %invslot2%==vide (
    set invslot2=fibres-rouges
	set i2nb=1
	goto :eof
)
if %invslot3%==vide (
    set invslot3=fibres-rouges
	set i3nb=1
	goto :eof
)
if %invslot4%==vide (
    set invslot4=fibres-rouges
	set i4nb=1
	goto :eof
)
if %invslot5%==vide (
    set invslot5=fibres-rouges
    set i5nb=1
    goto :eof
)
if %invslot6%==vide (
    set invslot6=fibres-rouges
    set i6nb=1
    goto :eof
)
if %invslot7%==vide (
    set invslot7=fibres-rouges
    set i7nb=1
    goto :eof
)
if %invslot8%==vide (
    set invslot8=fibres-rouges
    set i8nb=1
    goto :eof
)


goto :eof
::------------------------------------------------------------HAUT-------------------------------------------------------
:haut
set position=1pl
set lastdir=haut
batbox /g %c1% %l1% /c 0x%color2% /d O /c 0x%color1%

::TRANSPARENTS
::riviere
if %zriv%==oui (
    for /l %%a in (0,1,%nbriv%) do (
        if %c1%a%l1%a%zx%%zy%==!riv%%a! (
        batbox /g %c1% %l1% /c 0x23 /a 219 /c 0x2f
        )
    )
)	

::fleur jaune
for /l %%a in (0,1,%zfleur%) do (
    if j%c1%a%l1%==!fleur%%a! batbox /g %c1% %l1% /c 0x2e /a 15 /c 0x2f )

::fleur rouge
for /l %%a in (0,1,%zfleur%) do (
    if r%c1%a%l1%==!fleur%%a! batbox /g %c1% %l1% /c 0x2c /a 42 /c 0x2f )
::tapis
for /l %%a in (0,1,%mt%) do (
    if %c1%a%l1%==!tapis%%a! batbox /g %c1% %l1% /c 0x84 /a 178 /c 0x2f )
	

:: feuilles arbre
for /l %%a in (0,1,%zarbre%) do (
    if %c1%a%l1%==!xa%%a!a!yaa%%a! batbox /g %c1% %l1% /c 0x26 /a 219 /c 0x2f 
    if %c1%a%l1%==!xa%%a!a!yab%%a! batbox /g %c1% %l1% /c 0x26 /a 219 /c 0x2f 
    if %c1%a%l1%==!xa%%a!a!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!xac%%a!a!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!xad%%a!a!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!xa%%a!a!yad%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!posfexax%%a!a!posfexay%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f
    if %c1%a%l1%==!posfexbx%%a!a!posfexby%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    )

set /a l1=%l1%-1
set /a yspr=%yspr%-12



:: SOLIDES
::mur
for /l %%a in (0,1,%m%) do (
    if %c1%a%l1%==!murbois%%a! (
    set /a l1=%l1%+1
    set /a yspr=%yspr%+12
    )
)

::murpierre
for /l %%a in (0,1,%mpierre%) do (
    if %c1%a%l1%==!murpierre%%a! (
    set /a l1=%l1%+1
    set /a yspr=%yspr%+12
    )
)
::four
for /l %%a in (0,1,%mfour%) do (
    if %c1%a%l1%==!murfour%%a! (
    set /a l1=%l1%+1
    set /a yspr=%yspr%+12
    )
)


::pierre
for /l %%a in (0,1,%zpierre%) do (
	for /l %%b in (1,1,20) do (
   	 	if %c1%a%l1%==!bp%%b%%a! (
  	 	set /a l1=%l1%+1
  		set /a yspr=%yspr%+12
   	 	)
	)
)

::emine 
for /l %%a in (1,1,20) do (
   	 if %c1%a%l1%==!emine%%a! (
	 goto :entreemine
   	 )
)

for /l %%a in (0,1,%mp%) do (
    if %c1%a%l1%==!murplanche%%a! (
    set /a l1=%l1%+1
    set /a yspr=%yspr%+12
    )
)

for /l %%a in (0,1,%mpr%) do (
    if %c1%a%l1%==!porte%%a! (
    	if !etporte%%a!==fermee (
    		set /a l1=%l1%+1
    		set /a yspr=%yspr%+12
    	)
    )
)

for /l %%a in (0,1,%me%) do (
    if %c1%a%l1%==!etabli%%a! (
    set /a l1=%l1%+1
    set /a yspr=%yspr%+12
    )
)
::arbre
for /l %%a in (0,1,%zarbre%) do (
    if %c1%a%l1%==!arbre%%a! (
    set /a l1=%l1%+1
    set /a yspr=%yspr%+12
    set n12=1
    )
)

if %n12%==0 set hitengage=non
set n12=0
::son riviere
for /l %%a in (0,1,%nbriv%) do (
    if %c1%a%l1%a%zx%%zy%==!riv%%a! (
	if %sons%==on start %CD%\Sons\water_splash.vbs
	)
)
for /l %%a in (0,1,%zarbre%) do (
    if %c1%a%l1%==!xa%%a!a!yaa%%a! set position=2pl
    if %c1%a%l1%==!xa%%a!a!yab%%a! set position=2pl
    if %c1%a%l1%==!xa%%a!a!yac%%a! set position=2pl
    if %c1%a%l1%==!xac%%a!a!yac%%a! set position=2pl
    if %c1%a%l1%==!xad%%a!a!yac%%a! set position=2pl
    if %c1%a%l1%==!xa%%a!a!yad%%a! set position=2pl
    if %c1%a%l1%==!posfexax%%a!a!posfexay%%a! set position=2pl
    if %c1%a%l1%==!posfexbx%%a!a!posfexby%%a! set position=2pl
)
if %position%==1pl INSERTBMP /p:"textures\perso.bmp" /x:%xspr% /y:%yspr%
goto :sprite

::------------------------------------------------------------BAS-------------------------------------------------------
:bas
set lastdir=bas
set position=1pl
batbox /g %c1% %l1% /c 0x%color2% /d O /c 0x%color1%

:: TRANSPARENTS
::riviere
if %zriv%==oui (
    for /l %%a in (0,1,%nbriv%) do (
        if %c1%a%l1%a%zx%%zy%==!riv%%a! (
        batbox /g %c1% %l1% /c 0x23 /a 219 /c 0x2f
        )
    )
)
::fleur jaune
for /l %%a in (0,1,%zfleur%) do (
    if j%c1%a%l1%==!fleur%%a! batbox /g %c1% %l1% /c 0x2e /a 15 /c 0x2f )

::fleur rouge
for /l %%a in (0,1,%zfleur%) do (
    if r%c1%a%l1%==!fleur%%a! batbox /g %c1% %l1% /c 0x2c /a 42 /c 0x2f )
::tapis
for /l %%a in (0,1,%mt%) do (
    if %c1%a%l1%==!tapis%%a! batbox /g %c1% %l1% /c 0x84 /a 178 /c 0x2f )
:: feuilles arbre
for /l %%a in (0,1,%zarbre%) do (
    if %c1%a%l1%==!xa%%a!a!yaa%%a! batbox /g %c1% %l1% /c 0x26 /a 219 /c 0x2f 
    if %c1%a%l1%==!xa%%a!a!yab%%a! batbox /g %c1% %l1% /c 0x26 /a 219 /c 0x2f 
    if %c1%a%l1%==!xa%%a!a!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!xac%%a!a!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!xad%%a!a!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!xa%%a!a!yad%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!posfexax%%a!a!posfexay%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!posfexbx%%a!a!posfexby%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    )


set /a l1=%l1%+1
set /a yspr=%yspr%+12

:: SOLIDES

::mur
for /l %%a in (0,1,%m%) do (
    if %c1%a%l1%==!murbois%%a! (
    set /a l1=%l1%-1
    set /a yspr=%yspr%-12
    )
)

::murpierre
for /l %%a in (0,1,%mpierre%) do (
    if %c1%a%l1%==!murpierre%%a! (
    set /a l1=%l1%-1
    set /a yspr=%yspr%-12
    )
)
::four
for /l %%a in (0,1,%mfour%) do (
    if %c1%a%l1%==!murfour%%a! (
    set /a l1=%l1%-1
    set /a yspr=%yspr%-12
    )
)



::pierre
for /l %%a in (0,1,%zpierre%) do (
	for /l %%b in (1,1,20) do (
   	 	if %c1%a%l1%==!bp%%b%%a! (
  	 	set /a l1=%l1%-1
  		set /a yspr=%yspr%-12
   	 	)
	)
)

for /l %%a in (0,1,%mp%) do (
    if %c1%a%l1%==!murplanche%%a! (
    set /a l1=%l1%-1
    set /a yspr=%yspr%-12
    )
)

for /l %%a in (0,1,%mpr%) do (
    if %c1%a%l1%==!porte%%a! (
    	if !etporte%%a!==fermee (
    		set /a l1=%l1%-1
    		set /a yspr=%yspr%-12
    	)
    )
)

for /l %%a in (0,1,%me%) do (
    if %c1%a%l1%==!etabli%%a! (
    set /a l1=%l1%-1
    set /a yspr=%yspr%-12
    )
)
::arbre   
for /l %%a in (0,1,%zarbre%) do (
    if %c1%a%l1%==!arbre%%a! (
    set /a l1=%l1%-1
    set /a yspr=%yspr%-12
    set n12=1
    )
)
if %n12%==0 set hitengage=non
set n12=0
::son riviere
for /l %%a in (0,1,%nbriv%) do (
    if %c1%a%l1%a%zx%%zy%==!riv%%a! (
	if %sons%==on start %CD%\Sons\water_splash.vbs
	)
)
for /l %%a in (0,1,%zarbre%) do (
    if %c1%a%l1%==!xa%%a!a!yaa%%a! set position=2pl
    if %c1%a%l1%==!xa%%a!a!yab%%a! set position=2pl
    if %c1%a%l1%==!xa%%a!a!yac%%a! set position=2pl
    if %c1%a%l1%==!xac%%a!a!yac%%a! set position=2pl
    if %c1%a%l1%==!xad%%a!a!yac%%a! set position=2pl
    if %c1%a%l1%==!xa%%a!a!yad%%a! set position=2pl
    if %c1%a%l1%==!posfexax%%a!a!posfexay%%a! set position=2pl
    if %c1%a%l1%==!posfexbx%%a!a!posfexby%%a! set position=2pl
)
if %position%==1pl INSERTBMP /p:"textures\perso.bmp" /x:%xspr% /y:%yspr%
goto :sprite

::-----------------------------------------------------------GAUCHE-------------------------------------------------------
:gauche 
set lastdir=gauche
set position=1pl
batbox /g %c1% %l1% /c 0x%color2% /d O /c 0x%color1%

:: TRANSPARENTS
::riviere
if %zriv%==oui (
    for /l %%a in (0,1,%nbriv%) do (
        if %c1%a%l1%a%zx%%zy%==!riv%%a! (
        batbox /g %c1% %l1% /c 0x23 /a 219 /c 0x2f 
        )
    )
)
::fleur jaune
for /l %%a in (0,1,%zfleur%) do (
    if j%c1%a%l1%==!fleur%%a! batbox /g %c1% %l1% /c 0x2e /a 15 /c 0x2f  )

::fleur rouge
for /l %%a in (0,1,%zfleur%) do (
    if r%c1%a%l1%==!fleur%%a! batbox /g %c1% %l1% /c 0x2c /a 42 /c 0x2f  )
::tapis
for /l %%a in (0,1,%mt%) do (
    if %c1%a%l1%==!tapis%%a! batbox /g %c1% %l1% /c 0x84 /a 178 /c 0x2f )
:: feuilles arbre
for /l %%a in (0,1,%zarbre%) do (
    if %c1%a%l1%==!xa%%a!a!yaa%%a! batbox /g %c1% %l1% /c 0x26 /a 219 /c 0x2f 
    if %c1%a%l1%==!xa%%a!a!yab%%a! batbox /g %c1% %l1% /c 0x26 /a 219 /c 0x2f 
    if %c1%a%l1%==!xa%%a!a!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!xac%%a!a!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!xad%%a!a!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!xa%%a!a!yad%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!posfexax%%a!a!posfexay%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!posfexbx%%a!a!posfexby%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    )

set /a c1=%c1%-1
set /a xspr=%xspr%-8

:: SOLIDES

::mur
for /l %%a in (0,1,%m%) do (
    if %c1%a%l1%==!murbois%%a! (
    set /a c1=%c1%+1
    set /a xspr=%xspr%+8
    )
)

::murpierre
for /l %%a in (0,1,%mpierre%) do (
    if %c1%a%l1%==!murpierre%%a! (
    set /a c1=%c1%+1
    set /a xspr=%xspr%+8
    )
)
::four
for /l %%a in (0,1,%mfour%) do (
    if %c1%a%l1%==!murfour%%a! (
    set /a c1=%c1%+1
    set /a xspr=%xspr%+8
    )
)


::pierre
for /l %%a in (0,1,%zpierre%) do (
	for /l %%b in (1,1,20) do (
   	 	if %c1%a%l1%==!bp%%b%%a! (
  	 	set /a c1=%c1%+1
  		set /a xspr=%xspr%+8
   	 	)
	)
)

for /l %%a in (0,1,%mp%) do (
    if %c1%a%l1%==!murplanche%%a! (
    set /a c1=%c1%+1
    set /a xspr=%xspr%+8
    )
)
for /l %%a in (0,1,%me%) do (
    if %c1%a%l1%==!etabli%%a! (
    set /a c1=%c1%+1
    set /a xspr=%xspr%+8
    )
)

for /l %%a in (0,1,%mpr%) do (
    if %c1%a%l1%==!porte%%a! (
    	if !etporte%%a!==fermee (
    		set /a c1=%c1%+1
    		set /a xspr=%xspr%+8
    	)
    )
)
::arbre   
for /l %%a in (0,1,%zarbre%) do (
    if %c1%a%l1%==!arbre%%a! (
    set /a c1=%c1%+1
    set /a xspr=%xspr%+8
    set n12=1
    )
)
if %n12%==0 set hitengage=non
set n12=0
::son riviere
for /l %%a in (0,1,%nbriv%) do (
    if %c1%a%l1%a%zx%%zy%==!riv%%a! (
	if %sons%==on start %CD%\Sons\water_splash.vbs
	)
)
for /l %%a in (0,1,%zarbre%) do (
    if %c1%a%l1%==!xa%%a!a!yaa%%a! set position=2pl
    if %c1%a%l1%==!xa%%a!a!yab%%a! set position=2pl
    if %c1%a%l1%==!xa%%a!a!yac%%a! set position=2pl
    if %c1%a%l1%==!xac%%a!a!yac%%a! set position=2pl
    if %c1%a%l1%==!xad%%a!a!yac%%a! set position=2pl
    if %c1%a%l1%==!xa%%a!a!yad%%a! set position=2pl
    if %c1%a%l1%==!posfexax%%a!a!posfexay%%a! set position=2pl
    if %c1%a%l1%==!posfexbx%%a!a!posfexby%%a! set position=2pl
)
if %position%==1pl INSERTBMP /p:"textures\perso.bmp" /x:%xspr% /y:%yspr%
goto :sprite

::------------------------------------------------------------DROITE-------------------------------------------------------
:droite 
set lastdir=droite
set position=1pl

batbox /g %c1% %l1% /c 0x%color2% /d O /c 0x%color1%

:: TRANSPARENTS

::riviere
if %zriv%==oui (
    for /l %%a in (0,1,%nbriv%) do (
        if 	%c1%a%l1%a%zx%%zy%==!riv%%a! (
        batbox /g %c1% %l1% /c 0x23 /a 219 /c 0x2f 
        )
    )
)
::fleur jaune
for /l %%a in (0,1,%zfleur%) do (
    if j%c1%a%l1%==!fleur%%a! batbox /g %c1% %l1% /c 0x2e /a 15 /c 0x2f )

::fleur rouge
for /l %%a in (0,1,%zfleur%) do (
    if r%c1%a%l1%==!fleur%%a! batbox /g %c1% %l1% /c 0x2c /a 42 /c 0x2f )
::tapis
for /l %%a in (0,1,%mt%) do (
    if %c1%a%l1%==!tapis%%a! batbox /g %c1% %l1% /c 0x84 /a 178 /c 0x2f )
:: feuilles arbre
for /l %%a in (0,1,%zarbre%) do (
    if %c1%a%l1%==!xa%%a!a!yaa%%a! batbox /g %c1% %l1% /c 0x26 /a 219 /c 0x2f 
    if %c1%a%l1%==!xa%%a!a!yab%%a! batbox /g %c1% %l1% /c 0x26 /a 219 /c 0x2f 
    if %c1%a%l1%==!xa%%a!a!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!xac%%a!a!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!xad%%a!a!yac%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!xa%%a!a!yad%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!posfexax%%a!a!posfexay%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    if %c1%a%l1%==!posfexbx%%a!a!posfexby%%a! batbox /g %c1% %l1% /c 0x2a /a 177 /c 0x2f 
    )

set /a c1=%c1%+1
set /a xspr=%xspr%+8

:: SOLIDES

::mur
for /l %%a in (0,1,%m%) do (
    if %c1%a%l1%==!murbois%%a! (
    set /a c1=%c1%-1
    set /a xspr=%xspr%-8
    )
)

::murpierre
for /l %%a in (0,1,%mpierre%) do (
    if %c1%a%l1%==!murpierre%%a! (
    set /a c1=%c1%-1
    set /a xspr=%xspr%-8
    )
)
::four
for /l %%a in (0,1,%mfour%) do (
    if %c1%a%l1%==!murfour%%a! (
    set /a c1=%c1%-1
    set /a xspr=%xspr%-8
    )
)

::pierre
for /l %%a in (0,1,%zpierre%) do (
	for /l %%b in (1,1,20) do (
   	 	if %c1%a%l1%==!bp%%b%%a! (
  	 	set /a c1=%c1%-1
  		set /a xspr=%xspr%-8
   	 	)
	)
)

for /l %%a in (0,1,%mp%) do (
    if %c1%a%l1%==!murplanche%%a! (
    set /a c1=%c1%-1
    set /a xspr=%xspr%-8
    )
)
for /l %%a in (0,1,%me%) do (
    if %c1%a%l1%==!etabli%%a! (
    set /a c1=%c1%-1
    set /a xspr=%xspr%-8
    )
)

for /l %%a in (0,1,%mpr%) do (
    if %c1%a%l1%==!porte%%a! (
    	if !etporte%%a!==fermee (
    		set /a c1=%c1%-1
    		set /a xspr=%xspr%-8
    	)
    )
)
::arbre   
for /l %%a in (0,1,%zarbre%) do (
    if %c1%a%l1%==!arbre%%a! (
    set /a c1=%c1%-1
    set /a xspr=%xspr%-8
    set n12=1
    )
)
if %n12%==0 set hitengage=non
set n12=0
::son riviere
for /l %%a in (0,1,%nbriv%) do (
    if %c1%a%l1%a%zx%%zy%==!riv%%a! (
	if %sons%==on start %CD%\Sons\water_splash.vbs
	)
)
for /l %%a in (0,1,%zarbre%) do (
    if %c1%a%l1%==!xa%%a!a!yaa%%a! set position=2pl
    if %c1%a%l1%==!xa%%a!a!yab%%a! set position=2pl
    if %c1%a%l1%==!xa%%a!a!yac%%a! set position=2pl
    if %c1%a%l1%==!xac%%a!a!yac%%a! set position=2pl
    if %c1%a%l1%==!xad%%a!a!yac%%a! set position=2pl
    if %c1%a%l1%==!xa%%a!a!yad%%a! set position=2pl
    if %c1%a%l1%==!posfexax%%a!a!posfexay%%a! set position=2pl
    if %c1%a%l1%==!posfexbx%%a!a!posfexby%%a! set position=2pl
)
if %position%==1pl INSERTBMP /p:"textures\perso.bmp" /x:%xspr% /y:%yspr%
goto :sprite





:AddMur

::creation d'un mur
if %bloc%==buche (
set file=buche
set etat=solide
set nselect=m
if %nbloc%==0 goto :fingame
)

if %bloc%==planches (
set file=planches
set etat=solide
set nselect=mp
if %nbloc%==0 goto :fingame
)

if %bloc%==etabli (
set file=etabli!spre!
set etat=solide
set nselect=me
if %nbloc%==0 goto :fingame
)

if %bloc%==porte (
set file=porte%rot%!spre!
set nselect=mpr
set etat=solide
if %nbloc%==0 goto :fingame
)

if %bloc%==pierre (
set file=pierre
set nselect=mpierre
set etat=solide
if %nbloc%==0 goto :fingame
)
if %bloc%==four (
set file=four
set nselect=mfour
set etat=solide
if %nbloc%==0 goto :fingame
)
if %bloc%==tapis (
set bloc1=178
set nselect=mt
set colob=84
set etat=trans
)

for /l %%b in (0,1,!%nselect%!) do (
    if !murbois%%b!==%x%a%y% (
        goto :tableau1
    )
    if !murpierre%%b!==%x%a%y% (
        goto :tableau1
    )
    if !murplanche%%b!==%x%a%y% (
    goto :tableau1
    )
    if !porte%%b!==%x%a%y% (
    goto :tableau1
    )
    if !tapis%%b!==%x%%y% (
    goto :tableau1
    )
    if !four%%b!==%x%a%y% (
        goto :tableau1
    )
)

if %bloc%==buche (
set /a m=%m%+1
set murbois%m%=%x%a%y%
set xmurbois%m%=%x%
set ymurbois%m%=%y%
set /a nbloc=%nbloc%-1
echo murbois%m%;!xmurbois%m%!;!ymurbois%m%!>>%CD%\saves\!dest!.save
echo !m!;!mt!;!mp!;!me!;!mpr!;!mpierre!;!mfour!>%CD%\saves\val.save
)

if %bloc%==pierre (
set /a mpierre=!mpierre!+1
set murpierre%mpierre%=%x%a%y%
set xmurpierre%mpierre%=%x%
set ymurpierre%mpierre%=%y%
set /a nbloc=%nbloc%-1
echo murpierre%mpierre%;!xmurpierre%mpierre%!;!ymurpierre%mpierre%!>>%CD%\saves\!dest!.save
echo !m!;!mt!;!mp!;!me!;!mpr!;!mpierre!;!mfour!>%CD%\saves\val.save
)

if %bloc%==four (
set /a mfour=%mfour%+1
set murfour%mfour%=%x%a%y%
set xmurfour%mfour%=%x%
set ymurfour%mfour%=%y%
set /a nbloc=%nbloc%-1
echo murfour%mfour%;!xmurfour%mfour%!;!ymurfour%mfour%!>>%CD%\saves\!dest!.save
echo !m!;!mt!;!mp!;!me!;!mpr!;!mpierre!;!mfour!>%CD%\saves\val.save
)

if %bloc%==planches (
set /a mp=%mp%+1
set murplanche%mp%=%x%a%y%
set xmurplanche%mp%=%x%
set ymurplanche%mp%=%y%
set /a nbloc=%nbloc%-1
echo murplanche%mp%;!xmurplanche%mp%!;!ymurplanche%mp%!>>%CD%\saves\!dest!.save
echo !m!;!mt!;!mp!;!me!;!mpr!;!mpierre!;!mfour!>%CD%\saves\val.save
)

if %bloc%==etabli (
set /a me=%me%+1
set etabli%me%=%x%a%y%
set xetabli%me%=%x%
set yetabli%me%=%y%
set /a nbloc=%nbloc%-1
echo etabli%me%;!xetabli%me%!;!yetabli%me%!>>%CD%\saves\!dest!.save
echo !m!;!mt!;!mp!;!me!;!mpr!;!mpierre!;!mfour!>%CD%\saves\val.save
)

if %bloc%==porte (
set /a mpr=%mpr%+1
set porte%mpr%=%x%a%y%
set xporte%mpr%=%x%
set yporte%mpr%=%y%
set rot%mpr%=%rot%
set etporte%mpr%=fermee
set /a nbloc=%nbloc%-1
echo porte%mpr%;!xporte%mpr%!;!yporte%mpr%!;!rot%mpr%!>>%CD%\saves\!dest!.save
echo !m!;!mt!;!mp!;!me!;!mpr!;!mpierre!;!mfour!>%CD%\saves\val.save
)

if %bloc%==tapis (
set /a mt=%mt%+1
set tapis%mt%=%x%a%y%
set xtap%mt%=%x%
set ytap%mt%=%y%
echo tapis%mt%;!xtap%mt%!;!ytap%mt%!>>%CD%\saves\!dest!.save
echo !m!;!mt!;!mp!;!me!;!mpr!;!mpierre!;!mfour!>%CD%\saves\val.save
)

set /a xs=%x%*8
set /a ys=%y%*12
INSERTBMP /p:"textures\%file%.bmp" /x:%xs% /y:%ys%
batbox /g 0 0
if %invslot1%==%bloc% (
    set /a i1nb=%i1nb%-1
    goto :next2
)
if %invslot2%==%bloc% (
    set /a i2nb=%i2nb%-1
    goto :next2
)
if %invslot3%==%bloc% (
    set /a i3nb=%i3nb%-1
    goto :next2
)
if %invslot4%==%bloc% (
    set /a i4nb=%i4nb%-1
    goto :next2
)
if %invslot5%==%bloc% (
    set /a i5nb=%i5nb%-1
    goto :next2
)
if %invslot6%==%bloc% (
    set /a i6nb=%i6nb%-1
    goto :next2
)
if %invslot7%==%bloc% (
    set /a i7nb=%i7nb%-1
    goto :next2
)
if %invslot8%==%bloc% (
    set /a i8nb=%i8nb%-1
    goto :next2
)
:next2
del %CD%\saves\inventaire.save
echo slot1;%invslot1%;!i1nb!>>%CD%\saves\inventaire.save
echo slot2;%invslot2%;!i2nb!>>%CD%\saves\inventaire.save
echo slot3;%invslot3%;!i3nb!>>%CD%\saves\inventaire.save
echo slot4;%invslot4%;!i4nb!>>%CD%\saves\inventaire.save
echo slot5;%invslot5%;!i5nb!>>%CD%\saves\inventaire.save
echo slot6;%invslot6%;!i6nb!>>%CD%\saves\inventaire.save
echo slot7;%invslot7%;!i7nb!>>%CD%\saves\inventaire.save
echo slot8;%invslot8%;!i8nb!>>%CD%\saves\inventaire.save
goto :tableau





:CasserMur
::check destruction d'un mur
for /l %%a in (0,1,%m%) do (
    if !murbois%%a!==%x%a%y% (
    	set destrselect=buche
        goto :CasserMur2
    )
)
for /l %%a in (0,1,%mpierre%) do (
    if !murpierre%%a!==%x%a%y% (
    	set destrselect=pierre
        goto :CasserMur2
    )
)
for /l %%a in (0,1,%mfour%) do (
    if !murfour%%a!==%x%a%y% (
    	set destrselect=four
        goto :CasserMur2
    )
)
for /l %%a in (0,1,%mp%) do (
    if !murplanche%%a!==%x%a%y% (
    	set destrselect=planches
        goto :CasserMur2
    )
)

for /l %%a in (0,1,%me%) do (
    if !etabli%%a!==%x%a%y% (
    	set destrselect=etabli
        goto :CasserMur2
    )
)

for /l %%a in (0,1,%mpr%) do (
    if !porte%%a!==%x%a%y% (
    	set destrselect=porte
        goto :CasserMur2
    )
)

for /l %%a in (0,1,%mt%) do (
    if !tapis%%a!==%x%%y% (
        goto :CasserMur2
    )
)
goto :tableau1


:CasserMur2
::destruction d'un mur

if %invslot1%==%destrselect% (
    set slotselectb=1
    set slotc=plein
    goto :next_casser3
)
if %invslot2%==%destrselect% (
    set slotselectb=2
    set slotc=plein
    goto :next_casser3
)
if %invslot3%==%destrselect% (
    set slotselectb=3
    set slotc=plein
    goto :next_casser3
)
if %invslot4%==%destrselect% (
    set slotselectb=4
    set slotc=plein
    goto :next_casser3
)
if %invslot5%==%destrselect% (
    set slotselectb=5
    set slotc=plein
    goto :next_casser3
)
if %invslot6%==%destrselect% (
    set slotselectb=6
    set slotc=plein
    goto :next_casser3
)
if %invslot7%==%destrselect% (
    set slotselectb=7
    set slotc=plein
    goto :next_casser3
)
if %invslot8%==%destrselect% (
    set slotselectb=8
    set slotc=plein
    goto :next_casser3
)

if %invslot1%==vide (
    set invslot1=%destrselect%
    set slotselecta=1
    set slotc=vide
    goto :next_casser3
)
if %invslot2%==vide (
    set invslot2=%destrselect%
    set slotselecta=2
    set slotc=vide
    goto :next_casser3
)
if %invslot3%==vide (
    set invslot3=%destrselect%
    set slotselecta=3
    set slotc=vide
    goto :next_casser3
)
if %invslot4%==vide (
    set invslot4=%destrselect%
    set slotselecta=4
    set slotc=vide
    goto :next_casser3
)
if %invslot5%==vide (
    set invslot5=%destrselect%
    set slotselecta=5
    set slotc=vide
    goto :next_casser3
)
if %invslot6%==vide (
    set invslot6=%destrselect%
    set slotselecta=6
    set slotc=vide
    goto :next_casser3
)
if %invslot7%==vide (
    set invslot7=%destrselect%
    set slotselecta=7
    set slotc=vide
    goto :next_casser3
)
if %invslot8%==vide (
    set invslot8=%destrselect%
    set slotselecta=8
    set slotc=vide
    goto :next_casser3
)


:next_casser3
for /l %%b in (0,1,%m%) do (
    if !murbois%%b!==%x%a%y% (
        set murbois%%b=0
        set xmurbois%%b=0
        set ymurbois%%b=0
        if not %slotc%==vide set /a i%slotselectb%nb=!i%slotselectb%nb!+1
        if %slotc%==vide set /a i%slotselecta%nb=!i%slotselecta%nb!+1
        set /a nbloc=%nbloc%+1
    )
)
for /l %%b in (0,1,%mpierre%) do (
    if !murpierre%%b!==%x%a%y% (
        set murpierre%%b=0
        set xmurpierre%%b=0
        set ymurpierre%%b=0
        if not %slotc%==vide set /a i%slotselectb%nb=!i%slotselectb%nb!+1
        if %slotc%==vide set /a i%slotselecta%nb=!i%slotselecta%nb!+1
        set /a nbloc=%nbloc%+1
    )
)
for /l %%b in (0,1,%mfour%) do (
    if !murfour%%b!==%x%a%y% (
        set murfour%%b=0
        set xmurfour%%b=0
        set ymurfour%%b=0
        if not %slotc%==vide set /a i%slotselectb%nb=!i%slotselectb%nb!+1
        if %slotc%==vide set /a i%slotselecta%nb=!i%slotselecta%nb!+1
        set /a nbloc=%nbloc%+1
    )
)
for /l %%b in (0,1,%mp%) do (
    if !murplanche%%b!==%x%a%y% (
        set murplanche%%%b=0
        set xmurplanche%%%b=0
        set ymurplanche%%%b=0
        if not %slotc%==vide set /a i%slotselectb%nb=!i%slotselectb%nb!+1
        if %slotc%==vide set /a i%slotselecta%nb=!i%slotselecta%nb!+1
        set /a nbloc=%nbloc%+1
    )
)

for /l %%b in (0,1,%me%) do (
    if !etabli%%b!==%x%a%y% (
        set etabli%%%b=0
        set xetabli%%%b=0
        set yetabli%%%b=0
        if not %slotc%==vide set /a i%slotselectb%nb=!i%slotselectb%nb!+1
        if %slotc%==vide set /a i%slotselecta%nb=!i%slotselecta%nb!+1
        set /a nbloc=%nbloc%+1
    )
)


for /l %%b in (0,1,%mpr%) do (
    if !porte%%b!==%x%a%y% (
        set porte%%%b=0
        set xporte%%%b=0
        set yporte%%%b=0
        if not %slotc%==vide set /a i%slotselectb%nb=!i%slotselectb%nb!+1
        if %slotc%==vide set /a i%slotselecta%nb=!i%slotselecta%nb!+1
        set /a nbloc=%nbloc%+1
    )
)
for /l %%b in (0,1,%mt%) do (
    if !tapis%%b!==%x%%y% (
        set tapis%%b=0
        set xtap%%b=0
        set ytap%%b=0
    )
)

batbox /g %x% %y% /c 0x%color2% /a 219 /c 0x%color1% 
del %CD%\saves\inventaire.save
echo slot1;%invslot1%;!i1nb!>>%CD%\saves\inventaire.save
echo slot2;%invslot2%;!i2nb!>>%CD%\saves\inventaire.save
echo slot3;%invslot3%;!i3nb!>>%CD%\saves\inventaire.save
echo slot4;%invslot4%;!i4nb!>>%CD%\saves\inventaire.save
echo slot5;%invslot5%;!i5nb!>>%CD%\saves\inventaire.save
echo slot6;%invslot6%;!i6nb!>>%CD%\saves\inventaire.save
echo slot7;%invslot7%;!i7nb!>>%CD%\saves\inventaire.save
echo slot8;%invslot8%;!i8nb!>>%CD%\saves\inventaire.save
goto :tableau


:arbrecasse
::destruction de l'arbre
set hitengage=non

set /a yabr=!yarbre!-1
set /a yacr=!yarbre!-2
set /a xacr=!xarbre!-1
set /a xadr=!xarbre!+1
set /a yadr=!yarbre!-3
if %sons%==on start %CD%\Sons\tree_down.vbs
batbox /g !xarbre! !yarbre! /c 0x22 /a 219 /c 0x2f /w 20
batbox /g !xarbre! !yabr! /c 0x22 /a 219 /c 0x2f /w 20
batbox /g !xarbre! !yacr! /c 0x22 /a 177 /c 0x2f /w 20
batbox /g !xacr! !yacr! /c 0x22 /a 177 /c 0x2f /w 20
batbox /g !xadr! !yacr! /c 0x22 /a 177 /c 0x2f /w 20
batbox /g !xarbre! !yadr! /c 0x22 /a 177 /c 0x2f /w 20
batbox /g !xacr! !yadr! /c 0x22 /a 177 /c 0x2f /w 20
batbox /g !xadr! !yadr! /c 0x22 /a 177 /c 0x2f /w 20

for /l %%a in (0,1,%zarbre%) do (
    if !arbre%%a!==%xarbre%a%yarbre% call :destrarbre %%a
)
set /a randbois1=%random%%%3 
set /a randbois=%randbois1%+3

if %invslot1%==buche (
    set /a i1nb=%i1nb%+%randbois%
    goto :save
)
if %invslot2%==buche (
    set /a i2nb=%i2nb%+%randbois%
    goto :save
)
if %invslot3%==buche (
    set /a i3nb=%i3nb%+%randbois%
    goto :save
)
if %invslot4%==buche (
    set /a i4nb=%i4nb%+%randbois%
    goto :save
)
if %invslot5%==buche (
    set /a i5nb=%i5nb%+%randbois%
    goto :save
)
if %invslot6%==buche (
    set /a i6nb=%i6nb%+%randbois%
    goto :save
)
if %invslot7%==buche (
    set /a i7nb=%i7nb%+%randbois%
    goto :save
)
if %invslot8%==buche (
    set /a i8nb=%i8nb%+%randbois%
    goto :save
)

if %invslot1%==vide (
    set invslot1=buche
    set i1nb=%randbois%
    goto :save
)
if %invslot2%==vide (
    set invslot2=buche
    set i2nb=%randbois%
    goto :save
)

if %invslot3%==vide (
    set invslot3=buche
    set i3nb=%randbois%
    goto :save
)

if %invslot4%==vide (
    set invslot4=buche
    set i4nb=%randbois%
    goto :save
)
if %invslot5%==vide (
    set invslot5=buche
    set i5nb=%randbois%
    goto :save
)
if %invslot6%==vide (
    set invslot6=buche
    set i6nb=%randbois%
    goto :save
)

if %invslot7%==vide (
    set invslot7=buche
    set i7nb=%randbois%
    goto :save
)

if %invslot8%==vide (
    set invslot8=buche
    set i8nb=%randbois%
    goto :save
)

goto :save





:destrarbre
set arbre%1=!arbre%zarbre%!
set xa%1=0
set yaa%1=0
set xac%1=0
set xad%1=0
set yab%1=0
set yac%1=0
set yad%1=0
set posfexax%1=0
set posfexbx%1=0
set posfexay%1=0
set posfexby%1=0
goto :eof

:save 
del %CD%\saves\inventaire.save
echo slot1;%invslot1%;!i1nb!>>%CD%\saves\inventaire.save
echo slot2;%invslot2%;!i2nb!>>%CD%\saves\inventaire.save
echo slot3;%invslot3%;!i3nb!>>%CD%\saves\inventaire.save
echo slot4;%invslot4%;!i4nb!>>%CD%\saves\inventaire.save
echo slot5;%invslot5%;!i5nb!>>%CD%\saves\inventaire.save
echo slot6;%invslot6%;!i6nb!>>%CD%\saves\inventaire.save
echo slot7;%invslot7%;!i7nb!>>%CD%\saves\inventaire.save
echo slot8;%invslot8%;!i8nb!>>%CD%\saves\inventaire.save
FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\!dest!.save) DO (
    for /l %%b in (0,1,%m%) do (
        if murbois%%b==%%g echo murbois%%b;!xmurbois%%b!;!ymurbois%%b!>>%CD%\saves\!dest!a.save
    )
)
FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\!dest!.save) DO (
    for /l %%b in (0,1,%mp%) do (
        if murplanche%%b==%%g echo murplanche%%b;!xmurplanche%%b!;!ymurplanche%%b!>>%CD%\saves\!dest!a.save
    )
)


FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\!dest!.save) DO (
    for /l %%b in (0,1,%mpierre%) do (
        if murpierre%%b==%%g echo murpierre%%b;!xmurpierre%%b!;!ymurpierre%%b!>>%CD%\saves\!dest!a.save
    )
)

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\!dest!.save) DO (
    for /l %%b in (0,1,%mfour%) do (
        if murfour%%b==%%g echo murfour%%b;!xmurfour%%b!;!ymurfour%%b!>>%CD%\saves\!dest!a.save
    )
)


FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\!dest!.save) DO (
    for /l %%b in (0,1,%me%) do (
        if etabli%%b==%%g echo etabli%%b;!xetabli%%b!;!yetabli%%b!>>%CD%\saves\!dest!a.save
    )
)




FOR /F "tokens=1,2,3,4 delims=;" %%g IN (%CD%\saves\!dest!.save) DO (
    for /l %%b in (0,1,%mpr%) do (
        if porte%%b==%%g echo porte%%b;!xporte%%b!;!yporte%%b!;!rot%%b!>>%CD%\saves\!dest!a.save
    )
)
FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\!dest!.save) DO (
    for /l %%b in (0,1,%mt%) do (
        if tapis%%b==%%g echo tapis%%b;!xtap%%b!;!ytap%%b!>>%CD%\saves!dest!a.save
    )
)

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\!dest!.save) DO (
    for /l %%a in (0,1,%zarbre%) do (
        if garbre%%a==%%g echo garbre%%a;!xa%%a!;!yaa%%a!>>%CD%\saves\!dest!a.save
        if parbre%%a==%%g echo parbre%%a;!xa%%a!;!yaa%%a!>>%CD%\saves\!dest!a.save
    )
)
FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\!dest!.save) DO (
    for /l %%a in (0,1,%zfleur%) do (
        if jfleur%%a==%%g echo jfleur%%a;!randxf%%a!;!randyf%%a!>>%CD%\saves\!dest!a.save
        if rfleur%%a==%%g echo rfleur%%a;!randxf%%a!;!randyf%%a!>>%CD%\saves\!dest!a.save
    )
)
FOR /F "tokens=1,2,3,4 delims=;" %%g IN (%CD%\saves\!dest!.save) DO (
    for /l %%a in (0,1,%nbriv%) do (
        if riv%%a==%%g echo riv%%a;%%h;%%i;%%j>>%CD%\saves\!dest!a.save
	)
)
FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\!dest!.save) DO (
    for /l %%a in (0,1,%zpierre%) do (
        if gpierre%%a==%%g echo gpierre%%a;!startx%%a!;!starty%%a!>>%CD%\saves\!dest!a.save
        if ppierre%%a==%%g echo ppierre%%a;!startx%%a!;!starty%%a!>>%CD%\saves\!dest!a.save
    )
)

for /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\!dest!.save) DO (
	if mine==%%g echo mine;!startxm!;!startym!>>%CD%\saves\!dest!a.save
)
:next6
echo !m!;!mt!;!mp!;!me!;!mpr!;!mpierre!;!mfour!>%CD%\saves\val.save
echo !zx!;!zy!;!c1!;!l1!;!zone!>%CD%\saves\player.save
echo %zx%%zy%;!biome!>>%CD%\saves\biomes.save
del %CD%\saves\!dest!.save
ren %CD%\saves\!dest!a.save !dest!.save
goto :tableau



:load
::chargement des valeurs
set zriv=non
cls
echo !zx!;!zy!;!c1!;!l1!>%CD%\saves\player.save
echo %zx%%zy%;!biome!>>%CD%\saves\biomes.save
for /f "tokens=1,2 delims=;" %%g in (%CD%\saves\biomes.save) do (
	if %zx%%zy%==%%g set biome=%%h
	)

for /f "tokens=1,2,3 delims=;" %%g in (%CD%\saves\inventaire.save) do (
    if slot1==%%g (
        set invslot1=%%h
        set i1nb=%%i
    )
    if slot2==%%g (
        set invslot2=%%h
        set i2nb=%%i
    )
    if slot3==%%g (
        set invslot3=%%h
        set i3nb=%%i
    )
    if slot4==%%g (
        set invslot4=%%h
        set i4nb=%%i
    ) 
    if slot5==%%g (
        set invslot5=%%h
        set i5nb=%%i
    )
    if slot6==%%g (
        set invslot6=%%h
        set i6nb=%%i
    )
    if slot7==%%g (
        set invslot7=%%h
        set i7nb=%%i
    )
    if slot8==%%g (
        set invslot8=%%h
        set i8nb=%%i
    )    

)

	for /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zxa%%zya%.save) DO (
    	for /l %%a in (0,1,10) do (
    	    set bp1%%a=0
    	    set bp2%%a=0
    	    set bp3%%a=0
    	    set bp4%%a=0
    	    set bp5%%a=0
    	    set bp6%%a=0
    	    set bp7%%a=0
    	    set bp8%%a=0
    	    set bp9%%a=0
    	    set bp10%%a=0
    	    set bp11%%a=0
    	    set bp12%%a=0
    	    set bp13%%a=0
    	    set bp14%%a=0
    	    set bp15%%a=0
    	    set bp16%%a=0
    	    set bp17%%a=0
    	    set bp18%%a=0
    	    set bp19%%a=0
			)
		)
	)

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zxa%%zya%.save) DO (
    for /l %%b in (0,1,%m%) do (
        if murbois%%b==%%g (
            batbox /g !xmurbois%%b! !ymurbois%%b! /c 0x22 /d O /c 0x2f
            set xmurbois%%b=0
            set ymurbois%%b=0
            set murbois%%b=0

        )
    )
)

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zxa%%zya%.save) DO (
    for /l %%b in (0,1,%mpierre%) do (
        if murpierre%%b==%%g (
            batbox /g !xmurpierre%%b! !ymurpierre%%b! /c 0x22 /d O /c 0x2f
            set xmurpierre%%b=0
            set ymurpierre%%b=0
            set murpierre%%b=0

        )
    )
)


FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zxa%%zya%.save) DO (
    for /l %%b in (0,1,%mfour%) do (
        if murfour%%b==%%g (
            batbox /g !xmurfour%%b! !ymurfour%%b! /c 0x22 /d O /c 0x2f
            set xmurfour%%b=0
            set ymurfour%%b=0
            set murfour%%b=0

        )
    )
)

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zxa%%zya%.save) DO (
    for /l %%b in (0,1,%mp%) do (
        if murplanche%%b==%%g (
            batbox /g !xmurplanche%%b! !ymurplanche%%b! /c 0x22 /d O /c 0x2f
            set xmurplanche%%b=0
            set ymurplanche%%b=0
            set murplanche%%b=0

        )
    )
)

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zxa%%zya%.save) DO (
    for /l %%b in (0,1,%me%) do (
        if etabli%%b==%%g (
        	batbox /g !xetabli%%b! !yetabli%%b! /c 0x22 /d O /c 0x2f
            set xetabli%%b=0
            set yetabli%%b=0
            set etabli%%b=0

        )
    )
)

FOR /F "tokens=1,2,3,4 delims=;" %%g IN (%CD%\saves\%zxa%%zya%.save) DO (
    for /l %%b in (0,1,%mpr%) do (
        if porte%%b==%%g (
        	batbox /g !xporte%%b! !yporte%%b! /c 0x22 /d O /c 0x2f
            set xporte%%b=0
            set yporte%%b=0
            set porte%%b=0
            set rot%%b=%%j
            set etporte%%b=fermee
        )
    )
)

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zxa%%zya%.save) DO (
    for /l %%b in (0,1,%mt%) do (
        if tapis%%b==%%g (
        	batbox /g !xtap%%b! !ytap%%b! /c 0x22 /d O /c 0x2f
            set xtap%%b=0
            set ytap%%b=0
            set tapis%%b=0
        )
    )
)


::--------------------------------------------------------------------------------
for /f "tokens=1-8 delims=;" %%g in (%CD%\saves\val.save) do (
    set m=%%g
    set mt=%%h
    set mp=%%i
    set me=%%j
    set mpr=%%k
    set mpierre=%%l
    set mfour=%%m
)


for /f "tokens=1,2 delims=;" %%g in (%CD%\saves\zoneinfo.save) do (
	if a%zx%%zy%==%%g set zarbre=%%h 
	if r%zx%%zy%==%%g set zriv=oui
	if f%zx%%zy%==%%g set zfleur=%%h
	if nr%zx%%zy%==%%g set nbriv=%%h
	if pi%zx%%zy%==%%g set zpierre=%%h

)

::chargement terrain sauvegarde
cls

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
    for /l %%a in (0,1,%zfleur%) do (
        if jfleur%%a==%%g (
        	set randxf%%a=%%h
        	set randyf%%a=%%i
			set fleur%%a=j%%ha%%i
       	 	batbox /g !randxf%%a! !randyf%%a! /c 0x2e /a 15 /c 0x2f
       )
       	if rfleur%%a==%%g (
        	set randxf%%a=%%h
        	set randyf%%a=%%i
			set fleur%%a=r%%ha%%i
        	batbox /g !randxf%%a! !randyf%%a! /c 0x2c /a 42 /c 0x2f 	

        )
    )
)     

if %zriv%==oui (
	for /f "tokens=1,2,3,4 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
		for /l %%a in (0,1,%nbriv%) do (
			if riv%%a==%%g (
				set riv%%a=%%ha%%ia%%j
				batbox /g %%h %%i /c 0x23 /a 219 /c 0x2f 
				if %%h geq !maxcol! goto :next5
				if %%i leq 0 goto :next5
				if %%i geq !maxline! goto :next5
			)
		)
	)
)
:next5

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
    for /l %%a in (0,1,%zarbre%) do (
    if garbre%%a==%%g (
    set xa%%a=%%h
    set yaa%%a=%%i

    set /a yab%%a=!yaa%%a!-1
    set /a yac%%a=!yaa%%a!-2
    set /a xac%%a=!xa%%a!-1
    set /a xad%%a=!xa%%a!+1
    set /a yad%%a=!yaa%%a!-3
    set arbre%%a=!xa%%a!a!yaa%%a!
    set posfexax%%a=!xac%%a!
    set posfexbx%%a=!xad%%a!
    set posfexay%%a=!yad%%a!
    set posfexby%%a=!yad%%a!
    
    batbox /g !xa%%a! !yaa%%a! /c 0x26 /a 219 /c 0x2f
    batbox /g !xa%%a! !yab%%a! /c 0x26 /a 219 /c 0x2f
    batbox /g !xa%%a! !yac%%a! /c 0x2a /a 177 /c 0x2f
    batbox /g !xac%%a! !yac%%a! /c 0x2a /a 177 /c 0x2f
    batbox /g !xad%%a! !yac%%a! /c 0x2a /a 177 /c 0x2f
    batbox /g !xa%%a! !yad%%a! /c 0x2a /a 177 /c 0x2f
    batbox /g !xac%%a! !yad%%a! /c 0x2a /a 177 /c 0x2f
    batbox /g !xad%%a! !yad%%a! /c 0x2a /a 177 /c 0x2f 

)    
 if parbre%%a==%%g (
    set xa%%a=%%h
    set yaa%%a=%%i
    
    set /a yab%%a=!yaa%%a!-1
    set /a yac%%a=!yaa%%a!-2
    set /a xac%%a=!xa%%a!-1
    set /a xad%%a=!xa%%a!+1
    set /a yad%%a=!yaa%%a!-3
    set /a yab%%a=!yaa%%a!-1
    set /a yac%%a=!yaa%%a!-2
    set /a xac%%a=!xa%%a!-1
    set /a xad%%a=!xa%%a!+1
    set /a yad%%a=!yaa%%a!-3

    set arbre%%a=!xa%%a!a!yaa%%a!

    batbox /g !xa%%a! !yaa%%a! /c 0x26 /a 219 /c 0x2f
    batbox /g !xa%%a! !yab%%a! /c 0x26 /a 219 /c 0x2f
    batbox /g !xa%%a! !yac%%a! /c 0x2a /a 177 /c 0x2f
    batbox /g !xac%%a! !yac%%a! /c 0x2a /a 177 /c 0x2f
    batbox /g !xad%%a! !yac%%a! /c 0x2a /a 177 /c 0x2f
    batbox /g !xa%%a! !yad%%a! /c 0x2a /a 177 /c 0x2f
        )
    )
)    



for /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
    for /l %%a in (0,1,%zpierre%) do (
    if gpierre%%a==%%g (
    	set startx%%a=%%h
    	set starty%%a=%%i
		set x1%%a=!startx%%a!
		set /a x2%%a=!startx%%a!+1
		set /a x3%%a=!startx%%a!-1
		set /a x4%%a=!startx%%a!+2
		set /a x5%%a=!startx%%a!-2
		set /a x6%%a=!startx%%a!+3
		set /a x7%%a=!startx%%a!-3
		
		set y1%%a=!starty%%a!
		set /a y2%%a=!starty%%a!-1
		set /a y3%%a=!starty%%a!-2
		set /a y4%%a=!starty%%a!-3
		
		
        set bp1%%a=!x1%%a!a!y1%%a!
        set bp2%%a=!x2%%a!a!y1%%a!
        set bp3%%a=!x3%%a!a!y1%%a!
        set bp4%%a=!x4%%a!a!y1%%a!
        set bp5%%a=!x5%%a!a!y1%%a!
        set bp6%%a=!x1%%a!a!y2%%a!
        set bp7%%a=!x2%%a!a!y2%%a!
        set bp8%%a=!x3%%a!a!y2%%a!
        set bp9%%a=!x4%%a!a!y2%%a!
        set bp10%%a=!x5%%a!a!y2%%a!
        set bp11%%a=!x1%%a!a!y3%%a!
        set bp12%%a=!x2%%a!a!y3%%a!
        set bp13%%a=!x3%%a!a!y3%%a!
       
        set bp14%%a=!x6%%a!a!y1%%a!
        set bp15%%a=!x7%%a!a!y1%%a!
        set bp16%%a=!x6%%a!a!y2%%a!
        set bp17%%a=!x7%%a!a!y2%%a!
        set bp18%%a=!x4%%a!a!y3%%a!
        set bp19%%a=!x5%%a!a!y3%%a!
   
   
        batbox /g !x1%%a! !y1%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x2%%a! !y1%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x3%%a! !y1%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x4%%a! !y1%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x5%%a! !y1%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x1%%a! !y2%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x2%%a! !y2%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x3%%a! !y2%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x4%%a! !y2%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x5%%a! !y2%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x1%%a! !y3%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x2%%a! !y3%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x3%%a! !y3%%a! /c 0x28 /a 178 /c 0x2f
       
        batbox /g !x6%%a! !y1%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x7%%a! !y1%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x6%%a! !y2%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x7%%a! !y2%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x4%%a! !y3%%a! /c 0x28 /a 178 /c 0x2f
        batbox /g !x5%%a! !y3%%a! /c 0x28 /a 178 /c 0x2f
		)

	if ppierre%%a==%%g (
    	set startx%%a=%%h
    	set starty%%a=%%i
		set x1%%a=!startx%%a!
		set /a x2%%a=!startx%%a!+1
		set /a x3%%a=!startx%%a!-1
		set /a x4%%a=!startx%%a!+2
		set /a x5%%a=!startx%%a!-2
		set /a x6%%a=!startx%%a!+3
		set /a x7%%a=!startx%%a!-3
		
		set y1%%a=!starty%%a!
		set /a y2%%a=!starty%%a!-1
		set /a y3%%a=!starty%%a!-2
		set /a y4%%a=!starty%%a!-3
		
		
		set bp1%%a=!x1%%a!a!y1%%a!
		set bp2%%a=!x2%%a!a!y1%%a!
		set bp3%%a=!x3%%a!a!y1%%a!
		set bp4%%a=!x4%%a!a!y1%%a!
		set bp5%%a=!x5%%a!a!y1%%a!
		set bp6%%a=!x1%%a!a!y2%%a!
		set bp7%%a=!x2%%a!a!y2%%a!
		set bp8%%a=!x3%%a!a!y2%%a!
		set bp9%%a=!x4%%a!a!y2%%a!
		set bp10%%a=!x5%%a!a!y2%%a!
		set bp11%%a=!x1%%a!a!y3%%a!
		set bp12%%a=!x2%%a!a!y3%%a!
		set bp13%%a=!x3%%a!a!y3%%a!
	
		
		
		batbox /g !x1%%a! !y1%%a! /c 0x28 /a 178 /c 0x2f
		batbox /g !x2%%a! !y1%%a! /c 0x28 /a 178 /c 0x2f
		batbox /g !x3%%a! !y1%%a! /c 0x28 /a 178 /c 0x2f
		batbox /g !x4%%a! !y1%%a! /c 0x28 /a 178 /c 0x2f
		batbox /g !x5%%a! !y1%%a! /c 0x28 /a 178 /c 0x2f
		batbox /g !x1%%a! !y2%%a! /c 0x28 /a 178 /c 0x2f
		batbox /g !x2%%a! !y2%%a! /c 0x28 /a 178 /c 0x2f
		batbox /g !x3%%a! !y2%%a! /c 0x28 /a 178 /c 0x2f
		batbox /g !x4%%a! !y2%%a! /c 0x28 /a 178 /c 0x2f
		batbox /g !x5%%a! !y2%%a! /c 0x28 /a 178 /c 0x2f
		batbox /g !x1%%a! !y3%%a! /c 0x28 /a 178 /c 0x2f
		batbox /g !x2%%a! !y3%%a! /c 0x28 /a 178 /c 0x2f
		batbox /g !x3%%a! !y3%%a! /c 0x28 /a 178 /c 0x2f

		)
	)
)



for /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
if mine==%%g (
	set startxm=%%h
	set startym=%%i
	set x1%1=!startxm!
	set /a x2=!startxm!+1
	set /a x3=!startxm!-1
	set /a x4=!startxm!+2
	set /a x5=!startxm!-2
	set /a x6=!startxm!+3
	set /a x7=!startxm!-3
	
	set y1=!startym!
	set /a y2=!startym!-1
	set /a y3=!startym!-2
	set /a y4=!startym!-3
	
	
	set emine1=!x1!a!y1!
	set emine2=!x2!a!y1!
	set emine3=!x3!a!y1!
	set bp4a0=!x4!a!y1!
	set bp5a0=!x5!a!y1!
	set emine6=!x1!a!y2!
	set emine7=!x2!a!y2!
	set emine8=!x3!a!y2!
	set bp9a0=!x4!a!y2!
	set bp10a0=!x5!a!y2!
	set bp11a0=!x1!a!y3!
	set bp12a0=!x2!a!y3!
	set bp13a0=!x3!a!y3!
	
	
	batbox /g !x1! !y1! /c 0x00 /a 178 /c 0x2f
	batbox /g !x2! !y1! /c 0x00 /a 178 /c 0x2f
	batbox /g !x3! !y1! /c 0x00 /a 178 /c 0x2f
	batbox /g !x4! !y1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x5! !y1! /c 0x28 /a 178 /c 0x2f
	batbox /g !x1! !y2! /c 0x00 /a 178 /c 0x2f
	batbox /g !x2! !y2! /c 0x00 /a 178 /c 0x2f
	batbox /g !x3! !y2! /c 0x00 /a 178 /c 0x2f
	batbox /g !x4! !y2! /c 0x28 /a 178 /c 0x2f
	batbox /g !x5! !y2! /c 0x28 /a 178 /c 0x2f
	batbox /g !x1! !y3! /c 0x28 /a 178 /c 0x2f
	batbox /g !x2! !y3! /c 0x28 /a 178 /c 0x2f
	batbox /g !x3! !y3! /c 0x28 /a 178 /c 0x2f
	)
)

::------------------------------------------------------------------------
FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
    for /l %%b in (0,1,%m%) do (
        if murbois%%b==%%g (
            set xmurbois%%b=%%h
            set ymurbois%%b=%%i
            set murbois%%b=%%ha%%i
			set /a xs%%b=%%h*8
            set /a ys%%b=%%i*12
            INSERTBMP /p:"textures\buche.bmp" /x:!xs%%b! /y:!ys%%b!
        )
    )
)

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
    for /l %%b in (0,1,%mpierre%) do (
        if murpierre%%b==%%g (
            set xmurpierre%%b=%%h
            set ymurpierre%%b=%%i
            set murpierre%%b=%%ha%%i
			set /a xs%%b=%%h*8
            set /a ys%%b=%%i*12
            INSERTBMP /p:"textures\pierre.bmp" /x:!xs%%b! /y:!ys%%b!
        )
    )
)


FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
    for /l %%b in (0,1,%mp%) do (
        if murplanche%%b==%%g (
            set xmurplanche%%b=%%h
            set ymurplanche%%b=%%i
            set murplanche%%b=%%ha%%i
            set /a xs%%b=%%h*8
            set /a ys%%b=%%i*12
            INSERTBMP /p:"textures\planches.bmp" /x:!xs%%b! /y:!ys%%b!
        )
    )
)

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
    for /l %%b in (0,1,%me%) do (
        if etabli%%b==%%g (
            set xetabli%%b=%%h
            set yetabli%%b=%%i
            set etabli%%b=%%ha%%i
            set /a xs%%b=%%h*8
            set /a ys%%b=%%i*12
            INSERTBMP /p:"textures\etabli!spre!.bmp" /x:!xs%%b! /y:!ys%%b!
        )
    )
)


FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
    for /l %%b in (0,1,%mfour%) do (
        if murfour%%b==%%g (
            set xmurfour%%b=%%h
            set ymurfour%%b=%%i
            set murfour%%b=%%ha%%i
			set /a xs%%b=%%h*8
            set /a ys%%b=%%i*12
            INSERTBMP /p:"textures\four.bmp" /x:!xs%%b! /y:!ys%%b!
        )
    )
)


FOR /F "tokens=1,2,3,4 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
    for /l %%b in (0,1,%mpr%) do (
        if porte%%b==%%g (
            set xporte%%b=%%h
            set yporte%%b=%%i
            set porte%%b=%%ha%%i
            set rot%%b=%%j
            set etporte%%b=fermee
            set /a xs%%b=%%h*8
            set /a ys%%b=%%i*12
            INSERTBMP /p:"textures\porte!rot%%b!!spre!.bmp" /x:!xs%%b! /y:!ys%%b!
        )
    )
)

FOR /F "tokens=1,2,3 delims=;" %%g IN (%CD%\saves\%zx%%zy%.save) DO (
    for /l %%b in (0,1,%mt%) do (
        if tapis%%b==%%g (
            set xtap%%b=%%h
            set ytap%%b=%%i
            set tapis%%b=%%ha%%i
            batbox /g !xtap%%b! !ytap%%b! /c 0x84 /a 178 /c 0x2f 
        )
    )
)




goto :tableau



::generation des fleurs
:setf
set /a randf=%random%%%2
set /a randxf%1=%random%%%!maxcol!
set /a randyf%1=%random%%%!maxline!
if %randf%==1 (
batbox /g !randxf%1! !randyf%1! /c 0x2e /a 15 /c 0x2f
set fleur%1=j!randxf%1!a!randyf%1!
echo jfleur%1;!randxf%1!;!randyf%1!>>%CD%\saves\%zx%%zy%.save
)

if %randf%==0 (
batbox /g !randxf%1! !randyf%1! /c 0x2c /a 42 /c 0x2f
set fleur%1=r!randxf%1!a!randyf%1!
echo rfleur%1;!randxf%1!;!randyf%1!>>%CD%\saves\%zx%%zy%.save
)

goto :eof

::generation des arbres
:seta 
set /a xa%1=%random%%%!maxcol!
:setaa
set /a yaa%1=%random%%%!maxline!
if !yaa%1! lss 10 goto :setaa
set /a randaf=%random%%%2
set /a yab%1=!yaa%1!-1
set /a yac%1=!yaa%1!-2
set /a xac%1=!xa%1!-1
set /a xad%1=!xa%1!+1
set /a yad%1=!yaa%1!-3
set arbre%1=!xa%1!a!yaa%1!

if %randaf%==0 (
set posfexax%1=!xac%1!
set posfexbx%1=!xad%1!
set posfexay%1=!yad%1!
set posfexby%1=!yad%1!
batbox /g !xa%1! !yaa%1! /c 0x26 /a 219 /c 0x2f
batbox /g !xa%1! !yab%1! /c 0x26 /a 219 /c 0x2f
batbox /g !xa%1! !yac%1! /c 0x2a /a 177 /c 0x2f
batbox /g !xac%1! !yac%1! /c 0x2a /a 177 /c 0x2f
batbox /g !xad%1! !yac%1! /c 0x2a /a 177 /c 0x2f
batbox /g !xa%1! !yad%1! /c 0x2a /a 177 /c 0x2f
batbox /g !xac%1! !yad%1! /c 0x2a /a 177 /c 0x2f
batbox /g !xad%1! !yad%1! /c 0x2a /a 177 /c 0x2f
echo garbre%1;!xa%1!;!yaa%1!>>%CD%\saves\%zx%%zy%.save
)

if %randaf%==1 (
batbox /g !xa%1! !yaa%1! /c 0x26 /a 219 /c 0x2f
batbox /g !xa%1! !yab%1! /c 0x26 /a 219 /c 0x2f
batbox /g !xa%1! !yac%1! /c 0x2a /a 177 /c 0x2f
batbox /g !xac%1! !yac%1! /c 0x2a /a 177 /c 0x2f
batbox /g !xad%1! !yac%1! /c 0x2a /a 177 /c 0x2f
batbox /g !xa%1! !yad%1! /c 0x2a /a 177 /c 0x2f
set posfexax%1=0
set posfexbx%1=0
set posfexay%1=0
set posfexby%1=0
echo parbre%1;!xa%1!;!yaa%1!>>%CD%\saves\%zx%%zy%.save
)

goto :eof


::------------------------------------------------------------------------GENERATION DE PIERRE-------------------------------------------------------
:setpierre

set /a randpierre=%random%%%2
if %randpierre%==0 (

	set /a startx%1=%random%%%200
	set /a starty%1=%random%%%70
	
	set x1%1=!startx%1!
	set /a x2%1=!startx%1!+1
	set /a x3%1=!startx%1!-1
	set /a x4%1=!startx%1!+2
	set /a x5%1=!startx%1!-2
	set /a x6%1=!startx%1!+3
	set /a x7%1=!startx%1!-3
	
	set y1%1=!starty%1!
	set /a y2%1=!starty%1!-1
	set /a y3%1=!starty%1!-2
	set /a y4%1=!starty%1!-3
	
	
	set bp1%1=!x1%1!a!y1%1!
	set bp2%1=!x2%1!a!y1%1!
	set bp3%1=!x3%1!a!y1%1!
	set bp4%1=!x4%1!a!y1%1!
	set bp5%1=!x5%1!a!y1%1!
	set bp6%1=!x1%1!a!y2%1!
	set bp7%1=!x2%1!a!y2%1!
	set bp8%1=!x3%1!a!y2%1!
	set bp9%1=!x4%1!a!y2%1!
	set bp10%1=!x5%1!a!y2%1!
	set bp11%1=!x1%1!a!y3%1!
	set bp12%1=!x2%1!a!y3%1!
	set bp13%1=!x3%1!a!y3%1!
	
	set bp14%1=!x6%1!a!y1%1!
	set bp15%1=!x7%1!a!y1%1!
	set bp16%1=!x6%1!a!y2%1!
	set bp17%1=!x7%1!a!y2%1!
	set bp18%1=!x4%1!a!y3%1!
	set bp19%1=!x5%1!a!y3%1!
	

	batbox /g !x1%1! !y1%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x2%1! !y1%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x3%1! !y1%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x4%1! !y1%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x5%1! !y1%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x1%1! !y2%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x2%1! !y2%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x3%1! !y2%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x4%1! !y2%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x5%1! !y2%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x1%1! !y3%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x2%1! !y3%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x3%1! !y3%1! /c 0x%color3% /a 178 /c 0x2f
	
	batbox /g !x6%1! !y1%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x7%1! !y1%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x6%1! !y2%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x7%1! !y2%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x4%1! !y3%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x5%1! !y3%1! /c 0x%color3% /a 178 /c 0x2f
	
	echo gpierre%1;!startx%1!;!starty%1!>>%CD%\saves\!dest!.save
	goto :eof
	
)
if %randpierre%==1 (

	set /a startx%1=%random%%%200
	set /a starty%1=%random%%%70
	
	set x1%1=!startx%1!
	set /a x2%1=!startx%1!+1
	set /a x3%1=!startx%1!-1
	set /a x4%1=!startx%1!+2
	set /a x5%1=!startx%1!-2
	set /a x6%1=!startx%1!+3
	set /a x7%1=!startx%1!-3
	
	set y1%1=!starty%1!
	set /a y2%1=!starty%1!-1
	set /a y3%1=!starty%1!-2
	set /a y4%1=!starty%1!-3
	
	
	set bp1%1=!x1%1!a!y1%1!
	set bp2%1=!x2%1!a!y1%1!
	set bp3%1=!x3%1!a!y1%1!
	set bp4%1=!x4%1!a!y1%1!
	set bp5%1=!x5%1!a!y1%1!
	set bp6%1=!x1%1!a!y2%1!
	set bp7%1=!x2%1!a!y2%1!
	set bp8%1=!x3%1!a!y2%1!
	set bp9%1=!x4%1!a!y2%1!
	set bp10%1=!x5%1!a!y2%1!
	set bp11%1=!x1%1!a!y3%1!
	set bp12%1=!x2%1!a!y3%1!
	set bp13%1=!x3%1!a!y3%1!
	
	
	batbox /g !x1%1! !y1%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x2%1! !y1%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x3%1! !y1%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x4%1! !y1%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x5%1! !y1%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x1%1! !y2%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x2%1! !y2%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x3%1! !y2%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x4%1! !y2%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x5%1! !y2%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x1%1! !y3%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x2%1! !y3%1! /c 0x%color3% /a 178 /c 0x2f
	batbox /g !x3%1! !y3%1! /c 0x%color3% /a 178 /c 0x2f
	
	
	
	echo ppierre%1;!startx%1!;!starty%1!>>%CD%\saves\!dest!.save
	goto :eof

	
)



:setmine

set /a startxm%1=%random%%%200
set /a startym%1=%random%%%70

set x1%1=!startxm!
set /a x2=!startxm!+1
set /a x3=!startxm!-1
set /a x4=!startxm!+2
set /a x5=!startxm!-2
set /a x6=!startxm!+3
set /a x7=!startxm!-3

set y1=!startym!
set /a y2=!startym!-1
set /a y3=!startym!-2
set /a y4=!startym!-3


set emine1=!x1!a!y1!
set emine2=!x2!a!y1!
set emine3=!x3!a!y1!
set bp40=!x4!a!y1!
set bp50=!x5!a!y1!
set emine6=!x1!a!y2!
set emine7=!x2!a!y2!
set emine8=!x3!a!y2!
set bp90=!x4!a!y2!
set bp100=!x5!a!y2!
set bp110=!x1!a!y3!
set bp120=!x2!a!y3!
set bp130=!x3!a!y3!


batbox /g !x1! !y1! /c 0x00 /a 178 /c 0x2f
batbox /g !x2! !y1! /c 0x00 /a 178 /c 0x2f
batbox /g !x3! !y1! /c 0x00 /a 178 /c 0x2f
batbox /g !x4! !y1! /c 0x!color3! /a 178 /c 0x2f
batbox /g !x5! !y1! /c 0x!color3! /a 178 /c 0x2f
batbox /g !x1! !y2! /c 0x00 /a 178 /c 0x2f
batbox /g !x2! !y2! /c 0x00 /a 178 /c 0x2f
batbox /g !x3! !y2! /c 0x00 /a 178 /c 0x2f
batbox /g !x4! !y2! /c 0x!color3! /a 178 /c 0x2f
batbox /g !x5! !y2! /c 0x!color3! /a 178 /c 0x2f
batbox /g !x1! !y3! /c 0x!color3! /a 178 /c 0x2f
batbox /g !x2! !y3! /c 0x!color3! /a 178 /c 0x2f
batbox /g !x3! !y3! /c 0x!color3! /a 178 /c 0x2f



echo mine%1;!startxm%1!;!startym%1!>>%CD%\saves\!dest!.save
goto :eof


:ShowGui_
FOR /F "tokens=1,* delims=:" %%A IN ('AGRAF "%~1" %~2') DO SET %%A=%%B
Goto :Eof



::---------------------------------------------------------------------------------------END OF CODE--------------------------------------------------------------------------------
