/// A structure that contains the closing policies for items.
///
/// The policies control what should happen when a user expands an item
/// and another item(s) were already expanded.
enum Sections {
  /// Allows all items to remain expanded.
  all,

  /// Allows the last opened item to be expanded and shrink
  /// all other items automatically.
  last,
}
