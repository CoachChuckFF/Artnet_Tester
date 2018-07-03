import 'package:flutter/material.dart';


import 'package:flutter_redux/flutter_redux.dart';


import 'package:artnet_tester/models/app_state.dart';

import 'package:artnet_tester/views/network_settings_screen.dart';
import 'package:artnet_tester/views/components/packet_list.dart';
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
import 'package:artnet_tester/views/components/packet_count.dart';

import 'package:artnet_tester/controllers/reducers.dart';
import 'package:artnet_tester/controllers/udp_server.dart';

const ButtonStyle = TextStyle(color: Colors.white,
                                fontSize: 23.0,
                                fontFamily: 'Roboto');

const SubTitleStyle = TextStyle(color: Colors.white70,
                                fontSize: 33.0,
                                fontFamily: 'Roboto');

const TitleStyle = TextStyle(color: Colors.white,
                                fontSize: 33.0,
                                fontFamily: 'Roboto');