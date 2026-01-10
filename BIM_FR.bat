MODE CON: COLS=160
@echo off
REG ADD "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d "chcp 65001 >NUL" /f


:menu
set stop=false
echo. 
echo.
echo à tout moment vous pouvez abréger votre opération en saisissant    menu   ^(sinon Ctrl+C^)
echo ? Souhaitez vous :
echo . renommer des éléments :                                          nn
echo . copier un ou plusieurs un élément :                              cd
echo . faire remonter des éléments :                                    et
echo.
goto :main

:main
set /p ope="operation : "

         if "%ope%"=="nn" ( call :rename
) else ( if "%ope%"=="cd" ( call :distribute
) else ( if "%ope%"=="et" ( call :extract

) else ( goto :main )))


if "%stop%"=="true" (
    goto :menu
)
pause

goto :menu
goto :EOF



:rename
echo.
echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
echo :     RENNOMAGE
echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
echo °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
echo.
    call :questionTargetType
    if "%stop%"=="true" goto :EOF
    call :questionRenameType
    if "%stop%"=="true" goto :EOF
    call :ignoreConfirmation
    if "%stop%"=="true" goto :EOF
    :NNCQD
    call :questionDestination
    if "%stop%"=="true" goto :EOF
    call :questionSearchedword
    if "%stop%"=="true" goto :EOF
    if "%stop%"=="CQD"  goto :NNCQD
    call :questionNewName
    if "%stop%"=="true" goto :EOF
    echo.
    call :renRoutine
goto :EOF

:distribute
echo.
echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
echo :     COPIE
echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
echo °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
echo.
    call :questionTargetType
    if "%stop%"=="true" goto :EOF
    :CDCQD
    call :questionDestination
    if "%stop%"=="true" goto :EOF
    call :questionSearchedword
    if "%stop%"=="true" goto :EOF
    if "%stop%"=="CQD"  goto :CDCQD
    call :questionSource
    if "%stop%"=="true" goto :EOF
    call :ignoreBox
    if "%stop%"=="true" goto :EOF
    call :multiple
    if "%stop%"=="true" goto :EOF
    call :questionNewName
    if "%stop%"=="true" goto :EOF
    echo.
    call :copyRoutine
goto :EOF

:extract
echo.
echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
echo :     EXTRACTION
echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
echo °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
echo.
    set "searchedType=r"
    call :ignoreConfirmation
    if "%stop%"=="true" goto :EOF
    :ETCQD
    call :questionDestination
    if "%stop%"=="true" goto :EOF
    call :questionSearchedword
    if "%stop%"=="true" goto :EOF
    if "%stop%"=="CQD"  goto :ETCQD
    call :specifName
    if "%stop%"=="true" goto :EOF
    call :questionNewName
    if "%stop%"=="true" goto :EOF
    echo.
    call :extractRoutine
goto :EOF




:questionSearchedType
    set "searchedType="

    set /p searchedType= "rechercher parmi les fichier (f) ou les dossiers (d) : "

    if "%searchedType%"=="menu" (  set "stop=true"
                                   goto :EOF
    ) else ( 
        if "%searchedType%"=="f" ( goto :EOQST )
        if "%searchedType%"=="d" ( goto :EOQST
    ) else (
        goto :questionSearchedType))
:EOQST
    echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
    if "%searchedType%"=="f" (          echo :     Recherche parmi les fichiers # searchedType=%searchedType%
    ) else ( if "%searchedType%"=="d" ( echo :     Recherche parmi les dossiers # searchedType=%searchedType%
    ) )
    echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
    echo.

goto :EOF


:questionTargetType
    set "searchedType="

    if "%ope%"=="nn" ( set /p searchedType= "renommage divers à travers les sous-répertoires (r) ou de répertoires parmi ceux visibles (d) : " 
    ) else ( set /p searchedType= "copie multiple vers une destination unique (r) ou à vers des répertoires ciblés parmi ceux visibles (d) : " )

    if "%searchedType%"=="menu" (   set "stop=true"
                                    goto :EOF
    ) else ( 
        if "%searchedType%"=="r" (  goto :EOQTT )
        if "%searchedType%"=="d" (  goto :EOQTT
    ) else (
        goto :questionTargetType))
