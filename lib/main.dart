import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  var routes = <String, WidgetBuilder>{
    AddTask.routeName: (BuildContext context) => new AddTask(title: "Add Task"),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Todo'),
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

//  Padding _buildTodoList() {
//    return new Padding(
//      padding:
//          EdgeInsets.only(top: 24.0, right: 18.0, bottom: 20.0, left: 18.0),
//      child: new Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          new Text(
//            "Upcoming",
//            style: new TextStyle(fontSize: 24.0),
//          ),
//          new Padding(padding: EdgeInsets.all(8.0)),
//          new Row(
//            children: <Widget>[
//              new IconButton(
//                  icon: new Icon(Icons.check_circle_outline),
//                  onPressed: null,
//                  iconSize: 22.0),
//              new Text(
//                "Meeting with Vikas",
//                style: new TextStyle(fontSize: 18.0),
//              ),
//            ],
//          ),
//          new Row(
//            children: <Widget>[
//              new IconButton(
//                  icon: new Icon(Icons.check_circle_outline),
//                  onPressed: null,
//                  iconSize: 22.0),
//              new Text(
//                "Call CEO for meeting",
//                style: new TextStyle(fontSize: 18.0),
//              ),
//            ],
//          ),
//          new Row(
//            children: <Widget>[
//              new IconButton(
//                  icon: new Icon(Icons.check_circle_outline),
//                  onPressed: null,
//                  iconSize: 22.0),
//              new Text(
//                "Eat kfc at inox",
//                style: new TextStyle(fontSize: 18.0),
//              ),
//            ],
//          ),
//          new Row(
//            children: <Widget>[
//              new IconButton(
//                  icon: new Icon(Icons.check_circle_outline),
//                  onPressed: null,
//                  iconSize: 22.0),
//              new Text(
//                "Finish Flutter course",
//                style: new TextStyle(fontSize: 18.0),
//              ),
//            ],
//          ),
//          new Row(
//            children: <Widget>[
//              new IconButton(
//                  icon: new Icon(Icons.check_circle_outline),
//                  onPressed: null,
//                  iconSize: 22.0),
//              new Text(
//                "Create 5 pull requests",
//                style: new TextStyle(fontSize: 18.0),
//              ),
//            ],
//          ),
//          new Padding(padding: EdgeInsets.all(8.0)),
//          new Text(
//            "Finished",
//            style: new TextStyle(fontSize: 24.0),
//          ),
//          new Padding(padding: EdgeInsets.all(8.0)),
//          new Row(
//            children: <Widget>[
//              new IconButton(
//                  icon: new Icon(Icons.check_circle),
//                  onPressed: null,
//                  iconSize: 22.0),
//              new Text(
//                "Buy a Macbook",
//                style: new TextStyle(fontSize: 18.0),
//              ),
//            ],
//          ),
//          new Row(
//            children: <Widget>[
//              new IconButton(
//                  icon: new Icon(Icons.check_circle),
//                  onPressed: null,
//                  iconSize: 22.0),
//              new Text(
//                "Become a speaker",
//                style: new TextStyle(fontSize: 18.0),
//              ),
//            ],
//          ),
//          new Row(
//            children: <Widget>[
//              new IconButton(
//                  icon: new Icon(Icons.check_circle),
//                  onPressed: null,
//                  iconSize: 22.0),
//              new Text(
//                "Engage in communities",
//                style: new TextStyle(fontSize: 18.0),
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }

  List<String> _todoItems = [];

  //This will be called each time + icon is pressed
  void _addTodoItem() {
    //this will re render the list whenever our state is changed
    setState(() {
      int index = _todoItems.length;
      _todoItems.add('Item ' + index.toString());
    });
  }

  Widget _buildTodoList() {
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index) {

          /*itemBuilder will be automatically be called as many times as it takes for the
          list to fill up its available space, which is most likely more than the
          number of todo items we have. So, we need to check the index is OK. */

          if (index < _todoItems.length) {
            return _buildTodoItem(_todoItems[index]);
          }
        }
    );
  }

  Widget _buildTodoItem(String todoText) {
    return new ListTile(
        title: new Text(todoText)
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addTodoItem,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AddTask extends StatefulWidget {
  AddTask({Key key, this.title}) : super(key: key);

  static const String routeName = "/AddTask";

  final String title;

  @override
  _AddTaskState createState() => new _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String _value = '';

  void _onSubmit(String value) {
    setState(() {
      _value = '${value}';
      print(_value);
      //Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Column(
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(
                labelText: 'What\'s your plan today?',
              ),
              autocorrect: true,
              autofocus: true,
              keyboardType: TextInputType.text,
              onSubmitted: _onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
