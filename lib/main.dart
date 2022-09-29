import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController =
      TextEditingController(); //controle do peso
  TextEditingController heightController =
      TextEditingController(); //controle da altura

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFilds(){
    weightController.text = "";
    heightController.text = "";
    setState((){
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });

  }
  void _calculate(){
    setState((){
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.5){
        _infoText = "Abaixo do peso!! IMC: ${imc.toStringAsPrecision(4)}";
      }else if(imc >= 18.5 && imc <= 24.9){
        _infoText = "Peso normal! IMC: ${imc.toStringAsPrecision(4)}";
      }else if(imc >= 25 && imc <= 29.9){
        _infoText = "Sobrepeso! IMC: ${imc.toStringAsPrecision(4)}";
      }else if(imc >= 30 && imc <= 34.9){
        _infoText = "Obesidade grau I! IMC: ${imc.toStringAsPrecision(4)}";
      }else if(imc >= 35 && imc <= 39.9){
        _infoText = "Obesidade grau II! IMC: ${imc.toStringAsPrecision(4)}";
      }else{
        _infoText = "Obesidade grau III! IMC: ${imc.toStringAsPrecision(4)}";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              onPressed: _resetFilds,
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
              10.0, 0.0, 10.0, 0.0), // adicionando borda no app todo
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_outline, size: 120, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Peso (kg)',
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  controller: weightController,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Insira seu peso!';
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  controller: heightController,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Insira sua altura!';
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                )
              ],
            ),
          ),
        ));
  }
}
