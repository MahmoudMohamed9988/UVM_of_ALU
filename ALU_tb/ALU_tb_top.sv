import pkg::*;

import uvm_pkg::*;

`timescale 1ns/1ps
interface my_interface;
logic clk;
logic rst_n;
logic global_enable;
logic enable_a;
logic enable_b;
logic irq_clear;
logic [1:0] op_a;
logic [1:0] op_b;
logic [7:0] in_a;
logic [7:0] in_b;
logic [7:0] out;
logic iqr;


task get_an_input(my_sequence_item tx_in);
//$monitor(" the global_enable = %0d , the enable_a = %0d , the enable_b = %0d , the irq_clear = %0d , the op_a = %0d , the op_b = %0d , the in_a = %0d , the in_b = %0d ", global_enable, enable_a, enable_b, irq_clear , op_a , op_b , in_a , in_b );
tx_in.rst_n = rst_n;
@(posedge clk)
tx_in.global_enable = global_enable;
tx_in.enable_a= enable_a;
tx_in.enable_b= enable_b;
tx_in.irq_clear= irq_clear;
tx_in.op_a= op_a;
tx_in.op_b= op_b;
tx_in.in_a= in_a;
tx_in.in_b= in_b;


endtask

task  get_an_output(my_sequence_item tx_in);
//$monitor("at time = %0t , the out = %0d , the iqr = %0d",$time,  out , iqr);

@(posedge clk)
tx_in.out= out;
tx_in.iqr= iqr;
@(posedge clk);

endtask


task  transfer(my_sequence_item my_item);
               
 rst_n = my_item.rst_n;                            
@(posedge clk)
global_enable = my_item.global_enable;
enable_a = my_item.enable_a;
enable_b = my_item.enable_b;
irq_clear = my_item.irq_clear;
op_a = my_item.op_a;
op_b = my_item.op_b;
in_a = my_item.in_a;
in_b = my_item.in_b;


endtask






initial begin 
  clk = 1'b0; 
  forever begin
    #5 clk=~clk;
  end
end







endinterface


module tb_top;


my_interface my_if();

// instantiate the dut 
ALU ALU_1 (my_if.clk,my_if.rst_n,my_if.global_enable,my_if.enable_a,my_if.enable_b, my_if.irq_clear,my_if.op_a,my_if.op_b,my_if.in_a,my_if.in_b,my_if.iqr,my_if.out);

initial begin

  uvm_config_db #(virtual my_interface)::set(uvm_root::get(),"my_test","vif",my_if);

run_test("my_test");
end




//initial begin
//#1000;
//$finish;
//
//end




endmodule

