class ResponseConverter {
  int dummy = 1;
  static dynamic fromPayload<T>(dynamic data, bool isList, Function fun) {
    var content = data['payload'];
    if (content == null) {
      return null;
    }
    return _baseConverter<T>(content, isList, fun);
  }

  static dynamic fromRoot<T>(dynamic data, bool isList, Function fun) {
    if (data == null) {
      return null;
    }
    return _baseConverter<T>(data, isList, fun);
  }

  static dynamic _baseConverter<T>(body, bool isList, Function fun) {
    if (isList) {
      if (body == null) {
        return [];
      }
      var list = <T>[];
      for (var i = 0; i < body.length; i++) {
        list.add(fun(body[i]));
      }
      return list;
    } else {
      if (body == null) {
        return '';
      }
      return fun(body);
    }
  }
}
