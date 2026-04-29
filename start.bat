@echo off
set "browser_path=%LocalAppData%\Yandex\YandexBrowser\Application\browser.exe"

if exist "%browser_path%" (
    start "" "%browser_path%" --app="%cd%\index.html"
) else (
    echo Путь к Yandex не найден автоматически.
    echo Попробуй просто открыть index.html двойным кликом.
    pause
)