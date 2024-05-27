CREATE OR REPLACE FUNCTION ADICIONAR_HORAS_UTEIS(EXPEDIENTE_INI TIME, 
                                                 EXPEDIENTE_FIM TIME,
                                                 INTERVALO_INI TIME,
                                                 INTERVALO_FIM TIME,
                                                 DATA_HORA_INICIAL TIMESTAMP, 
                                                 HORAS_UTEIS INT) 
RETURNS TABLE(DATA_HORA_FINAL TIMESTAMP, 
              MINUTOS_TOTAIS INTEGER, 
              HORAS_TOTAIS INTEGER)
AS $$
DECLARE
    MINUTOS_UTEIS INT         := HORAS_UTEIS * 60;
    MINUTOS_ADICIONADOS INT   := 0;
BEGIN 
    MINUTOS_TOTAIS            := 0;
    DATA_HORA_FINAL           := DATA_HORA_INICIAL;
    WHILE MINUTOS_ADICIONADOS <= MINUTOS_UTEIS LOOP
        DATA_HORA_FINAL       := DATA_HORA_FINAL + INTERVAL '1 MINUTE';
        MINUTOS_TOTAIS        := MINUTOS_TOTAIS  + 01;
        HORAS_TOTAIS          := MINUTOS_TOTAIS  / 60;
        IF EXTRACT(ISODOW FROM DATA_HORA_FINAL) < 6 
       AND (CAST(DATA_HORA_FINAL AS DATE) NOT IN (SELECT DATA 
                                                    FROM FERIADO F 
                                                   WHERE INATIVO = 'N')) 
       AND (((DATA_HORA_FINAL   >= CAST(CAST(DATA_HORA_FINAL AS DATE)||' '||EXPEDIENTE_INI AS TIMESTAMP))  
            AND (DATA_HORA_FINAL < CAST(CAST(DATA_HORA_FINAL AS DATE)||' '||INTERVALO_INI  AS TIMESTAMP))) 
         OR ((DATA_HORA_FINAL   >= CAST(CAST(DATA_HORA_FINAL AS DATE)||' '||INTERVALO_FIM  AS TIMESTAMP))  
            AND (DATA_HORA_FINAL < CAST(CAST(DATA_HORA_FINAL AS DATE)||' '||EXPEDIENTE_FIM AS TIMESTAMP)))) THEN
          MINUTOS_ADICIONADOS := MINUTOS_ADICIONADOS + 01;
        END IF;       
    END LOOP;
    RETURN NEXT;
END;
$$ LANGUAGE PLPGSQL;
