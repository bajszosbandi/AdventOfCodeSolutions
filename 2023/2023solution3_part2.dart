
import 'dart:io';

// Digit checking
bool isDigit(String s, int idx) => idx >= 0 && idx <= s.length - 1 && (s.codeUnitAt(idx) ^ 0x30) <= 9;

Future<List<String>>Beolvas(String filepath) async {
    
    List<String>sorok = [];

    var file = File(filepath);
    var contents = await file.readAsLines();

    for(var line in contents)
        if (line != "")
            sorok.add(line);

    return sorok;
}

int numberLength(List<String>l, int x, int y, String side) {
    int length = 1;

    if (side == "right"){
        int i = 1;
        while (y + 1 <= l[x].length - 1 && isDigit(l[x], y + i)) {
            length++;
            i++;
        }
    }
    else if (side == "left") {
        int i = 1;
        while (y - 1 >= 0 && isDigit(l[x], y - i)) {
            length++;
            i++;
        }
    }

    return length;
}

int Ratio(List<String>l, int x, int y, List<List<bool>>v) {
    var row = [-1, 0, 1, -1, 1, -1, 0, 1];
    var col = [-1, -1, -1, 0, 0, 1, 1, 1];

    List<int>cogs = [];

    for (int i = 0; i < 8; i++) {
        int x1 = x + row[i];
        int y1 = y + col[i];
        if (isDigit(l[x1], y1) && !v[x1][y1]) {
            int length = 0;
            int number = 0;
            v[x1][y1] = true;
            if (col[i] == -1) {
                length = numberLength(l, x1, y1, "left");
                y1 -= (length - 1);
                length = numberLength(l, x1, y1, "right");
                number = int.parse(l[x1].substring(y1, y1 + length));
                for (int j = y1; j < y1 + length; j++) {
                    v[x1][j] = true;
                }
                cogs.add(number);
            }
            else if (col[i] == 0) {
                length = numberLength(l, x1, y1, "left");
                y1 -= (length - 1);
                length = numberLength(l, x1, y1, "right");
                number = int.parse(l[x1].substring(y1, y1 + length));
                for (int j = y1; j < y1 + length; j++) {
                    v[x1][j] = true;
                }
                cogs.add(number);
            }
            else if (col[i] == 1) {
                length = numberLength(l, x1, y1, "right");
                number = int.parse(l[x1].substring(y1, y1 + length));
                for (int j = y1; j < y1 + length; j++) {
                    v[x1][j] = true;
                }
                cogs.add(number);
            }
        }
    }

    if (cogs.length != 2) return 0;

    return cogs[0] * cogs[1];
}

void main() async {
    var sorok = await Beolvas("2023input3.txt");


    int sum = 0;

    for (int i = 0; i < sorok.length; i++) {
        for (int j = 0; j < sorok[i].length; j++) {
            List<List<bool>> v = List.generate(140, (_) => List.generate(140, (_) => false));
            if (sorok[i][j] == "*") {
                sum += Ratio(sorok, i, j, v);
            }
        }
    }

    print(sum);
}