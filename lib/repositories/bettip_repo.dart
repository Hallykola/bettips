/*
use a Repository class which going to act as the inter-mediator and
a layer of abstraction between the APIs and the BLOC.

The task of the repository is to deliver movies data
to the BLOC after fetching it from the API.
 */

import 'dart:convert';

import 'package:bettips/api/api_base_helper.dart';
import 'package:bettips/models/bettip.dart';
import 'package:bettips/models/tip.dart';
import 'package:bettips/responses/tip_response.dart';
import 'package:bettips/utils/constants.dart';
import 'package:http/http.dart' as http;

class BettipRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

   fetchTipsList() async {
    final response = await _helper.get(Constants.alltips);
    return TipResponse.fromJson(response).results ;
  }

  fetchSpecificTipCategory(cat) async {
    final response =
        await _helper.get(Constants.alltips + '?filter=tags,eq,$cat');
    return TipResponse.fromJson(response).results ;
  }

  fetchSpecificTip(id) async {
    final response = await _helper.get(Constants.alltips + '?filter=id,eq,$id');
    return TipResponse.fromJson(response).results as Future<List<Tip>>;
  }

   editTip(id, Tip tip) async {
    final response = await _helper.put(
        Constants.alltips + '/$id', json.encode(tip.toJson()));
    //final response = await _helper.post(Constants.allusers, user);

    return true;
  }

  deleteTip(id) async {
    final response = await _helper.delete(Constants.alltips + '/$id');
    //final response = await _helper.post(Constants.allusers, user);

    return true;
  }

  createTip(tip) async {
    final response =
        await _helper.post(Constants.alltips, json.encode(tip.toJson()));

    if (!(response == null)) {
      final newresponse = await _helper.get(Constants.alltips + '/$response');
      return Tip.fromJson(newresponse);
    } else {
      return Tip.fromJson({});
    }
  }
}
