import 'dart:async';

import 'package:flutter/material.dart';

class SidebarController extends ChangeNotifier {
  SidebarController({
    int? selectedIndex, // Accept nullable selectedIndex
    bool? extended,
  }) : _selectedIndex = selectedIndex {
    _setExtended(extended ?? false);
  }

  int? _selectedIndex; // Change to nullable
  var _extended = false;

  final _extendedController = StreamController<bool>.broadcast();
  Stream<bool> get extendStream =>
      _extendedController.stream.asBroadcastStream();

  int? get selectedIndex => _selectedIndex; // Change to nullable

  void selectIndex(int val) {
    if (_selectedIndex == val) {
      _selectedIndex = null; // Deselect if already selected
    } else {
      _selectedIndex = val; // Select the new index
    }
    notifyListeners();
  }

  bool get extended => _extended;

  void setExtended(bool extended) {
    _extended = extended;
    _extendedController.add(extended);
    notifyListeners();
  }

  void toggleExtended() {
    _extended = !_extended;
    _extendedController.add(_extended);
    notifyListeners();
  }

  void _setExtended(bool val) {
    _extended = val;
    notifyListeners();
  }

  @override
  void dispose() {
    _extendedController.close();
    super.dispose();
  }
}
