const { app, BrowserWindow } = require('electron');
const path = require('path');

function createWindow() {
  const win = new BrowserWindow({
    width: 900,
    height: 700,
    resizable: false, // Чтобы нельзя было менять размер окна
    icon: path.join(__dirname, 'icon.ico'), // Если захочешь иконку
    webPreferences: {
      nodeIntegration: true
    }
  });

  // Убираем стандартное верхнее меню (File, Edit и т.д.)
  win.setMenuBarVisibility(false);

  // Загружаем наш HTML файл
  win.loadFile('index.html');
}

app.whenReady().then(createWindow);

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});