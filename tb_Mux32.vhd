library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity tb_Mux32 is
end tb_Mux32;

architecture behavior of tb_Mux32 is
	Constant tb_LengthOfInp : integer := 5; -- Change N to 32 when testing for 32 bit mux input
	signal tb_MuxInp_0 : std_logic_vector( tb_LengthOfInp - 1 downto 0) := (others => '0');
	signal tb_MuxInp_1 : std_logic_vector( tb_LengthOfInp - 1 downto 0) := (others => '0');
	signal tb_MuxCntrlInp : std_logic := '0';
	signal tb_MuxOut : std_logic_vector( tb_LengthOfInp - 1 downto 0) := (others => '0');
begin
	test_module : entity work.MuxNBit(Behavioral)
	 GENERIC MAP( tb_LengthOfInp => 5 ) -- Change N to 32 when testing for 32 bit mux input
	 port map (
		MuxControlInput => tb_MuxCntrlInp,
        	MuxInput_1 => tb_MuxInp_1,
        	MuxInput_0 => tb_MuxInp_0,
        	MuxOutput => tb_MuxOut
	  );
	process
	begin
		tb_MuxInp_1 <= "10111"; -- When 32 --> x"ABCA1111"
		tb_MuxInp_0 <= "00010"; -- When 32 --> x"2345ABBC"

		tb_MuxCntrlInp <= '0';
		wait for 100 ns;

		tb_MuxCntrlInp <= '1';
		wait for 100 ns;

		tb_MuxCntrlInp <= '0';
		wait for 100 ns;
		
		ASSERT false
		REPORT "END"
			SEVERITY failure;

	end process;
end architecture;
