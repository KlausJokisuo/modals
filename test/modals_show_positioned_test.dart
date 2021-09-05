import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modals/modals.dart';

void main() {
  group('show modals', () {
    testWidgets('show modal using initState', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: TestWidget()));
      await tester.pump();
      expect(find.byKey(const Key('firstModal')), findsOneWidget);
    });

    testWidgets('show modal using gesture', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: TestWidget()));
      await tester.tap(find.byKey(
        const Key('secondModalButton'),
      ));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('secondModal')), findsOneWidget);
    });
  });
}

class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  void initState() {
    super.initState();
    showModal(ModalEntry.positioned(context,
        key: const Key('firstModal'),
        tag: 'firstModal',
        left: 200,
        top: 200,
        child: const SizedBox.shrink()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key('secondModalButton'),
      onTap: () {
        showModal(ModalEntry.positioned(context,
            key: const Key('secondModal'),
            tag: 'secondModal',
            left: 200,
            top: 200,
            child: const SizedBox.shrink()));
      },
      child: Container(
        color: Colors.red,
        height: 50,
        width: 50,
      ),
    );
  }
}
