library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registers is 
	port (
        Clock: in std_logic;
		reg_write: in std_logic;
		read_reg_1: in std_logic_vector(4 downto 0);
		read_reg_2: in std_logic_vector(4 downto 0);
		write_reg: in std_logic_vector(4 downto 0);

		write_data: in std_logic_vector(31 downto 0);
		read_data_1: out std_logic_vector(31 downto 0);
		read_data_2: out std_logic_vector(31 downto 0);

R0:out STD_LOGIC_VECTOR(31 DOWNTO 0); --using R0-R3 to see the result in testing bench
R1:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R2:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R3:out STD_LOGIC_VECTOR(31 DOWNTO 0)

	);
end registers;

architecture beh of registers is

    type mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
    signal reg_mem: 
	mem_array := (
        "00000000000000000000000000000000", -- $zero
        "00000000000000000000000000000000", -- mem 1
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", -- mem 10 
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",  
        "00000000000000000000000000000000", -- mem 20
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000", -- mem 30
        "00000000000000000000000000000000"
    );

	begin

    process(Clock,reg_write)
        begin
        if rising_edge(Clock) then
	if reg_write='1' then
		reg_mem(to_integer(unsigned(write_reg))) <= write_data;
	end if;
        elsif falling_edge(Clock) then 
                read_data_1 <= reg_mem(to_integer(unsigned(read_reg_1)));
                read_data_2 <= reg_mem(to_integer(unsigned(read_reg_2)));
        end if;
    end process;

R0<=reg_mem(0);
R1<=reg_mem(1);
R2<=reg_mem(2);
R3<=reg_mem(3);

end beh;