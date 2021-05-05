# flutter_animation_floating_button

This project show , how to use animation and AniamtedWidget,InheritedWidget.

##

|             App Home               |
:----------------------------------: |
| <a  target="_blank"><img src="https://user-images.githubusercontent.com/37551474/117149478-ee1a6c80-adbf-11eb-93c4-164479deac38.gif" width="250"></a>|

## Usage

```dart
 CfloatingButton(
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
    child: Icon(
    Icons.home,
    size: 30.0,
    color: Colors.white,
    ),
    onPressed: () => print('taylan'),
    actions: [
    ActionIcon(
        icon: Icons.person,
        onPressed: () => print('first action'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.black,
    ),
    ActionIcon(
        icon: Icons.settings,
        onPressed: () => print('second action'),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.orange,
    ),
    ActionIcon(
        icon: Icons.cached,
        onPressed: () => print('third action'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
    ),
  ],
),
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
