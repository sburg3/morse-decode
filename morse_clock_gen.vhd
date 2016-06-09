library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity morse_clock_gen is
	port(	clock_50, reset : in std_logic;
			wpm : in std_logic_vector(7 downto 0);
			clock_morse : out std_logic
	);
end morse_clock_gen;

architecture a of morse_clock_gen is

signal count : unsigned(15 downto 0) := x"0000";
signal clk_int : std_logic := '0';
signal clk_pd : unsigned(19 downto 0) := x"00000";

begin

clock_morse <= clk_int;

clk_pd <= x"00000" when wpm = x"00" else 300000/unsigned(x"000"&wpm);

process(clock_50)
begin
	if rising_edge(clock_50) then
		if reset = '1' then
			count <= x"0000";
			clk_int <= '0';
		else
			if count < clk_pd then --orig 125000
				count <= count + 1;
			else
				count <= x"0000";
				clk_int <= not clk_int;
			end if;
		end if;
	end if;
end process;
end a;