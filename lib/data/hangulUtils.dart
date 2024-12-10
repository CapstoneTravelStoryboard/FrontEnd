class HangulUtils {
  // 초성, 중성, 종성 리스트 (Chosung, Jungseong, Jongseong)
  static final List<String> chosungList = [
    "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ",
    "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
  ];

  static final List<String> jungseongList = [
    "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ",
    "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"
  ];

  static final List<String> jongseongList = [
    "", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ",
    "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ",
    "ㅋ", "ㅌ", "ㅍ", "ㅎ"
  ];

  // 초성 추출
  // 초성 추출 함수 (Extract Chosung)
  static String extractChosung(String text) {
    String result = "";
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      if (char.codeUnitAt(0) >= 0xAC00 && char.codeUnitAt(0) <= 0xD7A3) {
        int code = char.codeUnitAt(0) - 0xAC00;
        int chosungIndex = code ~/ (21 * 28); // 초성 인덱스 계산
        result += chosungList[chosungIndex];
      } else {
        result += char; // 한글이 아닌 문자는 그대로 추가
      }
    }
    return result;
  }
}
