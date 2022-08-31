abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppBottomNavBarState extends AppStates{
  AppBottomNavBarState(index);
}

class AppCreateDatabaseState extends AppStates{}

class AppInsertDatabaseState extends AppStates{}

class AppGetDatabaseState extends AppStates{}

class AppUpdateDatabaseState extends AppStates{}

class AppDeleteDatabaseState extends AppStates{}

class AppGetDatabaseLoadingState extends AppStates{}

class AppBottomSheetState extends AppStates{}

class AppChangeModeState extends AppStates{}