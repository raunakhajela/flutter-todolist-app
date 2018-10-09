import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
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
  void _addTodoItem(String task) {
    //this will re render the list whenever our state is changed
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  Widget _buildTodoList() {
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index) {

          /*itemBuilder will be automatically be called as many times as it takes for the
          list to fill up its available space, which is most likely more than the
          number of todo items we have. So, we need to check the index is OK. */

          if (index < _todoItems.length) {
            return _buildTodoItem(_todoItems[index], index);
          }
        }
    );
  }

  // Much like _addTodoItem, this modifies the array of todo strings and
  // notifies the app that the state has changed by using setState
  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  // Show an alert dialog asking the user to confirm that the task is done
  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Mark "${_todoItems[index]}" as done?'),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    _removeTodoItem(index);
                    Navigator.of(context).pop();
                  },
                  child: new Text('MARK AS DONE')
              ),
              new FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: new Text('CANCEL')
              )
            ],
          );
        }
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return new InkWell(
      onTap: () => _promptRemoveTodoItem(index),
      child: new Row(
        children: <Widget>[
          new IconButton(
              icon: new Icon(Icons.check_circle_outline), iconSize: 22.0),
          new Text(todoText, style: new TextStyle(fontSize: 18.0),),
        ],
      ),
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
        onPressed: _pushAddTodoScreen,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: Icon(Icons.home), iconSize: 25.0,),
            IconButton(icon: Icon(Icons.show_chart), iconSize: 25.0,),
            new Text(''),
            IconButton(icon: Icon(Icons.tab), iconSize: 25.0,),
            IconButton(icon: Icon(Icons.settings), iconSize: 25.0,)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
                title: new Text('Add a new task')
            ),
            body: new TextField(
              autofocus: true,
              onSubmitted: (val) {
                _addTodoItem(val);
                Navigator.pop(context); // Close the add todo screen
              },
              decoration: new InputDecoration(
                  hintText: 'Enter something to do...',
                  contentPadding: const EdgeInsets.all(16.0)
              ),
            ),
          );
        })
    );
  }
}