
import 'dart:io';

Future<(List<int>, List<int>)> Input(String filepath) async {
    List<int> first = [];
    List<int> second = [];

    var file = File(filepath);
    var contents = await file.readAsLines();

    for (var line in contents) {
        var parts = line.split(" ").where((s) => s.isNotEmpty).toList();
        var in1 = int.parse(parts[0]);
        var in2 = int.parse(parts[1]);
        first.add(in1);
        second.add(in2);
    }

    return (first, second);
}


void main() async {
    var input = await Input("2024input1.txt");
    var list1 = input.$1;
    var list2 = input.$2;

    list1.sort();
    list2.sort();

    var sum = 0;

    for (int i = 0; i < list1.length; i++) {
        sum += (list1[i] - list2[i]).abs();
    }

    print(sum);
}