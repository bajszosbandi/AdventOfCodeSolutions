
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

int numberLength(List<String>l, int x, int y) {
    int length = 1;

    int i = 1;
    while (y + 1 <= l[x].length - 1 && isDigit(l[x], y + i)) {
        length++;
        i++;
    }

    return length;
}

bool isPart(List<String>l, int x, int y, String number) {

    var row = [-1, 0, 1];

    for (int i = 0; i < 3; i++) {
        if (y - 1 >= 0 && x + row[i] >= 0 && x + row[i] <= l.length - 1 && l[x + row[i]][y - 1] != ".") {
            return true;
        }
    }

    for (int i = 0; i < number.length; i++) {
        for (int j = 0; j < 3; j += 2) {
            if (x + row[j] >= 0 && x + row[j] <= l.length - 1 && l[x + row[j]][y + i] != ".") {
                return true;
            }
        }
    }

    for (int i = 0; i < 3; i++) {
        if (y + 1 + number.length - 1 <= l[x].length - 1 && x + row[i] >= 0 && x + row[i] <= l.length - 1 && l[x + row[i]][y + 1 + number.length - 1] != ".") {
            return true;
        }
    }
    return false;
}

void main() async {
    var sorok = await Beolvas("2023input3.txt");

    int sum = 0;

    for (int i = 0; i < sorok.length; i++) {
        for (int j = 0; j < sorok[i].length; j++) {
            if (isDigit(sorok[i], j)) {
                if(isPart(sorok, i, j, sorok[i].substring(j, j + numberLength(sorok, i, j)))) {
                    sum += int.parse(sorok[i].substring(j, j + numberLength(sorok, i, j)));
                    j += numberLength(sorok, i, j);
                }
                else {
                    j += numberLength(sorok, i, j);
                }
            }
        }
    }

    print(sum);
}
