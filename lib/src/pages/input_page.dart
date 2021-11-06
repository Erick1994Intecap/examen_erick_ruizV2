import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _nombre = '';
  String _email = '';
  String _fecha = '';

  String _opcionSeleccionada = 'Perro';
  String _sexoSeleccionado = 'No sé';

  List<String> _raza = ['Perro', 'Gato', 'Loro', 'Alienigena'];
  List<String> _sexo = ['Macho', 'Hembra', 'No sé'];

  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _crearInput('Nombre de dueño', 'Dueño', 'Nombre de dueño',
              Icon(Icons.account_circle)),
          Divider(),
          _crearInput('Nombre de mascota', 'Mascota', 'Nombre de mascota',
              Icon(Icons.pets)),
          Divider(),
          _crearNumero('Telefono dueño', 'Telefono', 'Telefono Dueño',
              Icon(Icons.phone_android)),
          Divider(),
          _crearNumero('Edad Mascota', 'Edad Mascota', 'Edad Mascota',
              Icon(Icons.query_stats_rounded)),
          Divider(),
          _crearRaza(),
          Divider(),
          _crearSexo(),
          Divider(),
          _crearFecha(context),
          Divider(),
          _crearPersona()
        ],
      ),
    );
  }

  Widget _crearInput(hint, label, helper, Icon) {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          counter: Text('Letras ${_nombre.length}'),
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

  Widget _crearNumero(hint, label, helper, Icon) {
    return TextField(
        keyboardType: TextInputType.number,
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
