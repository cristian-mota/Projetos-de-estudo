@echo off
set largura=100
set altura=30
set file=


:yy
mode %largura%,%altura%

if %altura% GTR 7 set /a altura=%altura%-1 &goto yy
if %largura% LSS 100 set /a largura=%largura%+1 &goto yy
title ~ LOCALIZADOR DE STRINGS

color 0A
bg cursor 0

:main
Editv64 -p " Arraste A Pasta ou Arquivo aqui: " file

if not defined file (cls &goto main)

set file=%file:"=%



if not exist "%tmp%\localiza_string" (md "%tmp%\localiza_string")


echo.%file%>"%tmp%\localiza_string\file.txt"
set /p file=<"%tmp%\localiza_string\file.txt"


cd "%tmp%\localiza_string"

del /f /q *.txt

dir /b /s "%file%">arvore.txt

type "arvore.txt" | find /v /c "">sv.txt

bg cursor 1
echo.
set /p strin=:^> Digite a String a ser pesquisada: 
set /p quant=<sv.txt
set encont=0
set num=%quant%


setlocal enabledelayedexpansion

cls
echo. _________________________________________________________>>resultados.txt
for /f "tokens=* delims= " %%R in (arvore.txt) DO (
set /a num=!num!-1
set arq=%%R
findstr /M /L /I /C:"!strin!" "!arq!">>resultados.txt
findstr /L /I /C:"!strin!" "!arq!">>resultados.txt

if "!errorlevel!" equ "0" (set /a encont+=1
echo.>>resultados.txt
echo. _________________________________________________________>>resultados.txt
echo.
)
cls
echo. Pastas/arquivos: !quant!
echo. String pesquisada: !strin!
echo. Arquivos restantes: !num!
echo. Encontrados: !encont!

echo. Pesquisando arquivo: !arq!
)

setlocal disabledelayedexpansion

if "%encont%" GTR "0" (
cls
echo.
echo.
echo.					PESQUISA CONCLUÖDA ! &ping 0 -n 3 >nul
explorer "resultados.txt"


) Else (
cls
echo.
echo.
echo.					NADA FOI ENCONTRADO &pause >nul
exit
)




