library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_signal_gen is
	port(	clock_morse : in std_logic;
			morse_sig : out std_logic
	);
end test_signal_gen;

architecture a of test_signal_gen is

signal clk_count : unsigned(11 downto 0) := "000000000000";

begin

process(clock_morse)
begin
	if rising_edge(clock_morse) then
		clk_count <= clk_count + 1;
		if clk_count < 100 then
			morse_sig <= '1';
		elsif clk_count >= 100 and clk_count < 200 then
			morse_sig <= '0';
		elsif clk_count >= 200 and clk_count < 350 then
			morse_sig <= '1';
		elsif clk_count >= 350 and clk_count < 650 then
			morse_sig <= '0';
		elsif clk_count >= 650 and clk_count < 750 then
			morse_sig <= '1';
		elsif clk_count >= 750 and clk_count < 1450 then
			morse_sig <= '0';
		elsif clk_count >= 1450 and clk_count < 1600 then
			morse_sig <= '1';
		elsif clk_count >= 1600 and clk_count < 2300 then
			morse_sig <= '0';
		else
			morse_sig <= '0';
			clk_count <= "000000000000";
		end if;
	end if;
end process;
end a;