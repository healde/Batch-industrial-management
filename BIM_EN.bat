MODE CON: LINES=30 COLS=130
@echo off
REG ADD "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d "chcp 65001 >NUL" /f

echo.
echo .·:'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''':·.
echo : : ,---.  .      .       .   .-,--'  .                                                   .  : :
echo : : ^|  -'  ^|  ,-. ^|-. ,-. ^|    \^|__ . ^|  ,-. ,-.  ,-,-. ,-. ,-. ,-. ,-. ,-. ,-,-. ,-. ,-. ^|- : :
echo : : ^|  ,-' ^|  ^| ^| ^| ^| ,-^| ^|     ^|   ^| ^|  ^|-' `-.  ^| ^| ^| ,-^| ^| ^| ,-^| ^| ^| ^|-' ^| ^| ^| ^|-' ^| ^| ^|  : :
echo : : `---^|  `' `-' ^^-' `-^^ `'   `'   ' `' `-' `-'  ' ' ' `-^^ ' ' `-^^ `-^| `-' ' ' ' `-' ' ' `' : :
echo : :  ,-.^|                                                            ,^|                      : :
echo : :  `-+'              .            .       .  .-,--'            .   `'                      : :
echo : :            ,-. . , ^|- ,-. ,-. ,-^| ,-. ,-^|   \^|__ . . ,-. ,-. ^|- . ,-. ,-. ,-.            : :
echo : :            ^|-'  X  ^|  ^|-' ^| ^| ^| ^| ^|-' ^| ^|    ^|   ^| ^| ^| ^| ^|   ^|  ^| ^| ^| ^| ^| `-.            : :
echo : :            `-' ' ` `' `-' ' ' `-^^ `-' `-^^   `'   `-^^ ' ' `-' `' ' `-' ' ' `-'            : :
echo '·:..........................................................................................:·'

:main
set stop=false
echo. 
echo.
echo At any moment you can write this to come back at this step :                       main   ^(or Ctrl+C^ to quit)
echo.
echo . - -- --- ---- ? Is something you want :                                  - -- ---- --- --- -- -- - -
echo .  - - -- -- --- --- -----------------    Search for elements to rename :          re   ------------
echo .                            ---------    Search for elements to bring back :      rb   -----------------
echo .                         ------------    Copy an element to repeatedly paste :    cp   ---------
echo.
goto :operation

:operation
set /p ope="operation : "

         if "%ope%"=="re" ( call :rename
) else ( if "%ope%"=="cp" ( call :distribute
) else ( if "%ope%"=="rb" ( call :extract

) else ( goto :operation )))


if "%stop%"=="true" (
    goto :main
)
pause

goto :main
goto :EOF


:rename
echo.
echo ---------------------------------------------------------------------------------------------------------------------------------
echo :     RECURSIVELY ^(OR NOT^) SEARCH FOR ELEMENTS TO RENAME
echo ---------------------------------------------------------------------------------------------------------------------------------
echo °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
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
echo ---------------------------------------------------------------------------------------------------------------------------------
echo :     COPY AN ELEMENT TO REPEATEDLY PASTE
echo ---------------------------------------------------------------------------------------------------------------------------------
echo °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
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
echo ---------------------------------------------------------------------------------------------------------------------------------
echo :     RECURSIVELY SEARCH FOR ELEMENTS TO BRING BACK
echo ---------------------------------------------------------------------------------------------------------------------------------
echo °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
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



:questionTargetType
    set "searchedType="

    if "%ope%"=="re" ( set /p searchedType= "Rename through directories (r) or only what is visible from a selected one (d) : " 
    ) else ( set /p searchedType= "Repeatedly paste into one folder (r) or to many selected (d) : " )

    if "%searchedType%"=="main" (   set "stop=true"
                                    goto :EOF
    ) else ( 
        if "%searchedType%"=="r" (  goto :EOQTT )
        if "%searchedType%"=="d" (  goto :EOQTT
    ) else (
        goto :questionTargetType))
