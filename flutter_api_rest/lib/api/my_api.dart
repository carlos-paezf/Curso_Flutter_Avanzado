//! Hacer uso del cliente HTTP a traves de dio
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:meta/meta.dart';

class MyAPI {
  final Dio _dio = Dio();

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
        'https://curso-api-flutter.herokuapp.com/api/v1/register',
        //* Por defecto DIO aplica el header como Content-Type: application/jason
        //* En caso de querer agregarlo manualmente, o a mas headers
        //? En dado caso que no reciba el application/json, pasar como valor:
        //? application/x-www-form-urlencoded <-- Por defecto, es el header de paquete HTTP
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'username': username, 'email': email, 'password': password},
      );
      progressDialog.dismiss();

      if (response.statusCode == 200) {
        print(response.data);
        Dialogs.info(
          context,
          title: "GOOD",
          content: 'User created',
        );
      }
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
}
