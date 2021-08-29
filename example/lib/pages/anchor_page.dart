import 'package:flutter/material.dart';
import 'package:modals/modals.dart';

class AnchorPage extends StatelessWidget {
  const AnchorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const AnchorWidget(),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  showModal(ModalEntry.anchored(context,
                      tag: 'anchoredModalTag',
                      anchorTag: 'anchorTag',
                      modalAlignment: Alignment.centerLeft,
                      anchorAlignment: Alignment.centerRight,
                      child: const _Menu(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Item 1'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Item 2'),
                          ),
                        ],
                      )));
                },
                child: const Text('Show context menu modal'),
              ),
              const Text('Anchor is draggable')
            ],
          ),
        ),
      ],
    );
  }
}

class AnchorWidget extends StatefulWidget {
  const AnchorWidget({Key? key}) : super(key: key);

  @override
  _AnchorWidgetState createState() => _AnchorWidgetState();
}

class _AnchorWidgetState extends State<AnchorWidget> {
  double xPosition = 0;
  double yPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: xPosition,
      top: yPosition,
      child: ModalAnchor(
          tag: 'anchorTag',
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                xPosition += details.delta.dx;
                yPosition += details.delta.dy;
              });
            },
            child: const Card(
              color: Colors.grey,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.anchor),
              ),
            ),
          )),
    );
  }
}

class _Menu extends StatefulWidget {
  const _Menu({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;

  @override
  __MenuState createState() => __MenuState();
}

class __MenuState extends State<_Menu> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 550),
    vsync: this,
  )..forward();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ...widget.children,
              InkWell(
                  onTap: () async {
                    await _controller.reverse();
                    removeModal('anchoredModalTag');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Close'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
