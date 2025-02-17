import 'package:flutter/material.dart';
import 'dart:math';//This is needed for the power function

void main() {
  runApp(const MyApp());
}

//A widget that does not change during program execution
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

//A widget that can change during program execution
class MyHomePage extends StatefulWidget {
  //title - is an attribute of this widget
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//This class maintain the memory state of MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  //This is the global variable
  //Declare variable here
  double _bmi = 0.0;
  double _weight = 0.0;
  double _height = 0.0;

  String _bmiOutput ='';
  String _bmiImage = 'assets/images/empty.png';

  //Define text field controller - set/get text to/from TextField
  final TextEditingController _weightCtrl = TextEditingController();
  final TextEditingController _heightCtrl = TextEditingController();

  void _calculateBMI() {
    _weight = double.tryParse(_weightCtrl.text)!;
    //_weight = double.parse(_weightCtrl.text);
    _height = double.tryParse(_heightCtrl.text)!;
    setState(() {
      _bmi = _weight/ pow(_height/100, 2);
      if(_bmi < 18.5){
        _bmiOutput = '${_bmi.toStringAsFixed(2)} [Underweight]';
        _bmiImage = 'assets/images/under.png';
      }
      else if(_bmi >= 25){
        _bmiOutput = '${_bmi.toStringAsFixed(2)} [Overweight]';
        _bmiImage = 'assets/images/over.png';
      }
      else {
        _bmiOutput = '${_bmi.toStringAsFixed(2)} [Normal]';
        _bmiImage = 'assets/images/normal.png';
      }
    });
  }

  void _resetScreen() {
    //Clear input text
    _weightCtrl.clear();
    _heightCtrl.clear();
    setState(() {
      _bmi = 0.0;
      _bmiOutput = '';
      _bmiImage = 'assets/images/empty.png';
    });
  }

  //This is called when the user is leaving your app/screen
  @override
  void dispose() {
    super.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                fit: StackFit.loose,
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      _bmiImage,
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    alignment: Alignment.center,
                    //variable == value? true: false;
                    child: _bmi == 0.0
                      ? Text(
                        textAlign: TextAlign.center,
                        'Enter body weight and height to know your Body Mass Index (BMI)',
                        style: TextStyle(fontSize: 12, color: Colors.orange)
                    )
                      : Text(''),
                  )
                ],
              ),
              const Text(
                'Your Body Mass Index (BMI) is : ',
              ),
              Text(
                _bmiOutput,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              TextField(
                controller: _weightCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter weight (kg)'
                ),
              ),
              TextField(
                controller: _heightCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter height (cm)'
                ),
              ),
              const Expanded(
                  child: SizedBox(height: double.infinity,)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: _resetScreen,
                      child: Text('Reset')
                  ),
                  ElevatedButton(
                      onPressed: _calculateBMI,
                      child: Text('Calculate')
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
