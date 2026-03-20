import 'package:flutter_test/flutter_test.dart';

import 'package:studymate/main.dart';

void main() {
  testWidgets('NeighborDrop smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NeighborDropApp());
  });
}
