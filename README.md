<div align="center">

# Modals


<p align="center">
<img src="https://raw.githubusercontent.com/KlausJokisuo/modals/master/assets/modals_icon.png" height="100" alt="Modals" />
</p>

_Flutter overlays simplified_!
</div>

## Motivation

Working with Flutter overlays is quite cumbersome. Adding a simple context menu next to your button should not be hard.

Say hello&nbsp;👋 &nbsp;to **Modals**, a package to simplify all your _overlay_ needs!

## Features

* Show and remove modals easily
* Show modals using absolute position
* Position modals based on another widget position
* Prioritise modal visibility
* Remove modals on Pop and Push


## How to use

### Showing modals
`showModal` is used to show modals. Function accepts a `ModalEntry` as parameter.
`ModalEntry` has two options `ModalEntry.positioned` and `ModalEntry.anchored`

#### Positioned
```dart
class PositionedModalExample extends StatelessWidget {
  const PositionedModalExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showModal(ModalEntry.positioned(context,
                  tag: 'containerModal',
                  left: 200,
                  top: 200,
                  child: Container(
                    color: Colors.red,
                    width: 50,
                    height: 50,
                  )));
        },
        child: const Text('Show Modal'),
      ),
    );
  }
}
```

Above example positions your `widget` to wanted position.

#### Anchored

```dart

class AnchoredModalExample extends StatelessWidget {
  const AnchoredModalExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const ModalAnchor(
                  tag: 'anchor',
                  child: Card(
                    color: Colors.grey,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.anchor),
                    ),
                  )),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  showModal(ModalEntry.anchored(context,
                          tag: 'anchoredModal',
                          anchorTag: 'anchor',
                          modalAlignment: Alignment.centerLeft,
                          anchorAlignment: Alignment.centerRight,
                          child: Container(
                            color: Colors.red,
                            width: 50,
                            height: 50,
                          )));
                },
                child: const Text('Show Modal'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

Above example positions `widget` at next to `ModalAnchor widget`.

_To make widget act as an anchor, wrap widget with `ModalAnchor` widget._

### Removing modals

You have 2 options to remove modals

`removeModal(String id)` removes modal by the given id

`removeAllModals()` removes all modals

### Prioritising modals

To prioritise modals, use `aboveTag` and `belowTag` parameters.

* `aboveTag`
  * Modal will be positioned just above given `aboveTag`


* `belowTag`
  * Modal will be positioned just above given `belowTag`


### Using removeOnPop and removeOnPushNext

To remove modal on route change, you need to add navigator observer to your root widget.

````dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppModals',
      navigatorObservers: [RouteObserver<ModalRoute<dynamic>>()], // <- This line here
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _Home(),
    );
  }
}
````

* `removeOnPop`
  * The modal is removed when route is popped where the modal exists

* `removeOnPushNext`
  * The modal is removed when new route is pushed on top of the route where the modal exists





See the [Examples](https://github.com/KlausJokisuo/modals/tree/master/example) for more information