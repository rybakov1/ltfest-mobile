// lib/providers/connectivity_provider.dart

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus { isConnected, isDisconnected }

final connectivityStatusProvider = StreamProvider<ConnectivityStatus>(
  (ref) {
    return Connectivity().onConnectivityChanged.map(
      (List<ConnectivityResult> result) {
        if (result.contains(ConnectivityResult.none) && result.length == 1) {
          return ConnectivityStatus.isDisconnected;
        } else {
          return ConnectivityStatus.isConnected;
        }
      },
    );
  },
);
