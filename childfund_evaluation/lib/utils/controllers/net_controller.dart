import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetController {
  bool isConected(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    return hasInternet;
  }
}
