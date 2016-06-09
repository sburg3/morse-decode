library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity morse_sm is
	port( 	clock, dot, dash, clr_st, reset : in std_logic;
			char_addr : out std_logic_vector(5 downto 0));
end entity;

architecture a of morse_sm is

type state_type is (sStart, sA, sB, sC, sD, sE, sF, sG, sH, sI, sJ,
					sK, sL, sM, sN, sO, sP, sQ, sR, sS, sT,
					sU, sV, sW, sX, sY, sZ, s1, s2, s3, s4,
					s5, s6, s7, s8, s9, s0, sUU, sOO, sCH);
signal state : state_type;

begin
	process(clock, reset)
	begin
	if reset = '1' then
	state <= sStart;
	else
		if rising_edge(clock) then
			case state is
				when sStart =>
					if dot = '1' then
						state <= sE;
					elsif dash = '1' then
						state <= sT;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sStart;
					end if;
				when sA =>
					if dot = '1' then
						state <= sR;
					elsif dash = '1' then
						state <= sW;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sA;
					end if;				
				when sB =>
					if dot = '1' then
						state <= s6;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sB;
					end if;				
				when sC =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sC;
					end if;				
				when sD =>
					if dot = '1' then
						state <= sB;
					elsif dash = '1' then
						state <= sX;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sD;
					end if;				
				when sE =>
					if dot = '1' then
						state <= sI;
					elsif dash = '1' then
						state <= sA;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sE;
					end if;				
				when sF =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sF;
					end if;				
				when sG =>
					if dot = '1' then
						state <= sZ;
					elsif dash = '1' then
						state <= sQ;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sG;
					end if;				
				when sH =>
					if dot = '1' then
						state <= s5;
					elsif dash = '1' then
						state <= s4;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sH;
					end if;				
				when sI =>
					if dot = '1' then
						state <= sS;
					elsif dash = '1' then
						state <= sU;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sI;
					end if;				
				when sJ =>	
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= s1;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sJ;
					end if;							
				when sK =>
					if dot = '1' then
						state <= sC;
					elsif dash = '1' then
						state <= sY;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sK;
					end if;				
				when sL =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sL;
					end if;				
				when sM =>
					if dot = '1' then
						state <= sG;
					elsif dash = '1' then
						state <= sO;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sM;
					end if;				
				when sN =>
					if dot = '1' then
						state <= sD;
					elsif dash = '1' then
						state <= sK;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sN;
					end if;				
				when sO =>
					if dot = '1' then
						state <= sOO;
					elsif dash = '1' then
						state <= sCH;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sO;
					end if;				
				when sP =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sP;
					end if;				
				when sQ =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sQ;
					end if;				
				when sR =>
					if dot = '1' then
						state <= sL;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sR;
					end if;				
				when sS =>
					if dot = '1' then
						state <= sH;
					elsif dash = '1' then
						state <= sV;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sS;
					end if;				
				when sT =>
					if dot = '1' then
						state <= sN;
					elsif dash = '1' then
						state <= sM;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sT;
					end if;				
				when sU =>
					if dot = '1' then
						state <= sF;
					elsif dash = '1' then
						state <= sUU;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sU;
					end if;				
				when sV =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= s3;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sV;
					end if;				
				when sW =>
					if dot = '1' then
						state <= sP;
					elsif dash = '1' then
						state <= sJ;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sW;
					end if;				
				when sX =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sX;
					end if;				
				when sY =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sY;
					end if;				
				when sZ =>
					if dot = '1' then
						state <= s7;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sZ;
					end if;				
				when s1 =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= s1;
					end if;				
				when s2 =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= s2;
					end if;				
				when s3 =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= s3;
					end if;				
				when s4 =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= s4;
					end if;				
				when s5 =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= s5;
					end if;				
				when s6 =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= s6;
					end if;				
				when s7 =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= s7;
					end if;				
				when s8 =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= s8;
					end if;				
				when s9 =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= s9;
					end if;				
				when s0 =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= s0;
					end if;
				when sUU =>
					if dot = '1' then
						state <= sStart;
					elsif dash = '1' then
						state <= s2;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sUU;
					end if;	
				when sOO =>
					if dot = '1' then
						state <= s8;
					elsif dash = '1' then
						state <= sStart;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sOO;
					end if;	
				when sCH =>
					if dot = '1' then
						state <= s9;
					elsif dash = '1' then
						state <= s0;
					elsif clr_st = '1' then
						state <= sStart;
					else
						state <= sCH;
					end if;
				when others => state <= sStart;
			end case;
		end if;
	end if;
	end process;
	
	process(state)
	begin
		case state is
			when sA => char_addr <= "000001";
			when sB => char_addr <= "000010";
			when sC => char_addr <= "000011";
			when sD => char_addr <= "000100";
			when sE => char_addr <= "000101";
			when sF => char_addr <= "000110";
			when sG => char_addr <= "000111";
			when sH => char_addr <= "001000";
			when sI => char_addr <= "001001";
			when sJ => char_addr <= "001010";
			when sK => char_addr <= "001011";
			when sL => char_addr <= "001100";
			when sM => char_addr <= "001101";
			when sN => char_addr <= "001110";
			when sO => char_addr <= "001111";
			when sP => char_addr <= "010000";
			when sQ => char_addr <= "010001";
			when sR => char_addr <= "010010";
			when sS => char_addr <= "010011";
			when sT => char_addr <= "010100";
			when sU => char_addr <= "010101";
			when sV => char_addr <= "010110";
			when sW => char_addr <= "010111";
			when sX => char_addr <= "011000";
			when sY => char_addr <= "011001";
			when sZ => char_addr <= "011010";
			when s1 => char_addr <= "110001";
			when s2 => char_addr <= "110010";
			when s3 => char_addr <= "110011";
			when s4 => char_addr <= "110100";
			when s5 => char_addr <= "110101";
			when s6 => char_addr <= "110110";
			when s7 => char_addr <= "110111";
			when s8 => char_addr <= "111000";
			when s9 => char_addr <= "111001";
			when s0 => char_addr <= "110000";
			when others => char_addr <= "000000";
		end case;
	end process;
end a;