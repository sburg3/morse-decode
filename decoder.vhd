library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
	port(	clock, morse_sig, reset : in std_logic;
			dot, dash, letter, word, word_shift : out std_logic);
end entity;

architecture arc of decoder is
	signal pos_count : unsigned(9 downto 0) := "0000000000";
	signal neg_count : unsigned(9 downto 0) := "0000000000";
	signal word_int : std_logic := '0';
begin
	word <= word_int;
process(clock, reset)
begin
if reset = '1' then
	pos_count <= "0000000000";
	neg_count <= "0000000000";
	letter <= '0';
	word_int <= '0';
	dot <= '0';
	dash <= '0';
else
	if rising_edge(clock) then
		if morse_sig = '1' then
			if pos_count < x"3FF" then
				pos_count <= pos_count + 1;
			else
				pos_count <= pos_count;
			end if;
			
			if neg_count > 250 and neg_count < 350 then
				letter <= '1';
			elsif neg_count > 650 and neg_count < 750 then
				word_int <= '1';
			else
				word_int <= '0';
				letter <= '0';
			end if;
			neg_count <= "0000000000";
		else
			if neg_count < x"3FF" then
				neg_count <= neg_count + 1;
			else
				neg_count <= neg_count;
			end if;
			
			if pos_count > 50 and pos_count < 150 then
				dot <= '1';
			elsif pos_count > 250 and pos_count < 350 then
				dash <= '1';
			else
				dot <= '0';
				dash <= '0';
			end if;
			pos_count <= "0000000000";
		end if;
	end if;
end if;
end process;
process(clock)
begin
	if falling_edge(clock) then
		word_shift <= not word_int;
	end if;
end process;
end arc;
