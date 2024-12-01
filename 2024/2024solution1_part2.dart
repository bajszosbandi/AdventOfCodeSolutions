
import 'dart:io';
import 'dart:math';

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

    var sum = 0;

    int maxElement = list2.fold(list2.first, (prev, elem) => max(prev, elem));

    var sumList = List.filled(maxElement + 1, 0);

    for (int i = 0; i < list2.length; i++) {
        sumList[list2[i]]++;
    }

    for (int i = 0; i < list1.length; i++) {
        sum += list1[i] * sumList[list1[i]];
    }

    print(sum);
}