:EOQTT
    echo ---------------------------------------------------------------------------------------------------------------------------------
    if "%ope%"=="re" ( 
             if "%searchedType%"=="r" ( echo :     RECURSIVE SEARCH # searchedType=%searchedType%
    ) else ( if "%searchedType%"=="d" ( echo :     SEARCH ON VISIBLE ELEMENT ONLY # searchedType=%searchedType%
    ) ) ) else (
             if "%searchedType%"=="r" ( echo :     CLONE COPY # searchedType=%searchedType%
    ) else ( if "%searchedType%"=="d" ( echo :     DISTRIBUTE COPY # searchedType=%searchedType%
    ) ) )
    echo ---------------------------------------------------------------------------------------------------------------------------------
    echo.

goto :EOF


:questionRenameType
    set "renameType="

    if "%searchedType%"=="r" ( set /p renameType= "Rename with using parent folders last index (i) or offer static name (-) : "
    ) else ( set /p renameType= "Rename with using the last index contained in the name (i) or with an isolated part of the name (p) or with new index (e) : " )

    if "%renameType%"=="main" ( set "stop=true"
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
    echo ---------------------------------------------------------------------------------------------------------------------------------
    if "%searchedType%"=="d" ( 
             if "%renameType%"=="i" ( echo :     USE NAME LAST NUMERICAL VALUE AS INDEX # renameType=%renameType%
    ) else ( if "%renameType%"=="p" ( echo :     USE PART OF THE NAME AS VALUE # renameType=%renameType%
    ) else ( if "%renameType%"=="e" ( echo :     SET WITH NEW INDEX # renameType=%renameType%
    ) ) ) ) else ( if "%searchedType%"=="r" (
             if "%renameType%"=="i" ( echo :     USE PARENT FOLDERS LAST NUMERICAL VALUE AS INDEX # renameType=%renameType%
    ) else ( if "%renameType%"=="e" ( echo :     SEARCH AND USE GENERICAL NAME # renameType=%renameType%
    ) ) ) )
    echo ---------------------------------------------------------------------------------------------------------------------------------
    echo.

goto :EOF


:ignoreBox
    set "ignoreBox="

    if "%searchedType%"=="d" if exist "%srcPath%\" ( echo.
        set /p ignoreBox= "Do you want let content out (y) or keep into selected folder (-) : " )
    if "%searchedType%"=="d" if exist "%srcPath%\" (

    if "%ignoreBox%"=="main" ( set "stop=true"
                               goto :EOF 

    ) else ( if "%ignoreBox%"=="y" (
        echo ---------------------------------------------------------------------------------------------------------------------------------
        echo : FULL FOLDER IS READY TO BE COPIED
        echo ---------------------------------------------------------------------------------------------------------------------------------
        echo.
    ) else ( set "ignoreBox="  
             call :getbox "%srcPath%"
        echo ---------------------------------------------------------------------------------------------------------------------------------
        echo : FOLDER'S CONTENT ONLY IS READY TO BE COPIED
        echo ---------------------------------------------------------------------------------------------------------------------------------
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

    if "%ope%"=="re" ( set /p ignoreConfirmation= "Do want every match to be renamed in one shot (y) or set each command with a confirmation (-) : " 
    ) else ( set /p ignoreConfirmation= "Do want every match to be extracted in one shot (y) or set each command with a confirmation (-) : " ) 

    if "%ignoreConfirmation%"=="main" ( set "stop=true"
                                        goto :EOF

    ) else ( if "%ignoreConfirmation%"=="y" ( set "confirm=y"
        echo ---------------------------------------------------------------------------------------------------------------------------------
        if "%ope%"=="re" (
            if "%searchedType%"=="r" (  echo : RECURSIVE SEARCH,  AND RENAME WITHOUT CONFIRMATION 
            ) else (                    echo : MATCH LIMITED TO VISIBLE FOLDERS,  AND RENAME WITHOUT CONFIRMATION
        ) ) else ( 
                                        echo : EXTRACTION WITHOUT CONFIRMATION 
        )
    ) else ( set "confirm="
        if "%ope%"=="re" (
                                        echo : CONTROL MODE
        ) else (
                                        echo : CONTROL MODE
    ) )
        echo ---------------------------------------------------------------------------------------------------------------------------------
        echo. 
    )

goto :EOF


:specifName

    set "specifName="
    set /p specifName= "Do you want generically rename the extracted elements (y) or keep original name (-) : "
    echo.

    if "%specifName%"=="main" ( set "stop=true" 
    ) else ( if not "%specifName%"=="y" ( set "specifName=" ) )

goto :EOF



:questionSource

    echo.
    set /p srcPath= "Element to copy : "

    for /f "tokens=* delims=" %%B in ("%srcPath%") do ( set "srcPath=%%B" )

    if "%srcPath%"=="main" (            set "stop=true"
                                        goto :EOF

    ) else ( if not exist "%srcPath%" ( goto :questionSource ) )

    echo ---------------------------------------------------------------------------------------------------------------------------------
    echo :     source retenue = %srcPath%
    echo ---------------------------------------------------------------------------------------------------------------------------------

goto :EOF


:questionDestination

    echo.
    if "%ope%"=="cp" ( if "%searchedType%"=="d" ( set /p dirPrompt= "Direct parent repertory of the folders collection in which to paste : "
    ) else ( set /p dirPrompt= "Folder in which paste : " )
    ) else ( set /p dirPrompt= "Root directory in which search for elements : " )
    if "%dirPrompt%"=="" goto :questionDestination

    for /f "tokens=* delims=" %%B in ("%dirPrompt%") do ( set "dirPrompt=%%B" )

    for %%A in ("%dirPrompt%") do ( set "dirPath=%%~dpA"
                                    set "endPath=%%~nxA" )
    
    if "%dirPrompt%"=="main" (              set "stop=true"
                                            goto :EOF

    ) else ( if "%dirPrompt%"=="%endPath%" ( goto :questionDestination
    ) else ( if not exist %dirPath% (        goto :questionDestination

    ) else ( if exist "%dirPrompt%\" ( if not "%dirPath%"=="%dirPrompt%" ( 

        set "dirPath=%dirPrompt%\" 
    ) ) ) ) )
        
