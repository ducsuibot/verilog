module half_adder(A,B,S,C); 
input A,B; 
output S,C;
xor Sum(S,A,B); 
and Carry(C,A,B); 
endmodule