import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_api_rest/api/my_api.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:meta/meta.dart' show required;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//! Esta clase tiene un patron de diseño Singletón
//! Es decir que solo se puede instanciar la clase en ella misma
class Auth {
  //? Contructor privado
  Auth._internal();
  static Auth _instance = Auth._internal();
  static Auth get instance => _instance;

  final _storage = FlutterSecureStorage();
  final key = 'SESSION';

  //! Garantizar que si hago varias llamadas al get accessToken
  //! primero termine las llamadas anteriores y luego realice la llamada en cuestion
  Completer _completer;

  //? Obtener el estado del token y renovarlo dependiendo del tiempo
  Future<String> get accessToken async {
    if (_completer != null) {
      await _completer.future;
    }
    print('acessToken');
    _completer = new Completer();
    final Session session = await this.getSession();
    if (session != null) {
      // ignore: unused_local_variable
      final DateTime currentDate = DateTime.now();
      // ignore: unused_local_variable
      final DateTime createdAt = session.createdAt;
      final int expiresIn = session.expiresIn;
      //final int diff = currentDate.difference(createdAt).inSeconds;
      //* variable de prueba
      final int diff = 3554;
      print('time ${expiresIn - diff}');
      if (expiresIn - diff >= 60) {
        print('Token Alive');
        _complete();
        return session.token;
      } else {
        final Map<String, dynamic> data = await MyAPI.instance.refresh(session.token);
        print('Refresh token');
        if (data != null) {
          await this.setSession(data);
          _complete();
          return data['token'];
        }
        _complete();
        return null;
      }
    }
    _complete();
    print('Session null');
    return null;
  }

  _complete(){
    if (this._completer != null && !this._completer.isCompleted){
      this._completer.complete();
    }
  }
  //! Por medio de este método empezamos a guardar los datos
  //! anteriores en las preferencias de la app
  Future<void> setSession(Map<String, dynamic> data) async {
    final Session session = Session(
      token: data['token'],
      expiresIn: data['expiresIn'],
      createdAt: DateTime.now(),
    );
    final String value = jsonEncode(session.toJson());
    await this._storage.write(key: key, value: value);
    print('Session saved');
  }

  //! Por medio de este método obtenemos los datos de las preferencias y las
  //! convertimos en una instancia de la clase Session
  Future<Session> getSession() async {
    final String value = await this._storage.read(key: key);
    if (value != null) {
      final Map<String, dynamic> json = jsonDecode(value);
      final session = Session.fromJson(json);
      return session;
    }
    return null;
  }

  //! Por medio de este método se eliminan los datos del dispositivo
  //! Luego redirecciona a la página de LOGIN
  Future<void> logOut(BuildContext context) async {
    await this._storage.deleteAll();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginPage.routeName,
      (_) => false,
    );
  }
}

class Session {
  final String token;
  final int expiresIn;
  final DateTime createdAt;

  Session({
    @required this.token,
    @required this.expiresIn,
    @required this.createdAt,
  });

  static Session fromJson(Map<String, dynamic> json) {
    return Session(
        token: json['token'],
        expiresIn: json['expiresIn'],
        createdAt: DateTime.parse(json['createdAt']));
  }

  Map<String, dynamic> toJson() {
    return {
      'token': this.token,
      'expiresIn': this.expiresIn,
      'createdAt': this.createdAt.toString(),
    };
  }
}
