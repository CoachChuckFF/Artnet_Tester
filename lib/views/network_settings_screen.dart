import 'dart:async';

import 'package:flutter/material.dart';

import 'package:artnet_tester/models/network_settings.dart';
import 'dart:io';
import 'dart:async';
import 'package:validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:d_artnet/d_artnet.dart';

import 'package:flutter/material.dart';
import 'package:d_artnet/d_artnet.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:artnet_tester/models/action.dart';
import 'package:artnet_tester/models/app_state.dart';
import 'package:artnet_tester/models/network_settings.dart';
import 'package:artnet_tester/models/packet.dart';

import 'package:artnet_tester/views/main_screen.dart';
import 'package:artnet_tester/views/network_settings_screen.dart';
import 'package:artnet_tester/views/components/packet_item.dart';
import 'package:artnet_tester/views/themes.dart';

import 'package:artnet_tester/controllers/reducers.dart';
import 'package:artnet_tester/controllers/udp_server.dart';


class NetworkSettingsScreen extends StatefulWidget {
  const NetworkSettingsScreen({ Key key }) : super(key: key);

  static const String routeName = '/material/text-form-field';

  @override
  NetworkSettingsScreenState createState() => new NetworkSettingsScreenState();
}


class NetworkSettingsScreenState extends State<NetworkSettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>(); 

  bool _autovalidate = false;
  bool _formWasEdited = false;

  NetworkSettings _tempSettings = new NetworkSettings();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value)
    ));
  }

  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red and resubmit');
    } else {
      form.save();
      showInSnackBar('Outgoing packets settings set \n${_tempSettings.ipAddress}:${_tempSettings.port}');
    }
  }

  String _validateIpAddress(String value) {
    _formWasEdited = true;
    final RegExp ipExpression = new RegExp(r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
    if (!ipExpression.hasMatch(value)) return '###.###.###.### where ### is 0-255';
    return null;
  }

  String _validatePort(String value) {
    _formWasEdited = true;
    final RegExp portExpression = new RegExp(r'^[0-9]*$');
    if (!portExpression.hasMatch(value)) return 'Please enter a number';
    return null;
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formWasEdited || form.validate())
      return true;

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: const Text('This form has errors'),
          content: const Text('Really leave this form?'),
          actions: <Widget> [
            new FlatButton(
              child: const Text('YES'),
              onPressed: () { Navigator.of(context).pop(true); },
            ),
            new FlatButton(
              child: const Text('NO'),
              onPressed: () { Navigator.of(context).pop(false); },
            ),
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('Network Settings'),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          autovalidate: _autovalidate,
          onWillPop: _warnUserAboutInvalidData,
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 24.0),
                new StoreConnector<AppState, Store>(
                  converter: (store) => store,
                  builder: (context, store) {
                    return new TextFormField(
                      decoration: const InputDecoration(
                        border: const UnderlineInputBorder(),
                        filled: true,
                        icon: const Icon(Icons.cloud),
                        hintText: '255.255.255.255',
                        labelText: 'Outgoing Ip Address'
                      ),
                      initialValue: store.state.networkSettings.ipAddress,
                      keyboardType: TextInputType.phone,
                      onSaved: (String value) { 
                        _tempSettings = _tempSettings.copyWith(ipAddress: value);
                        store.dispatch(new SettingAction(SettingActions.setOutgoingIp, NetworkSettings(ipAddress: value)));
                      },
                      validator: _validateIpAddress,
                    );
                  },
                ),
                const SizedBox(height: 24.0),
                new StoreConnector<AppState, Store>(
                  converter: (store) => store,
                  builder: (context, store) {
                    return new TextFormField(
                      decoration: const InputDecoration(
                        border: const UnderlineInputBorder(),
                        filled: true,
                        icon: const Icon(Icons.directions_boat),
                        hintText: '6454',
                        labelText: 'IO Port',
                      ),
                      initialValue: store.state.networkSettings.port.toString(),
                      keyboardType: TextInputType.phone,
                      onSaved: (String value) {
                        _tempSettings = _tempSettings.copyWith(port: int.parse(value));
                        store.dispatch(new SettingAction(SettingActions.setOutgoingPort, NetworkSettings(port: int.parse(value))));
                      },
                      validator: _validatePort,
                    );
                  },
                ),
                const SizedBox(height: 24.0),
                new Center(
                  child: new RaisedButton(
                    child: const Text('SUBMIT'),
                    onPressed: _handleSubmitted,
                  ),
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

