import 'package:expressions/expressions.dart';

main() async {
  final ex = ExpressionEvaluator();
  var context = {"name": 11};
  print(ex.eval(Expression.parse('991+100.68'), context));
}
