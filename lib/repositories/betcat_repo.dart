/*
use a Repository class which going to act as the inter-mediator and
a layer of abstraction between the APIs and the BLOC.

The task of the repository is to deliver movies data
to the BLOC after fetching it from the API.
 */

import 'package:bettips/api/api_base_helper.dart';
import 'package:bettips/models/bettip.dart';
import 'package:bettips/models/mycategorie.dart';
import 'package:bettips/models/category.dart';
import 'package:bettips/responses/cat_response.dart';
import 'package:bettips/utils/constants.dart';
import 'package:http/http.dart' as http;

class BetCatRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  fetchCatsList() async {
    final response = await _helper.get(Constants.categories);
    return CatResponse.fromJson(response).results;
  }

  fetchSpecificCategory(cat) async {
    final response =
        await _helper.get(Constants.categories + '?filter=category,eq,$cat');
    return CatResponse.fromJson(response).results;
  }

  fetchSpecificCat(id) async {
    final response =
        await _helper.get(Constants.categories + '?filter=id,eq,$id');
    return CatResponse.fromJson(response).results;
  }

  editCat(id, Categorie cat) async {
    final response =
        await _helper.put(Constants.categories + '/$id', cat.toJson());
    //final response = await _helper.post(Constants.allusers, user);

    return true;
  }

  deleteCat(id) async {
    final response = await _helper.delete(Constants.categories + '/$id');
    //final response = await _helper.post(Constants.allusers, user);

    return true;
  }

  createCat(cat) async {
    final response = await _helper.post(Constants.categories, cat.toJson());

    if (!(response == null)) {
      final newresponse =
          await _helper.get(Constants.categories + '/$response');
      return CatResponse.fromJson(newresponse);
    } else {
      return CatResponse.fromJson({"records": []});
    }
  }
}
