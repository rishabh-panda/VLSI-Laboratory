// design: describes the behaviour of system
// data flow modelling
module fulladder1(sum, cout, a, b, cin);
  
  input a, b, cin;
  output sum, cout;
  
  assign sum=a ^ b ^ cin;
  assign cout=(a&b) | (b&cin) | (a&cin);

endmodule


// 4 bit full adder using 1 bit adder
module fulladder4(sum, cout, a, b, cin);
  
  input [3:0] a, b;
  output [3:0] sum;
  input cin;
  output cout;
  
  wire w1, w2, w3;
  
  fulladder1 L0(sum[0], w1, a[0], b[0], cin);
  fulladder1 L1(sum[1], w2, a[1], b[1], w1);
  fulladder1 L2(sum[2], w3, a[2], b[2], w2);
  fulladder1 L3(sum[3], cout, a[3], b[3], w3);
  
endmodule