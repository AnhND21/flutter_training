import 'package:flutter_training/models/message.dart';

class MessageConvert {
  Message? currentMessage;
  Message? nextMessage;
  Message? previousMessage;

  MessageConvert({
    this.currentMessage,
    this.nextMessage,
    this.previousMessage,
  });
}
