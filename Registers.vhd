library IEEE;
use IEEE.std_logic_1164.all;

entity Registers is 
	port (
        ck: in std_logic;
		Reg_write: in std_logic;
		Read_reg_1: in std_logic_vector(4 downto 0);
		Read_reg_2: in std_logic_vector(4 downto 0);
		Write_reg: in std_logic_vector(4 downto 0);
		Write_data: in std_logic_vector(31 downto 0);

		Read_data_1: out std_logic_vector(31 downto 0)
		Read_data_2: out std_logic_vector(31 downto 0)
	);
end Registers;

architecture Behavioral of Registers is

    type Mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
    signal Reg_mem: Mem_array := (
        "00000000000000000000000000000000", -- $zero
        "00000000000000000000000000000000", -- $at
        "00000000000000000000000000000000", -- $v0
        "00000000000000000000000000000000", -- $v1
        "00000000000000000000000000000000", -- $a0
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", -- $a3
        "00000000000000000000000000000000", -- $t0
        "00000000000000000000000000000000", -- 
        "00000000000000000000000000000000", -- (mem 10) 
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", -- $t7
        "00000000000000000000000000000000", -- $s0
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",  
        "00000000000000000000000000000000", -- (mem 20)
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", -- $s7
        "00000000000000000000000000000000", -- $t8
        "00000000000000000000000000000000", -- $t9
        "00000000000000000000000000000000", -- $k0 
        "00000000000000000000000000000000", -- $k1 
        "00000000000000000000000000000000", -- $gp 
        "00000000000000000000000000000000", -- $sp
        "00000000000000000000000000000000", -- $s8/$fp  (mem 30)
        "00000000000000000000000000000000"  -- $ra
    );

    begin

        Read_data_1 <= Reg_mem(to_integer(unsigned(Read_reg_1)));
        Read_data_2 <= Reg_mem(to_integer(unsigned(Read_reg_2)));
    
        process(ck)
            begin
            if ck='0' and ck'event and Reg_write='1' then
                Reg_mem(to_integer(unsigned(Write_reg))) <= Write_data;
            end if;
        end process;
    
    end architecture;