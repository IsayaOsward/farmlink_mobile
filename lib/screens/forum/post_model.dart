class Post {
  final String username;
  final String avatarUrl;
  final String content;
  final String? mediaUrl;
  final MediaType? mediaType;

  Post({
    required this.username,
    required this.avatarUrl,
    required this.content,
    this.mediaUrl,
    this.mediaType,
  });
}

enum MediaType { image, video }

final mockPosts = [
  Post(
    username: 'John Farmer',
    avatarUrl: 'https://i.pravatar.cc/150?img=3',
    content: 'Just finished harvesting. Look at this yield!',
    mediaUrl:
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiLAtdSKYjjcoyB2isDgkWeeZMUrzVOJAhu75Ek9yA76AG5hY1dmV7JjAwqRxO1RFvH5j3PzLglynMWaJ0HBpcVntPSxB89jxRAgUo0eMkPxxaS7HX_2kQRp7s2wjsAneEC-G6dx5dKZsdMrsih--KOFZepv75vpIYOzMvux51JIHKkeK4RcXqJOgid/w1200-h675-p-k-no-nu/farmer.jpg',
    mediaType: MediaType.image,
  ),
  Post(
    username: 'AgriTech Talk',
    avatarUrl: 'https://i.pravatar.cc/150?img=6',
    content: 'Drone technology is changing the way we manage crops. Thoughts?',
    mediaUrl:
        'https://videos.pexels.com/video-files/5532774/5532774-sd_960_506_25fps.mp4',
    mediaType: MediaType.video,
  ),
];
