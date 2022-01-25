![Logo](https://github.com/BinaryBush/binarybush.dev/blob/main/assets/banner.png)

An easy-to-use and highly customizable expandable list widget for your Flutter application.

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/binarybush/toggle_list?sort=semver) ![GitHub](https://img.shields.io/github/license/binarybush/toggle_list?label=license) ![Lines of code](https://img.shields.io/tokei/lines/github/binarybush/toggle_list)

> This package is not yet widely tested.
> 
> Use it with caution and [file any potential issues you see](https://github.com/BinaryBush/toggle_list/issues/new/choose).

<span><img src="https://user-images.githubusercontent.com/50302858/150950690-076b7560-8b8f-4fba-b9c2-0350749abbe7.gif" style="width:250px;"/></span>
<span><img src="https://user-images.githubusercontent.com/50302858/150950727-0725106d-970b-4618-9db8-e4faec9c030a.gif" style="width:250px;"/></span>

## Installation

### Via command line
```
flutter pub add toggle_list
```
### Manually
Add the following line to your pubspec.yaml file.
```yaml
dependencies:
  toggle_list: ^0.1.0
```
Then either save the file or use the `flutter pub run` command.

### Import
```dart
import 'package:toggle_list/toggle_list.dart';
```
    
## Usage 
```dart
return Scaffold(
  body: ToggleList(
    children: [
      ToggleListItem(
        title: const Text('I am the first item'),
        content: const Padding(
          padding: EdgeInsets.all(20),
          child: Text('Hello there!'),
        ),
      ),
      ToggleListItem(
        title: const Text('I am the second item'),
        content: const Padding(
          padding: EdgeInsets.all(20),
          child: Text('I am delighted that you are here.'),
        ),
      ),
      ToggleListItem(
        title: const Text('I am the third item'),
        content: const Padding(
          padding: EdgeInsets.all(20),
          child: Text('Have a wonderful day!'),
        ),
      ),
    ],
  ),
);
```

For a more detailed use case, check out the [example directory](https://github.com/binarybush/toggle_list/tree/main/example).

## Contributing
Contributions of any kind are always welcome!

As of now, we don't have a standardized way for contributions. For this reason, if you would like to help us with your coding, feel free to send an email to [contact@binarybush.dev](mailto:contact@binarybush.dev).

## Metadata
:green_book: [Doucumentation](https://pub.dev/documentation/toggle_list/latest/). 

:email: [contact@binarybush.dev](mailto:contact@binarybush.dev)

:bug: [Bug report](https://github.com/BinaryBush/toggle_list/issues/new?assignees=&labels=bug%2Ctriage&template=1_bug.yaml)

:zap: [Requesting features](https://github.com/BinaryBush/toggle_list/issues/new?assignees=&labels=new-feature&template=2_feature_request.yaml)

Every opened issue is very much appreciated!
