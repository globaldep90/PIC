;************** TRABALHIN ZIKA (help) GGEZ *****************
LIST   P=PIC16F628A
RADIX DEC	
#INCLUDE <P16F628A.INC>
	__CONFIG H'3F10'

	CBLOCK	0x20	;ENDERE�O INICIAL DA MEM�RIA DE
					;USU�RIO
	CONTADOR1
	CONTADOR2
	CONTADOR3
	CONTADOR_BOTAO1
	CONTADOR_BOTAO2

	ENDC			;FIM DO BLOCO DE MEM�RIA	

	#DEFINE	BOTAO PORTA,2 ;PORTA DO BOT�O
					  ; 0 -> PRESSIONADO
					  ; 1 -> LIBERADO

	#DEFINE	TERREO PORTB,0	;PORTA DO LED TERREO
					; 0 -> APAGADO
					; 1 -> ACESO	

	#DEFINE	PRIMEIRO PORTB,1	;PORTA DO LED PRIMEIRO ANDAR
					; 0 -> APAGADO
					; 1 -> ACESO	

	#DEFINE	SEGUNDO	PORTB,2	;PORTA DO LED SEGUNDO ANDAR
					; 0 -> APAGADO
					; 1 -> ACESO	

	#DEFINE	TERCEIRO PORTB,3	;PORTA DO LED TERCEIRO ANDAR
					; 0 -> APAGADO
					; 1 -> ACESO	

	#DEFINE	QUARTO PORTB,4	;PORTA DO LED QUARTO ANDAR
					; 0 -> APAGADO
					; 1 -> ACESO	

	#DEFINE	CONTROLE PORTB,5 ;PORTA DO LED CONTROLE
					; 0 -> APAGADO
					; 1 -> ACESO	
	#DEFINE	PRESSIONADO PORTB,6 ; LED QUE INDICA QUE O BOT�O FOI PRESSIONADO
					; 0 -> APAGADO
					; 1 -> ACESO	
	
	ORG	0x00		;ENDERE�O INICIAL DE PROCESSAMENTO
	GOTO	INICIO
		
INICIO
	BCF		PRESSIONADO
	CLRF	PORTA		;LIMPA O PORTA
	CLRF	PORTB		;LIMPA O PORTB
	BSF STATUS, RP0			;ALTERA PARA O BANCO 1
	MOVLW	B'00000100'
	MOVWF	TRISA		;DEFINE RA2 COMO ENTRADA E DEMAIS COMO SA�DAS
	CLRF	TRISB		;DEFINE TODO O PORTB COMO SA�DA
	CLRF	INTCON		;TODAS AS INTERRUP��ES DESLIGADAS
	BCF STATUS, RP0 ;RETORNA PARA O BANCO 0
	MOVLW	B'00000111'
	MOVWF	CMCON		;DEFINE O MODO DO COMPARADOR ANAL�GICO

REPETE
	CALL TER
	;TESTA SE O BOT�O FOI PRESSIONADO, SE SIM VAI PARA O TERREO
	BTFSC PRESSIONADO
	GOTO REPETE
	
	CALL PRIMEIROANDAR
	;TESTA SE O BOT�O FOI PRESSIONADO, SE SIM VAI PARA O TERREO
	BTFSC PRESSIONADO
	GOTO REPETE

	CALL SEGUNDOANDAR
	;TESTA SE O BOT�O FOI PRESSIONADO, SE SIM VAI PARA O PRIMEIRO_ANDAR
	BTFSC PRESSIONADO
	GOTO PRIMEIRO_ANDAR
	
	CALL TERCEIROANDAR
	;TESTA SE O BOT�O FOI PRESSIONADO, SE SIM VAI PARA O SEGUNDO_ANDAR
	BTFSC PRESSIONADO
	GOTO SEGUNDO_ANDAR

	CALL QUARTOANDAR
	;TESTA SE O BOT�O FOI PRESSIONADO, SE SIM VAI PARA O TERCEIRO_ANDAR, NESSE CASO N�O IR� PRECISAR DESVIAR, APENAS CONTINUAR PARA BAIXO

TERCEIRO_ANDAR
	CALL TERCEIROANDAR
SEGUNDO_ANDAR
	CALL SEGUNDOANDAR
PRIMEIRO_ANDAR
	CALL PRIMEIROANDAR
	CALL TER
	GOTO REPETE 

TER
	BCF PRESSIONADO ;LIMPA O BOT�O DE PRESSIONADO
	BSF TERREO
	BSF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF TERREO
	BSF CONTROLE
	RETURN

