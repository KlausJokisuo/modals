import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modals/modals.dart';

void main() {
  group('position modal with ModalEntry.positioned', () {
    testWidgets('position modal to absolute position', (tester) async {
      const right = 190.0;
      const bottom = 155.0;
      const childrenHeight = 40.0;
      const childrenWidth = 40.0;

      await tester.pumpWidget(const MaterialApp(
          home: TestWidget(
              right: right,
              bottom: bottom,
              childrenHeight: childrenHeight,
              childrenWidth: childrenWidth)));
      await tester.pump();
      final modalBackgroundSize =
          tester.getRect(find.byKey(const Key('modal'))).size;

      final modalChildrenPosition =
          tester.getCenter(find.byKey(const Key('modalChildren')));

      final modalChildrenSize =
          tester.getRect(find.byKey(const Key('modalChildren'))).size;

      final exceptedDx = modalBackgroundSize.width -
          (modalChildrenPosition.dx + (modalChildrenSize.width / 2));

      final exceptedDy = modalBackgroundSize.height -
          (modalChildrenPosition.dy + (modalChildrenSize.height / 2));

      expect(Offset(exceptedDx, exceptedDy), const Offset(right, bottom));
    });
  });
}

class TestWidget extends StatefulWidget {
  const TestWidget(
      {Key? key,
      required this.right,
      required this.bottom,
      required this.childrenWidth,
      required this.childrenHeight})
      : super(key: key);

  final double right;
  final double bottom;

  final double childrenWidth;
  final double childrenHeight;

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  void initState() {
    super.initState();
    showModal(ModalEntry.positioned(
      context,
      key: const Key('modal'),
      tag: 'modalTag',
      right: widget.right,
      bottom: widget.bottom,
      child: Container(
        key: const Key('modalChildren'),
        color: Colors.yellow,
        width: widget.childrenWidth,
        height: widget.childrenHeight,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
