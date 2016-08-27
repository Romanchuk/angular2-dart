import 'dart:async';
import 'dart:convert';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:angular2/core.dart';
import '../models/user.model.dart';

@Injectable()
class UserService {
  //final BrowserClient _http; не получилось "заинджетить"
  //UserService(this._http);

  var _url = "/test_user.json";
  Stream<User> get() {
    try {
      var br = new BrowserClient();
      return br.get(_url).asStream()
        .map(_extractData)
        .expand((fd) => fd.map((value) => new User.fromJson(value)));      
    }
    catch (e){
      print(e);
      throw e;
    }
  }

  dynamic _extractData(Response res) {
    return JSON.decode(res.body);
  }
}
