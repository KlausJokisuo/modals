import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modals/modals.dart';

void main() {
  group('show anchored', () {
    testWidgets('show anchored modal using gesture', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: TestWidget()));
      await tester.tap(find.byKey(
        const Key('showModalButton'),
      ));
      await tester.pumpAndSettle();

      final modalAnchorChildrenPosition =
          tester.getCenter(find.byKey(const Key('modalAnchorChildren')));

      final modalChildrenPosition =
          tester.getCenter(find.byKey(const Key('modalChildren')));

      expect(modalChildrenPosition, modalAnchorChildrenPosition);
    });
  });
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ModalAnchor(
            tag: 'modalAnchor',
            child: Container(
              key: const Key('modalAnchorChildren'),
              color: Colors.green,
              width: 200,
              height: 200,
            )),
        GestureDetector(
          key: const Key('showModalButton'),
          onTap: () {
            showModal(ModalEntry.anchored(context,
                key: const Key('firstModal'),
                tag: 'firstModal',
                anchorTag: 'modalAnchor',
                child: Container(
                    key: const Key('modalChildren'),
                    color: Colors.black,
                    width: 50,
                    height: 50)));
          },
          child: Container(
            color: Colors.red,
            height: 50,
            width: 50,
          ),
        ),
      ],
    );
  }
}
