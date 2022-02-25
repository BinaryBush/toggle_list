import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:toggle_list/src/toggle_list_controller.dart';
import 'package:toggle_list/src/toggle_list_data.dart';
import 'toggle_list_item.dart';
import 'utils.dart';

/// A list that lays out its toggleable children.
///
/// This widget is also responsible for scrolling properties,
/// list animations, and the number of expanded items.
class ToggleList extends StatefulWidget {
  /// A list of [ToggleListItem] widgets that are managed and drawn on the screen.
  final List<ToggleListItem> children;

  /// The curve of toggle animations.
  ///
  /// Used to animate the height of the [ToggleListItem.content] widget
  /// and the rotation of the [trailing] widget,
  /// when [trailingExpanded] is not set.
  final Curve curve;

  /// A widget between each adjacent list item
  /// that visually seperates them.
  final Widget divider;

  /// Specifies whether [trailing] flips automatically when toggled.
  ///
  /// If [trailingExpanded] is set this is ignored.
  final bool flipTrailingOnToggle;

  /// The padding between the set of elements
  /// and the outer boundary of the list.
  ///
  /// Used when
  /// - [ToggleListItem]s need to be narrower
  /// than the width of the [ToggleList],
  /// - the scrollbar covers the [ToggleListItem]s.
  ///
  /// Use it with caution as setting the upper and lower padding will make
  /// the scrollable space shorter than the scrollbar's height.
  final EdgeInsets innerPadding;

  /// The direction in which the list can be scrolled.
  final Axis scrollDirection;

  /// The duration of the animation with which the item is
  /// scrolled to its position when expanded.
  final Duration scrollDuration;

  /// The scrolling physics determine how the list responds to scrolling.
  final ScrollPhysics scrollPhysics;

  /// The end position of the animation in which the item is
  /// scrolled to its position when expanded.
  final AutoScrollPosition scrollPosition;

  /// Item closing policy for the list.
  ///
  /// See [Sections] for more details on the policies.
  final Sections sectionsLeftExpanded;

  /// Specifies whether the list should shrink wrap.
  ///
  /// If set to `true` the list will take up only the space required
  /// in the [scrollDirection].
  /// If set to `false` the list will expand to the maximum size allowed
  /// in the [scrollDirection].
  final bool shrinkWrap;

  /// The duration of the animation with which the item is
  /// expanded and shurnk.
  final Duration toggleAnimationDuration;

  /// The rightmost component of the header.
  ///
  /// Used to visually display the toggle state of the item.
  /// It is visible when:
  /// - the item is shrunk,
  /// - the item is expanded and [trailingExpanded] is not set, in which case
  /// the widget is modified based on the [flipTrailingOnToggle] flag.
  final Widget trailing;

  /// The rightmost component of the header when the item is expanded.
  ///
  /// If not set, the trailing of an expanded item is based
  /// on the [trailing] widget and the [flipTrailingOnToggle] flag.
  final Widget? trailingExpanded;

  /// The additional padding of the viewport.
  ///
  /// Used when a part of the viewport is covered (by a bottom navigation bar
  /// or an app bar).
  /// Set this to prevent animations from ending beneath these elements.
  final EdgeInsets viewPadding;

  /// Constructs a toggle list, that holds [ToggleListItem]s.
  ///
  /// The constructor contains parameters that controls
  /// the behaviour and appearance of the list itself,
  /// as well as parameters that apply to all items in the list.
  const ToggleList({
    Key? key,
    required this.children,
    this.curve = Curves.easeIn,
    this.divider = const SizedBox(height: 20),
    this.flipTrailingOnToggle = true,
    this.innerPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.toggleAnimationDuration = const Duration(milliseconds: 500),
    this.sectionsLeftExpanded = Sections.last,
    this.scrollDirection = Axis.vertical,
    this.scrollDuration = const Duration(milliseconds: 500),
    this.scrollPosition = AutoScrollPosition.begin,
    this.scrollPhysics = const AlwaysScrollableScrollPhysics(),
    this.shrinkWrap = false,
    this.trailing = const Icon(Icons.expand_more),
    this.trailingExpanded,
    this.viewPadding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  State<ToggleList> createState() => _ToggleListState();
}

class _ToggleListState extends State<ToggleList> {
  late final AutoScrollController _scrollController;
  late final ToggleListController _listController;
  @override
  void initState() {
    _scrollController = AutoScrollController(
      viewportBoundaryGetter: () {
        return Rect.fromLTRB(
          widget.viewPadding.left,
          widget.viewPadding.top,
          widget.viewPadding.right,
          widget.viewPadding.bottom,
        );
      },
      axis: widget.scrollDirection,
    );
    _listController =
        ToggleListController(sectionsLeftExpanded: widget.sectionsLeftExpanded);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      interactive: true,
      isAlwaysShown: false,
      child: Padding(
        padding: widget.innerPadding,
        child: ListView.separated(
          cacheExtent: MediaQuery.of(context).size.height * 2,
          controller: _scrollController,
          itemCount: widget.children.length,
          scrollDirection: widget.scrollDirection,
          physics: widget.scrollPhysics,
          shrinkWrap: widget.shrinkWrap,
          separatorBuilder: (context, index) => widget.divider,
          itemBuilder: (context, index) {
            return ToggleListData(
              child: widget.children[index],
              children: widget.children,
              curve: widget.curve,
              listController: _listController,
              scrollController: _scrollController,
              flipTrailingOnToggle: widget.flipTrailingOnToggle,
              toggleAnimationDuration: widget.toggleAnimationDuration,
              scrollDuration: widget.scrollDuration,
              scrollPosition: widget.scrollPosition,
              trailing: widget.trailing,
              trailingExpanded: widget.trailingExpanded,
            );
          },
        ),
      ),
    );
  }
}