:EOQTT
    echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
    if "%ope%"=="nn" ( 
             if "%searchedType%"=="r" ( echo :     Renommage ciblé à travers tout les sous-répertoires # searchedType=%searchedType%
    ) else ( if "%searchedType%"=="d" ( echo :     Renommage de dossiers parmi ceux visibles # searchedType=%searchedType%
    ) ) ) else (
             if "%searchedType%"=="r" ( echo :     Copie à répétition vers un répertoire sélectionné # searchedType=%searchedType%
    ) else ( if "%searchedType%"=="d" ( echo :     Copie vers un ensemble de sous-répertoires ciblés parmi les premiers du répertoire parent # searchedType=%searchedType%
    ) ) )
    echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
    echo.

goto :EOF


:questionRenameType
    set "renameType="

    if "%searchedType%"=="r" ( set /p renameType= "renommer les occurences correspondantes avec dernier indice du dossier parent (i) sinon laissez vide pour appliquer un nom invariable : "
    ) else ( set /p renameType= "renommer chaque dossier correspondant avec le dernier indice (i) ou une autre partie variable (p) de son nom original, ou avec nouvel indice de départ (e) : " )

    if "%renameType%"=="menu" ( set "stop=true"
                                goto :EOF
    ) else (
        if "%searchedType%"=="r" ( if not "%renameType%"=="i" ( set "renameType=e" )
        goto :EOQRT
    ) else ( 
        if "%renameType%"=="e" ( goto :EOQRT )
        if "%renameType%"=="i" ( goto :EOQRT )
        if "%renameType%"=="p" ( goto :EOQRT
    ) else (
        goto :questionRenameType )))
:EOQRT
    echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
    if "%searchedType%"=="d" ( 
             if "%renameType%"=="i" ( echo :     Renommage parmi les dossiers visibles en conservant la dernière valeur numérique du nom d'origine # renameType=%renameType%
    ) else ( if "%renameType%"=="p" ( echo :     Renommage parmi les dossiers visibles en conservant les parties variable du nom d'origine # renameType=%renameType%
    ) else ( if "%renameType%"=="e" ( echo :     Renommage incrémentoire parmi les dossiers visibles # renameType=%renameType%
    ) ) ) ) else ( if "%searchedType%"=="r" (
             if "%renameType%"=="i" ( echo : Renommage à travers chaque répertoire en gardant la dernière valeur numérique du nom des dossiers parents # renameType=%renameType%
    ) else ( if "%renameType%"=="e" ( echo :     Renommage ciblé des fichiers ou dossiers à travers tout les sous-répertoires # renameType=%renameType%
    ) ) ) )
    echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
    echo.

goto :EOF


:ignoreBox
    set "ignoreBox="

    if "%searchedType%"=="d" if exist "%srcPath%\" ( echo.
        set /p ignoreBox= "Voulez-vous placer directement le contenu de ce répertoire dans ceux de destination (tapez `y`) sinon laissez vide : " )
    if "%searchedType%"=="d" if exist "%srcPath%\" (

    if "%ignoreBox%"=="menu" ( set "stop=true"
                               goto :EOF 

    ) else ( if "%ignoreBox%"=="y" (
        echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
        echo : Le répertoire copié se retrouvera dans chaque répertoire de destination
        echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
        echo.
    ) else ( set "ignoreBox="  
             call :getbox "%srcPath%"
        echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
        echo : le contenu du répertoire copié sera directement placé dans chaque répertoire de destination
        echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
        echo.
    ) ) ) 

goto :EOF
     :getbox

    set "box=%~1"
    set "next=start"
    
    :searchedbox
    for /f "tokens=1,* delims=\" %%B in ("%box%") do ( set "next=%%C" )
    
    if "%next%"=="" ( 
        for /f "tokens=1,* delims=\" %%B in ("%box%") do ( set "box=%%B\" )
    ) else (
        set "box=%next%"
        goto :searchedbox 
    )

    goto :EOF


