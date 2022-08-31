import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/Newsapp/cubit.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolen(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget
{
  bool? isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=> NewsCubit()..getBusiness()..getSports()..getScience(),),
        BlocProvider(create: (BuildContext context)=>AppCubit()..changeAppMode(fromShared: isDark),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: (
                  AppBarTheme(
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  )
              ),
              bottomNavigationBarTheme:BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme:
              (
                  AppBarTheme(
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light,
                    ),
                    backgroundColor: HexColor('333739'),
                    elevation: 0,
                  )
              ),
              bottomNavigationBarTheme:BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: HexColor('333739'),
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}