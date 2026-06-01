.data
	msg1:.asciiz"\nDigite um ano: "
	msg2:.asciiz"\nDigite outro ano: "
	msg3:.asciiz"\nEsse é o número de anos não bissextos entre os anos: "
.text
entrada:
	li $v0, 4	#Entrada ano 1
	la $a0, msg1
	syscall
	li $v0, 5
	syscall
	add $t0, $v0, 0
	
	li $v0, 4	#Entrada ano 2
	la $a0, msg2
	syscall
	li $v0, 5
	syscall
	add $t1, $v0, 0
	
	beq $t0,$t1, entrada	#Verifica ano 1 = ano 2
	bgt $t0,$t1,troca	#Trocar caso precise
	j valida
	troca:
		add $t9, $t0, 0
		add $t0, $t1, 0
		add $t1, $t9, 0
	
valida:				#Valida diferença de anos (Tem que ser menor que 1000)
	sub $t2, $t1,$t0
	bgt $t2,1000,entrada
	li $t3, 0
	add $t0, $t0, 1		#Ajusta o intervalo
	sub $t1, $t1, 1
	sub $t5, $t1, $t0	#Calcula a diferença entre os anos
	add $t5,$t5, 1
loop:				#Verifica que anos são bissextos
	rem $t8, $t0, 400	
	beq $t8, 0, bissexto

    	rem $t7, $t0, 100
    	beq $t7, 0, soma
	
	rem $t6, $t0, 4
	beq $t6, 0, bissexto
	j soma
	
	bissexto:		#Conta quantos anos são bissextos
		add $t3, $t3, 1
	
	soma:
		add $t0, $t0, 1	#Incremento do loop
		ble $t0, $t1, loop
	
	sub $t4, $t5, $t3	#Calcula a diferença de anos pela quantidade de bissexto
	
saida:
	li $v0, 4	#Mostra quantos anos não são bissextos entre os números
	la $a0, msg3
	syscall
	li $v0, 1
	add $a0, $t4, 0
	syscall

