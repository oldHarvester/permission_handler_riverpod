enum AppRoutes {
  home(
    name: "Home",
    path: '/home',
  );

  const AppRoutes({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;
}
