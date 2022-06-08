CREATE OPERATOR CLASS fixeddecimal_minmax_ops
DEFAULT FOR TYPE FIXEDDECIMAL USING brin AS
    OPERATOR    1   <  (FIXEDDECIMAL, FIXEDDECIMAL),
    OPERATOR    2   <= (FIXEDDECIMAL, FIXEDDECIMAL),
    OPERATOR    3   =  (FIXEDDECIMAL, FIXEDDECIMAL),
    OPERATOR    4   >= (FIXEDDECIMAL, FIXEDDECIMAL),
    OPERATOR    5   >  (FIXEDDECIMAL, FIXEDDECIMAL),
    FUNCTION    1   brin_minmax_opcinfo(INTERNAL),
    FUNCTION    2   brin_minmax_add_value(INTERNAL, INTERNAL, INTERNAL, INTERNAL),
    FUNCTION    3   brin_minmax_consistent(INTERNAL, INTERNAL, INTERNAL),
    FUNCTION    4   brin_minmax_union(INTERNAL, INTERNAL, INTERNAL);

