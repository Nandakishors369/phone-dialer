import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phone_dialer/models/contact_model.dart';

part 'get_contact_event.dart';
part 'get_contact_state.dart';

class GetContactBloc extends Bloc<GetContactEvent, GetContactState> {
  GetContactBloc() : super(GetContactInitial()) {
    on<GetContactEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
