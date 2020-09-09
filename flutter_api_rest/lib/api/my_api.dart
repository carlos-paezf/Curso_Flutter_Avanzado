//! Hacer uso del cliente HTTP a traves de dio
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/utils/auth.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:meta/meta.dart';

class MyAPI {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://curso-api-flutter.herokuapp.com'));

  Future<void> register(
    BuildContext context, {
    @required String username,
    @required String email,
    @required String password,
  }) async {
    final ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final Response response = await this._dio.post(
        //? Como se pasa la base Url en el Dio, ya solo queda escribir el path especifico
        '/api/v1/register',
        //* Por defecto DIO aplica el header como Content-Type: application/jason
        //* En caso de querer agregarlo manualmente, o a mas headers
        //? En dado caso que no reciba el application/json, pasar como valor:
        //? application/x-www-form-urlencoded <-- Por defecto, es el header de paquete HTTP
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      await Auth.instance.setSession(response.data);
      progressDialog.dismiss();

      //! Puedo ignorar lo siguiente por la forma en que esta estructurada la API
      /* *if (response.statusCode == 200) {
        print(response.data);
        Dialogs.info(
          context,
          title: "GOOD",
          content: 'User created',
        );
      }*/

      //? Redireccionar a la página eliminando todo el historial anterior de registro y login
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.routeName,
        (_) => false,
      );
    } catch (e) {
      progressDialog.dismiss();
      //? En caso de registro duplicado nos mostrara un codigo 409
      if (e is DioError) {
        print(e.response.statusCode);
        print(e.response.data);
        Dialogs.info(context,
            title: 'ERROR',
            content: e.response.statusCode == 409
                ? 'Duplicate Username or Email'
                : e.message);
      } else {
        print(e);
      }
    }
  }

  Future<void> login(
    BuildContext context, {
    @required String email,
    @required String password,
  }) async {
    final ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final Response response = await this._dio.post(
        '/api/v1/login',
        //* Por defecto DIO aplica el header como Content-Type: application/jason
        //* En caso de querer agregarlo manualmente, o a mas headers
        //? En dado caso que no reciba el application/json, pasar como valor:
        //? application/x-www-form-urlencoded <-- Por defecto, es el header de paquete HTTP
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          'email': email,
          'password': password,
        },
      );

      await Auth.instance.setSession(response.data);
      progressDialog.dismiss();

      //! Puedo ignorar lo siguiente por la forma en que esta estructurada la API
      /* *if (response.statusCode == 200) {
        print(response.data);
        Dialogs.info(
          context,
          title: "GOOD",
          content: 'User created',
        );
      }*/

      //? Redireccionar a la página eliminando todo el historial anterior de registro y login
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.routeName,
        (_) => false,
      );
    } catch (e) {
      progressDialog.dismiss();
      //? En caso de registro duplicado nos mostrara un codigo 409
      if (e is DioError) {
        print(e.response.statusCode);
        print(e.response.data);
        String message = e.message;
        if (e.response.statusCode == 404) {
          message = 'User not found';
        } else if (e.response.statusCode == 403) {
          message = 'Invalid Password';
        }
        Dialogs.info(
          context,
          title: "ERROR",
          content: message,
        );
      } else {
        print(e);
      }
    }
  }

  Future<dynamic> refresh(String expiredToken) async {
    try {
      final Response response = await this._dio.post('/api/v1/refresh-token',
          options: Options(headers: {
            'token': expiredToken,
          }));
      return response.data;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
