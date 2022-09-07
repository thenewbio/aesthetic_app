class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
      imageUrl: 'assets/video.png',
      title: 'Welcome to Aesthetic App',
      description: "A home to feel relax and surf movies"),
  Slide(
      imageUrl: 'assets/video1.png',
      title: 'It is going to be fun',
      description: "As you will view and any movie of your choice"),
  Slide(
      imageUrl: 'assets/video2.png',
      title: 'Once again welcome',
      description: "Every Video is at your fingertip in Aesthetic app "),
];
