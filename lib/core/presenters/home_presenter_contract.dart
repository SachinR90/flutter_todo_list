abstract class HomePresenterContract{
  ///fetch data using startId.
  ///Note: if started with 0, will return 1 to 50 ids
  ///if started with 50, will return 51-100 ids.
  void fetchTodo(int startId, int pageLimit);
}