:ignoreConfirmation
    set "ignoreConfirmation="

    if "%ope%"=="nn" ( set /p ignoreConfirmation= "Souhaitez vous effectuer le renommage d'un bloc (tapez `y`) Ou parcourir les éléments pas à pas (laissez vide) : " 
    ) else ( set /p ignoreConfirmation= "Souhaitez vous effectuer l'extraction d'un bloc (tapez `y`) Ou parcourir les éléments pas à pas (laissez vide) : " ) 

    if "%ignoreConfirmation%"=="menu" ( set "stop=true"
                                        goto :EOF

    ) else ( if "%ignoreConfirmation%"=="y" ( set "confirm=y"
        echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
        if "%ope%"=="nn" (
            if "%searchedType%"=="r" (  echo : Le renommage sera récursif et se fera SANS confirmation 
            ) else (                    echo : Le renommage se fera SANS confirmation
        ) ) else ( 
                                        echo : L'extraction se fera SANS confirmation 
        )
    ) else ( set "confirm="
        if "%ope%"=="nn" (
                                        echo renommage pas à pas
        ) else (
                                        echo extraction pas à pas
    ) )
        echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
        echo. 
    )

goto :EOF


:specifName

    set "specifName="
    set /p specifName= "Souhaitez vous renommer les éléments récupérés (tapez `y`, sinon laissez vide) : "
    echo.

    if "%specifName%"=="menu" ( set "stop=true" 
    ) else ( if not "%specifName%"=="y" ( set "specifName=" ) )

goto :EOF



:questionSource

    echo.
    set /p srcPath= "élément à copier : "

    for /f "tokens=* delims=" %%B in ("%srcPath%") do ( set "srcPath=%%B" )

    if "%srcPath%"=="menu" (            set "stop=true"
                                        goto :EOF

    ) else ( if not exist "%srcPath%" ( goto :questionSource ) )

    echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
    echo :     source retenue = %srcPath%
    echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------

goto :EOF


:questionDestination

    echo.
    if "%ope%"=="cd" ( if "%searchedType%"=="d" ( set /p dirPrompt= "racine des répertoires vers lesquels copier : "
    ) else ( set /p dirPrompt= "destination de copie : " )
    ) else ( set /p dirPrompt= "dossier (parent) de recherche : " )
    if "%dirPrompt%"=="" goto :questionDestination

    for /f "tokens=* delims=" %%B in ("%dirPrompt%") do ( set "dirPrompt=%%B" )

    for %%A in ("%dirPrompt%") do ( set "dirPath=%%~dpA"
                                    set "endPath=%%~nxA" )
    
    if "%dirPrompt%"=="menu" (              set "stop=true"
                                            goto :EOF

    ) else ( if "%dirPrompt%"=="%endPath%" ( goto :questionDestination
    ) else ( if not exist %dirPath% (        goto :questionDestination

    ) else ( if exist "%dirPrompt%\" ( if not "%dirPath%"=="%dirPrompt%" ( 

        set "dirPath=%dirPrompt%\" 
    ) ) ) ) )
        
if "%ope%"=="cd" if "%searchedtype%"=="d" ( goto :EOF )
    
    echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
    echo :     chemin retenu = %dirPath%
    echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
    

goto :EOF


:questionSearchedword

    if "%ope%"=="cd" if "%searchedType%"=="r" ( goto :EOF )
    echo.
    set "word1="
    set "word2="
    set "choix="

    if "%renameType%"=="p" ( set /p word1= "première partie du nom à extraire pour isoler les indices : "
    ) else ( if "%ope%"=="cd" ( set /p word1= "identification des répertoires de destination (partielle ou complète) : "
    ) else ( set /p word1= "nom à rechercher (partiel ou complet) : " ) )

    if "%word1%"=="menu" (  set "stop=true" 
                            goto :EOF

        ) else ( if not "%word1%"=="" ( for %%C in ("%word1%") do ( set "word1=%%~nxC" ) ) )


    if "%ope%"=="nn" ( if "%renameType%"=="p" ( set /p word2= "deuxième partie du nom à extraire pour isoler les indices : " ) ) 

    if "%word2%"=="menu" (  set "stop=true" 
                            goto :EOF
        ) else (
            if "%word2%"=="" (
                if "%word1%"=="" goto :questionSearchedword
            ) else (
                for %%C in ("%word2%") do ( set "word2=%%~nxC" ) 
        ) )

    set "searchedPath=%dirPath%*%word1%*%word2%*"

    if "%ope%"=="et" (          set "stop=true"
        for /f "tokens=*" %%d in ( 'dir "%dirPath%" /b /a:d' ) do ( 
                                    dir "%dirPath%%%d\*%word1%*%word2%*" /b /s >nul 2>&1

        if not errorlevel 1 ( set "stop=false" ) ) 

    ) else (                    set "stop=false"
        if "%searchedType%"=="d" (  dir "%searchedPath%" /a:d /b >nul 2>&1
        ) else (                    dir "%searchedPath%" /b /s >nul 2>&1 )

        if errorlevel 1 (       set "stop=true" )
    )

    if "%stop%"=="true" ( 
        echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
        set /p choix="Aucun résultat. Tapez n'importe quel touche pour repartir au menu, ou saisissez une nouvelle recherche en appuyant sur entrée : " 
    )
    if "%stop%"=="true" ( if "%choix%"=="" ( set "stop=CQD" 
                        ) else (             goto :EOF ) )

 
    if "%ope%"=="cd" if "%searchedtype%"=="d" if not "%stop%"=="CQD" ( 
        echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
        echo :     chemin retenu = %searchedPath%
        echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
    )

