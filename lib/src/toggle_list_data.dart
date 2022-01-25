import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:toggle_list/src/toggle_list_controller.dart';
import 'package:toggle_list/src/toggle_list_item.dart';

/// An [InheritedWidget] storing the parameters of the list that are
/// visible for the list items.
class ToggleListData extends InheritedWidget {
  final List<ToggleListItem> children;
  final Curve curve;
  final bool flipTrailingOnToggle;
  final ToggleListController listController;
  final Duration toggleAnimationDuration;
  final AutoScrollController scrollController;
  final Duration scrollDuration;
  final AutoScrollPosition scrollPosition;
  final Widget trailing;
  final Widget? trailingExpanded;

  const ToggleListData({
    Key? key,
    required Widget child,
    required this.children,
    required this.curve,
    required this.flipTrailingOnToggle,
    required this.listController,
    required this.toggleAnimationDuration,
    required this.scrollController,
    required this.scrollDuration,
    required this.scrollPosition,
    required this.trailing,
    this.trailingExpanded,
  }) : super(key: key, child: child);

  static ToggleListData of(BuildContext context) {
    var result = context.dependOnInheritedWidgetOfExactType<ToggleListData>();
    assert(result != null, 'No ToggleListData found in context.');
    return result!;
  }

  @override
  bool updateShouldNotify(ToggleListData oldWidget) {
    return (children != oldWidget.children ||
        curve != oldWidget.curve ||
        flipTrailingOnToggle != oldWidget.flipTrailingOnToggle ||
        listController != oldWidget.listController ||
        toggleAnimationDuration != oldWidget.toggleAnimationDuration ||
        scrollController != oldWidget.scrollController ||
        scrollDuration != oldWidget.scrollDuration ||
        scrollPosition != oldWidget.scrollPosition ||
        trailing != oldWidget.trailing ||
        trailingExpanded != oldWidget.trailingExpanded);
  }
}
