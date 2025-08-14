module nonblocking_combinational (
    input wire a,
    output reg b, c, d
);
    always @(a) begin
        b <= a;
        c <= b; // c sẽ lấy giá trị cũ của b trước khi khối always này bắt đầu
        d <= c; // d sẽ lấy giá trị cũ của c trước khi khối always này bắt đầu
		  // Khi a thay đổi, b sẽ được gán giá trị mới của a
		  // Tuy nhiên, c sẽ được gán giá trị ban đầu của b, và d sẽ được gán giá trị ban đầu của c
		  //Giá trị của b và c chỉ được cập nhật sau khi toàn bộ khối always đã thực thi
    end
endmodule