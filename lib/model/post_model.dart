class PostModel {
  String uid;
  String content;
  String createdAt;
  String target;

  PostModel({this.uid, this.content, this.target, this.createdAt});

  Map toMap(PostModel post) {
    return {
      PostField.UID: post.uid,
      PostField.CONTENT: post.content,
      PostField.TARGET: "0",
      PostField.CREATEDAT: DateTime.now(),
    };
  }

  Map toMapByAddThread(PostModel post) {
    return {
      PostField.UID: post.uid,
      PostField.CONTENT: post.content,
      PostField.TARGET: "0",
      PostField.INDEX: "1",
      PostField.CREATEDAT: DateTime.now(),
    };
  }

  Map toMapAsReply(PostModel post) {
    return {
      PostField.UID: post.uid,
      PostField.CONTENT: post.content,
      PostField.TARGET: post.target,
      PostField.INDEX: "1",
      PostField.CREATEDAT: DateTime.now(),
    };
  }
}

class PostField {
  static const UID = "uid";
  static const CONTENT = "content";
  static const TARGET = "target";
  static const INDEX = "index";
  static const CREATEDAT = "createdAt";
}