goto :EOF


:questionNewName

    if "%ope%"=="cd" if "%searchedType%"=="d" ( goto :EOF )
    if "%ope%"=="et" if "%specifName%"=="" (    goto :EOF )
    echo.
    set "newName1="
    set "newName2="
    
    set /p newName1= "saisir le nouveau nom (son préfixe s'il contient un indice) : "

    if "%newName1%"=="menu" (   set "stop=true" 
                                goto :EOF
        ) else ( 
            if "%newName1%"=="" ( 
                if "%renameType%"=="e" goto :questionNewName

            ) else (
                for %%C in ("%newName1%") do ( set "newName1=%%~nxC" ) 
        ) )


    set "restricted=false"
    if "%renameType%"=="e" if "%searchedType%"=="r" ( set "restricted=true" )
    if "%restricted%"=="false" ( set /p newName2= "saisir le suffixe du nouveau nom (après indice) : " )
    if "%restricted%"=="false" (

    if "%newName2%"=="menu" (   set "stop=true" 

        ) else ( 
            if "%newName2%"=="" (
                if "%newName1%"=="" goto :questionNewName

            ) else (
                for %%C in ("%newName2%") do ( set "newName2=%%~nxC" ) 
        ) )
    ) 

goto :EOF




:renRoutine
    set "indice="
    set "useIndice=y"
    
    if "%renameType%"=="e" ( if "%searchedType%"=="d" ( set /P indice= "indice de départ : " 
    ) ) else ( if "%renameType%"=="i" (                 set /A "indice=0" ) )

    if "%indice%"=="menu" ( set "stop=true"
                            goto :EOF
    ) else ( 
    if "%renameType%"=="e" if "%searchedType%"=="d"   ( set /A "indice=%indice%-1" ) )

    if "%searchedType%"=="r" ( set "searchedList=/s"
    ) else (                   set "searchedList=/a:d" )

    echo.
    echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
    if "%renameType%"=="p" ( echo : Recherche des chaines  *%word1%*%word2%*  pour les renommer  %newName1%***%newName2%
    ) else ( echo : Recherche des chaines  *%word1%*%word2%*  pour les renommer  %newName1%%indice%%newName2% )
    echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
    if not "%ignoreConfirmation%"=="y" echo --- NB : Vous pouvez répéter le choix précédent en entrant une saisie vide ^(par défaut la saisie est `n`^) ---------------------------------------------------
    echo.

    setlocal enabledelayedexpansion
    for /f "tokens=*" %%d in ('dir "%searchedPath%" /b %searchedList%') do (
 
        if "%searchedList%"=="/s" ( set "relativePath=%%~dpd"
        ) else (                    set "relativePath=%dirPath%" )
        set "fullName=%%~nxd"          
        set "extension=%%~xd"   

        call :renext
            echo.
            if errorlevel 2 goto :EOF
    )
    endlocal
    
