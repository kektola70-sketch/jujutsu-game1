using System;
using System.Diagnostics;
using System.Windows.Forms;

class Program {
    [STAThread]
    static void Main() {
        // Ссылка на твою онлайн-игру
        string url = "https://твой-ник.github.io/jujutsu-game/"; 
        
        ProcessStartInfo startInfo = new ProcessStartInfo();
        
        // Пытаемся найти Яндекс или Хром для запуска в режиме приложения (без строк адреса)
        string yandexPath = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData) + @"\Yandex\YandexBrowser\Application\browser.exe";
        
        if (System.IO.File.Exists(yandexPath)) {
            startInfo.FileName = yandexPath;
            startInfo.Arguments = "--app=" + url;
        } else {
            // Если Яндекса нет, открываем просто в браузере
            startInfo.FileName = url;
            startInfo.UseShellExecute = true;
        }

        Process.Start(startInfo);
    }
}