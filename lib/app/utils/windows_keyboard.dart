import 'dart:ffi';
import 'dart:io';

final DynamicLibrary user32 = DynamicLibrary.open('user32.dll');

class WindowsKeyboard {
  Map<String, dynamic> vkMap = {
    'play_pause': 0xB3,
    'lwin': 0x5B,
    'lalt': 0xA4,
    'tab': 0x09,
    'lcontrol': 0xA2,
    'a': 0x61,
    'b': 0x62,
    'c': 0x63,
    'd': 0x64,
    'e': 0x65,
    'f': 0x66,
    'g': 0x67,
    'h': 0x68,
    'i': 0x69,
    'j': 0x6A,
    'k': 0x6B,
    'l': 0x6C,
    'm': 0x6D,
    'n': 0x6E,
    'o': 0x6F,
    'p': 0x70,
    'q': 0x71,
    'r': 0x72,
    's': 0x73,
    't': 0x74,
    'u': 0x75,
    'v': 0x76,
    'w': 0x77,
    'x': 0x78,
    'y': 0x79,
    'z': 0x7A,
  };
  void keyEvent(int keyCode, int keyEvent) {
    user32.lookupFunction<Void Function(Uint8, Uint16, Uint32, Pointer), void Function(int, int, int, Pointer)>('keybd_event')(
      keyCode,
      0,
      keyEvent,
      nullptr,
    );
  }

  void pressPlayPause() {
    if (Platform.isWindows) {
      keyEvent(vkMap['play_pause'], 0);
      keyEvent(vkMap['play_pause'], 2);
    } else {
      print('This feature is only supported on Windows.');
    }
  }

  void pressAltTab() async {
    keyEvent(vkMap['lalt'], 0);
    await Future.delayed(Duration(milliseconds: 50));
    keyEvent(vkMap['tab'], 0);
    await Future.delayed(Duration(milliseconds: 50));
    keyEvent(vkMap['tab'], 2);
    await Future.delayed(Duration(milliseconds: 50));
    keyEvent(vkMap['lalt'], 2);
    await Future.delayed(Duration(milliseconds: 50));
  }

  void pressWindows() async {
    if (Platform.isWindows) {
      keyEvent(vkMap['lwin'], 0);
      keyEvent(vkMap['lwin'], 2);
      await Future.delayed(Duration(seconds: 1));
      keyEvent(vkMap['r'], 0);
      keyEvent(vkMap['r'], 2);
    } else {
      print('This feature is only supported on Windows.');
    }
  }

  void pressCome(args) {
    
  }

  void paste() async {
    keyEvent(vkMap['lcontrol'], 0);
    keyEvent(vkMap['v'], 0);
    // await Future.delayed(const Duration(seconds: 1));
    keyEvent(vkMap['lcontrol'], 2);
    keyEvent(vkMap['v'], 2);
  }

  // static void pressKeyR() {
  //   if (Platform.isWindows) {
  //     pressKey(VK_R);
  //   } else {
  //     print('This feature is only supported on Windows.');
  //   }
  // }
}