echo.
goto :EOF
     :renext
        set "fullPath=%relativePath%%fullName%"
        if exist "%fullPath%\" set "extension="
        set "newName=%newName%%extension%"

        echo.
        echo ----- Dans le répertoire  %relativePath%  

        if "%renameType%"=="i" ( 

            if "%searchedType%"=="r" (          call :indiceNaturel "!relativePath:%dirPath%=!" 
            ) else ( if "%searchedType%"=="d" ( call :indiceNaturel "%fullName%" ) )

            if errorlevel 3 ( 
                ver > nul
                call :indiceNaturel "%dirPath%"

                if errorlevel 3 ( echo - Aucun indice trouvé
                ) else ( set /p useIndice="- Pas d'indice trouvé depuis le répertoire de recherche, voulez-vous utiliser le plus proche indice antérieur (Tapez `y`, sinon une autre touche): "
            
            ) ) else ( set "useIndice=y" )

        ) else ( if "%searchedType%"=="d" (

                 if "%renameType%"=="p" (
                    set "indice=%fullName%"
                    if not "%word1%"=="" set "indice=!indice:%word1%=!"
                    if not "%word2%"=="" set "indice=!indice:%word2%=!"

                 ) else ( set /A "indice=%indice%+1" )
        ) )
        
        if "%useIndice%"=="menu" (          set "stop=true"
                                            exit /b 2 
        ) else ( if not "%useIndice%"=="y"  set /A "indice=0" )

        set "newName=%newName1%%indice%%newName2%"
        if exist "%relativePath%%newName%" ( 

            if "%extension%"=="" ( echo ---- un autre répertoire nommé  %newName%\  existe déjà, ce nom ne peut être donné à  %fullName%\
            ) else (               echo ------- un autre fichier nommé  %newName%\  existe déjà, ce nom ne peut être donné à  %fullName%\ )
            pause
            goto :EOF

        ) else ( if not "%ignoreConfirmation%"=="y" ( REM echo.

            if "%extension%"=="" ( set /p confirm= "- Renommer le répertoire  %fullName%\  en  %newName%\  (si oui tapez `y`, sinon une autre touche): "
            ) else (               set /p confirm= "---- Renommer le fichier  %fullName%  en  %newName%  (si oui tapez `y`, sinon une autre touche): " ) ) )

        if "%confirm%"=="menu" ( set "stop=true"
                                    exit /b 2

        ) else ( if "%confirm%" == "y" ( 

            ren "%fullPath%" "%newName%"
            echo %fullName%   : a été renommé   %newName%
        ) )
            
    goto :EOF
         :indiceNaturel
            set "one=0"
            set "new=0"
            if  [%~1] == [] ( set "string=O"
            ) else ( set "string=%~1" )

            :count
            set char=%string:~0,1%
            
            if  "%char%" geq "0" if "%char%" leq "9" (

                if "%new%"=="0" (       set "one=1"
                                        set "new=1"
                                        set "indice=%char%"
                ) else (        set "indice=%indice%%char%" )

            ) else ( if "%new%"=="1" (  set "new=0"       ) )

            set string=%string:~1%
            if not "%string%"=="" goto :count 

            if not "%indice%"=="" set /A "indice=%indice%+0"
            if "%one%"=="0" exit /b 3

        goto :EOF



:copyRoutine

    if "%searchedType%"=="d" (
        
        for /f "tokens=*" %%d in ('dir "%searchedPath%" /a:d /b') do (
            if exist "%srcPath%\" (

                echo Copie vers  %dirPath%%%d\%box% :
                echo.
                xcopy "%srcPath%" "%dirPath%%%d\%box%"
            ) else (

                echo Copie vers  %dirPath%%%d\ :
                copy "%srcPath%" "%dirPath%%%d\"
            )
            echo.
        )
    ) else ( if "%searchedType%"=="r" (

        if exist "%srcPath%\" ( 
            
            if "%start%"=="%nbCopies%" (
                    echo création du dossier  %newName1%\ :
                    xcopy "%srcPath%" "%dirPath%%newName1%\" /e

            ) else ( 
                for /l %%n in (%start%,1,%nbCopies%) do (
                
                    echo création du dossier  %newName1%%%n%newName2%\ :
                    xcopy "%srcPath%" "%dirPath%%newName1%%%n%newName2%\" /e )
            echo.

        ) ) else ( for %%C in ("%srcPath%") do (

            if "%start%"=="%nbCopies%" ( 
                    copy "%srcPath%" "%dirPath%%newName1%%%~xC"

            ) else ( 
                for /l %%n in (%start%,1,%nbCopies%) do (
                
                    copy "%srcPath%" "%dirPath%%newName1%%%n%newName2%%%~xC" )
                    if exist %%d\ ( rmdir %%d /q /s )
        ) ) )
    ) )

