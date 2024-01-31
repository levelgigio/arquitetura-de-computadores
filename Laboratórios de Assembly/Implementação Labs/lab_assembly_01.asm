		addi $s0,$zero,123
		addi $s1,$zero,456
		addi $s2,$zero,789
		add $s4,$s0,$s1
		add $s3,$s4,$s2
		
		
		
		addi $s7,$zero,1234
		add $s7,$s7,$s7
		add $s7,$s7,$s7
		add $s7,$s7,$s7
		add $s7,$s7,$s7
		add $s7,$s7,$s7
		add $s7,$s7,-1234
		add $s7,$s7,-1234
		
		
		
		addi $s6,$zero,30
	loop:	addi $s5,$s5,23
		addi $s6,$s6,-1
		bne $s6,$zero,loop
		
		
		
		addi $s3,$zero,39
		addi $s1,$zero,1
		addi $s2,$zero,3
	soma:	add $s1,$s1,$s2
		addi $s2,$s2,2
		addi $s3,$s3,-1
		bne $s3,$zero,soma



		addi $s0,$zero,20
	add_i:	addi $s1,$s1,1 			#s1 eh o i
		add $s2,$zero,$s1  	#s2 vira o s1 (i aux)
		i_ao_2:	add $s3,$s3,$s1
			addi $s2,$s2,-1
			bne $s2,$zero,i_ao_2
		addi $s0,$s0,-1
		bne $s0,$zero,add_i
		
		
		
		
		
		
		
		