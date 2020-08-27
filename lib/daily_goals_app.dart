import 'package:daily_goal/add_goal_page.dart';
import 'package:daily_goal/daily_goal_tile.dart';
import 'package:daily_goal/service/sp_data.dart';
import 'package:flutter/material.dart';

class DailyGoalsApp extends StatefulWidget {
  @override
  _DailyGoalsAppState createState() => _DailyGoalsAppState();
}

class _DailyGoalsAppState extends State<DailyGoalsApp> {
  List<String> _goals = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily goals',
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Daily goals'),
          ),
        ),
        body: Center(
          child: FutureBuilder(
            future: SpData.getAllKeys(),
            initialData: <String>[],
            builder: (context, snapshot) {
              _goals = snapshot.data;
              return ConnectionState.done == snapshot.connectionState
                  ? _buildGoalsList(snapshot.data ?? [])
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _onFloatingButtonPress(context);
            },
          ),
        ),
      ),
      routes: {},
    );
  }

  void _onFloatingButtonPress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddGoalPage(submitAction: _addGoal),
      ),
    );
  }

  void _addGoal(String goal) {
    setState(() {
      _goals.add(goal);
      SpData.saveData(goal, false);
    });
  }

  void _deleteGoal(int index) {
    setState(() {
      _goals.removeAt(index);
    });
  }

  Widget _buildGoalsList(List<String> goals) {
    return ListView.builder(
      itemBuilder: (context, index) => FutureBuilder(
        future: SpData.isGoalDone(goals[index]),
        builder: (context, snapshot) =>
            ConnectionState.done == snapshot.connectionState
                ? DailyGoalTile(
                    index: index,
                    text: goals[index],
                    dismissAction: _deleteGoal,
                    isDone: snapshot.data,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
      itemCount: goals.length,
    );
  }
}
