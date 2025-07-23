// ignore_for_file: library_prefixes
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../constants/contsants.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  late IO.Socket socket;

  void initSocket(String userId, String token) {
    socket = IO.io(
      baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableReconnection()
          .setReconnectionAttempts(5)
          .setReconnectionDelay(2000)
          .setExtraHeaders({'Authorization': token})
          .setQuery({'userId': userId})
          .build(),
    );
    socket.onConnect((_) {
      debugPrint('✅ Connected to socket server');
      socket.emit('join', {'userId': userId});
      startPing();
    });

    debugPrint(token);
    debugPrint('User ID: $userId');
    debugPrint('Socket URL: $baseUrl');
    debugPrint("Socket Token $token");

    socket.onReconnect((_) {
      debugPrint('🔄 Reconnected to socket');
    });
    socket.onReconnectAttempt((data) {
      debugPrint('🔄 Trying to reconnect... $data');
    });
    socket.onReconnectFailed((_) {
      debugPrint('❌ Failed to reconnect');
    });

    socket.on('successMessage', (data) {
      debugPrint('Message stored: $data');
    });
    socket.onConnectError((data) {
      debugPrint("❌ Connect Error: $data");
    });

    socket.onError((data) {
      debugPrint("❌ General Error: $data");
    });
    socket.on('receiveMessage', (data) {
      debugPrint('New message from someone: $data');
    });

    socket.on('socket_Error', (error) {
      debugPrint('Socket error: $error');
    });

    socket.onDisconnect((_) => debugPrint('Disconnected from socket'));
    socket.onAny((event, data) {
      debugPrint('📡 Event received: $event -> $data');
    });
  }

  void sendMessage({required String message, required String destId}) {
    socket.emit('sendMessage', {'message': message, 'destId': destId});
    debugPrint('Message sent: $message to $destId');
  }

  void dispose() {
    socket.dispose();
  }

  void startPing() {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (socket.connected) {
        socket.emit('ping', {});
        debugPrint('🔄 Ping sent');
      } else {
        debugPrint('⚠️ Ping skipped, socket not connected');
      }
    });
  }
}