if "%ope%"=="cp" if "%searchedtype%"=="d" ( goto :EOF )
    
    echo ---------------------------------------------------------------------------------------------------------------------------------
    echo :     chemin retenu = %dirPath%
    echo ---------------------------------------------------------------------------------------------------------------------------------
    

goto :EOF


:questionSearchedword

    if "%ope%"=="cp" if "%searchedType%"=="r" ( goto :EOF )
    echo.
    set "word1="
    set "word2="
    set "choix="

    if "%renameType%"=="p" ( set /p word1= "First part of the name to select elements, before the variable part choose as index : "
    ) else ( if "%ope%"=="cp" ( set /p word1= "Word constituting the common part of each name between folders choose as this collection : "
    ) else ( set /p word1= "Element to target (full or partial) : " ) )

    if "%word1%"=="main" (  set "stop=true" 
                            goto :EOF

        ) else ( if not "%word1%"=="" ( for %%C in ("%word1%") do ( set "word1=%%~nxC" ) ) )


    if "%ope%"=="re" ( if "%renameType%"=="p" ( set /p word2= "Second part of the name to select elements, after the variable part choose as index : " ) ) 

    if "%word2%"=="main" (  set "stop=true" 
                            goto :EOF
        ) else (
            if "%word2%"=="" (
                if "%word1%"=="" goto :questionSearchedword
            ) else (
                for %%C in ("%word2%") do ( set "word2=%%~nxC" ) 
        ) )

    set "searchedPath=%dirPath%*%word1%*%word2%*"

    if "%ope%"=="rb" (          set "stop=true"
        for /f "tokens=*" %%d in ( 'dir "%dirPath%" /b /a:d' ) do ( 
                                    dir "%dirPath%%%d\*%word1%*%word2%*" /b /s >nul 2>&1

        if not errorlevel 1 ( set "stop=false" ) ) 

    ) else (                    set "stop=false"
        if "%searchedType%"=="d" (  dir "%searchedPath%" /a:d /b >nul 2>&1
        ) else (                    dir "%searchedPath%" /b /s >nul 2>&1 )

        if errorlevel 1 (       set "stop=true" )
    )

    if "%stop%"=="true" ( 
        echo ---------------------------------------------------------------------------------------------------------------------------------
        set /p choix="No Result. Write anything to go back to main (~) or let this input empty to try with other entries () : " 
    )
    if "%stop%"=="true" ( if "%choix%"=="" ( set "stop=CQD" 
                        ) else (             goto :EOF ) )

 
    if "%ope%"=="cp" if "%searchedtype%"=="d" if not "%stop%"=="CQD" ( 
        echo ---------------------------------------------------------------------------------------------------------------------------------
        echo :     chemin retenu = %searchedPath%
        echo ---------------------------------------------------------------------------------------------------------------------------------
    )

