import 'package:flutter/material.dart';
import 'package:modals/modals.dart';

class AlignedPage extends StatelessWidget {
  const AlignedPage({Key? key}) : super(key: key);

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
                      showModal(ModalEntry.aligned(context,
                          tag: 'alignedModalTag',
                          alignment: Alignment.center,
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  color: Colors.red,
                                  width: 25,
                                  height: 25,
                                ),
                                Text(Alignment.center.toString())
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
                      removeModal('alignedModalTag');
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
