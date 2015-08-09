var socket = new Phoenix.Socket("/socket");
socket.connect();

var channel1 = socket.chan("messages:1");
window.channel1 = channel1;
channel1.join();

var channel2 = socket.chan("messages:2");
window.channel2 = channel2;
channel2.join();

channel1.on("message_sent", function(data) {
  console.log("message sent");
  console.log(data);
});

channel2.on("message_received", function(data) {
  console.log("message received");
  console.log(data);
});
