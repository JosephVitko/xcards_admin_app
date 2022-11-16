import 'package:flutter/services.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcService {

  static Future<void> writeMessageHelper(NfcTag tag, Uri url) async {
    final Ndef? ndef = Ndef.from(tag);
    if (ndef == null) {
      throw Exception('Tag is not NDEF.');
    }
    if (!ndef.isWritable) {
      throw Exception('Tag is not writable.');
    }
    final NdefMessage message = NdefMessage([
      NdefRecord.createUri(url),
    ]);
    await ndef.write(message);

  }

  static Future<void> writeMessage(Uri url) async {
    bool isAvailable = await NfcManager.instance.isAvailable();

    if (!isAvailable) {
      throw Exception('NFC is not available.');
    }

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      print('Discovered tag');

      await writeMessageHelper(tag, url);

      await NfcManager.instance.stopSession();
    });
  }

}