
import 'dart:convert';
import 'dart:io';

// Digit checking
bool isDigit(String s, int idx) => (s.codeUnitAt(idx) ^ 0x30) <= 9;

Future<List<String>>Beolvas(String filepath) async {
    var file = File(filepath);
    
    try {
        List<String>sorok = await file
            .openRead()
            .transform(utf8.decoder)
            .transform(LineSplitter())
            .toList();

        return sorok;
    }
    catch (e) {
        print("Hiba a fájl beolvasása közben: $e");
        return [];
    }
}

String containsNumber(String text) {
    List<String>szamok = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];
    List<String>szamok1 = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];

    for (var i = 0; i < 9; i++) {
        if (text.contains(szamok[i])) {
            return szamok1[i];
        }
    }
    return "";
}

void main() async {
    var input = await Beolvas("2023input1.txt");

    var osszeg = 0;
    for (var i in input) {
        var elso;
        for (int j = 0; j <= i.length; j++) {
            if (j < i.length && isDigit(i, j)) {
                elso = i[j];
                break;
            }
            else if (containsNumber(i.substring(0, j + 1)) != "") {
                elso = containsNumber(i.substring(0, j + 1));
                break;
            }
        }
        var masodik;
        for (int j = i.length; j >= 0; j--) {
            if (j < i.length && isDigit(i, j)) {
                masodik = i[j];
                break;
            }
            else if (containsNumber(i.substring(j, i.length)) != "") {
                masodik = containsNumber(i.substring(j, i.length));
                break;
            }
        }
        var szam = int.parse(elso + masodik);
        osszeg += szam;
    }

    print(osszeg);
}