library ieee;
use ieee.std_logic_1164.all;

entity Controller is
  port (
    opCode  : in std_logic_vector(5 downto 0);
    RegDst  : out std_logic;
    Jump    : out std_logic;
    Branch  : out std_logic;
    MemRead : out std_logic;
    MemToReg: out std_logic;
    ALUOp   : out std_logic;
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
    -- ANDI
      when "000000" => -- R type cmds: and, add, sub, xor, jr: 0x00
				RegDst        <= '1';
				Jump          <= '0';
				Branch        <= '0';
				MemRead       <= '0';
				memToRegister <= '0';
				ALUop         <= "10";
				MemWrite      <= '0';
				ALUsrc        <= '0';
        RegWrite      <= '1' after 10 ns;
			when "001100" => -- and immediate(andi): 0x0c NOT SURE
        RegDst        <= '0';
				Jump          <= '0';
				Branch        <= '0';
				MemRead       <= '0';
				memToRegister <= '0';
				ALUop         <= "00";
				MemWrite      <= '0';
				ALUsrc        <= '1';
        RegWrite      <= '1' after 10 ns;
			when "100011" => -- load word(lw): 0x23
				RegDst        <= '0';
				Jump          <= '0';
				Branch        <= '0';
				MemRead       <= '1';
				memToRegister <= '1';
				ALUop         <= "00";
				MemWrite      <= '0';
				ALUsrc        <= '1';
				RegWrite      <= '1' after 10 ns;
			when "101011" => -- store word(sw): 0x2B
				RegDst        <= 'X'; -- don't care
				Jump          <= '0';
				Branch        <= '0' after 2 ns;
				MemRead       <= '0';
				memToRegister <= 'X'; -- don't care
				ALUop         <= "00";
				MemWrite      <= '1';
				ALUsrc        <= '1';
				RegWrite      <= '0';
			when "000100" => -- Branch equal(beq): 0x04
				RegDst        <= 'X'; -- don't care
				Jump          <= '0';
				Branch        <= '1' after 2 ns;
				MemRead       <= '0';
				memToRegister <= 'X'; -- don't care
				ALUop         <= "01";
				MemWrite      <= '0';
				ALUsrc        <= '0';
				RegWrite      <= '0';
			when "000010" => -- Jump(j): 0x02
				RegDst        <= 'X';
				Jump          <= '1';
				Branch        <= '0';
				MemRead       <= '0';
				memToRegister <= 'X';
				ALUop         <= "00";
				MemWrite      <= '0';
				ALUsrc        <= '0';
				RegWrite      <= '0';
			when OTHERS => NULL; --implement other commands down here
				RegDst        <= '0';
				Jump          <= '0';
				Branch        <= '0';
				MemRead       <= '0';
				memToRegister <= '0';
				ALUop         <= "00";
				MemWrite      <= '0';
				ALUsrc        <= '0';
        RegWrite      <= '0';
        
    end case ;
  end process ; -- Control

end architecture ; -- Behavior