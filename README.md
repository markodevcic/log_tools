
# Log Tools

A customizable Flutter package with built-in support for Dio interceptors, enabling detailed logging for network requests, responses, and errors. The package is designed to assist developers in monitoring their API interactions effectively with options to control the verbosity of logs.

**Note:** This package is specifically designed for optimal use with **VSCode**. 

While the logging functionality will still work in other IDEs, some may not fully support the color-coded ANSI escape sequences used to enhance log readability. These color codes may not render correctly in IDEs other than VSCode, leading to non-readable logs with visible escape sequences.

## Features

- Log HTTP requests and responses using Dio interceptors.
- Toggle between logging different stages: request, response, and errors.
- Customize which parts of the request or response are logged (headers, data, etc.).
- Pretty-print JSON data for easy readability.
- Optionally log requests and responses as cURL commands.
- Colored logs for better distinction between request types and errors.
- General-purpose logging with `LogTools.info()` to format and log complex lists and maps.

## Usage

### 1. Pretty-printing Complex Data with `LogTools.info()`

The `LogTools.info()` function allows you to print human-readable and formatted logs of any data in your app, making it especially useful for complex lists or maps.

```dart
LogTools.info(
  title: LogToolsInfoTitle(title: 'User Data', value: 'List of Users'),
  body: [
    LogToolsInfoBody(title: 'User 1', value: {'name': 'Alice', 'age': 30}),
    LogToolsInfoBody(title: 'User 2', value: {'name': 'Bob', 'age': 25}),
  ],
);
```

This will output:

![Pretty-Printed Log Output](https://raw.githubusercontent.com/markodevcic/log_tools/main/assets/pretty_printer_log_output.png)

### 2. Adding the Dio Interceptor to Log Network Requests

You can use the `LogToolsDioInterceptor` to log all network traffic through Dio, with options to customize the verbosity of the logs.

```dart
import 'package:dio/dio.dart';
import 'package:log_tools/log_tools.dart';

final dio = Dio();
dio.interceptors.add(LogToolsDioInterceptor(
  showRequest: true,
  showRequestCurl: true,
  showRequestData: true,
  showResponse: true,
  showResponseCurl: false,
  showResponseData: true,
  showError: true,
  showErrorData: true,
));
```

### 3. Logging Options

#### LogTools.info():
- `LogToolsInfoTitle`: The title and optional value displayed in the log header.
- `LogToolsInfoBody`: A list of key-value pairs (maps, lists, etc.) to be pretty-printed.

#### LogToolsDioInterceptor:
- `showRequest`: Logs HTTP requests.
- `showRequestCurl`: Logs the request as a cURL command.
- `showRequestData`: Logs request body data.
- `showResponse`: Logs HTTP responses.
- `showResponseCurl`: Logs the response as a cURL command.
- `showResponseData`: Logs response body data.
- `showError`: Logs any errors encountered during requests.
- `showErrorData`: Logs the data related to errors.

### Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  log_tools: ^1.0.5
```

Then, run `flutter pub get` to install the package.

## Example Output

**Request Dio Interceptor Log:**

![Log Dio Interceptor Request](https://raw.githubusercontent.com/markodevcic/log_tools/main/assets/log_dio_interceptor_request.png)

**Response Dio Interceptor Log:**

![Log Dio Interceptor Response](https://raw.githubusercontent.com/markodevcic/log_tools/main/assets/log_dio_interceptor_response.png)

## Contribution

Contributions are welcome! Feel free to open issues, submit pull requests, or suggest new features.

---

*Happy logging with beautifully formatted data!*
