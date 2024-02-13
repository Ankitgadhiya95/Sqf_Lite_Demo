import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflitedemo/database_repository.dart';
import 'package:sqflitedemo/todo_model.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ToDoModel> listData = [];

  getDataFromDB() async {
    var data = await DataBaseRepo.getItems();
    print(data);
    setState(() {
      listData = data;
      print(listData.length);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getDataFromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listData.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image(
                    //   image: NetworkImage(
                    //     controller.cartList[index].url.toString(),
                    //   ),
                    //   height: 100,
                    // ),
                    Row(
                      children: [
                        Text(
                          listData[index].id.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          listData[index].title.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          listData[index].description.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await DataBaseRepo.updateItem(
                                  listData[index].id, "HELLO", 'des');
                              getDataFromDB();
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              DataBaseRepo.deleteItem(listData[index].id);
                              getDataFromDB();
                            },
                            icon: Icon(CupertinoIcons.delete))
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await DataBaseRepo.createItem("title", "description");
              getDataFromDB();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              var data = await DataBaseRepo.getItemsbyId(3);
              setState(() {
                listData = data;
              });
              // getDataFromDB();
            },
            tooltip: 'Increment',
            child: const Icon(CupertinoIcons.search),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              //  var data=  await DataBaseRepo.getItemsbyId(3);

              getDataFromDB();
            },
            tooltip: 'Increment',
            child: const Icon(CupertinoIcons.back),
          ),
        ],
      ),
    );
  }
}