PRIMEIROANDAR
	BCF PRESSIONADO ;LIMPA O BOT�O DE PRESSIONADO
	BSF PRIMEIRO
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF PRIMEIRO
	BSF CONTROLE
	BSF PRIMEIRO
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF PRIMEIRO
	BSF CONTROLE
	RETURN

SEGUNDOANDAR
	BCF PRESSIONADO ;LIMPA O BOT�O DE PRESSIONADO
	BSF SEGUNDO
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF SEGUNDO
	BSF CONTROLE
	BSF SEGUNDO
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF SEGUNDO
	BSF CONTROLE
	BSF SEGUNDO
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF SEGUNDO
	BSF CONTROLE
	RETURN

TERCEIROANDAR
	BCF PRESSIONADO ;LIMPA O BOT�O DE PRESSIONADO
	BSF TERCEIRO
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF TERCEIRO
	BSF CONTROLE
	BSF TERCEIRO
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF TERCEIRO
	BSF CONTROLE
	BSF TERCEIRO
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF TERCEIRO
	BSF CONTROLE
	BSF TERCEIRO
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF TERCEIRO
	BSF CONTROLE
	RETURN

QUARTOANDAR
	BCF PRESSIONADO ;LIMPA O BOT�O DE PRESSIONADO
	BSF QUARTO
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF QUARTO
	BSF CONTROLE
	BSF QUARTO
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF QUARTO
	BSF CONTROLE
	BSF QUARTO
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF QUARTO
	BSF CONTROLE
	BSF QUARTO
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF QUARTO
	BSF CONTROLE
	BSF QUARTO
	CALL ATRASO ;DELAY DE 1S
	BCF CONTROLE
	CALL ATRASO ;DELAY DE 1S
	BCF QUARTO
	BSF CONTROLE
	RETURN

ATRASO			
	;SETAR CONTADORES	
	MOVLW	3	;7
	MOVWF	CONTADOR1
	MOVLW	25 ;22
	MOVWF	CONTADOR2
	MOVLW   15 ;67
	MOVWF	CONTADOR3

ATRASO1				
	BTFSS PRESSIONADO ;SE O LED DE PRESSIONADO ESTIVER EM 1 N�O TESTA SE O BOT�O EST� PRESSIONADO
	CALL TESTAR_BOTAO
	DECFSZ	CONTADOR1 ;TESTAR SE CONTADOR1 < 0
	GOTO ATRASO2

	RETURN ;RETORNAR PARA ONDE O ATRASO FOI CHAMADO

ATRASO2
	BTFSS PRESSIONADO ;SE O LED DE PRESSIONADO ESTIVER EM 1 N�O TESTA SE O BOT�O EST� PRESSIONADO
	CALL TESTAR_BOTAO
	DECFSZ CONTADOR2 ;TESTAR SE CONTADOR1 < 0
	GOTO ATRASO3
	GOTO ATRASO1

ATRASO3
	BTFSS PRESSIONADO ;SE O LED DE PRESSIONADO ESTIVER EM 1 N�O TESTA SE O BOT�O EST� PRESSIONADO
	CALL TESTAR_BOTAO
	DECFSZ CONTADOR3 ;TESTAR SE CONTADOR1 < 0
	GOTO ATRASO3
	GOTO ATRASO2	
	
TESTAR_BOTAO
	BTFSC	BOTAO		;O BOT�O EST� PRESSIONADO?
	CALL 	ATRASO_BOTAO ; NAO, FAZ UM ATRASO DE 30MSECS E VOLTA ONDE FOI CHAMADO
CONTINUA
	CALL	BOTAO_PRESSIONADO	;SIM, ENT�O TRATA BOT�O PRESSIONADO
DESCE	
	RETURN

BOTAO_PRESSIONADO
	BSF PRESSIONADO
	GOTO ATRASO
	GOTO ATRASO
	GOTO DESCE

ATRASO_BOTAO
	MOVLW	40 ;40
	MOVWF	CONTADOR_BOTAO1
	MOVLW	40 ;40
	MOVWF	CONTADOR_BOTAO2
	

ATRASO_BOTAO1
	DECFSZ CONTADOR_BOTAO1 ;TESTAR SE CONTADOR1 < 0
	GOTO ATRASO_BOTAO2
	GOTO CONTINUA

ATRASO_BOTAO2
	DECFSZ CONTADOR_BOTAO2 ;TESTAR SE CONTADOR1 < 0
	GOTO ATRASO_BOTAO2
	GOTO ATRASO_BOTAO1
END