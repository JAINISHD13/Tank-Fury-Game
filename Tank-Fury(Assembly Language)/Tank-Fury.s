#Created By Jainish Dabhi

.data

Title:
	.ascii "Welcome to the game --TANK FURY--. Created by Jainish Dabhi\n\0"

Desc:
	.ascii "\nSteps you have to follow to play the game.\n(1)Select the number of player(Enter Minimum 2 players and maximum 3 players)\n(2)Select the player you want to damage on.\n(3)Select the type of attack you want to do\n\0"

No_Player:
	.ascii "\nEnter Number of player:\n\0"

AttackQue:
	.ascii "\nWhich Player you want to attack on?\n\0"

WhatAttack:
	.ascii "\nWhat kind of attack you want to use?\0"

KindOfAttack:
	.quad 0

AttackedOn:
	.ascii "\nNo 1 has attacked \0"

Attackt:
	.ascii "\nAttack on No:\0"

AttackAns:
	.quad 0

Player:
	.quad 0

NewLine:
	.ascii"\n\0"

TankHealth:		#Health of the three players
	.quad 100
	.quad 100
	.quad 100
	.quad 100

Health:
	.quad 0

SelectAttack:
	.ascii "\nSelect the attack from the above two options: \0"

Spinner:
	.ascii "\n1. Spinner\n\0"

Supernova:
	.ascii "2. SuperNova\n\0"

Tank1:				#Spells of Attack 1
	.quad Spinner
	.quad Supernova

attackDamage:
	.ascii "\nDamage by Attack is : \0 "

Turn1:
	.ascii "\n\n------------Tank Mega has to Play now----------------\n\0"	#Name of the Tank 1(Player name)

Turn2:
	.ascii "\n\n------------Tank Giga has to play now----------------\n\0"  #Name of the Tank 2(Player name)

Turn3:
	.ascii "\n\n------------Tank Tera has to play now----------------\n\0"	#Name of the Tank 3(Player name)

StoreIndex:
	.quad 0

Tank1Health:
	.ascii "\nRemaining Health of Tank Mega:\0"

Tank2:				#Spells of Attack 2
	.quad SuperStar
	.quad SniperRifle

SuperStar:
	.ascii "\n1. SuperStar\0"

SniperRifle:
	.ascii "\n2. SniperRifle\0"

Tank2Health:
	.ascii "\nRemaining Health of Giga \0"

Tank3:				#Spells of Attack 3
	.quad MudPie	
	.quad LiquidNitrogen

MudPie:
	.ascii "\n1.MudPie\0"

LiquidNitrogen:
	.ascii "\n2.LiquidNitrogen\0"

Tank3Health:
	.ascii "\nRemaining Health of Tera\n\0"

TotalSurvival:
	.quad 0

Winner:
	.ascii "\n\nThe Tank-Fury Winner is Tank \0"

.text
.global _start

_start:
	mov $3, %rcx				#Set the color
	call SetForeColor
	mov $Title, %rcx			#Prints the name of the game and the author name 
	call PrintCString
	mov $7, %rcx
	call SetForeColor

	mov $NewLine, %rcx
	call PrintCString
	
	mov $5,%rcx				#Set the color
	call SetForeColor
	mov $Desc, %rcx				#Description of the game
	call PrintCString
	mov $7, %rcx
	call SetForeColor
	mov $No_Player, %rcx			#Enter the number of players
	call PrintCString
	call ScanInt
	mov %rcx, Player

	mov %rcx,TotalSurvival			#Survival of the player

	mov $0,%rdi
	call PlusLoop

callTurn1:					#Print the Turn line for the particular player
		
	cmp $0, TankHealth(,%rdi,8)
	jle callTurn2
	
	cmp $1,TotalSurvival			
	je checkWinner
	
	mov $3,%rcx
	call SetForeColor
	mov $Turn1,%rcx
	call PrintCString	
        mov $7,%rcx
        call SetForeColor

	jmp Continue

