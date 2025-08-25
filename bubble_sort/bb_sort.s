    .data
n:      .word 5                # Số phần tử mảng    
array:  .word 7, 2, 9, 4, 1    # Mảng ban đầu

    .text
    .globl main

main:
    # Đọc n vào a0
    la a1, n
    lw a0, 0(a1)          # a0 = n

    # Địa chỉ mảng array
    la a1, array          # a1 = &array[0]

    # i = 0
    addi a2, x0, 0        

outer_loop:
    add a3, a2, x0
    addi t0, a0, -1
    bge a3, t0, exit      # if (i >= n-1) -> thoát

    # j = 0
    addi a3, x0, 0        

inner_loop:
    sub t0, a0, a2        # t0 = n - i
    addi t0, t0, -1       # t0 = n - i - 1
    bge a3, t0, end_inner # if (j >= n-i-1) -> thoát vòng trong

    # Tính địa chỉ array[j]
    slli t0, a3, 2        # t0 = j*4
    add t0, a1, t0        # t0 = &array[j]
    lw t1, 0(t0)          # t1 = array[j]
    lw t2, 4(t0)          # t2 = array[j+1]

    # Nếu array[j] > array[j+1], thì đổi chỗ
    ble t1, t2, skip_swap

    sw t2, 0(t0)          # array[j] = t2
    sw t1, 4(t0)          # array[j+1] = t1

skip_swap:
    addi a3, a3, 1
    j inner_loop

end_inner:
    addi a2, a2, 1
    j outer_loop

exit:
