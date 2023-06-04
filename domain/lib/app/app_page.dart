enum AppPage {
  home("/"),
  login("/login"),
  register("/register"),
  postsList("/posts/list"),
  postsWrite("/posts/write"),
  postsRead("/posts/read"),
  postsModify("/posts/modify"),
  ;

  final String path;

  const AppPage(this.path);
}

typedef AppPageArguments = Map<String, dynamic>;