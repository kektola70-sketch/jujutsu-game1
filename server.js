const express = require('express');
const app = express();
const http = require('http').createServer(app);
const io = require('socket.io')(http);

let onlinePlayers = {};

io.on('connection', (socket) => {
    console.log('Новый маг подключился');

    // Когда игрок входит в игру
    socket.on('join_game', (data) => {
        onlinePlayers[socket.id] = {
            name: data.name,
            lvl: data.lvl,
            tech: data.tech,
            pos: { x: 0, y: 0 }
        };
        // Рассылаем всем список игроков онлайн
        io.emit('update_players', onlinePlayers);
        io.emit('chat_message', { system: true, msg: `Маг ${data.name} вошел в мир!` });
    });

    // Чат между игроками
    socket.on('send_message', (msg) => {
        const player = onlinePlayers[socket.id];
        io.emit('chat_message', { name: player.name, msg: msg });
    });

    socket.on('disconnect', () => {
        if (onlinePlayers[socket.id]) {
            io.emit('chat_message', { system: true, msg: `Маг ${onlinePlayers[socket.id].name} покинул нас.` });
            delete onlinePlayers[socket.id];
            io.emit('update_players', onlinePlayers);
        }
    });
});

http.listen(3000, () => {
    console.log('Сервер Магической Битвы запущен на порту 3000');
});