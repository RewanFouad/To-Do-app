import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/presentation/viewmodel/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialState());

  Future addTodayWork(Map<String, dynamic> userTodayMap, String id) async {
    emit(LoadingState());
    try {
      return await FirebaseFirestore.instance
          .collection("Today")
          .doc(id)
          .set(userTodayMap);
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  Future addTomorrowWork(
      Map<String, dynamic> userTomorrowMap, String id) async {
    emit(LoadingState());
    try {
      return await FirebaseFirestore.instance
          .collection("Tomorrow")
          .doc(id)
          .set(userTomorrowMap);
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  Future addNextWeekWork(
      Map<String, dynamic> userNextWeekMap, String id) async {
    emit(LoadingState());
    try {
      return await FirebaseFirestore.instance
          .collection("Next Week")
          .doc(id)
          .set(userNextWeekMap);
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState());
    }
  }
}
