enum SortOption {
  relevance("relevance"),
  mostRecent("mostRecent"),
  mostRead("mostRead");

  const SortOption(this.value);
  final String value;
}

enum PremiumDisplayOption {
  display("display"),
  displayOnly("displayOnly"),
  doNotDisplay("doNotDisplay");

  const PremiumDisplayOption(this.value);
  final String value;
}

enum SearchContext {
  collection("collection"),
  product("product"),
  author("author");

  const SearchContext(this.value);
  final String value;
}
