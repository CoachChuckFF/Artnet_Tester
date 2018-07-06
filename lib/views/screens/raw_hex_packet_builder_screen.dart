import 'package:flutter/material.dart';
import 'package:artnet_tester/controllers/udp_server.dart';

class RawHexPacketBuilderScreen extends StatefulWidget {
  const RawHexPacketBuilderScreen({ Key key }) : super(key: key);

  @override
  RawHexPacketBuilderScreenState createState() => new RawHexPacketBuilderScreenState();
}

class RawHexPacketBuilderScreenState extends State<RawHexPacketBuilderScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>(); 

  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    form.save();
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Raw Hex Builder'),
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
                  labelText: 'Hex String'
                ),
                keyboardType: TextInputType.phone,
                onSaved: (String value) { 
                  if(value == "") return;
                  List<int> ret = new List<int>();
                  for(var i = 0; i+1 < value.length; i+=2){
                    ret.add(int.parse(value.substring(i, i+1), radix: 16));
                  }
                  if(value.length % 2 != 0){
                    ret.add(int.parse(value.substring(value.length-1), radix: 16));
                  }

                  tron.sendPacket(ret);
                },
              ),
              const SizedBox(height: 24.0),
              new Center(
                child: new RaisedButton(
                  child: const Text('Send Hex'),
                  onPressed: _handleSubmitted,
                ),
              ),
              const SizedBox(height: 24.0), 
            ],
          ),
        ),
      ),
    );
  }
}
