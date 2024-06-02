import 'dart:io';

import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase _uploadBlogUseCase;

  BlogBloc({
    required UploadBlogUseCase uploadBlogUseCase,
  })  : _uploadBlogUseCase = uploadBlogUseCase,
        super(BlogInitial()) {
    on<UploadBlogEvent>(_onBlogUpload);
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

  @override
  void onChange(Change<BlogState> change) {
    super.onChange(change);
    print("BlogBloc $change");
  }
}
