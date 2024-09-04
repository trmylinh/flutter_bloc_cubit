part of 'image_cubit.dart';

sealed class ImageState {}

final class ImageInitialState extends ImageState {}

final class ImageLoadedState extends ImageState {
  final String imagePath;
  ImageLoadedState(this.imagePath);
}

final class ImageErrorState extends ImageState {
  final String message;
  ImageErrorState(this.message);
}
