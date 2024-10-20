import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/presentation/view/widgets/RowTextWidget.dart';
import 'package:todo_app/features/presentation/view/widgets/containerwidget.dart';
import 'package:todo_app/features/presentation/view/widgets/floatingactionwidget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> texts = ["Today", "Tomorrow", "Next Week"];
  int selectedtext = 0;
  List<bool> checkedValues = [false, false, false];

  Stream<QuerySnapshot> getDataStream(String category) {
    if (category == 'Today') {
      return FirebaseFirestore.instance.collection('Today').snapshots();
    } else if (category == 'Tomorrow') {
      return FirebaseFirestore.instance.collection('Tomorrow').snapshots();
    } else {
      return FirebaseFirestore.instance.collection('Next Week').snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FloatingAction(
            slectedcategory: texts[selectedtext],
            onTodoAdded: (String todoText) {
              setState(() {});
            },
          ).openBox(context);
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 90, left: 30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF32fDA2), Color(0xFF13D4CA), Color(0xFF09adfe)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "HELLO",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Good Morning",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: texts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedtext = index;
                        });
                      },
                      child: selectedtext == index
                          ? Center(child: ContainerWidget(text: texts[index]))
                          : RowText(text: texts[index]),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: getDataStream(texts[selectedtext]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                        child: Text(
                            "No data available for ${texts[selectedtext]}"));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var todoData = snapshot.data!.docs[index];

                      var dataMap = todoData.data() as Map<String, dynamic>;

                      if (dataMap.containsKey('text')) {
                        return CheckboxListTile(
                          activeColor: Color(0xFF279cfb),
                          value: checkedValues[index],
                          title: Text(
                            dataMap['text'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w400),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              checkedValues[index] = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
