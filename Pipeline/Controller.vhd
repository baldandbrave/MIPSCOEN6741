-- 31-29 opcode, 3bits
-- Reference: https://www.d.umn.edu/~gshute/mips/control-signal-summary.xhtml
-- TODO: explain `after x ns` in simmulation.
library ieee;
use ieee.std_logic_1164.all;

entity Controller is
  port (
    opCode  : in std_logic_vector(2 downto 0);
    RegDst  : out std_logic;
    Jump    : out std_logic;
    Branch  : out std_logic;
    MemRead : out std_logic;
    MemToReg: out std_logic;
    ALUOp   : out std_logic_vector(1 downto 0) ;;
    MemWrite: out std_logic;
    ALUSrc  : out std_logic;
    RegWrite: out std_logic
  ) ;
end Controller ;

architecture Behavior of Controller is

begin

  Control : process( opCode )
  begin
    case( opCode ) is
    	when "000" => -- R type cmds: and, add, sub, xor, jr: 0x00
				RegDst        <= '1';
				Jump          <= '0';
				Branch        <= '0';
				MemRead       <= '0';
				memToRegister <= '0';
				ALUOp         <= "10";
				MemWrite      <= '0';
				ALUsrc        <= '0';
				RegWrite      <= '1' after 10 ns;
		when "001" => -- and immediate(andi): 0x0C 
				RegDst        <= '0';
				Jump          <= '0';
				Branch        <= '0';
				MemRead       <= '0';
				memToRegister <= '0';
				-- ALUOp         <= "11"; -- its 1X = 10/11 ["00" previous]
				ALUOp					<= "11"; -- no refence from internet, set to 11(not used in other impl)
				MemWrite      <= '0';
				ALUsrc        <= '1';
				RegWrite      <= '1' after 10 ns;
		when "010" => -- subtract immediate(subi), assigned opcode 8
				RegDst        <= '0';
				Jump          <= '0';
				Branch        <= '0';
				MemRead       <= '0';
				memToRegister <= '0';
				ALUOp         <= "01";
				MemWrite      <= '0';
				ALUsrc        <= '1';
				RegWrite      <= '1' after 10 ns;
		when "011" => -- Branch equal(beq): 0x04
				RegDst        <= 'X'; -- don't care
				Jump          <= '0';
				Branch        <= '1' after 2 ns;
				MemRead       <= '0';
				memToRegister <= 'X'; -- don't care
				ALUOp         <= "01";
				MemWrite      <= '0';
				ALUsrc        <= '0';
				RegWrite      <= '0';
		when "100" => -- load word(lw): 0x23
				RegDst        <= '0';
				Jump          <= '0';
				Branch        <= '0';
				MemRead       <= '1';
				memToRegister <= '1';
				ALUOp         <= "00";
				MemWrite      <= '0';
				ALUsrc        <= '1';
				RegWrite      <= '1' after 10 ns;
		when "101" => -- store word(sw): 0x2B
				RegDst        <= 'X'; -- don't care
				Jump          <= '0';
				Branch        <= '0' after 2 ns;
				MemRead       <= '0';
				memToRegister <= 'X'; -- don't care
				ALUOp         <= "00";
				MemWrite      <= '1';
				ALUsrc        <= '1';
				RegWrite      <= '0';
		when OTHERS => NULL; --implement other commands down here
    end case ;
  end process ; -- Control

end architecture ; -- Behavior