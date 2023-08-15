import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_overview_17/app_provider.dart';
import 'package:provider_overview_17/success_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (_) => AppProvider(),
      child: MaterialApp(
        title: 'addListener of ChangeNotifier',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? searchTerm;
  late final AppProvider appProvider;

  @override
  void initState() {
    super.initState();
    appProvider = context.read<AppProvider>();
    appProvider.addListener(addListener);
  }

  void addListener() {
    if (appProvider.state == AppState.success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const SuccessPage();
          },
        ),
      );
    } else if (appProvider.state == AppState.error) {
      showDialog(
        context: context,
        builder: (_) {
          return const AlertDialog(
            content: Text('Something went wrong!'),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    appProvider.removeListener(addListener);
    super.dispose();
  }

  void submit() {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });

    final form = formKey.currentState;

    if (form == null || !form.validate()) {
      return;
    }

    form.save();

    context.read<AppProvider>().getResult(searchTerm!);
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppProvider>().state;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('search'),
                      prefixIcon: Icon(Icons.search),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Search term required';
                      }
                      return null;
                    },
                    onSaved: ((newValue) => searchTerm = newValue),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: (appState == AppState.loading) ? null : submit,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (appState == AppState.loading)
                            ? 'Loading...'
                            : 'Get Result',
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
