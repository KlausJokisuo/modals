import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modals/modals.dart';

void main() {
  Future<void> _initTestWidgets(
      WidgetTester tester, String firstModalTag, String secondModalTag) async {
    await tester.pumpWidget(MaterialApp(
        home: TestWidget(
      firstModalTag: firstModalTag,
      secondModalTag: secondModalTag,
    )));

    await tester.pump();
  }

  group('remove modals', () {
    testWidgets('remove modal by id', (tester) async {
      const firstModalId = 'firstModal';
      const secondModalId = 'secondModal';
      await _initTestWidgets(tester, firstModalId, secondModalId);
      removeModal('firstModal');
      await tester.pump();
      expect(find.byType(ModalEntry), findsOneWidget);
    });

    testWidgets('remove all modals', (tester) async {
      const firstModalId = 'firstModal';
      const secondModalId = 'secondModal';
      await _initTestWidgets(tester, firstModalId, secondModalId);

      removeAllModals();
      await tester.pump();
      expect(find.byType(ModalEntry), findsNothing);
    });
  });
}

class TestWidget extends StatefulWidget {
  const TestWidget(
      {Key? key, required this.firstModalTag, required this.secondModalTag})
      : super(key: key);
  final String firstModalTag;
  final String secondModalTag;

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  void initState() {
    super.initState();
    showModal(ModalEntry.positioned(context,
        tag: 'firstModal',
        left: 200,
        top: 200,
        child: const SizedBox.shrink()));

    showModal(ModalEntry.positioned(context,
        tag: 'secondModal',
        left: 200,
        top: 200,
        child: const SizedBox.shrink()));
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