goto :EOF
     :multiple 

        if "%searchedType%"=="d" ( goto :EOF )

        set "indice="
        set "nbCopies="

        echo.
        set /p nbCopies= "Combien de copies souhaitez-vous déposer (1 à 100) : "

        if "%nbCopies%"=="menu" ( set "stop=true"
                                  goto :EOF

        ) else ( if "%nbCopies%"=="" (  set /a "nbCopies=1"
        ) else (                        set /a "nbCopies=%nbCopies%+0" ) )

        if %nbCopies% GTR 1 (   set "renameType="

            if %nbCopies% GTR 100 ( echo : Dépassement du nombre de copies maximum défini pour une même éxécution
                                    goto :multiple ) 
            
        ) else (                set "renameType=e"  
            
            set /a "nbCopies=1"
            set /a "start=1"
        )
        
        :setIndice

            if %nbCopies% GTR 1  set /P indice= "indice de départ : "

            if "%indice%"=="menu" (                             set "stop=true"
                                                                goto :EOF
            ) else ( if %nbCopies% GTR 1 (  if "%indice%"=="" ( goto :setIndice 

            ) else ( set /a "start=%indice%+0" ) ) )
        
        
        If %start% LSS 0 ( set /a "indice=1" )
        set /a "start=%indice%+0"

        echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
        echo :     Nombre de copie : %nbCopies% ,        indice de départ : %indice%
        echo ---------------------------------------------------------------------------------------------------------------------------------------------------------------
        echo.

        set /a "nbCopies=%nbCopies%+%start%-1"

    goto :EOF



:extractRoutine

    echo.
    if not "%ignoreConfirmation%"=="y" ( 
        echo ----------------------------------------------------------------------------------------------------------------------------------------------------------------
        echo --- NB : Vous pouvez répéter le choix précédent en entrant une saisie vide ^(par défaut la saisie est `n`^) ----------------------------------------------------
        echo. )
        
    set /a "indice=0"
    set "newName="

    for /f "tokens=*" %%d in ('dir "%searchedPath%" /b /s') do ( 
    if not "%%~dpd"=="%dirPath%" ( if exist "%%d" (

        echo - De :   %%~dpd        
        if exist "%%d\" (
            set "originame=%%~nxd"
            set "extension="
        ) else ( 
            set "originame=%%~nd"
            set "extension=%%~xd" 
        )
        set "thisPath=%%d"

        if exist "%dirPath%%%~nxd\" (
            set "originameBis=%%~nxd"
            set "extensionBis="
        ) else (
            set "originameBis=%%~nd"
            set "extensionBis=%%~xd" 
        )
        set "renameBis="
        
        call :next
        setlocal enabledelayedexpansion                
            if "!confirm!"=="menu" ( goto :EOF )
        endlocal
                                 
        echo.
        echo.
    ) ) )

goto :EOF
     :next

        set /a "indice=%indice%+1"
        set "newName=%originame%%indice%%extension%"
        if "%renameBis%"=="" ( set "newNameBis=%originameBis%%indice%%extensionBis%" )

        if "%specifName%"=="" (

            if exist "%dirPath%%originame%%extension%" (
            if "%newNameBis%"=="%newName%" (
                
            if exist "%dirPath%%newNameBis%" ( goto :next )
                set "renameBis=yes"
                goto :next
            ) )
        ) else (   set "newName=%newName1%%indice%%newName2%%extension%" ) 

            if exist "%dirPath%%newName%" (    goto :next )
        if "%specifName%"=="" ( 

            if "%indice%" EQU "1" ( set "newName=%originame%%extension%" ) 
            set /a "indice=0"
        )

        if not "%ignoreConfirmation%"=="y" ( set /p confirm= "- récupérer l'élément  %originame%%extension%  en tant que  %newName%  (si oui tapez `y`, sinon une autre touche): " 
        ) else ( echo - récupération de l'élément  %originame%%extension%  en tant que  %newName% )

        if "%confirm%"=="menu" ( set "stop=true"
                                 goto :EOF

        ) else ( if "%confirm%"=="y" (

            if "%renameBis%"=="yes" (
                
                ren "%dirPath%%originame%%extension%" "%newNameBis%" 
                echo.
                echo l'élément ^"%originame%%extension%^" déjà présent a été renommé ^"%newNameBis%^"
            )
            
            if exist "%thisPath%\" ( 

                xcopy "%thisPath%" "%dirPath%%newName%\" /e /q
                rmdir "%thisPath%" /s /q
            ) else (

                copy "%thisPath%" "%dirPath%%newName%"
                del "%thisPath%" /q
                    
        ) ) )

    goto :EOF



