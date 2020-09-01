import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  //! Atributos
  final String label;
  final TextInputType keyboardType;
  final bool obscureText, borderEnable;
  final double fontSize;
  final void Function(String text) onChaged;
  final String Function(String text) validator;
  //! Constructor
  const InputText({
    Key key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.borderEnable = true,
    this.fontSize = 15,
    this.onChaged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //? Retornar un widget que sea comun para todas las veces que lo llame en mi proyecto
    return TextFormField(
      keyboardType: this.keyboardType,
      obscureText: this.obscureText,
      style: TextStyle(fontSize: this.fontSize),
      onChanged: this.onChaged,
      validator: this.validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5),
        //! Condicional ternario
        enabledBorder: this.borderEnable
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
              )
            : InputBorder.none,
        labelText: this.label.toUpperCase(),
        labelStyle: TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
