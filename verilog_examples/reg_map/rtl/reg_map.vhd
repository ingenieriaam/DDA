library ieee;
use ieee.std_logic_1164.all;
entity reg_map is
  generic(BITS:natural:=16;
          REGS:natural:=4);
  port (
        --control      
        clk,rst,en,srst:in std_logic;
        load:in std_logic_vector(REGS-1 downto 0) ;
        --data in
        data:in std_logic_vector(BITS-1 downto 0) ;
        --data out, de los 4 registros
        r0,r1,r2,r3:out std_logic_vector(BITS-1 downto 0) 
       );
end reg_map ;

architecture arch of reg_map is

    constant zeros:std_logic_vector(BITS-1 downto 0):=(others=>'0') ;
    -- array de 4 vectores de 16 bits
    type slv_array_t is array (REGS-1 downto 0)
         of std_logic_vector(BITS-1 downto 0);
    --signal del registro
    signal q_reg,q_next: slv_array_t; --4 reg de 16 bits en uno
    
    begin
    registros : for k in REGS-1 downto 0 generate
        --a partir de aca pienso en cada reg de 16 bits
        individual : process( clk,rst )
        begin
            if rst='1' then
                q_reg(k)<=(others=>'0');
            elsif rising_edge(clk) then
                q_reg(k)<=q_next(k);  
            end if ;
        end process ; -- individual
    end generate ; -- registros
   -----------------------------------------------
   estado_futuro : for k in REGS-1 downto 0 generate
    q_next(k)<= q_reg(k) when en='0' else
                zeros when srst='1' else
                data when load(k)='1' else
                q_reg(k);
end generate ; -- estado_futuro
-----------------------------------------------
r0 <= q_reg ( 0 ) ;
r1 <= q_reg ( 1 ) ;
r2 <= q_reg ( 2 ) ;
r3 <= q_reg ( 3 ) ;

end architecture ; 