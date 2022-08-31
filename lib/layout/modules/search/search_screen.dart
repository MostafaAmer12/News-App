//import 'package:conditional_builder/conditional_builder.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/Newsapp/cubit.dart';
import 'package:news_app/layout/Newsapp/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var list=NewsCubit.get(context).search;
        bool isSearch=false;

        return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultTextFormField(
                    onChange:(value)
                    {
                      NewsCubit.get(context).getSearch(value);
                    } ,
                    validate: (String value)
                    {
                      if(value.isEmpty||value == null)
                      {
                        return 'search must not be empty';
                      }
                      else {
                        isSearch = true;
                        return null;
                      }
                    },
                    label: 'Search',
                    prefix: Icons.search,
                    type: TextInputType.text,
                    controller: searchController,
                  ),
                ),
                Expanded(
                    child:
                    ConditionalBuilder(
                      condition: list.length>0,
                      builder: (context){
                        return ListView.separated(
                        itemBuilder: (context, index) {
                          return buildArticleItem(list[index],context);
                        },
                        physics: BouncingScrollPhysics(),
                            separatorBuilder: (context,index)=>SizedBox(height: 15,),
                        itemCount: 10
      );
      }, fallback: (context) => Center(child: CircularProgressIndicator()),
                )
                )
              ],
            )
        );
      },
    );
  }
}
