module full_adder(A,B,CIN,S,COUT); 
input A,B,CIN; 
output S,COUT;
wire S1,C1,C2; 
// built full_adder from 2 half_adder 
half_adder part(A,B,S1,C1),sum(S1,CIN,S,C2); 
or carry(COUT,C2,C1); 
endmodule