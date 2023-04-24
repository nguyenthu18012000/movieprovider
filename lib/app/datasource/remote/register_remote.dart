import 'package:movie_provider/constants/api_constants.dart';
import 'package:movie_provider/helpers/helpers.dart';

class RegisterRemote {
  final HttpHelper httpClient = HttpHelper();
  
  register(String username, String password) async {
    // var response = await httpClient.sendPost(
    //   ApiConstants.registerApi,
    //   {
    //     "username": username,
    //     "password": password
    //   }
    // );
    var response = await httpClient.sendGet("/user/1");
    print(response);

    return response;
  }
}