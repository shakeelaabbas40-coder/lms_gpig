
import 'package:flutter_test/flutter_test.dart';
import 'package:lms_gpig/main.dart';

void main() {
testWidgets('LMS app loads successfully', (WidgetTester tester) async {
await tester.pumpWidget(const MyApp());

// Check that the app starts successfully.
expect(find.byType(MyApp), findsOneWidget);
});
}
