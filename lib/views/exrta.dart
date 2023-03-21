
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
