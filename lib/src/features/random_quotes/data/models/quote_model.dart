import 'package:quotes/src/features/random_quotes/domain/entities/quote.dart';

class QuoteModel extends Quote {
  const QuoteModel({
    required id,
    required content,
    required author,
  }) : super(author: author, id: id, content: content);

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
        id: json["_id"],
        content: json["content"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "content": content,
        "author": author,
      };
}
