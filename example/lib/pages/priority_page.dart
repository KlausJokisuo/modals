import 'package:flutter/material.dart';
import 'package:modals/modals.dart';

class PriorityPage extends StatefulWidget {
  const PriorityPage({Key? key}) : super(key: key);

  @override
  _PriorityPageState createState() => _PriorityPageState();
}

class _PriorityPageState extends State<PriorityPage> {
  final xPosition = 200.0;
  final yPosition = 200.0;

  @override
  void initState() {
    super.initState();
    showModal(ModalEntry.positioned(context,
        tag: 'firstTag',
        left: xPosition,
        top: yPosition,
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              Container(
                color: Colors.yellow,
                width: 40,
                height: 40,
              ),
              const Text('Medium priority')
            ],
          ),
        )));
  }

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
                      showModal(ModalEntry.positioned(context,
                          tag: 'secondTag',
                          left: xPosition,
                          top: yPosition,
                          aboveTag: 'firstTag',
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.red,
                                  width: 25,
                                  height: 25,
                                ),
                                const Text('Highest priority')
                              ],
                            ),
                          )));

                      showModal(ModalEntry.positioned(context,
                          tag: 'thirdTag',
                          left: xPosition,
                          top: yPosition,
                          belowTag: 'firstTag',
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.green,
                                  width: 80,
                                  height: 80,
                                ),
                                const Text('Lowest priority')
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
                      removeModal('secondTag');
                      removeModal('thirdTag');
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
