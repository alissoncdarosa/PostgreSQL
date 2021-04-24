create or alter procedure PROC_RETORNA_MESES_SEQUENCIA (
    ABREVIAR varchar(1) not null,
    RECUAR integer,
    NUMEROMESES integer not null)
returns (
    IDMES INTEGER,
    MES varchar(20),
    ANO integer)
as
declare variable COMPARAMES integer;
declare variable CONTADOR integer;
declare variable DATAINICIO date;
begin
  DATAINICIO = dateadd(RECUAR month to current_date);
  CONTADOR = 0;
  while (NUMEROMESES > 0) do
  begin
    COMPARAMES = extract(month from (dateadd(CONTADOR month to DATAINICIO)));
    ANO = extract(year from (dateadd(CONTADOR month to DATAINICIO)));
    IDMES = COMPARAMES;
    MES = case
            when COMPARAMES = 1 and ABREVIAR = 'S' then 'Jan'
            when COMPARAMES = 2 and ABREVIAR = 'S' then 'Fev'
            when COMPARAMES = 3 and ABREVIAR = 'S' then 'Mar'
            when COMPARAMES = 4 and ABREVIAR = 'S' then 'Abr'
            when COMPARAMES = 5 and ABREVIAR = 'S' then 'Mai'
            when COMPARAMES = 6 and ABREVIAR = 'S' then 'Jun'
            when COMPARAMES = 7 and ABREVIAR = 'S' then 'Jul'
            when COMPARAMES = 8 and ABREVIAR = 'S' then 'Ago'
            when COMPARAMES = 9 and ABREVIAR = 'S' then 'Set'
            when COMPARAMES = 10 and ABREVIAR = 'S' then 'Out'
            when COMPARAMES = 11 and ABREVIAR = 'S' then 'Nov'
            when COMPARAMES = 12 and ABREVIAR = 'S' then 'Dez'
            when COMPARAMES = 1 and ABREVIAR = 'N' then 'Janeiro'
            when COMPARAMES = 2 and ABREVIAR = 'N' then 'Fevereiro'
            when COMPARAMES = 3 and ABREVIAR = 'N' then 'Mar?o'
            when COMPARAMES = 4 and ABREVIAR = 'N' then 'Abril'
            when COMPARAMES = 5 and ABREVIAR = 'N' then 'Maio'
            when COMPARAMES = 6 and ABREVIAR = 'N' then 'Junho'
            when COMPARAMES = 7 and ABREVIAR = 'N' then 'Julho'
            when COMPARAMES = 8 and ABREVIAR = 'N' then 'Agosto'
            when COMPARAMES = 9 and ABREVIAR = 'N' then 'Setembro'
            when COMPARAMES = 10 and ABREVIAR = 'N' then 'Outubro'
            when COMPARAMES = 11 and ABREVIAR = 'N' then 'Novembro'
            when COMPARAMES = 12 and ABREVIAR = 'N' then 'Dezembro'
          end;
    CONTADOR = CONTADOR + 1;
    NUMEROMESES = NUMEROMESES - 1;
    suspend;
  end
end
