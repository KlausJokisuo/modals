import 'package:flutter/material.dart';

enum _ModalEntryType { positioned, aligned, anchored }

class _Leader {
  const _Leader(this.layerlink, this.followers);

  final LayerLink layerlink;
  final List<String> followers;

  @override
  String toString() {
    return '_Leader{layerlink: $layerlink, followers: $followers}';
  }
}

final _routeObserverError = FlutterError.fromParts(<DiagnosticsNode>[
  ErrorSummary('RouteObserver was not found on given context'),
  ErrorDescription(
    'If removeOnPop or removeOnPushNext are used, then routeObserver must be set.\n'
    'For more information please refer to https://api.flutter.dev/flutter/widgets/RouteObserver-class.html',
  )
]);

final Map<String?, OverlayEntry> _modalsMap = {};
final Map<String, _Leader> _anchorMap = {};
RouteObserver<ModalRoute>? _routeObserver;

void showModal(ModalEntry modalEntry) {
  final context = modalEntry.context;

  if (modalEntry.removeOnPop || modalEntry.removeOnPushNext) {
    final widgetsApp = context.findAncestorWidgetOfExactType<WidgetsApp>();

    if (widgetsApp == null) {
      throw _routeObserverError;
    }

    final navigatorObservers = widgetsApp.navigatorObservers ?? [];

    if (navigatorObservers.isEmpty) {
      throw _routeObserverError;
    }

    try {
      _routeObserver =
          navigatorObservers.firstWhere((navigatorObserver) => navigatorObserver is RouteObserver)
              as RouteObserver<ModalRoute>?;
    } catch (e) {
      throw _routeObserverError;
    }
  }

  final overlayState = Overlay.of(context, rootOverlay: true);
  final overlayEntry = OverlayEntry(builder: (BuildContext context) => modalEntry);

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (_modalsMap.containsKey(modalEntry.tag)) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('There are multiple modal entries that share the same tag'),
        ErrorDescription(
          'Each ModalEntry must have a unique non-null tag.\n'
          'In this case, multiple modal entries had the following tag: ${modalEntry.tag}',
        )
      ]);
    }

    final above = _modalsMap[modalEntry.aboveTag];
    final below = _modalsMap[modalEntry.belowTag];

    overlayState!.insert(overlayEntry, above: above, below: below);
    _modalsMap.putIfAbsent(modalEntry.tag, () => overlayEntry);
  });
}

void removeModal(String id) {
  final overlay = _modalsMap[id];
  if (overlay != null) {
    overlay.remove();
    _modalsMap.remove(id);
  }
}

void removeAllModals() {
  for (final modal in _modalsMap.values) {
    modal.remove();
  }
  _modalsMap.clear();
}

class ModalEntry extends StatefulWidget {
  const ModalEntry.positioned(
    this.context, {
    Key? key,
    required this.tag,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.aboveTag,
    this.belowTag,
    this.removeOnPop = false,
    this.removeOnPushNext = false,
    this.barrierDismissible = false,
    this.barrierColor = Colors.transparent,
    this.onRemove,
    required this.child,
  })  : offset = Offset.zero,
        anchorTag = null,
        anchorAlignment = Alignment.center,
        modalAlignment = Alignment.center,
        alignment = Alignment.center,
        _modalEntryType = _ModalEntryType.positioned,
        assert(left == null || right == null),
        assert(top == null || bottom == null),
        assert(aboveTag == null || belowTag == null),
        super(key: key);

  const ModalEntry.aligned(
    this.context, {
    Key? key,
    required this.tag,
    required this.alignment,
    this.aboveTag,
    this.belowTag,
    this.anchorAlignment = Alignment.center,
    this.modalAlignment = Alignment.center,
    this.offset = Offset.zero,
    this.removeOnPop = false,
    this.removeOnPushNext = false,
    this.barrierDismissible = false,
    this.barrierColor = Colors.transparent,
    this.onRemove,
    required this.child,
  })  : left = null,
        top = null,
        right = null,
        bottom = null,
        anchorTag = null,
        _modalEntryType = _ModalEntryType.aligned,
        assert(aboveTag == null || belowTag == null),
        super(key: key);

  const ModalEntry.anchored(
    this.context, {
    Key? key,
    required this.tag,
    this.aboveTag,
    this.belowTag,
    required this.anchorTag,
    this.anchorAlignment = Alignment.center,
    this.modalAlignment = Alignment.center,
    this.offset = Offset.zero,
    this.removeOnPop = false,
    this.removeOnPushNext = false,
    this.barrierDismissible = false,
    this.barrierColor = Colors.transparent,
    this.onRemove,
    required this.child,
  })  : left = 0,
        top = null,
        right = null,
        bottom = 0,
        alignment = Alignment.center,
        _modalEntryType = _ModalEntryType.anchored,
        assert(aboveTag == null || belowTag == null),
        super(key: key);

