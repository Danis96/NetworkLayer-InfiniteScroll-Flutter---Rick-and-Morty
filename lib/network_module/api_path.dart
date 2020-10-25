/// ApiPath
///
/// helper class in which we define paths that
/// we concatenate to our base url
enum ApiPath {
  characters,
}

class ApiPathHelper {
  static String getValue(ApiPath path, {String concatValue = ''}) {
    switch (path) {
      case ApiPath.characters:
        return 'character/';
      default:
        return '';
    }
  }
}
