//import 'package:conditional_builder/conditional_builder.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/Newsapp/cubit.dart';
import 'package:news_app/layout/Newsapp/states.dart';
import 'package:news_app/shared/components/components.dart';

class SportsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context, state) {

      } ,
      builder:(context,state){
        return ConditionalBuilder(
          condition: NewsCubit.get(context).sports.length>0,
          builder: (context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildArticleItem(NewsCubit.get(context).sports[index],context),
              separatorBuilder: (context,index)=> SizedBox
                (
                width: 20,
              ),
              itemCount: 10
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      } ,
    );
  }
}
