CREATE OR REPLACE FUNCTION REPLACE_UNSUPPORTED_CHARS(INPUT_TEXT TEXT)
 RETURNS TEXT
 LANGUAGE PLPGSQL
AS $FUNCTION$
DECLARE
    OUTPUT_TEXT TEXT;
BEGIN
    OUTPUT_TEXT := REPLACE(INPUT_TEXT, '\', '\\');      -- substitui '\' por '\\'     
    OUTPUT_TEXT := REPLACE(INPUT_TEXT, '"', '\"');      -- substitui '"' por '\"'
    OUTPUT_TEXT := REPLACE(OUTPUT_TEXT, '/', '\/');     -- substitui '/' por '\/'
    OUTPUT_TEXT := REPLACE(OUTPUT_TEXT, CHR(8), '\b');  -- substitui char(8) por \b
    OUTPUT_TEXT := REPLACE(OUTPUT_TEXT, CHR(9), '\t');  -- substitui char(9) por \t
    OUTPUT_TEXT := REPLACE(OUTPUT_TEXT, CHR(10), '\n'); -- substitui char(10) por \n
    OUTPUT_TEXT := REPLACE(OUTPUT_TEXT, CHR(12), '\f'); -- substitui char(12) por \f
    OUTPUT_TEXT := REPLACE(OUTPUT_TEXT, CHR(13), '\r'); -- substitui char(13) por \r    
    RETURN OUTPUT_TEXT;
END;
$FUNCTION$
;
