part of 'blog_bloc.dart';


@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String error;

  BlogFailure(this.error);
}

final class BlogUploadedSuccess extends BlogState {}

final class BlogsFetchedSuccess extends BlogState {
  final List<Blog> blogs;
  BlogsFetchedSuccess(this.blogs);
}