goto :EOF


:questionNewName

    if "%ope%"=="cp" if "%searchedType%"=="d" ( goto :EOF )
    if "%ope%"=="rb" if "%specifName%"=="" (    goto :EOF )
    echo.
    set "newName1="
    set "newName2="
    
    set /p newName1= "Input the new name (prefix if index set) : "

    if "%newName1%"=="main" (   set "stop=true" 
                                goto :EOF
        ) else ( 
            if "%newName1%"=="" ( 
                if "%renameType%"=="e" goto :questionNewName

            ) else (
                for %%C in ("%newName1%") do ( set "newName1=%%~nxC" ) 
        ) )


    set "restricted=false"
    if "%renameType%"=="e" if "%searchedType%"=="r" ( set "restricted=true" )
    if "%restricted%"=="false" ( set /p newName2= "Input the new name's suffix (following the index) : " )
    if "%restricted%"=="false" (

    if "%newName2%"=="main" (   set "stop=true" 

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
    
    if "%renameType%"=="e" ( if "%searchedType%"=="d" ( set /P indice= "start index : " 
    ) ) else ( if "%renameType%"=="i" (                 set /A "indice=0" ) )

    if "%indice%"=="main" ( set "stop=true"
                            goto :EOF
    ) else ( 
    if "%renameType%"=="e" if "%searchedType%"=="d"   ( set /A "indice=%indice%-1" ) )

    if "%searchedType%"=="r" ( set "searchedList=/s"
    ) else (                   set "searchedList=/a:d" )

    echo.
    echo ---------------------------------------------------------------------------------------------------------------------------------
    if "%renameType%"=="p" ( echo : Looking after elements like  *%word1%*%word2%*  to be renamed as  %newName1%***%newName2%
    ) else ( echo : Looking after elements like  *%word1%*%word2%*  to be renamed as  %newName1%%indice%%newName2% )
    echo ---------------------------------------------------------------------------------------------------------------------------------
    if not "%ignoreConfirmation%"=="y" echo --- NB : Empty input does repeat the last choice ^(first default input is `n`^) --------------------------------------------------
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
        echo ----- in the repertory  %relativePath%  

        if "%renameType%"=="i" ( 

            if "%searchedType%"=="r" (          call :indiceNaturel "!relativePath:%dirPath%=!" 
            ) else ( if "%searchedType%"=="d" ( call :indiceNaturel "%fullName%" ) )

            if errorlevel 3 ( 
                ver > nul
                call :indiceNaturel "%dirPath%"

                if errorlevel 3 ( echo - No index found
                ) else ( set /p useIndice="- No index found from root repertory of searching, do you want use closest index contained in this path (y) else index set to zero (-) : "
            
            ) ) else ( set "useIndice=y" )

        ) else ( if "%searchedType%"=="d" (

                 if "%renameType%"=="p" (
                    set "indice=%fullName%"
                    if not "%word1%"=="" set "indice=!indice:%word1%=!"
                    if not "%word2%"=="" set "indice=!indice:%word2%=!"

                 ) else ( set /A "indice=%indice%+1" )
        ) )
        
        if "%useIndice%"=="main" (          set "stop=true"
                                            exit /b 2 
        ) else ( if not "%useIndice%"=="y"  set /A "indice=0" )

        set "newName=%newName1%%indice%%newName2%"
        if exist "%relativePath%%newName%" ( 

            if "%extension%"=="" ( echo - Another folder  %newName%\  exist, this name cannot be attribute to  %fullName%\
            ) else (               echo - Another file  %newName%\  exist, this name cannot be attribute to  %fullName%\ )
            pause
            goto :EOF

        ) else ( if not "%ignoreConfirmation%"=="y" ( REM echo.

            if "%extension%"=="" ( set /p confirm= "- Rename folder  %fullName%\  as  %newName%\  (y) else (-) : "
            ) else (               set /p confirm= "- Rename file  %fullName%  as  %newName%  (y) else (-) : " ) ) )

        if "%confirm%"=="main" ( set "stop=true"
                                    exit /b 2

        ) else ( if "%confirm%" == "y" ( 

            ren "%fullPath%" "%newName%"
            echo %fullName%   : has been renamed   %newName%
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

                echo Copy to  %dirPath%%%d\%box% :
                echo.
                xcopy "%srcPath%" "%dirPath%%%d\%box%"
            ) else (

                echo Copy to  %dirPath%%%d\ :
                copy "%srcPath%" "%dirPath%%%d\"
            )
            echo.
        )
    ) else ( if "%searchedType%"=="r" (

        if exist "%srcPath%\" ( 
            
            if "%start%"=="%nbCopies%" (
                    echo Creation of folder  %newName1%\ :
                    xcopy "%srcPath%" "%dirPath%%newName1%\" /e

            ) else ( 
                for /l %%n in (%start%,1,%nbCopies%) do (
                
                    echo Creation of folder  %newName1%%%n%newName2%\ :
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
        set /p nbCopies= "How much copy do you want to execute (1 to 100) : "

        if "%nbCopies%"=="main" ( set "stop=true"
                                  goto :EOF

        ) else ( if "%nbCopies%"=="" (  set /a "nbCopies=1"
        ) else (                        set /a "nbCopies=%nbCopies%+0" ) )

        if %nbCopies% GTR 1 (   set "renameType="

            if %nbCopies% GTR 100 ( echo : Overide of the maximum of copy set for one single command 
                                    goto :multiple ) 
            
        ) else (                set "renameType=e"  
            
            set /a "nbCopies=1"
            set /a "start=1"
        )
        
        :setIndice

            if %nbCopies% GTR 1  set /P indice= "Start index : "

            if "%indice%"=="main" (                             set "stop=true"
                                                                goto :EOF
            ) else ( if %nbCopies% GTR 1 (  if "%indice%"=="" ( goto :setIndice 

            ) else ( set /a "start=%indice%+0" ) ) )
        
        
        If %start% LSS 0 ( set /a "indice=1" )
        set /a "start=%indice%+0"

        echo ---------------------------------------------------------------------------------------------------------------------------------
        echo :     Copy quantity : %nbCopies% ,        Start index : %indice%
        echo ---------------------------------------------------------------------------------------------------------------------------------
        echo.

        set /a "nbCopies=%nbCopies%+%start%-1"

    goto :EOF



:extractRoutine

    echo.
    if not "%ignoreConfirmation%"=="y" ( 
        echo ---------------------------------------------------------------------------------------------------------------------------------
        echo --- NB : Empty input does repeat the last choice ^(first default input is `n`^) -------------------------------------------------
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
            if "!confirm!"=="main" ( goto :EOF )
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

        if not "%ignoreConfirmation%"=="y" ( set /p confirm= "- Bring the element  %originame%%extension%  back as  %newName%  (y) else (-) : " 
        ) else ( echo - The element  %originame%%extension%  is ready to be kept as  %newName% )

        if "%confirm%"=="main" ( set "stop=true"
                                 goto :EOF

        ) else ( if "%confirm%"=="y" (

            if "%renameBis%"=="yes" (
                
                ren "%dirPath%%originame%%extension%" "%newNameBis%" 
                echo.
                echo The current element ^"%originame%%extension%^" have been renamed ^"%newNameBis%^"
            )
            
            if exist "%thisPath%\" ( 

                xcopy "%thisPath%" "%dirPath%%newName%\" /e /q
                rmdir "%thisPath%" /s /q
            ) else (

                copy "%thisPath%" "%dirPath%%newName%"
                del "%thisPath%" /q
                    
        ) ) )

    goto :EOF
