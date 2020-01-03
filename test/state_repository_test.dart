import 'package:flutter_test/flutter_test.dart';
import 'package:state_repository/state_repository.dart';


class TestRepo extends Repository
{
 int count;

}

void main() {
  test('create listeners', () {
    TestRepo t = TestRepo();
    t.count =5;
    expect(Repository.of<TestRepo>().count, 5); 
  });
}
