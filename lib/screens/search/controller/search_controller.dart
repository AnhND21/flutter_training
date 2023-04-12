import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var keywordFirst = ''.obs;
  var keywordSecond = ''.obs;
  var keywordThird = ''.obs;

  get keyFirst => keywordFirst.value;

  get keySecond => keywordSecond.value;

  get keyThird => keywordThird.value;

  updateKeywordFirst({@required text}) {
    keywordFirst = text;
  }

  updateKeywordSecond({@required text}) {
    keywordSecond = text;
  }

  updateKeywordThird({@required text}) {
    keywordThird = text;
  }
}
