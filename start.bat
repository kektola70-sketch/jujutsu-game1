@echo off
set "yandex=%LocalAppData%\Yandex\YandexBrowser\Application\browser.exe"
set "icon=%cd%\icon.jpg"

echo Запуск Магического Техникума...

if exist "%yandex%" (
    start "" "%yandex%" --app="%cd%/index.html" --icon="%icon%"
) else (
    echo Яндекс.Браузер не найден. Запуск в обычном браузере...
    start index.html
)