class Role {
  late String name;
  late String description;
  late bool isInGame;

  Role(this.name, this.description) {
    isInGame = false;
  }

  void changeRoleStatus(Role role) {}
}
