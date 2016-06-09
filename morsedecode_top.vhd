library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity morsedecode_top is
	port( 	CLOCK_50, CLOCK_27 : in std_logic;
			KEY : in std_logic_vector(3 downto 0);
			LEDR : out std_logic_vector(17 downto 0);
			LEDG : out std_logic_vector(8 downto 0);
			SW : in std_logic_vector(17 downto 0);
			--dot_top, dash_top, letter_top, word_top, word_shift_top, clock_morse_top, morse_sig_top : out std_logic;
			--char_addr_top : out std_logic_vector(5 downto 0));
			VGA_HS, VGA_VS, VGA_BLANK, VGA_CLK, VGA_SYNC : out std_logic;
			VGA_R, VGA_G, VGA_B : out std_logic_vector(9 downto 0);
			AUD_ADCDAT : in std_logic;
			--AUD_BCLK, AUD_ADCLRCK, AUD_DACLRCK, I2C_SDAT : inout std_logic;
			AUD_BCLK, I2C_SDAT : inout std_logic;
			AUD_XCK, AUD_DACDAT, I2C_SCLK, AUD_ADCLRCK, AUD_DACLRCK, TD_RESET : out std_logic);
end entity;

architecture a of morsedecode_top is

component decoder is
	port(	clock, morse_sig, reset : in std_logic;
			dot, dash, letter, word, word_shift : out std_logic);
end component;

component morse_sm is
	port( 	clock, dot, dash, clr_st, reset : in std_logic;
			char_addr : out std_logic_vector(5 downto 0));
end component;

component vga_controller is
	port(	clock_25 : in std_logic;
			horiz_sync, vert_sync, video_on, pixel_clock : out std_logic;
			red, green, blue : out std_logic_vector(9 downto 0);
			char_addr : in std_logic_vector(5 downto 0);
			letter, word, word_shift : in std_logic
	);
end component;

component altpll0 IS
	PORT
	(
		areset		: IN STD_LOGIC;
		inclk0		: IN STD_LOGIC;
		c0		: OUT STD_LOGIC;
		c1		: OUT STD_LOGIC 
	);
end component;

component morse_clock_gen is
	port(	clock_50, reset : in std_logic;
			wpm : in std_logic_vector(7 downto 0);
			clock_morse : out std_logic
	);
end component;

--component test_signal_gen is
--	port(	clock_morse : in std_logic;
--			morse_sig : out std_logic
--	);
--end component;

component audio_codec_top is
	port(	clock_50, clock_27, reset : in std_logic;
			AUD_ADCDAT : in std_logic;
			AUD_BCLK, I2C_SDAT : inout std_logic;
			--AUD_XCK, 
			AUD_DACDAT, I2C_SCLK, TD_RESET, AUD_XCK, AUD_ADCLRCK, AUD_DACLRCK : out std_logic;
			morse_sig : out std_logic;
			debug_led : out std_logic_vector(15 downto 0));
end component;

signal morse_sig_int : std_logic;

signal dot_int : std_logic;
signal dash_int : std_logic;
signal letter_int : std_logic;
signal word_int : std_logic;
signal word_shift_int : std_logic;
--signal lorw : std_logic;

signal clock_25_int : std_logic;
signal clock_morse_int : std_logic;

signal char_addr_int : std_logic_vector(5 downto 0);

signal reset : std_logic;

signal debug : std_logic_vector(15 downto 0);

begin
--	dot_top <= dot_int;
--	dash_top <= dash_int;
--	letter_top <= letter_int;
--	word_top <= word_int;
--	word_shift_top <= word_shift_int;
--	char_addr_top <= char_addr_int;
--	clock_morse_top <= clock_morse_int;
--	morse_sig_top <= morse_sig_int;
	VGA_SYNC <= '0';
	--lorw <= letter_int or word_int;
	--morse_sig_int <= not KEY(3);
	
	LEDR <= "00" & debug;
	LEDG <= "0000" & dot_int & dash_int & letter_int & word_int & morse_sig_int;
	
	reset <= not KEY(0);
	
	dec1 : decoder
	port map(
		clock => clock_morse_int,
		morse_sig => morse_sig_int,
		reset => reset,
		dot => dot_int,
		dash => dash_int,
		letter => letter_int,
		word => word_int,
		word_shift => word_shift_int
	);
	
	sm1 : morse_sm
	port map(
		clock => clock_morse_int,
		dot => dot_int,
		dash => dash_int,
		clr_st => letter_int or word_int,
		reset => reset,
		char_addr => char_addr_int
	);
	
	vga1 : vga_controller
	port map(
		clock_25 => clock_25_int,
		horiz_sync => VGA_HS,
		vert_sync => VGA_VS,
		video_on => VGA_BLANK,
		pixel_clock => VGA_CLK,
		red => VGA_R,
		green => VGA_G,
		blue => VGA_B,
		char_addr => char_addr_int,
		letter => letter_int,
		word => word_int,
		word_shift => word_shift_int
	);
	
	pll : altpll0
	port map(
		areset => reset,
		inclk0 => CLOCK_50,
		c0 => clock_25_int,
		c1 => open
	);
	
	mc1 : morse_clock_gen
	port map(
		clock_50 => CLOCK_50,
		reset => reset,
		wpm => SW(7 downto 0),
		clock_morse => clock_morse_int
	);
	
--	tsg : test_signal_gen
--	port map(
--		clock_morse => clock_morse_int,
--		morse_sig => open
--	);
	
	act : audio_codec_top
	port map(
		clock_50 => CLOCK_50,
		clock_27 => CLOCK_27,
		reset => reset,
		AUD_ADCDAT => AUD_ADCDAT,
		AUD_BCLK => AUD_BCLK,
		AUD_ADCLRCK => AUD_ADCLRCK,
		AUD_DACLRCK => AUD_DACLRCK,
		I2C_SDAT => I2C_SDAT,
		AUD_XCK => AUD_XCK,
		AUD_DACDAT => AUD_DACDAT,
		I2C_SCLK => I2C_SCLK,
		TD_RESET => TD_RESET,
		morse_sig => morse_sig_int,
		debug_led => debug
	);
end a;