import 'package:flutter_test/flutter_test.dart';
import 'package:onboarding/app.dart';

void main() {
  testWidgets('every launch opens onboarding after splash', (tester) async {
    await tester.pumpWidget(const VoltWayApp());
    expect(find.text('VOLTWAY'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 800));

    expect(
      find.text('Find nearby charging,\npower up with ease'),
      findsOneWidget,
    );
    expect(find.text('Next'), findsOneWidget);
  });
}
