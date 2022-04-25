// Code your design here
module mealy_overlap(Y,A,clk,rst);
  input A;
  input clk;
  input rst;
  output reg Y;
  
  //current and next states
  reg [1:0] cst, nst;
  
  //assigning binary values to the states
  parameter s0=2'b00, s1=2'b01, s2=2'b10;
  
  always @ (cst or A)
    begin
      case(cst)
        
        s0:
          begin
            nst=A?s1:s0;
            Y=1'b0;
          end
        
        s1:
          begin
            nst=A?s1:s2;
            Y=1'b0;
          end
        
        s2:
          begin
            nst=A?s1:s0;
            Y=A?1'b1:1'b0;
          end
        
        default: nst=s0;
        
      endcase
    end
  always @ (posedge clk or posedge rst)
    begin
      if(rst)
        cst<=s0;
      else
        cst<=nst;
    end
endmodule

// Code your testbench here
// or browse Examples
module mealy_overlap_tb();
  reg A,clk,rst;
  wire Y;
  mealy_overlap m1(Y,A,clk,rst);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  initial begin
    clk=0;
    rst=1;
    A=0;
    #10 rst=0; A=1; #20;
    A=0; #20; A=1; #20;
    A=0; #20; A=1; #20;
    A=1; #20; A=0; #20;
    A=1; #20; A=0; #20;
    #200 $stop;
  end
  //always #20 A=!A;
  always #10 clk=!clk;
endmodule