  final BuildContext context;

  /// Unique tag for [ModalEntry]
  final String tag;

  /// [ModalEntry] will be positioned just above given aboveTag [ModalEntry]
  final String? aboveTag;

  /// [ModalEntry] will be positioned just above given belowTag [ModalEntry]
  final String? belowTag;

  /// [child] widget which will be shown as modal
  final Widget child;

  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  final Alignment alignment;

  /// The additional offset to apply to the [ModalEntry] position
  final Offset offset;

  /// The [ModalAnchor] tag on this widget tree that will act as an anchor for the [ModalEntry]
  final String? anchorTag;

  /// The anchor point on the given [ModalAnchor] that [ModalEntry] will line up with.
  ///
  /// Defaults to [Alignment.center].
  final Alignment anchorAlignment;

  /// The anchor point on this widget that will line up with [ModalAnchor]
  ///
  /// Defaults to [Alignment.center].
  final Alignment modalAlignment;

  /// Remove [ModalEntry] on pop
  final bool removeOnPop;

  /// Remove [ModalEntry] on push
  final bool removeOnPushNext;

  /// Modal barrier color
  final Color barrierColor;

  /// Remove [ModalEntry] on tapping the barrier
  final bool barrierDismissible;

  /// Callback function on [ModalEntry] removal
  final VoidCallback? onRemove;

  final _ModalEntryType _modalEntryType;

  @override
  ModalEntryState createState() => ModalEntryState();
}

class ModalEntryState extends State<ModalEntry> with RouteAware {
  LayerLink? link;

  @override
  void initState() {
    super.initState();
    if (widget.anchorTag != null) {
      if (!_anchorMap.containsKey(widget.anchorTag)) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('Unable to find ModalAnchor with given anchorTag'),
          ErrorDescription(
            'ModalAnchor must be visible before showing ModalEntry.\n'
            'Make sure that ModalAnchor is visible and ModalEntry is using correct anchorTag. Given anchorTag was: ${widget.anchorTag}',
          )
        ]);
      }
      link = _anchorMap[widget.anchorTag]!.layerlink;
      _anchorMap[widget.anchorTag]!.followers.add(widget.tag);
    }

    _routeObserver?.subscribe(this, ModalRoute.of(widget.context) as PageRoute);
  }

  @override
  void dispose() {
    _routeObserver?.unsubscribe(this);
    remove();
    super.dispose();
  }

  void remove() {
    if (mounted) {
      if (widget.onRemove != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onRemove!();
        });
      }
      removeModal(widget.tag);
    }
  }

  @override
  void didPop() {
    if (widget.removeOnPop) {
      remove();
    }
  }

  @override
  void didPushNext() {
    if (widget.removeOnPushNext) {
      remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            ignoring: !widget.barrierDismissible,
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => remove(),
                child: ColoredBox(color: widget.barrierColor)),
          ),
        ),
        if (widget._modalEntryType == _ModalEntryType.positioned)
          Positioned(
            top: widget.top,
            left: widget.left,
            bottom: widget.bottom,
            right: widget.right,
            child: widget.child,
          )
        else if (widget._modalEntryType == _ModalEntryType.aligned)
          Align(
            alignment: widget.alignment,
            child: widget.child,
          )
        else if (widget._modalEntryType == _ModalEntryType.anchored)
          Positioned(
            top: widget.top,
            left: widget.left,
            bottom: widget.bottom,
            right: widget.right,
            child: CompositedTransformFollower(
              link: link!,
              showWhenUnlinked: false,
              offset: widget.offset,
              targetAnchor: widget.anchorAlignment,
              followerAnchor: widget.modalAlignment,
              child: widget.child,
            ),
          )
      ],
    );
  }
}

class ModalAnchor extends StatefulWidget {
  const ModalAnchor({Key? key, required this.tag, required this.child}) : super(key: key);

  /// Unique tag for [ModalAnchor]
  final String tag;
  final Widget child;

  @override
  _ModalAnchorState createState() => _ModalAnchorState();
}

class _ModalAnchorState extends State<ModalAnchor> {
  final link = _Leader(LayerLink(), []);

  @override
  void initState() {
    super.initState();
    if (_anchorMap.containsKey(widget.tag)) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('There are multiple modal anchors that share the same tag'),
        ErrorDescription(
          'Each ModalAnchor must have a unique non-null tag.\n'
          'In this case, multiple modal anchors had the following tag: ${widget.tag}',
        )
      ]);
    }
    _anchorMap.putIfAbsent(widget.tag, () => link);
  }

  @override
  void dispose() {
    for (final follower in _anchorMap[widget.tag]!.followers) {
      _modalsMap.remove(follower);
    }

    _anchorMap.remove(widget.tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: link.layerlink,
      child: widget.child,
    );
  }
}
