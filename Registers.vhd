library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
 entity Registers is
    port(
        Reg_write: in std_logic; -- output from controller
        Read_reg_1: in std_logic_vector(4 downto 0); -- output instruction[28-24] from instruction memory
        Read_reg_2: in std_logic_vector(4 downto 0); -- output instruction[23-19] from instruction memory

        Write_register: in std_logic_vector(4 downto 0); 
        Write_data: in std_logic_vector(31 downto 0);

        Read_data_1: out std_logic_vector(31 downto 0);
        Read_data_2: out std_logic_vector(31 downto 0)
        );
end Registers;


 architecture Behavior of Registers is

     type Mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);

     signal Reg_mem: Mem_array := (
        x"00000000", -- $zero
        x"00000000", -- $at
        x"00000000", -- $v0
        x"00000000", -- $v1
        x"00000000", -- $a0
        x"00000000", -- $a1
        x"00000000", -- $a2
        x"00000000", -- $a3
        x"00000111", -- $t0
        x"00000321", -- $t1
        x"0000FFFF", -- $t2 (mem 10) 
        x"00003333", -- $t3
        x"00004444", -- $t4
        x"0000FFFF", -- $t5
        x"0000000C", -- $t6
        x"00000000", -- $t7
        x"00000000", -- $s0
        x"00000000", -- $s1
        x"00000010", -- $s2
        x"00000010", -- $s3
        x"00000000", -- $s4 (mem 20)
        x"00000000", -- $s5
        x"00000FFF", -- $s6
        x"00000000", -- $s7
        x"00001234", -- $t8
        x"00006789", -- $t9
        x"00000000", -- $k0 
        x"00000000", -- $k1 
        x"00000000", -- $gp 
        x"00000000", -- $sp
        x"00000000", -- $s8/$fp (mem 30)
        x"00000000"  -- $ra
    );


 begin
    -- Register_process : process
    -- -- writeRegister is used to write the register
    -- -- writeData is used to save the data
    -- begin
    --     if(Reg_write = '1') then
    --         Reg_mem(to_integer(unsigned(Write_register))) <= Write_data;
    --     end if;
    -- end process; -- Register_process
    Reg_mem(to_integer(unsigned(Write_register))) <= Write_data when Reg_write='1';
     -- read port
    Read_data_1 <= Reg_mem(to_integer(unsigned(Read_reg_1)));
    Read_data_2 <= Reg_mem(to_integer(unsigned(Read_reg_2)));

  end architecture; -- Behavior 
