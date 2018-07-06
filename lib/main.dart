import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:artnet_tester/models/app_state.dart';
import 'package:artnet_tester/controllers/reducers.dart';
import 'package:artnet_tester/controllers/udp_server.dart';
import 'package:artnet_tester/views/screens/main_screen.dart';

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

