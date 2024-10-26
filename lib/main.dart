import 'package:flutter/material.dart';
import 'package:sip_ua/sip_ua.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements SipUaHelperListener {
  final SIPUAHelper _sipuaHelper = SIPUAHelper();
  late RegistrationState _registerState;

  void login() async {
    final UaSettings uaSettings = UaSettings()
      ..webSocketUrl = 'wss://sip.otens.ru:8089/ws'
      ..password = '1909video2024'
      ..userAgent = '113'
      ..transportType = TransportType.WS
      ..webSocketSettings.allowBadCertificate = true
      ..uri = '113@sip.otens.ru'
      ..displayName = '113';
    await _sipuaHelper.start(uaSettings);
  }

  @override
  void initState() {
    super.initState();
    _sipuaHelper.addSipUaHelperListener(this);
    _registerState = _sipuaHelper.registerState;
    login();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('title'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                EnumHelper.getName(_registerState.state),
              ),
            ],
          ),
        ),
      )
    );
  }

  @override
  void callStateChanged(Call call, CallState state) {
    // TODO: implement callStateChanged
  }

  @override
  void onNewMessage(SIPMessageRequest msg) {
    // TODO: implement onNewMessage
  }

  @override
  void onNewNotify(Notify ntf) {
    // TODO: implement onNewNotify
  }

  @override
  void onNewReinvite(ReInvite event) {
    // TODO: implement onNewReinvite
  }

  @override
  void registrationStateChanged(RegistrationState state) {
    setState(() {
      _registerState = state;
    });
  }

  @override
  void transportStateChanged(TransportState state) {
    // TODO: implement transportStateChanged
  }
}
