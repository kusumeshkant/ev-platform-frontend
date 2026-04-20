import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'locale_manager.dart';

// Events
sealed class LocaleEvent {}
class ChangeLocale extends LocaleEvent {
  final Locale locale;
  ChangeLocale(this.locale);
}

// State
class LocaleState {
  final Locale locale;
  const LocaleState(this.locale);
}

// BLoC
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc(Locale initial) : super(LocaleState(initial)) {
    on<ChangeLocale>(_onChange);
  }

  Future<void> _onChange(ChangeLocale event, Emitter<LocaleState> emit) async {
    await LocaleManager.persist(event.locale);
    emit(LocaleState(event.locale));
  }
}
