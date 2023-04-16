# Informe proyecto etapa 1

Para la ROM dataout se trabajó con palabras binarias de 36 bits, de los cuales los 16 bits más significativos corresponden al literal que será entregado al MUX B, de esos 16 bits los 12 menos significativos serán enviados al PC y al RAM address. Mientras que los últimos 20 bits de la ROM dataout corresponderán al opcode enviado a la Control Unit.

En cuanto al Status, tendrá una salida binaria de 3 bits, donde el bit más significativo será el valor de C, el siguiente será el valor de Z y el menos significativo corresponderá a N.

## Tabla de instrucciones implementadas

### Operacion MOV

|Operación|Variables|Opcode|
| ---- | ------- | -------------------- |
| MOV  | A,B     |"00000000000000000000"|
|      | B,A     |"00000000000000000001"|
|      | A,Lit   |"00000000000000000010"|
|      | B,Lit   |"00000000000000000011"|
|      | A,(Dir) |"00000000000000000100"|
|      | B,(Dir) |"00000000000000000101"|
|      | (Dir),A |"00000000000000000110"|
|      | (Dir),B |"00000000000000000111"|

### Operaciones ADD, SUB, AND, OR XOR

|Operación|Variables|Opcode|
| ---- | ------- | -------------------- |
| ADD  | A,B     |"00000000000000001000"|
|      | B,A     |"00000000000000001001"|
|      | A,Lit   |"00000000000000001010"|
|      | B,Lit   |"00000000000000001011"|
|      | A,(Dir) |"00000000000000001100"|
|      | B,(Dir) |"00000000000000001101"|
|      | (Dir)   |"00000000000000001110"|
| SUB  | A,B     |"00000000000000001111"|
|      | B,A     |"00000000000000010000"|
|      | A,Lit   |"00000000000000010001"|
|      | B,Lit   |"00000000000000010010"|
|      | A,(Dir) |"00000000000000010011"|
|      | B,(Dir) |"00000000000000010100"|
|      | (Dir)   |"00000000000000010101"|
| AND  | A,B     |"00000000000000010110"|
|      | B,A     |"00000000000000010111"|
|      | A,Lit   |"00000000000000011000"|
|      | B,Lit   |"00000000000000011001"|
|      | A,(Dir) |"00000000000000011010"|
|      | B,(Dir) |"00000000000000011011"|
|      | (Dir)   |"00000000000000011100"|
| OR   | A,B     |"00000000000000011101"|
|      | B,A     |"00000000000000011110"|
|      | A,Lit   |"00000000000000011111"|
|      | B,Lit   |"00000000000000100000"|
|      | A,(Dir) |"00000000000000100001"|
|      | B,(Dir) |"00000000000000100010"|
|      | (Dir)   |"00000000000000100011"|
| XOR  | A,B     |"00000000000000100100"|
|      | B,A     |"00000000000000100101"|
|      | A,Lit   |"00000000000000100110"|
|      | B,Lit   |"00000000000000100111"|
|      | A,(Dir) |"00000000000000101000"|
|      | B,(Dir) |"00000000000000101001"|
|      | (Dir)   |"00000000000000101010"|

### Operaciones NOT, SHL, SHR

|Operación|Variables|Opcode|
| ---- | ------- | -------------------- |
| NOT  | A       |"00000000000000101011"|
|      | B,A     |"00000000000000101100"|
|      | (Dir),A |"00000000000000101101"|
| SHL  | A       |"00000000000000101110"|
|      | B,A     |"00000000000000101111"|
|      | (Dir),A |"00000000000000110000"|
| SHR  | A       |"00000000000000110001"|
|      | B,A     |"00000000000000110010"|

### Operacion INC

|Operación|Variables|Opcode|
| ---- | ------- | -------------------- |
|      | (Dir),A |"00000000000000110011"|
| INC  | A       |"00000000000000110100"|
|      | B       |"00000000000000110101"|
|      | (Dir)   |"00000000000000110110"|

### Operacion DEC

|Operación|Variables|Opcode|
| ---- | ------- | -------------------- |
| DEC  | A       |"00000000000000110111"|

### Operacion CMP

|Operación|Variables|Opcode|
| ---- | ------- | -------------------- |
| CMP  | A,B     |"00000000000000111000"|
|      | A,Lit   |"00000000000000111001"|
|      | A,(Dir) |"00000000000000111010"|

### Operaciones JMP, JEQ, JNE

|Operación|Variables|Opcode|
| ---- | ------- | -------------------- |
| JMP  |  Ins    |"00000000000001010010"|
| JEQ  | Ins     |"00000000000001010011"|
| JNE  | Ins     |"00000000000001010100"|

### Operacion NOP

|Operación|Variables|Opcode|
| ---- | ------- | -------------------- |
| NOP  |  -----  |"00000000000001011010"|