callTurn2:					#Print the Turn line for the particular player

	cmp $0, TankHealth(,%rdi,8)
	jle callTurn3
	
	cmp $1,TotalSurvival
        je checkWinner

	
        mov $3,%rcx
        call SetForeColor
	mov $Turn2,%rcx
	call PrintCString
	
        mov $7,%rcx
        call SetForeColor
	jmp Continue

callTurn3:					#Print the Turn line for the particular player

	cmp $0, TankHealth(,%rdi,8)
	jle callTurn1

	cmp $1,TotalSurvival
        je checkWinner

        mov $3,%rcx
        call SetForeColor

	mov $Turn3,%rcx
	call PrintCString	
	
	
        mov $3,%rcx
        call SetForeColor

	jmp Continue
	
PlusLoop:					#Increase the index of the player
	
	cmp $0,%rdi
	je callTurn1
	
	cmp $1,%rdi
	je callTurn2

	cmp $2,%rdi
	je callTurn3

Continue:		
					#Asks the Tank on which you want to attack
	mov $AttackQue,%rcx
	call PrintCString

	call ScanInt
	mov %rcx,AttackAns
	
	mov $6,%rcx
	call SetForeColor
	mov $Attackt,%rcx
	call PrintCString
	mov $7,%rcx
	call SetForeColor
	
	mov AttackAns,%rcx
	call PrintInt

	cmp $0,%rdi
	je AtTank1	
	
	cmp $1,%rdi
	je AtTank2

	cmp $2,%rdi
	je AtTank3

AtTank1:					#Asks Tank 1's type of choices
	mov %rdi,StoreIndex
	mov $WhatAttack,%rcx
	call PrintCString

	mov $0,%rdi
	
	mov Tank1(,%rdi,8),%rcx
	call PrintCString

	mov $1,%rdi
	
	mov Tank1(,%rdi,8),%rcx
	call PrintCString

	mov $SelectAttack,%rcx
	call PrintCString
	
	call ScanInt
	mov %rcx,KindOfAttack

	cmp $1,KindOfAttack
	je callSpinner

	cmp $2,KindOfAttack
	je callSupernova

AtTank2:					#Asks Tank 2's type of choices

	mov %rdi,StoreIndex
	mov $WhatAttack,%rcx
	call PrintCString
	
	 mov $3,%rcx
        call SetForeColor

	mov $0,%rdi

	mov Tank2(,%rdi,8),%rcx
	call PrintCString
	
	mov $1,%rdi
	mov Tank2(,%rdi,8),%rcx
	call PrintCString

	mov $7, %rcx
	call SetForeColor
	mov $SelectAttack,%rcx
	call PrintCString	
	
	call ScanInt
	mov  %rcx,KindOfAttack
	
	cmp $1,KindOfAttack
	je callSuperStar

	cmp $2,KindOfAttack
	je callSniperRifle
	
AtTank3:					#Asks Tank 1's type of choices

	mov %rdi,StoreIndex
	mov $WhatAttack,%rcx
	call PrintCString
	
	mov $4,%rcx
        call SetForeColor
	mov $0,%rdi
	mov Tank3(,%rdi,8),%rcx
	call PrintCString

	mov $1,%rdi
	mov Tank3(,%rdi,8),%rcx
	call PrintCString

	mov $SelectAttack,%rcx
	call PrintCString
	 mov $7,%rcx
        call SetForeColor
	call ScanInt
	mov %rcx,KindOfAttack

	cmp $1,KindOfAttack
	je callMudPie 

	cmp $2,KindOfAttack
	je callLiquidNitrogen

callOnFunction:			#For transfering the call to a particular Tank on which we can perform the operation
	
	cmp $1,AttackAns
	je OnTank1

	cmp $2,AttackAns
	je OnTank2

	cmp $3, AttackAns
	je OnTank3

plus:				#Increment in index of the player
	add $1,%rdi
	jmp PlusLoop
			
OnFirst:			#Assign the value of the index to 0 when it comes to the last player
	mov $0,%rdi
	jmp PlusLoop

