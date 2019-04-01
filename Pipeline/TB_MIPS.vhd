--
-- Test bench del procesador MIPS Segmentado
--
-- Licencia: Copyright 2008 Emmanuel LujÃ¡n
--
-- 	This program is free software; you can redistribute it and/or
-- 	modify it under the terms of the GNU General Public License as
-- 	published by the Free Software Foundation; either version 2 of
-- 	the License, or (at your option) any later version. This program
-- 	is distributed in the hope that it will be useful, but WITHOUT
-- 	ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-- 	or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
-- 	License for more details. You should have received a copy of the
-- 	GNU General Public License along with this program; if not, write
-- 	to the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
-- 	Boston, MA 02110-1301 USA.
-- 
-- Autor:	Emmanuel LujÃ¡n
-- Email:	info@emmanuellujan.com.ar
-- VersiÃ³n:	1.0
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;		
use IEEE.numeric_std.all;

entity TB_MIPS is
end TB_MIPS;

architecture TB_MIPS_ARC of TB_MIPS is
	signal tb_CLK	: STD_LOGIC;
	signal tb_RESET	: STD_LOGIC;

begin
	MIPS_TB: ENTITY work.MIPS(Behavior)
		PORT MAP(
			clock => tb_CLK,
			reset => tb_RESET
			);

	CLK_PROC:
		process
		begin
			while true loop
				tb_CLK <= '0';
				wait for 10 ns;
				tb_CLK <= '1';
				wait for 10 ns;
			end loop;
		end process CLK_PROC;


	RESET_PROC:
		process
		begin
			tb_RESET<='1';
			wait for 25 ns;
			tb_RESET<='0';
			wait;
		end process RESET_PROC;
   	
end TB_MIPS_ARC;