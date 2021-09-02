import 'package:flutter/foundation.dart';

class GetAddressModel{
  final bool status;
  final DataAddressModel dataAddressModel;

  GetAddressModel({@required this.status, @required this.dataAddressModel});
  factory GetAddressModel.fromRes(Map<String ,dynamic> data)=>
      GetAddressModel(
        status: data['status'],
        dataAddressModel: data['data']['data'].isEmpty
            ? null
            : DataAddressModel.fromRes(data['data']['data'][0]),
      );
}


class DataAddressModel{
  final int id;
  final String name ,city ,region ,details ,notes ,latitude ,longitude;

  DataAddressModel({
    @required this.id,
    @required this.name,
    @required this.city,
    @required this.region,
    @required this.details,
    @required this.notes,
    @required this.latitude,
    @required this.longitude});

  factory DataAddressModel.fromRes(Map<String ,dynamic> data)=>
      DataAddressModel(
        id: data['id'],
        name: data['name'],
        city: data['city'],
        region: data['region'],
        details: data['details'],
        notes: data['notes'],
        latitude: data['latitude'].toString(),
        longitude: data['longitude'].toString(),
      );

}