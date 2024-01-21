class Youtube {
  final String videoThumbnail;
  final String videoTitle;
  final String videoUrl;

  Youtube({
    required this.videoThumbnail,
    required this.videoTitle,
    required this.videoUrl,
  });

  factory Youtube.fromMap(Map<String, dynamic> json) {
    return Youtube(
      videoThumbnail: json['videoThumbnail'],
      videoTitle: json['videoTitle'],
      videoUrl: json['videoUrl'],
    );
  }
}
