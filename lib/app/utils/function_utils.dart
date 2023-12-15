import 'dart:convert';
import 'dart:developer' as dev;

import 'package:get/get.dart';
import 'package:process_run/cmd_run.dart';

import '../../helpers/saweria_message_helper.dart';
import 'environment.dart';

void logKey([key, content]) {
  String finalLog = '';
  dynamic tempContent = content ?? key;
  if (tempContent is Map || tempContent is List) {
    try {
      finalLog = json.encode(tempContent);
    } catch (e) {
      finalLog = tempContent.toString();
    }
  } else if (tempContent is String) {
    finalLog = tempContent;
  } else {
    finalLog = tempContent.toString();
  }

  if (content != null) {
    dev.log('$key => $finalLog');
  } else {
    dev.log(finalLog);
  }
}

dynamic runCommand({bool isPython3 = false, required String pyautoguiCommand}) {
  String pathCommand = '';
  if (isPython3) {
    pathCommand += 'python3 -c "import pyautogui;"';
  } else {
    pathCommand += 'python -c "import pyautogui;"';
  }
  pathCommand = pathCommand.replaceRange(pathCommand.length - 2, pathCommand.length - 1, '; $pyautoguiCommand');
  logKey('pathCommand', pathCommand);
  return run(pathCommand);
}

dynamic startNgrok({required String url, required String ip, required String port}) async {
  // return run('ngrok http 192.168.0.2:7070 --log-format=json --log=stdout');
  // "ngrok", "http", "--domain=turkey-amazed-regularly.ngrok-free.app", "192.168.0.2:7070"
  final res = await run(
    // 'ngrok http --domain=turkey-amazed-regularly.ngrok-free.app 192.168.0.2:7070 --log-format=json --log=stdout',
    'ngrok http --domain=$url $ip:$port --log-format=json --log=stdout',
    onProcess: (process) async {
      logKey('startNgrok', process.pid);
    },
  ).catchError(
    (a) async {
      logKey('catchError');
      Get.snackbar(
        'Error',
        // 'Ngrok Error, please stop on NGROK dashboard\nthen restart again',
        'Ngrok is already running'
      );
      return a;
    },
  );
  logKey('res', res);
  return res;
}

String tuyaInit() {
  return "import tinytuya; lampu_kamar = tinytuya.BulbDevice('$lampu_kamar_device_id', '$lampu_kamar_ip', '$lampu_kamar_local_key', version=3.3);";
}

void dropWeapon(bool valorantMode) async {
  if (!valorantMode) {
    return;
  }
  var commandString = "pyautogui.press('1'); pyautogui.press('g');";
  runCommand(pyautoguiCommand: commandString);
}

void allChat(String message, bool valorantMode) async {
  // logKey('masuk allchat', valorantMode.value);
  var msg = message;
  var chat = msg.split(SaweriaMessageHelper.TXT).last;

  if (!valorantMode) {
    return;
  }
  // var commandString = "pyautogui.press('enter'); pyautogui.write('$chat'); pyautogui.hotkey('shift','enter'); pyautogui.press('enter');";
  var commandString =
      " pyautogui.hotkey('shiftright','enter', inverval=0.25);pyautogui.hotkey('shiftright','enter'); pyautogui.write('$chat'); pyautogui.press('enter');";
  // var commandString = "pyautogui.keyDown('shift'); pyautogui.press('enter'); pyautogui.keyUp('shift'); pyautogui.write('$chat');  pyautogui.press('enter');";
  runCommand(pyautoguiCommand: commandString);
}

void moveMouse() async {
  var cmdString = 'pyautogui.moveTo(100, 100, 2, pyautogui.easeInQuad);';
  runCommand(pyautoguiCommand: cmdString);
}
