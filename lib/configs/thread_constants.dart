class ThreadCons {
  static const GENRE = ["雑談", "独り言", "誰か聞いて", "悩み", "オフ会", "オタク"];

  static String parentCategory(String categoryName) {
    String categroyNameRe = "";
    if (categoryName.isNotEmpty) {
      switch (categoryName) {
        case "TALKING":
          categroyNameRe = "雑談";
          break;
        case "HOBBY":
          categroyNameRe = "趣味";
          break;
        case "SOCIAL":
          categroyNameRe = "社会";
          break;
        case "ITRELATED":
          categroyNameRe = "IT関係";
          break;
        default:
          categroyNameRe = "何もないよ";
      }
    }
    return categroyNameRe;
  }
}
