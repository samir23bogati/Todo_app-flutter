abstract class CheckDataSyncState {}

class CheckDataSyncInitial extends CheckDataSyncState{}

class CheckDataSyncLoading extends CheckDataSyncState{}

class CheckDataSyncExist extends CheckDataSyncState {}

class CheckDataSyncNotExist extends CheckDataSyncExist{}