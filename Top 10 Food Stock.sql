-- Compare the daily performance of the top 10 food stocks (price, volatility, volume) for the last 6 months
select
    stock,
    date,
    open,
    close,
    high,
    low,
    `adj close`,  -- Changed to `adj close`
    volume,
    (high - low) as daily_volatility,  -- Volatility is the range between the highest and lowest price of the day
    (`adj close` - open) / open * 100 as daily_return  -- Daily return in percentage
from (
    select 'BRK-A' as stock, date, open, close, high, low, `adj close`, volume from `brk-a`
    union all
    select 'DNUT' as stock, date, open, close, high, low, `adj close`, volume from dnut
    union all
    select 'DPZ' as stock, date, open, close, high, low, `adj close`, volume from dpz
    union all
    select 'LKNCY' as stock, date, open, close, high, low, `adj close`, volume from lkncy
    union all
    select 'MCD' as stock, date, open, close, high, low, `adj close`, volume from mcd
    union all
    select 'PZZA' as stock, date, open, close, high, low, `adj close`, volume from pzza
    union all
    select 'QSR' as stock, date, open, close, high, low, `adj close`, volume from qsr
    union all
    select 'SBUX' as stock, date, open, close, high, low, `adj close`, volume from sbux
    union all
    select 'WEN' as stock, date, open, close, high, low, `adj close`, volume from wen
    union all
    select 'YUM' as stock, date, open, close, high, low, `adj close`, volume from yum
) as food_stocks
where date >= date_sub(curdate(), interval 6 month)  -- Last 6 months
order by stock, date;



-- Find the top 3 food stocks with the highest average daily return over the last year
select
    stock,
    avg((`adj close` - `open`) / `open` * 100) as avg_daily_return  -- Calculate average daily return in percentage
from (
    select 'BRK-A' as stock, date, `open`, `close`, high, low, `adj close`, volume from `brk-a`
    union all
    select 'DNUT' as stock, date, `open`, `close`, high, low, `adj close`, volume from `dnut`
    union all
    select 'DPZ' as stock, date, `open`, `close`, high, low, `adj close`, volume from `dpz`
    union all
    select 'LKNCY' as stock, date, `open`, `close`, high, low, `adj close`, volume from `lkncy`
    union all
    select 'MCD' as stock, date, `open`, `close`, high, low, `adj close`, volume from `mcd`
    union all
    select 'PZZA' as stock, date, `open`, `close`, high, low, `adj close`, volume from `pzza`
    union all
    select 'QSR' as stock, date, `open`, `close`, high, low, `adj close`, volume from `qsr`
    union all
    select 'SBUX' as stock, date, `open`, `close`, high, low, `adj close`, volume from `sbux`
    union all
    select 'WEN' as stock, date, `open`, `close`, high, low, `adj close`, volume from `wen`
    union all
    select 'YUM' as stock, date, `open`, `close`, high, low, `adj close`, volume from `yum`
) as food_stocks
where `date` >= (select date_sub(curdate(), interval 1 year))  -- Last 1 year
group by stock
order by avg_daily_return desc  -- Sort by the highest daily return
limit 3;  -- Return top 3



-- Identify long-term growth trends by calculating the percentage increase in the adjusted closing price over the last 5 years
select
    stock,
    (first_adj_close - last_adj_close) / last_adj_close * 100 as five_year_growth  -- Percentage growth over 5 years
from (
    select 'BRK-A' as stock, 
           first_value(`adj close`) over (partition by 'BRK-A' order by `date`) as last_adj_close,  -- First value from 5 years ago
           first_value(`adj close`) over (partition by 'BRK-A' order by `date` desc) as first_adj_close  -- Latest value
    from `brk-a`
    union all
    select 'DNUT' as stock, 
           first_value(`adj close`) over (partition by 'DNUT' order by `date`) as last_adj_close,
           first_value(`adj close`) over (partition by 'DNUT' order by `date` desc) as first_adj_close 
    from `dnut`
    union all
    select 'DPZ' as stock, 
           first_value(`adj close`) over (partition by 'DPZ' order by `date`) as last_adj_close,
           first_value(`adj close`) over (partition by 'DPZ' order by `date` desc) as first_adj_close 
    from `dpz`
    union all
    select 'LKNCY' as stock, 
           first_value(`adj close`) over (partition by 'LKNCY' order by `date`) as last_adj_close,
           first_value(`adj close`) over (partition by 'LKNCY' order by `date` desc) as first_adj_close 
    from `lkncy`
    union all
    select 'MCD' as stock, 
           first_value(`adj close`) over (partition by 'MCD' order by `date`) as last_adj_close,
           first_value(`adj close`) over (partition by 'MCD' order by `date` desc) as first_adj_close 
    from `mcd`
    union all
    select 'PZZA' as stock, 
           first_value(`adj close`) over (partition by 'PZZA' order by `date`) as last_adj_close,
           first_value(`adj close`) over (partition by 'PZZA' order by `date` desc) as first_adj_close 
    from `pzza`
    union all
    select 'QSR' as stock, 
           first_value(`adj close`) over (partition by 'QSR' order by `date`) as last_adj_close,
           first_value(`adj close`) over (partition by 'QSR' order by `date` desc) as first_adj_close 
    from `qsr`
    union all
    select 'SBUX' as stock, 
           first_value(`adj close`) over (partition by 'SBUX' order by `date`) as last_adj_close,
           first_value(`adj close`) over (partition by 'SBUX' order by `date` desc) as first_adj_close 
    from `sbux`
    union all
    select 'WEN' as stock, 
           first_value(`adj close`) over (partition by 'WEN' order by `date`) as last_adj_close,
           first_value(`adj close`) over (partition by 'WEN' order by `date` desc) as first_adj_close 
    from `wen`
    union all
    select 'YUM' as stock, 
           first_value(`adj close`) over (partition by 'YUM' order by `date`) as last_adj_close,
           first_value(`adj close`) over (partition by 'YUM' order by `date` desc) as first_adj_close 
    from `yum`
) as growth_stocks;



