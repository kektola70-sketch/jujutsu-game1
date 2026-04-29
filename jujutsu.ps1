# Устанавливаем кодировку для корректного отображения русского языка
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# --- НАСТРОЙКА ПУТЕЙ ---
$BaseDir = "jujutsu game"
$AccDir  = "$BaseDir/account"

# Проверяем и создаем папки, если их нет
if (-not (Test-Path $AccDir)) {
    New-Item -Path $AccDir -ItemType Directory -Force | Out-Null
    Write-Host "Система инициализирована. Папки созданы." -ForegroundColor Gray
}

# --- ФУНКЦИИ ХРАНЕНИЯ ---

function Save-Player($Player) {
    # Сохраняем каждого игрока в персональный файл "имя_игрока.json"
    $Path = "$AccDir/$($Player.Username).json"
    $Player | ConvertTo-Json | Out-File $Path -Encoding UTF8
}

function Get-Player($Username) {
    $Path = "$AccDir/$Username.json"
    if (Test-Path $Path) {
        return Get-Content $Path -Raw | ConvertFrom-Json
    }
    return $null
}

# --- ЛОГИКА АККАУНТОВ ---

function Register-Menu {
    Clear-Host
    Write-Host "=== РЕГИСТРАЦИЯ НОВОГО МАГА ===" -ForegroundColor Cyan
    $name = Read-Host "Введите имя персонажа"
    
    if (Get-Player $name) {
        Write-Host "Этот маг уже существует в базе техникума!" -ForegroundColor Red
        Start-Sleep -Seconds 2
        return $null
    }

    $pass = Read-Host "Придумайте пароль"
    
    Write-Host "`nВыберите врожденную технику:" -ForegroundColor Yellow
    Write-Host "1. Техника Десяти Теней"
    Write-Host "2. Манипуляция Кровью"
    Write-Host "3. Проклятая Речь"
    $tChoice = Read-Host "Выберите номер"
    
    $tech = switch($tChoice) {
        "1" { "Техника Десяти Теней" }
        "2" { "Манипуляция Кровью" }
        "3" { "Проклятая Речь" }
        Default { "Базовая Проклятая Энергия" }
    }

    # Создаем объект игрока
    $NewUser = [PSCustomObject]@{
        Username  = $name
        Password  = $pass
        Technique = $tech
        Level     = 1
        Rank      = "4-й ранг"
        Exp       = 0
        Energy    = 100
        Money     = 500
    }

    Save-Player $NewUser
    Write-Host "`nАккаунт создан! Теперь вы можете войти." -ForegroundColor Green
    Start-Sleep -Seconds 2
    return $null
}

function Login-Menu {
    Clear-Host
    Write-Host "=== ВХОД В АККАУНТ ===" -ForegroundColor Cyan
    $name = Read-Host "Имя мага"
    $pass = Read-Host "Пароль"

    $player = Get-Player $name
    if ($player -and $player.Password -eq $pass) {
        Write-Host "Доступ разрешен. Загрузка данных..." -ForegroundColor Green
        Start-Sleep -Seconds 1
        return $player
    } else {
        Write-Host "Ошибка: Неверное имя или пароль!" -ForegroundColor Red
        Start-Sleep -Seconds 2
        return $null
    }
}

# --- ИГРОВОЕ МЕНЮ ---

function Show-GameMenu($CurrentPlayer) {
    $p = $CurrentPlayer
    while ($true) {
        Clear-Host
        Write-Host "--- МАГИЧЕСКАЯ БИТВА: ГЛАВНОЕ МЕНЮ ---" -ForegroundColor Magenta
        Write-Host "Игрок: $($p.Username) | Техника: $($p.Technique)"
        Write-Host "Ранг:  $($p.Rank) | Уровень: $($p.Level)"
        Write-Host "Деньги: $($p.Money) ¥"
        Write-Host "---------------------------------------"
        Write-Host "1. Отправиться на задание (Изгнать проклятие)"
        Write-Host "2. Магазин артефактов"
        Write-Host "3. Профиль и Инвентарь"
        Write-Host "4. Сохранить и Выйти"

        $choice = Read-Host "`nВаш выбор"

        switch ($choice) {
            "1" { 
                Write-Host "Вы отправились в заброшенную школу..." -ForegroundColor Cyan
                Start-Sleep -Seconds 1
                Write-Host "Боевая система в разработке!" -ForegroundColor Yellow
                Start-Sleep -Seconds 2
            }
            "4" { 
                Save-Player $p
                Write-Host "Данные сохранены в $AccDir/$($p.Username).json" -ForegroundColor Gray
                return 
            }
        }
    }
}

# --- ГЛАВНЫЙ ЦИКЛ ПРИ ЗАПУСКЕ ---

while ($true) {
    Clear-Host
    Write-Host "================================" -ForegroundColor Red
    Write-Host "       JUJUTSU KAISEN           " -ForegroundColor Red
    Write-Host "      POWERSHELL EDITION        " -ForegroundColor Yellow
    Write-Host "================================" -ForegroundColor Red
    Write-Host "1. Войти"
    Write-Host "2. Регистрация"
    Write-Host "3. Выход"

    $topChoice = Read-Host "`nВыберите опцию"

    if ($topChoice -eq "1") {
        $user = Login-Menu
        if ($user) { Show-GameMenu $user }
    }
    elseif ($topChoice -eq "2") {
        Register-Menu
    }
    elseif ($topChoice -eq "3") {
        break
    }
}