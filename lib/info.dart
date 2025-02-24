import 'package:flutter/material.dart';

//E.g Info(bmi_value);

class Info extends StatelessWidget {
  const Info({super.key, required this.bmi});

  final String bmi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Body Mass Index Info'),
      ),
        body: Padding(
        padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('Body mass index (BMI) is a value derived from the mass (weight) and height of a person. The BMI is defined as the body mass divided by the square of the body height, and is expressed in units of kg/m\u00B2, resulting from mass in kilograms (kg) and height in metres (m).'
        ),

        Table(
          border: TableBorder.all(color: Colors.orangeAccent),
          children: [
            TableRow(
              children: [
                TableCell(
                  child:
                  Text('BMI Value',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),),
                TableCell(
                  child:
                  Text('Classification',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),),
              ],
            ),
            TableRow(
              children: [
                TableCell(child: Text('Below 18.5')),
                TableCell(child: Text('Underweight')),
              ],
            ),
            TableRow(
              children: [
                TableCell(child: Text('18.5 - 24.9')),
                TableCell(child: Text('Normal')),
              ],
            ),
            TableRow(
              children: [
                TableCell(child: Text('More than 25')),
                TableCell(child: Text('Overweight')),
              ],
            ),
          ],
        ),

        bmi != '' ? Text('Your Body mass index (BMI) is $bmi')
        : Text('Please enter your weight and height'),

        bmi.contains('Normal') ? const Text('Maintain')
        : Text('Please maintain'),

        Expanded(child: SizedBox(height: double.infinity,)),
        ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text('Go back!')),
      ],
    ),),
    );
  }
}