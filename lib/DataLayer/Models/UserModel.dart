class UserDetails {
  final String email;
  final String username;
  final String uid;

  UserDetails({
    required this.email,
    required this.username,
    required this.uid,
  });

  // Factory method to create an instance from a map
  factory UserDetails.fromMap(Map<String, dynamic> data) {
    return UserDetails(
      email: data['email'] ?? '',
      username: data['username'] ?? '',
      uid: data['uid'] ?? '',
    );
  }
}
