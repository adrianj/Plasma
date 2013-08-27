---------------------------------------------------------------------
-- TITLE: Plasma MCU with DDR2 RAM targetting Digilent ATLYS Board
-- AUTHOR: Adrian Jongenelen
--
-- Adds a shared Fifo to get 32-bit words in/out of the CPU.
---------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.plasmaPeriphRegisters.all;


entity PlasmaAtlysDDR is
  generic(
    uartLogFile     : string    := "UNUSED";
    simulateRam     : std_logic := '0';
    simulateProgram : std_logic := '0'
    );
  port(
    clk_100    : in  std_logic;
    reset_ex_n : in  std_logic;         -- external reset
    sysClk     : out std_logic;         -- 50 MHz system clock.
    reset_n    : out std_logic;         -- system generated reset
    UartRx     : in  std_logic;
    UartTx     : out std_logic;

    leds     : out   std_logic_vector(7 downto 0);
    switches : in    std_logic_vector(7 downto 0);
    buttons  : in    std_logic_vector(4 downto 0);
    pmod     : inout std_logic_vector(7 downto 0);

    Uart_bypassRx         : in  std_logic_vector(7 downto 0);
    Uart_bypassRxWeToggle : in  std_logic;
    Uart_bypassTx         : out std_logic_vector(7 downto 0);
    Uart_bypassTxDv       : out std_logic;

    FifoDin   : in  std_logic_vector(31 downto 0) := (others => '0');
    FifoDout  : out std_logic_vector(31 downto 0);
    FifoWe    : in  std_logic                     := '0';
    FifoRe    : in  std_logic                     := '0';
    FifoFull  : out std_logic;
    FifoEmpty : out std_logic;
    FifoClear : in  std_logic                     := '0';

    ExBusDin  : in  std_logic_vector(31 downto 0) := (others => '0');
    ExBusDout : out std_logic_vector(31 downto 0);
    ExBusAddr : out std_logic_vector(31 downto 0);
    ExBusRe   : out std_logic;
    ExBusWe   : out std_logic;

    -- Flash
    FlashCLK   : out   std_logic;
    FlashCS    : out   std_logic;
    FlashTris  : out   std_logic_vector(3 downto 0);
    FlashMemDq : inout std_logic_vector(3 downto 0);

    -- DDR2 SDRAM on ATLYS Board
    ddr_s_dq     : inout std_logic_vector(15 downto 0) := (others => 'Z');
    ddr_s_a      : out   std_logic_vector(12 downto 0);
    ddr_s_ba     : out   std_logic_vector(2 downto 0);
    ddr_s_ras_n  : out   std_logic;
    ddr_s_cas_n  : out   std_logic;
    ddr_s_we_n   : out   std_logic;
    ddr_s_odt    : out   std_logic;
    ddr_s_cke    : out   std_logic;
    ddr_s_dm     : out   std_logic;
    ddr_d_udqs   : inout std_logic                     := 'Z';
    ddr_d_udqs_n : inout std_logic                     := 'Z';
    ddr_s_rzq    : inout std_logic                     := 'Z';
    ddr_s_zio    : inout std_logic                     := 'Z';
    ddr_s_udm    : out   std_logic;
    ddr_d_dqs    : inout std_logic                     := 'Z';
    ddr_d_dqs_n  : inout std_logic                     := 'Z';
    ddr_d_ck     : out   std_logic;
    ddr_d_ck_n   : out   std_logic
    );
end;


architecture logic of PlasmaAtlysDDR is



begin  --architecture

  MCU : entity work.PlasmaTop
    generic map (
      uartLogFile     => uartLogFile,
      simulateRam     => simulateRam,
      simulateProgram => simulateProgram,
      AtlysDDR        => '1')
    port map (
      clk_100      => clk_100,
      reset_ex_n   => reset_ex_n,
      UartRx       => UartRx,
      UartTx       => UartTx,
      leds         => leds,
      switches     => switches,
      buttons      => buttons,
      pmod         => pmod,
      FlashClk     => FlashClk,
      FlashCS      => FlashCS,
      FlashTris    => FlashTris,
      FlashMemDq   => FlashMemDq,
      ddr_s_dq     => ddr_s_dq,
      ddr_s_a      => ddr_s_a,
      ddr_s_ba     => ddr_s_ba,
      ddr_s_ras_n  => ddr_s_ras_n,
      ddr_s_cas_n  => ddr_s_cas_n,
      ddr_s_we_n   => ddr_s_we_n,
      ddr_s_odt    => ddr_s_odt,
      ddr_s_cke    => ddr_s_cke,
      ddr_s_dm     => ddr_s_dm,
      ddr_d_udqs   => ddr_d_udqs,
      ddr_d_udqs_n => ddr_d_udqs_n,
      ddr_s_rzq    => ddr_s_rzq,
      ddr_s_zio    => ddr_s_zio,
      ddr_s_udm    => ddr_s_udm,
      ddr_d_dqs    => ddr_d_dqs,
      ddr_d_dqs_n  => ddr_d_dqs_n,
      ddr_d_ck     => ddr_d_ck,
      ddr_d_ck_n   => ddr_d_ck_n);


end;  --architecture logic

