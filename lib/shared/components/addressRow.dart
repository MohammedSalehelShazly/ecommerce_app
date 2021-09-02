import '../../models/userModels/getAddressModel.dart';
import 'package:flutter/material.dart';

class AddressRow extends StatelessWidget {
  GetAddressModel getAddressModel;
  AddressRow(this.getAddressModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [BoxShadow(spreadRadius: -5,blurRadius: 8 ,color: Colors.black26)]
      ),
      child: Row(
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.location_on),
          ),

          Expanded(
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(text: getAddressModel.dataAddressModel.city +', '),
                  TextSpan(text: getAddressModel.dataAddressModel.region +', '),
                  TextSpan(text: getAddressModel.dataAddressModel.notes),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
