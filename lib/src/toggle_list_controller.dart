import 'package:flutter/material.dart';
import 'utils.dart';

/// This controller supervises the state of the individual list items.
///
/// Besides managing the expansion and shrinkage of the items,
/// it enforces the remaining expanded items policy specified by the user
/// in [sectionsLeftExpanded].
class ToggleListController extends ChangeNotifier {
  /// The list of currently expanded items.
  List<UniqueKey> expandedItems = [];

  /// The policy of automatically shrink items.
  final Sections sectionsLeftExpanded;

  /// Creates a controller for supervising the list items.
  ToggleListController({required this.sectionsLeftExpanded});

  /// Toggles the expansion state of an item.
  void updateItem(UniqueKey key) {
    if (expandedItems.contains(key)) {
      expandedItems.remove(key);
    } else {
      expandedItems.add(key);
      if (sectionsLeftExpanded == Sections.last) {
        expandedItems.removeRange(0, expandedItems.length - 1);
      }
    }
    notifyListeners();
  }

  /// Sets the initial state of the item to expanded.
  void setInitiallyExpandedItem(UniqueKey key) {
    expandedItems.add(key);
    if (sectionsLeftExpanded == Sections.last) {
      expandedItems.removeRange(0, expandedItems.length - 1);
    }
  }

  /// Returns the expansion status of an item.
  bool checkIfExpanded(UniqueKey key) {
    return expandedItems.contains(key);
  }
}
