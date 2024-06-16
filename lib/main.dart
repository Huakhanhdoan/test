import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final i18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      useCountryCode: false,
      fallbackFile: 'en',
      basePath: 'assets/flutter_i18n',
      forcedLocale: const Locale('en'),
    ),
  );

  await i18nDelegate.load(const Locale('en')); // Load initial translations with non-null locale

  runApp(MyApp(i18nDelegate));
}

class MyApp extends StatefulWidget {
  final FlutterI18nDelegate i18nDelegate;

  MyApp(this.i18nDelegate, {super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        widget.i18nDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('vi'),
      ],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "hello")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(FlutterI18n.translate(context, "welcome")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FlutterI18n.refresh(context, const Locale('vi'));
                setState(() {}); // Gọi setState để cập nhật giao diện
              },
              child: const Text("Switch to Vietnamese"),
            ),
            ElevatedButton(
              onPressed: () async {
                await FlutterI18n.refresh(context, const Locale('en'));
                setState(() {}); // Gọi setState để cập nhật giao diện
              },
              child: const Text("Switch to English"),
            ),
          ],
        ),
      ),
    );
  }
}
