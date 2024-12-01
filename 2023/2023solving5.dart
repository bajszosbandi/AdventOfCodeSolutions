
import 'dart:io';

bool isDigit(String s, int idx) => idx >= 0 && idx <= s.length - 1 && (s.codeUnitAt(idx) ^ 0x30) <= 9;

class Terkep {
    List<int> be;
    List<int> ki;
    Terkep(this.be, this.ki);
}

class Rule {
    int destination;
    int source;
    int length;
    Rule(this.destination, this.source, this.length);
}

Future<(List<int>, Map<String, List<Rule>>)>Beolvas(String filepath) async {
    var file = File(filepath);
    var contents = await file.readAsLines();
    
    List<int> seeds = [];

    

    /*var terkepek = [
        "seed-to-soil map:",
        "soil-to-fertilizer map:",
        "fertilizer-to-water map:",
        "water-to-light map:",
        "light-to-temperature map:",
        "temperature-to-humidity map:",
        "humidity-to-location map:"
    ];*/

    Map<String, List<Rule>> rules = {};

    var type = "";

    for (var line in contents) {
        if (line.contains("seeds:")) {
            var parts = line.split(":");
            var seedStrings = parts[1].trim().split(" ").where((s) => s.isNotEmpty);
            seeds = seedStrings.map((n) => int.parse(n)).toList();
        }
        else {
            if (!isDigit(line, 0)) {
                type = line;
            }
            else if (isDigit(line, 0)) {
                var parts = line.split(" ").where((s) => s.isNotEmpty);
                var numbers = parts.map((n) => int.parse(n)).toList();
                Rule rule = Rule(numbers[0], numbers[1], numbers[2]);
                rules.putIfAbsent(type, () => []).add(rule);
            }
        }
    }
    return (seeds, rules);
}

void main() async {
    var bemenet = await Beolvas("2023pelda5.txt");
    var seeds = bemenet.$1;
    var rules = bemenet.$2;

    print(seeds);
    print(rules);
}