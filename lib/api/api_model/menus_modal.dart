class MenusModal {
  String? message;
  List<GetMenu>? getMenu;

  MenusModal({this.message, this.getMenu});

  MenusModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['getMenu'] != null) {
      getMenu = <GetMenu>[];
      json['getMenu'].forEach((v) {
        getMenu!.add(GetMenu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (getMenu != null) {
      data['getMenu'] = getMenu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetMenu {
  String? menuName;
  String? menuImage;
  String? backgroundColor;
  String? isDashboardMenu;
  String? isLargeMenu;
  String? menuClick;

  GetMenu(
      {this.menuName,
        this.menuImage,
        this.backgroundColor,
        this.isDashboardMenu,
        this.isLargeMenu,
        this.menuClick});

  GetMenu.fromJson(Map<String, dynamic> json) {
    menuName = json['menu_name'];
    menuImage = json['menu_image'];
    backgroundColor = json['background_color'];
    isDashboardMenu = json['is_dashboard_menu'];
    isLargeMenu = json['is_large_menu'];
    menuClick = json['menu_click'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_name'] = menuName;
    data['menu_image'] = menuImage;
    data['background_color'] = backgroundColor;
    data['is_dashboard_menu'] = isDashboardMenu;
    data['is_large_menu'] = isLargeMenu;
    data['menu_click'] = menuClick;
    return data;
  }
}
