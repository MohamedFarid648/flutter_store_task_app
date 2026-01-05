class LoginEntity {
  final String token;
  final String userId;
  final String email;

  const LoginEntity({
    required this.token,
    required this.userId,
    required this.email,
  });
}
