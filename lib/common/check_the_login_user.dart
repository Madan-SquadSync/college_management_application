class CheckTheUser {
  String checkUser(int value) {
    return value == 0
        ? 'isFaculty'
        : value == 1
            ? 'isStudent'
            : 'isParent';
  }
}
