
part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class UploadBlogEvent extends BlogEvent {
  final File image;
  final String title;
  final String content;
  final String userId;
  final List<String> topics;

  UploadBlogEvent({
    required this.image,
    required this.title,
    required this.content,
    required this.userId,
    required this.topics,
  });


}
