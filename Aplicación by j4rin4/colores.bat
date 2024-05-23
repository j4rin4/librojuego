@echo off
setlocal EnableDelayedExpansion

:: Asignación de colores, Victoria
set "VICTORIA=02"

:: Frases de ambiente, Victoria
set "TITULO_VICTORIA=VICTORIA"

:: Asignación de colores, Derrota
set "DERROTA=04"

::Asignacion de ambiente, Derrota
set "TITULO_DERROTA=DERROTA"

:: Asignación de colores
set "HABITACION=0E"
set "NOCHE=08"
set "INTERACCIONA=5F"

:: Asignacion de ambiente
set "TITULO_HABITACION=Los rayos de luz atraviesan la persiana . . ."
set "TITULO_NOCHE=ES DE NOCHE . . ."
set "TITULO_INTERACCIONA=INTERACCIONA . . ."

set "variables= NOCHE INTERACCIONA DERROTA HABITACION VICTORIA"

REM Configurar UTF-8 para visualización correcta de caracteres
CHCP 65001 > nul

:: Verificar que se ha proporcionado un ambiente como argumento
if "%~1"=="" (
    echo Error: No se proporciono un ambiente.
    exit /b 1
)

:: Asignar el código de color basado en el argumento de ambiente
set "ambiente=%~1"
set "codigoColor=!%ambiente%!"

if "!codigoColor!"=="" (
    echo Error: Ambiente desconocido '%ambiente%'
    exit /b 1
)

:: Aplicar el color
color !codigoColor!
for %%v in (%variables%) do (
    if "!ambiente!"=="%%v" (
        echo !TITULO_%%v!
        echo - - - - - - - - - - - - - - - - - - - - - - - - - -
    )
)

exit /b 0

:: Code By j4rin4