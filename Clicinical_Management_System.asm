.data
menu: .asciiz "\n\n1. Register Patient\n2. Select Disease\n3. Assign Doctor\n4. Enter Appointment Date\n5. Billing\n6. View Record\n7. Add Record\n8. Delete Record\n9. Exit\nEnter your choice: "

enter_id: .asciiz "Enter patient ID (0-5): "
name_prompt: .asciiz "Enter patient name: "
gender_prompt: .asciiz "Enter gender (M/F): "
contact_prompt: .asciiz "Enter contact number: "
disease_menu: .asciiz "\n1. Fever\n2. Cold/Cough\n3. Headache\n4. Allergy\n5. Flu\n6. Vomiting\n7. Stomach flu\n8. Sore throat\nChoose disease: "
doctor_assigned: .asciiz "Doctor assigned: Dr. Zain\n"
date_prompt: .asciiz "Enter appointment date (DDMM): "
bill_prompt: .asciiz "Total Bill: "
view_prompt: .asciiz "Enter patient ID to view: "
green_text: .asciiz "\nRisk Level: LOW (Green)"
yellow_text: .asciiz "\nRisk Level: MEDIUM (Yellow)"
red_text: .asciiz "\nRisk Level: HIGH (Red)"
med_prompt: .asciiz "\nSuggested Medicine: "
newline: .asciiz "\n"
add_msg: .asciiz "Enter Patient ID (6-9): "
name_msg: .asciiz "Enter Patient Name: "
search_id_msg: .asciiz "Enter Patient ID to delete: "
deleted_msg: .asciiz "Record deleted.\n"
not_found_msg: .asciiz "Record not found.\n"

medicine_table:
    .asciiz "Paracetamol      "
    .asciiz "Benadryl         "
    .asciiz "Panadol Extra    "
    .asciiz "Cetirizine       "
    .asciiz "Tamiflu          "
    .asciiz "Ondansetron      "
    .asciiz "ORS & Flagyl     "
    .asciiz "Strepsils        "

names: .space 200
genders: .space 10
contacts: .space 100
diseases: .space 10
dates: .space 100
bills: .space 40

.text
.globl main

main:
menu_loop:
    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    beq $t0, 1, register
    beq $t0, 2, select_disease
    beq $t0, 3, assign_doctor
    beq $t0, 4, enter_date
    beq $t0, 5, billing
    beq $t0, 6, view_record
    beq $t0, 7, add_record
    beq $t0, 8, delete_record
    beq $t0, 9, exit

    j menu_loop

register:
    li $v0, 4
    la $a0, enter_id
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    li $v0, 4
    la $a0, name_prompt
    syscall
    li $v0, 8
    la $t2, names
    mul $t3, $t1, 20
    add $a0, $t2, $t3
    li $a1, 20
    syscall

    li $v0, 4
    la $a0, gender_prompt
    syscall
    li $v0, 12
    syscall
    move $t4, $v0
    la $t5, genders
    add $t5, $t5, $t1
    sb $t4, 0($t5)

    li $v0, 4
    la $a0, contact_prompt
    syscall
    li $v0, 8
    la $t2, contacts
    mul $t3, $t1, 10
    add $a0, $t2, $t3
    li $a1, 10
    syscall

    j menu_loop

select_disease:
    li $v0, 4
    la $a0, enter_id
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    li $v0, 4
    la $a0, disease_menu
    syscall
    li $v0, 5
    syscall
    move $t2, $v0

    la $t3, diseases
    add $t3, $t3, $t1
    sb $t2, 0($t3)
    j menu_loop

assign_doctor:
    li $v0, 4
    la $a0, enter_id
    syscall
    li $v0, 5
    syscall

    li $v0, 4
    la $a0, doctor_assigned
    syscall
    j menu_loop

enter_date:
    li $v0, 4
    la $a0, enter_id
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    li $v0, 4
    la $a0, date_prompt
    syscall
    li $v0, 5
    syscall
    move $t2, $v0

    la $t3, dates
    add $t3, $t3, $t1
    sb $t2, 0($t3)
    j menu_loop

billing:
    li $v0, 4
    la $a0, enter_id
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    la $t2, diseases
    add $t2, $t2, $t1
    lb $t3, 0($t2)

    li $t4, 500
    li $t5, 100
    mul $t6, $t3, $t5
    add $t7, $t6, $t4

    la $t8, bills
    add $t8, $t8, $t1
    sb $t7, 0($t8)

    li $v0, 4
    la $a0, bill_prompt
    syscall
    li $v0, 1
    move $a0, $t7
    syscall
    j menu_loop

view_record:
    li $v0, 4
    la $a0, view_prompt
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    la $t2, names
    mul $t3, $t1, 20
    add $a0, $t2, $t3
    li $v0, 4
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    la $t2, genders
    add $t2, $t2, $t1
    lb $a0, 0($t2)
    li $v0, 11
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    la $t2, contacts
    mul $t3, $t1, 10
    add $a0, $t2, $t3
    li $v0, 4
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    la $t2, bills
    add $t2, $t2, $t1
    lb $a0, 0($t2)
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    la $t2, diseases
    add $t2, $t2, $t1
    lb $t5, 0($t2)

    li $v0, 34
    ble $t5, 2, green_risk
    ble $t5, 5, yellow_risk
    j red_risk

green_risk:
    li $v0, 4
    la $a0, green_text
    syscall
    j suggest_meds
yellow_risk:
    li $v0, 4
    la $a0, yellow_text
    syscall
    j suggest_meds
red_risk:
    li $v0, 4
    la $a0, red_text
    syscall
suggest_meds:
    li $v0, 4
    la $a0, med_prompt
    syscall

    la $t6, medicine_table
    addi $t5, $t5, -1
    mul $t5, $t5, 20
    add $a0, $t6, $t5
    li $v0, 4
    syscall

    j menu_loop

add_record:
    li $v0, 4
    la $a0, add_msg
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    blt $t1, 0, add_exit
    bgt $t1, 9, add_exit

    li $v0, 4
    la $a0, name_msg
    syscall
    li $v0, 8
    la $t2, names
    mul $t3, $t1, 20
    add $a0, $t2, $t3
    li $a1, 20
    syscall

add_exit:
    j menu_loop

delete_record:
    li $v0, 4
    la $a0, search_id_msg
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    li $t2, 0
    li $t3, 0

    li $t4, 20
    mul $t5, $t1, $t4
    la $t6, names
    add $t6, $t6, $t5

    li $t7, 0
clear_name_loop:
    li $t8, 0
    sb $t8, 0($t6)
    addi $t6, $t6, 1
    addi $t7, $t7, 1
    blt $t7, $t4, clear_name_loop

    li $v0, 4
    la $a0, deleted_msg
    syscall
    j menu_loop

exit:
    li $v0, 10
    syscall
