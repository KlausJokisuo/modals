import 'package:flutter/material.dart';
import 'package:modals/modals.dart';

class PositionedPage extends StatelessWidget {
  const PositionedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Center(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final size = MediaQuery.of(context).size;
                      final xPosition = (size.width / 2).round().toDouble();
                      final yPosition = (size.height / 2).round().toDouble();
                      showModal(ModalEntry.positioned(context,
                          tag: 'positionedModalTag',
                          left: xPosition,
                          top: yPosition,
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.red,
                                  width: 25,
                                  height: 25,
                                ),
                                Text('X: $xPosition, Y: $yPosition')
                              ],
                            ),
                          )));
                    },
                    child: const Text('Show'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      removeModal('positionedModalTag');
                    },
                    child: const Text('Remove'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
