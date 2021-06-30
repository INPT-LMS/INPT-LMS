import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lms_flutter/screens/LoginPage.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../mocks.dart';

void main() {
  testWidgets('Should have error snackbar', (WidgetTester tester) async {
    var compteService = MockCompteService();
    when(compteService.login(any, any)).thenAnswer((_) => Future(() => false));
    getIt.registerSingleton<CompteService>(compteService);

    await tester.pumpWidget(MaterialApp(builder: (context, child) {
      return ChangeNotifierProvider(
        create: (context) => InfosModel(null, ConnectivityResult.wifi),
        child: LoginPage(),
      );
    }));

    var loginButton = find.widgetWithText(ElevatedButton, "Se connecter");
    expect(loginButton, findsOneWidget);
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    var error =
        find.widgetWithText(SnackBar, "Email ou mot de passe incorrect");
    expect(error, findsOneWidget);
  });

  testWidgets('Should have text "bienvenue" ', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(builder: (context, child) {
      return ChangeNotifierProvider(
        create: (context) => InfosModel(null, ConnectivityResult.wifi),
        child: LoginPage(),
      );
    }));

    var loginButton = find.text("Bienvenue");
    expect(loginButton, findsOneWidget);
  });
}
