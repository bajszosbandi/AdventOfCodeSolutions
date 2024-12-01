
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

void main() async {
    var input = await Beolvas("2023input1.txt");

    var osszeg = 0;
    for (var i in input) {
        var j = 0;
        while (!isDigit(i, j)) {
            j++;
        }
        var k = i.length - 1;
        while (!isDigit(i, k)) {
            k--;
        }
        var szam = int.parse(i[j] + i[k]);
        osszeg += szam;
    }

    print(osszeg);
}