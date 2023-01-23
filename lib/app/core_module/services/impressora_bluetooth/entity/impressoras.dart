import 'dart:convert';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class Impressoras {
  String _name;
  String _address;
  int _type;
  bool _connected;

  String get name => _name;
  void setName(String value) => _name = value;

  String get address => _address;
  void setAddress(String value) => _address = value;

  int get type => _type;
  void setType(int value) => _type = value;

  bool get connected => _connected;
  void setConnected(bool value) => _connected = value;

  Impressoras({
    required String name,
    required String address,
    int type = 0,
    bool connected = false,
  })  : _name = name,
        _address = address,
        _type = type,
        _connected = connected;

  Impressoras.fromDevice(BluetoothDevice blue)
      : _name = blue.name!,
        _address = blue.address!,
        _type = blue.type,
        _connected = blue.connected;

  static Impressoras fromMap(dynamic map) {
    return Impressoras(
      name: map['name'],
      address: map['address'],
      connected: map['connected'],
      type: map['type'],
    );
  }

  static Map<String, dynamic> toMap(Impressoras imp) => {
        'name': imp.name,
        'address': imp.address,
        'type': imp.type,
        'connected': imp.connected,
      };

  static String toJson(Impressoras imp) => jsonEncode(toMap(imp));

  static BluetoothDevice toDevice(Impressoras imp) {
    return BluetoothDevice(imp.name, imp.address);
  }
}
