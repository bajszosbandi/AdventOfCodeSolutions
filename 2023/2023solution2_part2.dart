
import 'dart:io';

// Digit checking
//bool isDigit(String s, int idx) => (s.codeUnitAt(idx) ^ 0x30) <= 9;

Future<Map<String, List<Map<String, int>>>>Beolvas(String filepath) async {
    var file = File(filepath);
    var contents = await file.readAsLines();

    Map<String, List<Map<String, int>>>games = {};

    for (var line in contents) {
        var parts = line.split(":");
        var gameName = parts[0].trim();
        var roundsData = parts[1].trim().split(";");

        List<Map<String, int>>rounds = [];

        for (var round in roundsData) {
            var colorData = round.trim().split(",");

            Map<String, int> roundMap = {};

            for (var color in colorData) {
                var parts = color.trim().split(" ");
                var count = int.parse(parts[0]);
                var colorName = parts[1];
                roundMap[colorName] = count;
            }

            rounds.add(roundMap);
        }

        games[gameName] = rounds;
    }

    return games;
}



void main() async {
    var input = await Beolvas("2023input2.txt");

    var sum = 0;
    input.forEach((gameName, rounds) {
        Map<String, int> max = {
            "red" : 0,
            "green" : 0,
            "blue" : 0
        };
        for (var i = 0; i < rounds.length; i++) {
            rounds[i].forEach((color, number) {
                if (number > (max[color] ?? 0)) {
                    max[color] = number;
                }
            });
        }

        sum += max["red"]! * max["green"]! * max["blue"]!;
    });



    print(sum);
}