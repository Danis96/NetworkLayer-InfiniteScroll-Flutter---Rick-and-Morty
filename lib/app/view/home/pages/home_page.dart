import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:rickAndMorty/app/models/character_model.dart';
import 'package:rickAndMorty/app/provider/characters_provider.dart';
import 'package:rickAndMorty/app/utils/size_config.dart';
import 'package:rickAndMorty/app/view/home/widgets/character_card.dart';
import 'package:rickAndMorty/app/view/home/widgets/home_app_bar.dart';
import 'package:rickAndMorty/app/view/home/widgets/home_loader.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    _pagingController.addPageRequestListener((int pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  final PagingController<int, CharacterModel> _pagingController =
      PagingController<int, CharacterModel>(firstPageKey: 1);

  final int _pageSize = 20;

  Future<void> _fetchPage(int pageKey) async {
    Provider.of<CharactersProvider>(context, listen: false)
        .fetchCharacters(pageKey)
        .then((String error) {
      try {
        final List<CharacterModel> characters =
            Provider.of<CharactersProvider>(context, listen: false)
                .characterResult;
        final bool isLastPage = characters.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(characters);
        } else {
          final int nextPageKey = pageKey + 1;
          _pagingController.appendPage(characters, nextPageKey);
        }
      } catch (error) {
        _pagingController.error = error;
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeAppBar(),
      body: PagedListView<int, CharacterModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CharacterModel>(
          itemBuilder: (BuildContext context, CharacterModel characterModel,
                  int index) =>
              characterCard(characterModel),
          firstPageProgressIndicatorBuilder: (_) => progressLoader(size: 100),
          newPageProgressIndicatorBuilder: (_) => progressLoader(size: 50),
        ),

        // noItemsFoundIndicatorBuilder: (_) => NoItemsFoundIndicator(),
      ),
    );
  }
}
