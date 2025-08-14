module majority(major,V1,V2,V3); 
output major; 
input V1,V2,V3; 
wire N1,N2,N3; 
and A1(N1,V1,V2);
and A2(N2,V2,V3);
and A3(N3,V1,V3);
or SOS(major,N1,N2,N3); 
endmodule