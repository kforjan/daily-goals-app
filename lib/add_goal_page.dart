import 'package:flutter/material.dart';

class AddGoalPage extends StatefulWidget {
  const AddGoalPage({Key key, @required this.submitAction}) : super(key: key);

  final Function submitAction;

  @override
  _AddGoalPageState createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New goal'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 300,
                child: TextFormField(
                  controller: inputController,
                  decoration: InputDecoration(labelText: 'Name the new goal'),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  widget.submitAction(inputController.text);
                  Navigator.pop(context);
                },
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
