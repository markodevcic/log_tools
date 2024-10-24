/// A utility class for logging information titles and bodies.
///
/// This file contains classes that represent the structure of log information,
/// allowing for organized and formatted log entries.
class LogToolsInfoTitle {
  /// The title of the log entry.
  final String title;

  /// An optional value associated with the title.
  final String? value;

  /// Creates a [LogToolsInfoTitle] with the given [title] and optional [value].
  LogToolsInfoTitle({required this.title, this.value});
}

/// A class representing the body of log information.
///
/// This is used to encapsulate additional details for log entries.
class LogToolsInfoBody {
  // An optional title for the log body.
  final String? title;

  /// The value of the log body, which can be of any type.
  final dynamic value;

  /// Creates a [LogToolsInfoBody] with the given optional [title] and required [value].
  LogToolsInfoBody({this.title, required this.value});
}
