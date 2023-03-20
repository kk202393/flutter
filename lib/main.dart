// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstflutterapp/views/login_view.dart';
import 'package:firstflutterapp/views/register_view.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
// String fullName(first, last) {
//   return "$first $last";
// }

// class Cat {
//   final String name;
//   Cat(this.name);
// }

// Future<int> multply(int a) {
//   return Future.delayed(const Duration(seconds: 10), () {
//     return a * 25;
//   });
// }

// class Person {
//   final String data;
//   Person(this.data);
// }

// extension Run on Cat {
//   void run() {
//     print("This is $name of LDS");
//   }
// }

// Stream<int> timmer() {
//   return Stream.periodic(const Duration(seconds: 1), (a) {
//     return ++a;
//   });
// }

//void test() async {
// await for (final a in timmer()) {
//   print(a);
// }
// final result = await multply(20);
// final memo = Cat("Kailash");
// memo.run();
//}

// void test(name) {
//   final myName = Cat("Kailash");
//   final myName1 = Cat("Kailash");
//   print(myName.name);
//   print(myName1.name);
//   if (myName == myName1) {
//     print("This is Kailash");
//   } else {
//     print("This is not Kailash");
//   }
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(

//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// Home Page Code Start

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {
                print("You are a verified user");
              } else {
                print("You are not verified user");
              }
              return Text("${user?.email}");
            default:
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}




// Home Page Code end