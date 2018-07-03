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

import 'package:artnet_tester/controllers/reducers.dart';
import 'package:artnet_tester/controllers/udp_server.dart';


void main(){
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(),
  );
 
  tron.store = store;

  runApp(new MyApp(
    title: 'Artnet Tester',
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final String title;

  MyApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Artnet Tester',
        theme: new ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: new MainScreen(),
      ),
    );
  }
}

