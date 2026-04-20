import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:rider_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rider_app/features/auth/presentation/screens/phone_screen.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

Widget _makeTestable(Widget child, AuthBloc bloc) {
  return MaterialApp(
    home: BlocProvider<AuthBloc>.value(value: bloc, child: child),
  );
}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(const AuthInitial());
  });

  group('PhoneScreen', () {
    testWidgets('renders phone input and continue button', (tester) async {
      await tester.pumpWidget(_makeTestable(const PhoneScreen(), mockAuthBloc));

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
      expect(find.text('+91'), findsOneWidget);
    });

    testWidgets('continue button is disabled when field is empty', (tester) async {
      await tester.pumpWidget(_makeTestable(const PhoneScreen(), mockAuthBloc));

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('shows error when phone number is less than 10 digits', (tester) async {
      await tester.pumpWidget(_makeTestable(const PhoneScreen(), mockAuthBloc));

      await tester.enterText(find.byType(TextField), '98765');
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('continue button is enabled for valid 10-digit phone', (tester) async {
      await tester.pumpWidget(_makeTestable(const PhoneScreen(), mockAuthBloc));

      await tester.enterText(find.byType(TextField), '9876543210');
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('dispatches SendOtpEvent on valid submit', (tester) async {
      await tester.pumpWidget(_makeTestable(const PhoneScreen(), mockAuthBloc));

      await tester.enterText(find.byType(TextField), '9876543210');
      await tester.pump();
      await tester.tap(find.text('Continue'));
      await tester.pump();

      verify(() => mockAuthBloc.add(
        const SendOtpEvent(phone: '+919876543210'),
      )).called(1);
    });

    testWidgets('shows loading indicator when AuthLoading', (tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthLoading());
      await tester.pumpWidget(_makeTestable(const PhoneScreen(), mockAuthBloc));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
