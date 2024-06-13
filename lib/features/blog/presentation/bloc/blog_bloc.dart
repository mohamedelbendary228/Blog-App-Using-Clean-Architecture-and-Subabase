import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entitiy.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase _uploadBlogUseCase;
  final GetAllBlogsUseCase _getAllBlogsUseCase;

  BlogBloc({
    required UploadBlogUseCase uploadBlogUseCase,
    required GetAllBlogsUseCase getAllBlogsUseCase,
  })  : _uploadBlogUseCase = uploadBlogUseCase,
        _getAllBlogsUseCase = getAllBlogsUseCase,
        super(BlogInitial()) {
    on<UploadBlogEvent>(_onBlogUpload);
    on<FetchAllBlogsEvent>(_onFetchAllBlogs);
  }

  void _onBlogUpload(
    UploadBlogEvent event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());
    final result = await _uploadBlogUseCase(
      UploadBlogParams(
        image: event.image,
        title: event.title,
        content: event.content,
        userId: event.userId,
        topics: event.topics,
      ),
    );
    result.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogUploadedSuccess()),
    );
  }

  void _onFetchAllBlogs(
    FetchAllBlogsEvent event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());
    final result = await _getAllBlogsUseCase(NoParams());

    result.fold(
      (l) => emit(BlogFailure(l.message)),
      (blogs) => emit(
        BlogsFetchedSuccess(blogs),
      ),
    );
  }

  @override
  void onChange(Change<BlogState> change) {
    super.onChange(change);
    print("BlogBloc $change");
  }
}
