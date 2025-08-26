    .data
M:      .word 2               # Số hàng
N:      .word 3               # Số cột

A:      .word 1, 2, 3, 4, 5, 6        # Ma trận A (2x3)
B:      .word 7, 8, 9, 10, 11, 12     # Ma trận B (2x3)
C:      .space 24                      # Ma trận kết quả C (2x3), mỗi phần tử 4 byte

    .text
    .globl _start

_start:
    # Load số hàng và số cột
    la t0, M
    lw t1, 0(t0)        # t1 = M
    la t0, N
    lw t2, 0(t0)        # t2 = N

    # Khởi tạo địa chỉ mảng
    la t3, A            # t3 = &A
    la t4, B            # t4 = &B
    la t5, C            # t5 = &C

    li s1, 0            # s1 = i = 0 (hàng)

outer_loop:
    beq s1, t1, end     # nếu i == M 

    li s2, 0            # s2 = j = 0 (cột)

inner_loop:
    beq s2, t2, next_row   # nếu j == N → sang hàng tiếp theo

    # Tính offset = (i * N + j) * 4
    mul s3, s1, t2       # s3 = i * N
    add s3, s3, s2       # s3 = i*N + j
    slli s3, s3, 2       # s3 = offset * 4

    # Load phần tử A[i][j]
    add s4, t3, s3
    lw s5, 0(s4)

    # Load phần tử B[i][j]
    add s4, t4, s3
    lw s6, 0(s4)

    # Cộng hai phần tử
    add s7, s5, s6

    # Lưu kết quả vào C[i][j]
    add s4, t5, s3
    sw s7, 0(s4)

    # j++
    addi s2, s2, 1
    j inner_loop

next_row:
    addi s1, s1, 1
    j outer_loop

end:

