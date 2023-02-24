import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:toggle_list/src/toggle_list_controller.dart';

import 'toggle_list_data.dart';

/// Single list item with the ability to expand and shrink.
///
/// This item stores the required parameters
/// and draws itself on the screen based on them.
/// Use only as a child of [ToggleList].
class ToggleListItem extends StatefulWidget {
  /// The expandable part of the item.
  ///
  /// Only visible when [_ToggleListItemState._isExpanded] is `true`.
  /// When firstly showing the list it's original status can be set
  /// by the [isInitiallyExpanded] property.
  final Widget content;

  /// The middle component of the header.
  ///
  /// It is always visible.
  /// It is located between the [leading] and the [ToggleListData.trailing].
  final Widget title;

  /// The decoration of this item's header.
  ///
  /// Used when
  /// - item is expanded.
  final Decoration? expandedHeaderDecoration;

  /// The middle component of the expanded header.
  ///
  /// If not set, the title of an expanded item
  /// is defined by the [title] widget.
  final Widget? expandedTitle;

  /// The decoration of this item's header.
  ///
  /// Used when
  /// - item is shrunk,
  /// - item is expanded and [expandedHeaderDecoration] is not set.
  final Decoration headerDecoration;

  /// The initial status of this item.
  final bool isInitiallyExpanded;

  /// The decoration of this item.
  final Decoration itemDecoration;

  /// The leftmost component of the header.
  final Widget leading;

  /// A function which is called when this item's toggle state has changed.
  ///
  /// When specifying a single callback to be used by each and every item of
  /// the list (for example, populating the list with a generator or other build
  /// function) it is useful to know which item's state has changed. Thus the
  /// callback provides the index of the changed item as well as the flag
  /// that represents expandedness.
  ///
  /// The function should not change the item itself,
  /// as it would trigger a rebuild that leads to performance issues.
  final Function(int index, bool newValue)? onExpansionChanged;

  /// Contructs a list item to be used as a child of a [ToggleList].
  const ToggleListItem({
    Key? key,
    required this.content,
    required this.title,
    this.expandedHeaderDecoration,
    this.expandedTitle,
    this.headerDecoration = const BoxDecoration(),
    this.itemDecoration = const BoxDecoration(),
    this.isInitiallyExpanded = false,
    this.leading = const SizedBox(width: 0),
    this.onExpansionChanged,
  }) : super(key: key);

  @override
  State<ToggleListItem> createState() => _ToggleListItemState();
}

/// The state of a [ToggleListItem],
/// that stores whether it is expanded and handles it's animations.
class _ToggleListItemState extends State<ToggleListItem>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  /// A simple animation later used as a 180° turn in [trailingAnimation].
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0, end: 0.5);

  /// The controller responisble for supervising the number of
  /// expanded [ToggleListItem]s.
  ToggleListController? _listController;

  /// The controller responsible for performing animations on this
  /// [ToggleListItem].
  AnimationController? _animationController;

  /// The animation used when expanding or shrinking
  /// the [ToggleListItem.content] widget.
  late Animation<double> _heightAnimation;

  /// The animation used when rotating the [ToggleListData.trailing] widget.
  /// It is created by the chaining the [_halfTween]
  /// with the curve specified by the user in [ToggleList.curve].
  late Animation<double> _trailingAnimation;

  /// A unique identifier of this item.
  ///
  /// Used in [ToggleListController]'s functions
  /// to identify the calling [ToggleListItem] and supervising its state.
  late final UniqueKey _uniqueKey;

  /// The status of this item.
  late bool _isExpanded;

  @override
  bool get wantKeepAlive => _isExpanded;

  @override
  void initState() {
    _uniqueKey = UniqueKey();
    _isExpanded = PageStorage.of(context).readState(context) as bool? ??
        widget.isInitiallyExpanded;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var data = ToggleListData.of(context);
    _listController ??= data.listController;
    _listController!.addListener(itemStateListener);
    _animationController ??= AnimationController(
      duration: data.toggleAnimationDuration,
      vsync: this,
    );
    var userAnimation = CurveTween(curve: data.curve);
    _heightAnimation = _animationController!.drive(userAnimation);
    _trailingAnimation = _animationController!.drive(
      _halfTween.chain(userAnimation),
    );
    if (_isExpanded) {
      _animationController!.value = 1.0;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _listController!.removeListener(itemStateListener);
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: _animationController!.view,
      builder: _buildItem,
      child: widget.content,
    );
  }

  Widget _buildItem(BuildContext context, Widget? child) {
    var data = ToggleListData.of(context);
    var index = data.children.indexOf(widget);
    return Center(
      child: AutoScrollTag(
        key: _uniqueKey,
        controller: data.scrollController,
        index: index,
        child: Container(
          decoration: widget.itemDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () => _onItemTapped(context),
                child: AnimatedContainer(
                  curve: data.curve,
                  duration: data.toggleAnimationDuration,
                  decoration: _isExpanded
                      ? widget.expandedHeaderDecoration ??
                          widget.headerDecoration
                      : widget.headerDecoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.leading,
                      _isExpanded
                          ? Expanded(
                              child: widget.expandedTitle ?? widget.title,
                            )
                          : Expanded(child: widget.title),
                      _buildTrailing(context),
                    ],
                  ),
                ),
              ),
              ClipRect(
                child: Align(
                  heightFactor: _heightAnimation.value,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrailing(BuildContext context) {
    var data = ToggleListData.of(context);
    if (data.trailingExpanded != null) {
      return _isExpanded ? data.trailingExpanded! : data.trailing;
    } else {
      return RotationTransition(
        turns: _trailingAnimation,
        child: data.trailing,
      );
    }
  }

  Future<void> _onItemTapped(BuildContext context) async {
    var data = ToggleListData.of(context);
    var index = data.children.indexOf(widget);
    if (!_isExpanded) {
      data.scrollController.scrollToIndex(
        index,
        duration: data.scrollDuration,
        preferPosition: data.scrollPosition,
      );
    }
    data.listController.updateItem(_uniqueKey);
  }

  void itemStateListener() {
    var isExpanding = _listController!.checkIfExpanded(_uniqueKey);
    var didExpansionChange = isExpanding != _isExpanded;
    if (!mounted) return;
    setState(() {
      _isExpanded = isExpanding;
      if (_isExpanded) {
        _animationController!.forward();
      } else {
        _animationController!.reverse().then<void>(
          (value) {
            if (!mounted) return;
            setState(() {});
          },
        );
      }
      PageStorage.of(context).writeState(context, _isExpanded);
    });
    var index = ToggleListData.of(context).children.indexOf(widget);
    if (didExpansionChange) widget.onExpansionChanged?.call(index, _isExpanded);
  }
}
