
import 'dart:io';
import 'dart:math';

// Digit checking
bool isDigit(String s, int idx) => idx >= 0 && idx <= s.length - 1 && (s.codeUnitAt(idx) ^ 0x30) <= 9;

class Szamok {
    Set<int> nyero = {};
    Set<int> tipp = {};
    Szamok(this.nyero, this.tipp);
}

Future<Map<String, Szamok>>Beolvas(String filepath) async {

    var file = File(filepath);
    var contents = await file.readAsLines();

    Map<String, Szamok> map = {};

    for(var line in contents) {
        var parts = line.split(":");
        var cardName = parts[0].trim();
        var szamokParts = parts[1].trim().split("|");

        var ny = szamokParts[0].trim().split(" ").where((s) => s.isNotEmpty);
        var t = szamokParts[1].trim().split(" ").where((s) => s.isNotEmpty);

        Set<int> nyero = ny.map((n) => int.parse(n)).toSet();
        Set<int> tipp = t.map((n) => int.parse(n)).toSet();

        map[cardName] = Szamok(nyero, tipp);
    }

    return map;
}



void main() async {
    var szamok = await Beolvas("2023input4.txt");

    var sum = 0;

    szamok.forEach((key, value) {
        
        var kozos = value.nyero.intersection(value.tipp);
        sum += (kozos.length - 1 >= 0) ? pow(2, kozos.length - 1).toInt() : 0;
    });

    print(sum);

    
}