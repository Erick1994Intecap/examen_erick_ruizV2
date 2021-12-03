import 'dart:async';

import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _nombre = '';
  String _email = '';
  String _fecha = '';

  bool _isLoading = false;

  String _opcionSeleccionada = 'Perro';
  String _sexoSeleccionado = 'No sé';

  List<String> _raza = ['Perro', 'Gato', 'Loro', 'Alienigena'];
  List<String> _sexo = ['Macho', 'Hembra', 'No sé'];

  TextEditingController _inputFieldDateController = new TextEditingController();
  final TextEditingController _duenioController = TextEditingController();
  final TextEditingController _mascotaController = TextEditingController();
  final TextEditingController _telDuenioController = TextEditingController();
  final TextEditingController _edadMascotaController = TextEditingController();

  List<String> strs = ["Hari Prasad Chaudhary"];

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // _agregar10();
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[_crearForm(), Divider(), _listaPrueba()],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.grey,
          onPressed: () {
            _boton();
          }),
    );
  }

  Widget _listaPrueba() {
    return Column(
        children: strs.map((userone) {
      return Container(
        child: ListTile(
          title: Text(userone),
          subtitle: Text("Address: " + userone),
        ),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        color: Colors.green[100],
      );
    }).toList());
  }

  Future<Null> fetchData() async {
    _isLoading = true;
    setState(() {});

    final duration = new Duration(seconds: 2);
    return new Timer(duration, respuestaHTTP);
  }

  void respuestaHTTP() {
    _isLoading = false;

    _scrollController.animateTo(_scrollController.position.pixels + 100,
        curve: Curves.fastOutSlowIn, duration: Duration(milliseconds: 250));
  }

  void _limpiar() {
    _duenioController.clear();
    _mascotaController.clear();
    _inputFieldDateController.clear();
    _edadMascotaController.clear();
    _telDuenioController.clear();
  }

  Widget _boton() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      SizedBox(width: 30),
      FloatingActionButton(
          onPressed: _mensaje(),
          child: Icon(Icons.exposure_zero),
          backgroundColor: Colors.grey),
      Expanded(child: SizedBox())
    ]);
  }

  _mensaje() {
    print("Estamos mal");
    setState(() {
      strs.add(_duenioController.text);
      _limpiar();
    });
  }

  Widget _crearForm() {
    return Column(
      children: <Widget>[
        _crearInput('Nombre de dueño', 'Dueño', 'Nombre de dueño',
            Icon(Icons.account_circle), _duenioController),
        Divider(),
        _crearInput('Nombre de mascota', 'Mascota', 'Nombre de mascota',
            Icon(Icons.pets), _mascotaController),
        Divider(),
        _crearNumero('Telefono dueño', 'Telefono', 'Telefono Dueño',
            Icon(Icons.phone_android), _telDuenioController),
        Divider(),
        _crearNumero('Edad Mascota', 'Edad Mascota', 'Edad Mascota',
            Icon(Icons.query_stats_rounded), _edadMascotaController),
        Divider(),
        _crearRaza(),
        Divider(),
        _crearSexo(),
        Divider(),
        _crearFecha(context),
        Divider(),
        //_crearPersona(),
        Divider(),
      ],
    );
  }

  Widget _crearInput(hint, label, helper, Icon, TextEditingController) {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      controller: TextEditingController,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: hint,
          labelText: label,
          helperText: helper,
          icon: Icon),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  Widget _crearNumero(hint, label, helper, Icon, TextEditingController) {
    return TextField(
        keyboardType: TextInputType.number,
        controller: TextEditingController,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: hint,
            labelText: label,
            helperText: helper,
            icon: Icon),
        onChanged: (valor) => setState(() {
              _email = valor;
            }));
  }

  Widget _crearFecha(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Fecha de nacimiento',
          labelText: 'Fecha de nacimiento',
          icon: Icon(Icons.calendar_today)),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2025),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        _fecha = picked.toString();
        _inputFieldDateController.text = _fecha;
      });
    }
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();

    _raza.forEach((poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });

    return lista;
  }

  List<DropdownMenuItem<String>> getOpcionesSexo() {
    List<DropdownMenuItem<String>> lista = new List();

    _sexo.forEach((poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });

    return lista;
  }

  Widget _crearRaza() {
    return Row(
      children: <Widget>[
        Icon(Icons.catching_pokemon),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: _opcionSeleccionada,
            items: getOpcionesDropdown(),
            onChanged: (opt) {
              setState(() {
                _opcionSeleccionada = opt;
              });
            },
          ),
        )
      ],
    );
  }

  Widget _crearSexo() {
    return Row(
      children: <Widget>[
        Icon(Icons.catching_pokemon),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: _sexoSeleccionado,
            items: getOpcionesSexo(),
            onChanged: (opt) {
              setState(() {
                _sexoSeleccionado = opt;
              });
            },
          ),
        )
      ],
    );
  }

  Widget _crearPersona() {
    return ListTile(
      title: Text('Nombre es: $_nombre'),
      subtitle: Text('Email: $_email'),
      trailing: Text(_opcionSeleccionada),
    );
  }
}
