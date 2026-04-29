using System;
using System.Windows.Forms;
using System.Diagnostics;

class JujutsuLauncher {
    [STAThread]
    static void Main() {
        Application.EnableVisualStyles();
        Form form = new Form();
        form.Text = "Jujutsu Kaisen Online";
        form.Width = 750;
        form.Height = 550;
        form.FormBorderStyle = FormBorderStyle.FixedSingle;
        form.StartPosition = FormStartPosition.CenterScreen;

        WebBrowser browser = new WebBrowser();
        browser.Dock = DockStyle.Fill;
        
        // Указываем путь к нашему онлайн-клиенту
        // Если игра на хостинге, пишем https://сайт.com
        browser.Url = new Uri("file://" + System.IO.Directory.GetCurrentDirectory() + "/index.html");
        
        form.Controls.Add(browser);
        Application.Run(form);
    }
}