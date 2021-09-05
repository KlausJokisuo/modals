import 'package:flutter/material.dart';
import 'package:modals/modals.dart';

class RoutesPage extends StatelessWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 25),
          child: Text('Modal will be removed when pushing a new route'),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    showModal(ModalEntry.aligned(context,
                        tag: 'firstRouteModalTag',
                        alignment: Alignment.center,
                        removeOnPushNext: true,
                        child: Material(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                color: Colors.green,
                                width: 25,
                                height: 25,
                              ),
                              const Text('First route modal')
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const _Route()),
                    );
                  },
                  child: const Text('Next route'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Route extends StatelessWidget {
  const _Route({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Second route'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
              padding: EdgeInsets.only(top: 25),
              child: Text('Modal will be removed when popping this route')),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showModal(ModalEntry.aligned(context,
                          tag: 'secondRouteModalTag',
                          alignment: Alignment.center,
                          removeOnPop: true,
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  color: Colors.black,
                                  width: 25,
                                  height: 25,
                                ),
                                const Text('Second route modal')
                              ],
                            ),
                          )));
                    },
                    child: const Text('Show'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
