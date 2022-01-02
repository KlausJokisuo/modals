import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modals/modals.dart';

void main() {
  Future<void> _initTestWidgets(WidgetTester tester, String firstModalTag,
      String secondModalTag, String thirdModalTag) async {
    await tester.pumpWidget(MaterialApp(
        home: TestWidget(
            firstModalTag: firstModalTag,
            secondModalTag: secondModalTag,
            thirdModalTag: thirdModalTag)));

    await tester.pump();
  }

  group('remove modals', () {
    const firstModalId = 'firstModal';
    const secondModalId = 'secondModal';
    const thirdModalId = 'thirdModalTag';

    testWidgets('remove modal by id', (tester) async {
      await _initTestWidgets(tester, firstModalId, secondModalId, thirdModalId);
      removeModal(firstModalId);
      await tester.pump();
      expect(find.byType(ModalEntry), findsNWidgets(2));
    });

    testWidgets('remove all modals', (tester) async {
      await _initTestWidgets(tester, firstModalId, secondModalId, thirdModalId);
      removeAllModals();
      await tester.pump();
      expect(find.byType(ModalEntry), findsNothing);
    });

    testWidgets('remove modal by tapping barrier', (tester) async {
      await _initTestWidgets(tester, firstModalId, secondModalId, thirdModalId);
      await tester.tapAt(const Offset(10.0, 10.0));
      await tester.pump();
      expect(find.byType(ModalEntry), findsNWidgets(2));
    });
  });
}

class TestWidget extends StatefulWidget {
  const TestWidget(
      {Key? key,
      required this.firstModalTag,
      required this.secondModalTag,
      required this.thirdModalTag})
      : super(key: key);
  final String firstModalTag;
  final String secondModalTag;
  final String thirdModalTag;

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  void initState() {
    super.initState();
    showModal(ModalEntry.positioned(context,
        tag: widget.firstModalTag,
        left: 200,
        top: 200,
        child: const SizedBox.shrink()));

    showModal(ModalEntry.positioned(context,
        tag: widget.secondModalTag,
        left: 200,
        top: 200,
        child: const SizedBox.shrink()));

    showModal(ModalEntry.positioned(context,
        tag: 'thirdModalTag',
        left: 200,
        top: 200,
        barrierDismissible: true,
        child: const SizedBox.shrink()));
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
