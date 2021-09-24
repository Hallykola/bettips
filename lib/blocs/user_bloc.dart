class UserBloc {
  bool isAdmin = false;

  UserBloc() {
    isAdmin = false;
  }

  bool fetchStatus() {
    return isAdmin;
  }

  setAdmin(bool admin) {
    isAdmin = admin;
  }
}
