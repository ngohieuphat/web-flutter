import 'package:flutter_application_7/pages/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('Home page test', () {
    // ham rieng cho nut check va next ,inputprice
    Finder checkBtn() => find.text('Check');
    Finder nextBtn() => find.text('Next');
    Finder PriceInput() => find.byKey(const Key('priceInput'));

    // test check san pham
    testWidgets(
      'click Next to iterate over the product list',
      (WidgetTester tester) async {
        await tester.pumpWidget(const Material(
          child: HomePage(),
        ));
        expect(find.text(products[0].name), findsOneWidget);
        for (var i = 1; i < 5; i++) {
          await tester.tap(checkBtn());
          await tester.enterText(PriceInput(), '0');
          await tester.pump();
          await tester.tap(nextBtn());

          await tester.pump();
          expect(find.text(products[i].name), findsOneWidget);
        }

        await tester.tap(checkBtn());
        await tester.tap(nextBtn());

        await tester.pump();
        await tester.pump();
        expect(find.text(products[4].name), findsOneWidget);
      },
    );
    // test textField priceInput
    testWidgets('check result & show next product',
        (WidgetTester tester) async {
      await tester.pumpWidget(const Material(
        child: HomePage(),
      ));
      //qa san pham khong nhin thay next
      expect(nextBtn(), findsNothing);
      expect(find.byKey(const Key('result')), findsNothing);
      await tester.enterText(PriceInput(), '3');
      await tester.tap(checkBtn());

      await tester.pump();
      expect(nextBtn(), findsOneWidget);
      expect(find.byKey(const Key('result')), findsOneWidget);
      expect(find.text('pass'), findsOneWidget);

      await tester.tap(nextBtn());

      await tester.pump();

      await tester.enterText(PriceInput(), '4');
      await tester.tap(checkBtn());

      await tester.pump();
      expect(nextBtn(), findsOneWidget);
      expect(find.byKey(const Key('result')), findsOneWidget);
      expect(find.text('fail'), findsOneWidget);
      await tester.enterText(PriceInput(), '5');
      await tester.tap(checkBtn());

      await tester.pump();
      expect(find.text('pass'), findsOneWidget);
    });
  });
}
