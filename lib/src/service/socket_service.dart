import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    // Dart client
    this._socket = IO.io('http://localhost:3000/', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    this._socket.onConnect((_) {
      print('connect');
    });
    this._socket.onDisconnect((_) => print('disconnect'));
  }
}
