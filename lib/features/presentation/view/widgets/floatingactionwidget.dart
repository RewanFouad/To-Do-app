import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/presentation/viewmodel/cubit/home_cubit.dart';
import 'package:todo_app/features/presentation/viewmodel/cubit/home_state.dart';

class FloatingAction extends StatelessWidget {
  final String slectedcategory;
  final Function(String) onTodoAdded;

  FloatingAction(
      {Key? key, required this.slectedcategory, required this.onTodoAdded})
      : super(key: key);

  void openBox(BuildContext context) {
    TextEditingController todocontroller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel),
                  ),
                  SizedBox(width: 60),
                  Text(
                    "Add The Work Todo",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff008080),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text("Add Text"),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: todocontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Text",
                  ),
                ),
              ),
              SizedBox(height: 20),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      String todoText = todocontroller.text;
                      if (todoText.isNotEmpty) {
                        if (slectedcategory == 'Today') {
                          context
                              .read<HomeCubit>()
                              .addTodayWork({"text": todoText}, 'today id');
                        } else if (slectedcategory == 'Tomorrow') {
                          context.read<HomeCubit>().addTomorrowWork(
                              {"text": todoText}, 'tomorrow id');
                        } else if (slectedcategory == 'Next Week') {
                          context.read<HomeCubit>().addNextWeekWork(
                              {"text": todoText}, 'Next Week id');
                        }
                        onTodoAdded(todoText);
                        Navigator.pop(context);
                      }
                    },
                    child: Center(
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xFF008080),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
