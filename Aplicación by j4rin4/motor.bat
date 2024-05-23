@echo off
CHCP 65001 > nul
title Iniciando historia . . .
setlocal EnableDelayedExpansion


:: Mostrar banner ASCII
cls
echo|set /p=" _____      _      _                 _         _   _ _     _             _       "
echo.
echo|set /p=" |_  _|    (_)    (_)               | |       | | | (_)   | |           (_)      "
echo.
echo|set /p="  -| | _ __  _  ___ _  __ _ _ __   __| | ___   | |_| |_ ___| |_ ___  _ __ _  __ _ "
echo.
echo|set /p="  -| || '_ \| |/ __| |/ _` | '_ \ / _` |/ _ \  |  _  | / __| __/ _ \| '__| |/ _` |"
echo.
echo|set /p=" _| || | | | | (__| | (_| | | | | (_| | (_) | | | | | \__ \ || (_) | |  | | (_| |"
echo.
echo|set /p=" \___/_| |_|_|\___|_|\__,_|_| |_|\__,_|\___/  \_| |_/_|___/\__\___/|_|  |_|\__,_|"
echo.
echo.
echo Powered by Pedroza and j4rin4 ...
timeout /t 3 /nobreak >nul

:: Establecer la ruta del archivo como ruta predeterminada
set "basePath=%~dp0"

:: Ajustar la ruta basePath para eliminar el último caracter (barra invertida) si es necesario
if "%basePath:~-1%"=="\" set "basePath=%basePath:~0,-1%"
set "colorScriptPath=%basePath%\\colores.bat"
set "capitulo=1"

:: Definir nombre del libro
cls
echo Bienvenido a:
set /p gameTitle=<"%basePath%\\librojuego\\titulo.txt"
echo %gameTitle%
echo.

title %gameTitle%

:inicio
cls

:: Leer y aplicar el ambiente
set /p ambiente=<"%basePath%\\librojuego\\%capitulo%\\ambiente.txt"
call "%colorScriptPath%" "!ambiente!"

:: Mostrar el escenario
echo.
type "%basePath%\\librojuego\\%capitulo%\\escenario.txt"
echo.

:: Mostrar opciones y manejar la elección del usuario con tiempo límite
echo.
set /a numOpcion=0

set "opcionesValidas=0"
for /f "tokens=1* delims= " %%a in ('type "%basePath%\\librojuego\\%capitulo%\\opciones.txt"') do (
    set /a numOpcion+=1
    set "opcionesValidas=1"
    echo !numOpcion!: %%b
    set "opcion!numOpcion!=%%a"
)

if "!opcionesValidas!"=="0" (
    echo Reiniciando la historia...
    pause
    set "capitulo=1"
    goto inicio
)

:: Construir cadena de opciones para el comando choice
set "choiceOptions="
for /l %%i in (1,1,%numOpcion%) do (
    set "choiceOptions=!choiceOptions!%%i"
)

:: Permitir al usuario elegir una opción con tiempo límite
echo.
echo Tienes 60 segundos.
echo.
echo Elije una opción (1-%numOpcion%):
choice /C !choiceOptions! /N /D 2 /T 60
set "eleccion=%errorlevel%"

set "siguienteCapitulo=!opcion%eleccion%!"

:: Verificar la elección y cambiar al siguiente capítulo
if defined siguienteCapitulo (
    set "capitulo=!siguienteCapitulo!"
    goto inicio
) else (
    echo Opción inválida, intenta nuevamente.
    pause
    goto inicio
)

:end
echo Fin del juego. Presiona una tecla para cerrar.
pause > nul
exit /b 0

:: Code By j4rin4
