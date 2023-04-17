class User {
    User({
        required this.email,
        required this.changePassword,
        this.lastPasswordChange,
        required this.role,
        required this.username,
        required this.accountNonExpired,
        required this.accountNonLocked,
        required this.credentialsNonExpired,
        required this.id,
        required this.enabled,
    });

    String email;
    bool changePassword;
    dynamic lastPasswordChange;
    String role;
    String username;
    bool accountNonExpired;
    bool accountNonLocked;
    bool credentialsNonExpired;
    String id;
    bool enabled;

    factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        changePassword: json["changePassword"],
        lastPasswordChange: json["lastPasswordChange"],
        role: json["role"],
        username: json["username"],
        accountNonExpired: json["accountNonExpired"],
        accountNonLocked: json["accountNonLocked"],
        credentialsNonExpired: json["credentialsNonExpired"],
        id: json["id"],
        enabled: json["enabled"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "changePassword": changePassword,
        "lastPasswordChange": lastPasswordChange,
        "role": role,
        "username": username,
        "accountNonExpired": accountNonExpired,
        "accountNonLocked": accountNonLocked,
        "credentialsNonExpired": credentialsNonExpired,
        "id": id,
        "enabled": enabled,
    };
}
