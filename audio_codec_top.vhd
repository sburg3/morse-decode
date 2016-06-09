library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity audio_codec_top is
	port(	clock_50, clock_27, reset : in std_logic;
			AUD_ADCDAT : in std_logic;
			AUD_BCLK, I2C_SDAT : inout std_logic;
			--AUD_XCK, 
			AUD_DACDAT, I2C_SCLK, TD_RESET, AUD_XCK, AUD_ADCLRCK, AUD_DACLRCK : out std_logic;
			morse_sig : out std_logic;
			debug_led : out std_logic_vector(15 downto 0));
end entity;

architecture rtl of audio_codec_top is

component audio1 is
	port(	CLOCK_50, CLOCK_27, reset, AUD_ADCDAT : in std_logic;
			TD_RESET, I2C_SCLK, AUD_DACDAT, AUD_XCK, AUD_ADCLRCK, AUD_DACLRCK : out std_logic;
			I2C_SDAT, AUD_BCLK : inout std_logic;
			adc_datL : out std_logic_vector(15 downto 0));
end component;

signal adc_dat : std_logic_vector(15 downto 0);
type sample_arr is array (0 to 15) of signed(15 downto 0);
signal sample_fifo : sample_arr;
signal sum : signed(31 downto 0);
signal sum_div : signed(31 downto 0);

signal daclrck_int : std_logic;

begin

a1 : audio1
	port map(
		CLOCK_50 => clock_50,
		CLOCK_27 => clock_27,
		reset => reset,
		AUD_ADCDAT => AUD_ADCDAT,
		TD_RESET => TD_RESET,
		I2C_SCLK => I2C_SCLK,
		AUD_DACDAT => AUD_DACDAT,
		AUD_XCK => AUD_XCK,
		AUD_ADCLRCK => AUD_ADCLRCK,
		AUD_DACLRCK => daclrck_int,
		I2C_SDAT => I2C_SDAT,
		AUD_BCLK => AUD_BCLK,
		adc_datL => adc_dat
	);

AUD_DACLRCK <= daclrck_int;

process(daclrck_int)
begin
if rising_edge(daclrck_int) then
	if reset = '1' then
		sample_fifo <= (others => x"0000");
		sum <= x"00000000";
	else
		sample_fifo <= abs(signed(adc_dat)) & sample_fifo(0 to 14);
		sum <= sum + abs(signed(adc_dat)) - sample_fifo(15);
		if sum_div(15 downto 0) > 127 then
			morse_sig <= '1';
		else
			morse_sig <= '0';
		end if;
	end if;
end if;
end process;
	
debug_led <= std_logic_vector(sum_div(15 downto 0));
sum_div <= shift_right(sum, 4);

end rtl;