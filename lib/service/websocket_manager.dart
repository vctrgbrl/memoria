import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocketManager {
  static final WebSocketManager _manager = WebSocketManager._internal();

  late IO.Socket _socket;

  factory WebSocketManager() {
    return _manager;
  }

  WebSocketManager._internal() {
    _socket = IO.io(
      'http://200.20.1.15:3000', 
      IO.OptionBuilder().setTransports(['websocket']).build()
    );
    _socket.onDisconnect((_) => print('disconnect'));
    _socket.onConnect((_) => print('connected'));
    _socket.onConnectError((data) => print("Connection error $data"));
  }

  signCallback(String event, void Function(dynamic) c) {
    _socket.on(event, c);
  }

  removeCallback(String event, void Function(dynamic) c) {
    _socket.off(event, c);
  }

  removeAll(String event) {
    _socket.off(event);
  }

  emit(String event, [dynamic data]) {
    return _socket.emit(event, data);
  }
}