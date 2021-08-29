import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modals/modals.dart';

void main() {
  group('modal errors', () {
    testWidgets('throw FlutterError on duplicate modal tag', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: TestWidget()));
      expect(tester.takeException(), isFlutterError);
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
    showModal(ModalEntry.positioned(
      context,
      tag: 'firstTag',
      left: 200,
      top: 200,
      child: const SizedBox.shrink(),
    ));

    showModal(ModalEntry.positioned(
      context,
      tag: 'firstTag',
      left: 200,
      top: 200,
      child: const SizedBox.shrink(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
