library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control_unit is
  port (
    clk: in std_logic;
    clr: in std_logic;
    inst: in std_logic_vector(7 downto 0);
    addr: in std_logic_vector(7 downto 0);

    ai: out std_logic;
    ao: out std_logic;
    bi: out std_logic;
    bo: out std_logic;
    oi: out std_logic;
    oo: out std_logic;
    mari: out std_logic;
    maro: out std_logic;
    mvri: out std_logic;
    mvro: out std_logic;
    insi: out std_logic;
    inso: out std_logic;
    rami: out std_logic;
    ramo: out std_logic;
    pcjmp: out std_logic;
    pcinc: out std_logic;
    pco: out std_logic
  );
end control_unit;

architecture control_unit of control_unit is
  component counter is
    port (
      clk: in std_logic;
      clr: in std_logic;
      jmp: in std_logic;
      inc: in std_logic;
      eo: in std_logic;
      addr: in std_logic_vector(7 downto 0);

      q: out std_logic_vector(7 downto 0)
    );
  end component;

  signal step: std_logic_vector(7 downto 0);
  signal rst: std_logic;
begin
  ic: counter
  port map (
    clk => clk,
    clr => clr,
    jmp => rst,
    inc => '1',
    eo => '1',
    addr => "00000000",

    q => step
  );
  process(clk, inst, addr)
  begin
    if clk'event and clk = '1' then
      ai <= '0';
      ao <= '0';
      bi <= '0';
      bo <= '0';
      oi <= '0';
      oo <= '0';
      mari <= '0';
      maro <= '0';
      mvri <= '0';
      mvro <= '0';
      insi <= '0';
      inso <= '0';
      rami <= '0';
      ramo <= '0';
      pcjmp <= '0';
      pcinc <= '0';
      pco <= '0';

      if step = "00000000" then
        rst <= '0';
        pco <= '1';
        mari <= '1';
      elsif step = "00000001" then
        maro <= '1';
        insti <= '1';
      elsif step = "00000010" then
        pcinc <= '1';
      end if;
      else
        case inst
          when "00000000" =>      -- NOP
            rst <= '1';
          when "00010001" =>      -- LDA
            if step = "00000011" then
              pco <= '1';
              mari <= '1';
            elsif step = "00000100" then
              ramo <= '1';
              mvri <= '1'
            elsif step = "00000101" then
              mvri <= '1';
              mari <= '1';
            elsif step = "00000110" then
              ramo <= '1';
              ai <= '1';
            elsif step = "00000111" then
              rst <= '1';
              pcinc <= '1';
            end if;
          when "00010010" =>      -- LDB
            if step = "00000011" then
              pco <= '1';
              mari <= '1';
            elsif step = "00000100" then
              ramo <= '1';
              mvri <= '1'
            elsif step = "00000101" then
              mvri <= '1';
              mari <= '1';
            elsif step = "00000110" then
              ramo <= '1';
              bi <= '1';
            elsif step = "00000111" then
              rst <= '1';
              pcinc <= '1';
            end if;
          when "00011000" =>      -- STA
            if step = "00000011" then
              pco <= '1';
              mari <= '1';
            elsif step = "00000100" then
              ramo <= '1';
              mvri <= '1'
            elsif step = "00000101" then
              mvri <= '1';
              mari <= '1';
            elsif step = "00000110" then
              ramo <= '1';
              ai <= '1';
            elsif step = "00000111" then
              rst <= '1';
              pcinc <= '1';
            end if;
          when "00100001" =>      -- NOT
            if step = "00000100" then
            end if;
        end case;
      end if;
    end if;
  end process;
end control_unit;
