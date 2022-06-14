import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_provider_todo_app/models/catfact_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final httpClientProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: "https://catfact.ninja/"));
});

//Map<String,int> queryMap = {};
final catFactsProvider = FutureProvider.autoDispose
    .family<List<CatFactModel>, Map<String, int>>((ref, queryMap) async {
  ref.keepAlive(); //cach de verileri saklar

  final dio = ref.watch(httpClientProvider);
  final result = await dio.get("facts", queryParameters: queryMap);

  var data = result.data;
  List<Map<String, dynamic>> dataMapList = List.from(data["data"]);
  List<CatFactModel> catfactModelList =
      dataMapList.map((e) => CatFactModel.fromMap(e)).toList();

  /*   print(_result);
  print(_data);
  print(_dataMapList);
  print(_catfactModelList);
   */
  return catfactModelList;
});

class FutureProviderExample extends ConsumerWidget {
  const FutureProviderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var list =
        ref.watch(catFactsProvider(const {"limit": 100, "max_length": 1000}));
    return Scaffold(
      body: SafeArea(
          child: list.when(
              data: (liste) {
                return ListView.builder(
                  itemCount: liste.length,
                  itemBuilder: (context, index) {
                    var item = liste[index];
                    return ListTile(
                      title: Text(item.fact),
                      leading: Text(item.length.toString()),
                    );
                  },
                );
              },
              error: (err, stack) {
                return Center(child: Text("bir hata oluştu $err"));
              },
              loading: () => const Center(child: CircularProgressIndicator()))),
    );
  }
}
