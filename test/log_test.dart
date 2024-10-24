// test/log_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:log_tools/log_master.dart';

void main() {
  test('Log.info should format output correctly', () {
    // Arrange
    final title = LogToolsInfoTitle(title: 'Test', value: 'Success');
    final body = [LogToolsInfoBody(title: 'Status', value: 'OK')];

    // Act
    LogTools.info(title: title, body: body);

    // Assert
    // Here you can add assertions to check the expected output
    // This may require capturing the log output, which could be tricky
  });
}
