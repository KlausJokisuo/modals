import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modals/modals.dart';

void main() {
  group('position modal with ModalEntry.aligned', () {
    testWidgets('position modal to center of the screen', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(480, 800);
      tester.binding.window.devicePixelRatioTestValue = 1;

      await tester.pumpWidget(const MaterialApp(home: TestWidget()));
      await tester.pump();

      final modalChildrenPosition =
          tester.getCenter(find.byKey(const Key('modalChildren')));

      final screenCenterDx = tester.binding.window.physicalSize.width / 2;
      final screenCenterDy = tester.binding.window.physicalSize.height / 2;

      expect(modalChildrenPosition, Offset(screenCenterDx, screenCenterDy));
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
    showModal(ModalEntry.aligned(
      context,
      key: const Key('modal'),
      tag: 'modalTag',
      alignment: Alignment.center,
      child: Container(
        key: const Key('modalChildren'),
        color: Colors.yellow,
        width: 10,
        height: 10,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
