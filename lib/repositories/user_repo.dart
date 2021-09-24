/*
use a Repository class which going to act as the inter-mediator and
a layer of abstraction between the APIs and the BLOC.

The task of the repository is to deliver movies data
to the BLOC after fetching it from the API.
 */

import 'package:bettips/api/api_base_helper.dart';
import 'package:bettips/models/records.dart';
import 'package:bettips/models/recycleruser.dart';
import 'package:bettips/utils/constants.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  fetchUsersList() async {
    final response = await _helper.get(Constants.allusers);
    return Recycleruser.fromJson(response).records ;
  }

  fetchSpecificList(email) async {
    final response =
        await _helper.get(Constants.allusers + '?filter=email,eq,$email');
    return Recycleruser.fromJson(response).records ;
  }

  resetpassword(email) async {
    final response = await _helper.get(Constants.resetpass + '?email=$email');
    //final response = await _helper.post(Constants.allusers, user);

    return true;
  }

  registeruser(user) async {
    final response = await _helper.post(Constants.allusers, user);

    if (!(response == null)) {
      final newresponse = await _helper.get(Constants.allusers + '/$response');
      return Records.fromJson(newresponse);
    } else {
      return Records.fromJson({});
    }
  }
}
