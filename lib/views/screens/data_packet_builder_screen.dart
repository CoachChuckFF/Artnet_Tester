import 'dart:async';
import 'package:flutter/material.dart';
import 'package:d_artnet/d_artnet.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:artnet_tester/models/action.dart';
import 'package:artnet_tester/models/app_state.dart';
import 'package:artnet_tester/models/packet.dart';
import 'package:artnet_tester/controllers/udp_server.dart';

class DataPacketBuilderScreen extends StatefulWidget {
  const DataPacketBuilderScreen({ Key key }) : super(key: key);

  @override
  DataPacketBuilderScreenState createState() => new DataPacketBuilderScreenState();
}

class DataPacketBuilderScreenState extends State<DataPacketBuilderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>(); 

  ArtnetDataPacket _packet = new ArtnetDataPacket();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value)
    ));
  }

  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showInSnackBar('Please fix the errors in red and resubmit');
    } else {
      form.save();
      showInSnackBar('Universe set to: ${_packet.universe}');
    }
  }

  String _validateNet(String value) {
    final RegExp portExpression = new RegExp(r'^[0-9]*$');
    if (!portExpression.hasMatch(value)) return 'Please enter a number';
    int val = int.parse(value);
    if(val > 0x7F || val < 0) return 'Net is a value between 0-127';
    _packet.net = int.parse(value);
    return null;
  }

  String _validateSubnet(String value) {
    final RegExp portExpression = new RegExp(r'^[0-9]*$');
    if (!portExpression.hasMatch(value)) return 'Please enter a number';
    int val = int.parse(value);
    if(val > 0xFF || val < 0) return 'Subnet is a value between 0-255';
    _packet.subUni = int.parse(value);
    return null;
  }

  void _setValue(){
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('Data Packet Builder'),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
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
              new Center(
                child: new RaisedButton(
                  child: const Text('Set Universe'),
                  onPressed: _handleSubmitted,
                ),
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
                            onPressed: (){
                              _packet.whiteout();
                              StoreProvider.of<AppState>(context).dispatch(new ArtnetAction(ArtnetActions.sendPacket, new Packet(false, _packet, tron.outgoingIp, tron.outgoingPort)));
                              setState(_setValue);
                            },
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
                            onPressed: (){
                              _packet.blackout();
                              StoreProvider.of<AppState>(context).dispatch(new ArtnetAction(ArtnetActions.sendPacket, new Packet(false, _packet, tron.outgoingIp, tron.outgoingPort)));
                              setState(_setValue);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                      onLongPress: () {
                        _packet.setDmxValue(index + 1, 0);
                        StoreProvider.of<AppState>(context).dispatch(new ArtnetAction(ArtnetActions.sendPacket, new Packet(false, _packet, tron.outgoingIp, tron.outgoingPort)));
                        setState(_setValue);
                      },
                      onDoubleTap: () {
                        _packet.setDmxValue(index + 1, 255);
                        StoreProvider.of<AppState>(context).dispatch(new ArtnetAction(ArtnetActions.sendPacket, new Packet(false, _packet, tron.outgoingIp, tron.outgoingPort)));
                        setState(_setValue);
                      },
                      onTap: () {
                        setState(_setValue);
                        Future fut = showDialog(
                          context: context,
                          child: new DMXDialog(
                            packet: _packet,
                            index: index,
                          )
                        );
                        fut.whenComplete(
                          () {
                            setState(_setValue);
                          }
                        );
                      },
                      child: new SizedBox(
                        height: 33.0,
                        child: new Center(
                          child: new Text(
                            '${index + 1}\n${_packet.dmx[index]}'
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

class DMXDialog extends StatefulWidget {
  const DMXDialog({this.packet, this.index});

  final ArtnetDataPacket packet;
  final int index;

  @override
  State createState() => new DMXDialogState();
}

class DMXDialogState extends State<DMXDialog> {
  ArtnetDataPacket _packet;
  int _index;

  @override
  void initState() {
    super.initState();
    _packet = widget.packet;
    _index = widget.index;
  }

  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text("Set Channel: ${_index+1} : ${_packet.dmx[_index]}"),
      actions: [
        new Slider(
          value: _packet.dmx[_index].toDouble(),
          min: 0.0,
          max:255.0,
          onChanged: (double value) {
            setState(() {
              _packet.setDmxValue(_index + 1, value.toInt());
              StoreProvider.of<AppState>(context).dispatch(new ArtnetAction(ArtnetActions.sendPacket, new Packet(false, _packet, tron.outgoingIp, tron.outgoingPort)));
            });
          },
          onChangeEnd: (double value) => StoreProvider.of<AppState>(context).dispatch(new ArtnetAction(ArtnetActions.sendPacket, new Packet(false, _packet, tron.outgoingIp, tron.outgoingPort))),
        ),
        new FlatButton(
          child: const Text("Ok"),
          onPressed: ()=> Navigator.pop(context),
        ),
      ],
    );
  }
}
