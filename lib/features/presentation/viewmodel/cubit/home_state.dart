import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomeState {}

class InitialState extends HomeState {}

class LoadingState extends HomeState {}

class SuccessState extends HomeState {}

class ErrorState extends HomeState {}

class DataFetchedState extends HomeState {
  final List<QueryDocumentSnapshot> documents;

  DataFetchedState(this.documents);
}
