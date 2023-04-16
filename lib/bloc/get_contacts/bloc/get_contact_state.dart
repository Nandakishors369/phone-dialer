part of 'get_contact_bloc.dart';

@immutable
abstract class GetContactState {}

class GetContactInitial extends GetContactState {
  final List<ContactModel> contacts;
  GetContactInitial({this.contacts = const <ContactModel>[]});
}

class GetContactLoaded extends GetContactState {}
