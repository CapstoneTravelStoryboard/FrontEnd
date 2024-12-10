class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  // JSON 데이터를 User 객체로 변환
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }

  // User 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
    };
  }
}

class UsersList {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<User> users;

  UsersList({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.users,
  });

  // JSON 데이터를 UsersList 객체로 변환
  factory UsersList.fromJson(Map<String, dynamic> json) {
    return UsersList(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      users: (json['data'] as List)
          .map((user) => User.fromJson(user))
          .toList(),
    );
  }

  // UsersList 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
      'total': total,
      'total_pages': totalPages,
      'data': users.map((user) => user.toJson()).toList(),
    };
  }
}
