import 'package:daily_goal/service/sp_data.dart';
import 'package:flutter/material.dart';

class DailyGoalTile extends StatefulWidget {
  DailyGoalTile({
    Key key,
    @required this.index,
    @required this.text,
    @required this.dismissAction,
    this.isDone = false,
  }) : super(key: key);

  final int index;
  final String text;
  final Function dismissAction;
  bool isDone;

  @override
  _DailyGoalTileState createState() => _DailyGoalTileState();
}

class _DailyGoalTileState extends State<DailyGoalTile> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) {
        widget.dismissAction(widget.index);
        SpData.deleteData(widget.text);
      },
      background: Container(
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 30,
          right: 40,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: TextStyle(fontSize: 30),
              ),
              IconButton(
                icon: Icon(
                  Icons.check_circle,
                  color: widget.isDone ? Colors.green : Colors.grey,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    widget.isDone = !widget.isDone;
                    SpData.saveData(widget.text, widget.isDone);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
