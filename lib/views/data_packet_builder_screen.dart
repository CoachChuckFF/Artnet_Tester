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


class DataPacketBuilderScreen extends StatefulWidget {
  const DataPacketBuilderScreen({ Key key }) : super(key: key);

  @override
  DataPacketBuilderScreenState createState() => new DataPacketBuilderScreenState();
}


class DataPacketBuilderScreenState extends State<DataPacketBuilderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>(); 

  bool _autovalidate = false;
  bool _formWasEdited = false;
  ArtnetDataPacket _packet = new ArtnetDataPacket();

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
      StoreProvider.of<AppState>(context).dispatch(new ArtnetAction(ArtnetActions.sendPacket, new Packet(false, _packet, tron.outgoingIp, tron.outgoingPort)));
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  String _validateNet(String value) {
    _formWasEdited = true;
    final RegExp portExpression = new RegExp(r'^[0-9]*$');
    if (!portExpression.hasMatch(value)) return 'Please enter a number';
    int val = int.parse(value);
    if(val > 0x7F || val < 0) return 'Net is a value between 0-127';
    return null;
  }

  String _validateSubnet(String value) {
    _formWasEdited = true;
    final RegExp portExpression = new RegExp(r'^[0-9]*$');
    if (!portExpression.hasMatch(value)) return 'Please enter a number';
    int val = int.parse(value);
    if(val > 0xFF || val < 0) return 'Subnet is a value between 0-255';
    return null;
  }

  void _setValue(int index){

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
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 24.0),
              new TextFormField(
                decoration: const InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  icon: const Icon(Icons.cloud),
                  hintText: '0',
                  labelText: 'Net'
                ),
                initialValue: '0',
                keyboardType: TextInputType.phone,
                onSaved: (String value) { 
                  _packet.net = int.parse(value);
                },
                validator: _validateNet
              ),
              const SizedBox(height: 24.0),
              new TextFormField(
                decoration: const InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  icon: const Icon(Icons.cloud),
                  hintText: '0',
                  labelText: 'Subnet'
                ),
                initialValue: '0',
                keyboardType: TextInputType.phone,
                onSaved: (String value) { 
                  _packet.subUni = int.parse(value);
                },
                validator: _validateSubnet
              ),
              const SizedBox(height: 24.0), 
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Column(
                      children: <Widget>[
                        new Center(
                          child: new RaisedButton(
                            child: const Text('Whiteout'),
                            onPressed: () => _packet.whiteout(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Expanded(
                    child: new Column(
                      children: <Widget>[
                        new Center(
                          child: new RaisedButton(
                            child: const Text('Blackout'),
                            onPressed: () => _packet.blackout(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0), 
              new Center(
                child: new RaisedButton(
                  child: const Text('SEND'),
                  onPressed: _handleSubmitted,
                ),
              ),
              const SizedBox(height: 24.0),
              new Expanded(
                  child: new GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this would produce 2 rows.
                  crossAxisCount: 8,
                  // Generate 100 Widgets that display their index in the List
                  children: List.generate(512, (index) {
                    return new InkWell(
                      onLongPress: () => _packet.setDmxvalueue(index + 1, 255),
                      child: new SizedBox(
                        height: 33.0,
                        child: new Center(
                          child: new Text(
                            '${index + 1}'
                          ),
                        ),
                      )
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

