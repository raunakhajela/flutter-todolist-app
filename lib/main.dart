import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

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

  final _controller_key = TextEditingController();
  final _controller_data = TextEditingController();

  String text_to_show = '';

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
            icon: new Icon(Icons.check_circle_outline),
            iconSize: 22.0,
            onPressed: null,),
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
            IconButton(
              icon: Icon(Icons.home), iconSize: 25.0, onPressed: null,),
            IconButton(
              icon: Icon(Icons.show_chart), iconSize: 25.0, onPressed: null,),
            new Text(''),
            IconButton(icon: Icon(Icons.tab), iconSize: 25.0, onPressed: null,),
            IconButton(
              icon: Icon(Icons.settings), iconSize: 25.0, onPressed: null,)
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
            body: Column(
              children: <Widget>[
                new TextField(
                  controller: _controller_key,
                  autofocus: true,
                  onSubmitted: (val) {
                    _addTodoItem(val);
                    Navigator.pop(context); // Close the add todo screen
                  },
                  decoration: new InputDecoration(
                      hintText: 'Enter key...',
                      contentPadding: const EdgeInsets.all(16.0)
                  ),
                ),
                new TextField(
                  controller: _controller_data,
                  autofocus: true,
                  onSubmitted: (val) {
                    _addTodoItem(val);
                    Navigator.pop(context); // Close the add todo screen
                  },
                  decoration: new InputDecoration(
                      hintText: 'Enter data...',
                      contentPadding: const EdgeInsets.all(16.0)
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new RaisedButton(
                        onPressed: () =>
                            saveData(
                                _controller_key.text, _controller_data.text),
                        child: new Text('Save Data'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new RaisedButton(
                        onPressed: () => readData(_controller_key.text),
                        child: new Text('Read Data'),
                      ),
                    ),
                    Text('$text_to_show'),
                  ],
                ),
              ],
            ),
          );
        })
    );
  }

  Future saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);
  }

  Future readData(String text) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      text_to_show = prefs.getString(text);
    });
  }
}