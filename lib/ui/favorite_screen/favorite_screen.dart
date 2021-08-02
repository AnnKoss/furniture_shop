import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/ui/common/bottom_navigation_bar.dart';
import 'package:flutter_furniture_shop/ui/favorite_screen/favorite_screen_bloc.dart';
import 'package:flutter_furniture_shop/ui/common/default_alert_dialog.dart';
import 'package:flutter_furniture_shop/ui/favorite_screen/favorite_item_card.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite';
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  void initState() {
    super.initState();

    context.read<FavoriteScreenBloc>().add(
          FetchFavotritesEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Избранные товары',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              SizedBox(height: 30),
              BlocBuilder<FavoriteScreenBloc, FavoriteScreenState>(
                builder: (
                  context,
                  state,
                ) {
                  if (state is FavoriteScreenErrorState) {
                    return DefaultAlertDialog(state.errorMessage);
                  }
                  if (state is FavoriteScreenLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FavoriteScreenLoadedState) {
                    return ListView.builder(
                      itemCount: state.favoritesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FavoriteItem(
                          state.favoritesList[index],
                        );
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(1),
    );
  }
}
