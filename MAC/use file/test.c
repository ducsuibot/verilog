#include <stdio.h>

int golden_top(int a, int b, int sel){
    int out = 0;
    switch(sel){
        case 0: out = a; break;
        case 1: out = a + b; break;
        case 2: out = a - b; break;
        case 3: out = (b != 0) ? (a / b) : 0; break;  // tránh chia 0
        case 4: out = 0; break;  // tránh chia 0
        case 5: out = a << 1; break;
        case 6: out = a >> 1; break;
        case 7: out = (a > b); break;
    }
    return out & 0x3F;  // mask 6-bit để giống Verilog
}

void print_binary(FILE *fp, int value, int width){
    for(int i = width - 1; i >= 0; i--){
        fprintf(fp, "%d", (value >> i) & 1);
    }
    fprintf(fp, "\n");
}

int main(){
    FILE *fp = fopen("golden_output.txt", "w");
    if(!fp){
        printf("Cannot open file!\n");
        return -1;
    }

    for(int i = 0; i < 2048; i++){
        int in = i;
        int a   = in & 0xF;         // 4 bit thấp
        int b   = (in >> 4) & 0xF;  // 4 bit tiếp
        int sel = (in >> 8) & 0x7;  // 3 bit cao

        int out = golden_top(a, b, sel);

        print_binary(fp, out, 6);  // ghi nhị phân 6-bit
    }

    fclose(fp);
    return 0;
}