callOnFunction1:		#Store the index of the player and jump accordingly
	
	mov StoreIndex,%rdi
	cmp $0,%rdi
	je plus

	cmp $1,%rdi
	je plus

	cmp $2,%rdi
	je OnFirst
	
callSpinner:			#Attack Type-1

	mov $Spinner,%rcx
	call PrintCString
	
	mov $20,%rcx
	call Random
	mov %rcx,%rdx
	
	mov $attackDamage,%rcx
	call PrintCString
	mov %rdx,%rcx
	call PrintInt
	
	jmp callOnFunction

callSupernova:			#Attack Type-1

	mov $Supernova,%rcx
	call PrintCString
	
	mov  $20,%rcx
	call Random
	mov %rcx,%rdx
	
	mov $attackDamage,%rcx
	call PrintCString
	mov %rdx,%rcx
	call PrintInt
	
	jmp callOnFunction

callSuperStar:			#Attack Type-2	
	
	mov $SuperStar,%rcx
	call PrintCString

	mov $20,%rcx
	call Random
	mov %rcx,%rdx
	
	mov $attackDamage,%rcx
	call PrintCString
	mov %rdx,%rcx
	call PrintInt

	jmp callOnFunction

callSniperRifle:		#Attack Type-2
	
	mov $SniperRifle,%rcx
	call PrintCString

	mov $20,%rcx
	call Random
	mov %rcx,%rdx

	mov $attackDamage,%rcx
	call PrintCString
	mov %rdx,%rcx
	call PrintInt

	jmp callOnFunction

callMudPie:			#Attack Type-3
		
	mov $MudPie,%rcx
	call PrintCString

	mov $25,%rcx
	call Random
	mov %rcx,%rdx

	mov $attackDamage,%rcx
	call PrintCString
	mov %rdx,%rcx
	call PrintInt

	jmp callOnFunction

callLiquidNitrogen:		#Attack-Type-3

	mov $LiquidNitrogen,%rcx
	call PrintCString

	mov $18,%rcx
	call Random
	mov %rcx,%rdx
	
	mov $attackDamage,%rcx
	call PrintCString
	mov %rdx,%rcx
	call PrintInt
	
	jmp callOnFunction
	
OnTank3:			#Health changes according to damage on tank 3
	mov $2,%rdi
	
	mov TankHealth(,%rdi,8),%rbx
	
	sub %rcx,%rbx
	mov %rbx,TankHealth(,%rdi,8)
	
	cmp $0, TankHealth(,%rdi,8)
	jg printHealth3

	sub $1,TotalSurvival
	jmp callOnFunction1

printHealth3:		 
	
	mov $Tank3Health,%rcx
	call PrintCString
	mov %rbx,%rcx
	call PrintInt

	jmp callOnFunction1

OnTank2:			#Health changes according to damage on tank 2
	
	
	mov $1,%rdi
	
	mov TankHealth(,%rdi,8),%rbx

	sub %rcx,%rbx
	mov %rbx, TankHealth(,%rdi,8)
	
	cmp $0, TankHealth(,%rdi,8)
	jg printHealth2	

	sub $1,TotalSurvival
	jmp callOnFunction1

printHealth2:

	mov $Tank2Health,%rcx
	call PrintCString
	mov %rbx,%rcx
	call PrintInt

	jmp callOnFunction1

OnTank1:				#Health changes according to damage on tank 1
	
	mov $0,%rdi
		
	mov TankHealth(,%rdi,8),%rbx

	sub %rcx,%rbx
	mov %rbx, TankHealth(,%rdi,8)

	cmp $0,TankHealth(,%rdi,8)
	jg printHealth1
	
	sub $1,TotalSurvival
	jmp callOnFunction1

printHealth1:
	
	mov $Tank1Health,%rcx
	call PrintCString
	mov %rbx,%rcx
	call PrintInt
	
	jmp callOnFunction1

checkWinner:			#Winner Statement Call
	
	mov $Winner,%rcx
	call PrintCString
	
	mov %rdi,%rcx
	call PrintInt
	
	call EndProgram
