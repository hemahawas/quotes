import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String id;
  final String author;
  final String content;

  const Quote({
    required this.id,
    required this.author,
    required this.content,
  });

  @override
  List<Object?> get props => [id, author, content];
}
