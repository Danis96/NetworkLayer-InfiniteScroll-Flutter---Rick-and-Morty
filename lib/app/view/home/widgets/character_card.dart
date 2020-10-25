import 'package:flutter/material.dart';
import 'package:rickAndMorty/app/models/character_model.dart';
import 'package:rickAndMorty/app/utils/size_config.dart';
import '../../../utils/string_extension.dart';

Widget characterCard(CharacterModel characterModel) {
  return Card(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: <Widget>[
          Container(
            width: SizeConfig.blockSizeHorizontal * 49,
            height: SizeConfig.blockSizeVertical * 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  characterModel.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(child: characterModel.status.statusWidget()),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(characterModel.status),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
            ),
            width: 100,
            height: 100,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(characterModel.species),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
            ),
            width: 95,
            height: 100,
            child: Image.network(characterModel.image),
          ),
        ],
      ),
    ),
  );
}
