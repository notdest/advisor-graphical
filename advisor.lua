dofile (getScriptPath() .. "\\logger.lua")
dofile (getScriptPath() .. "\\markFunctions.lua")

config  = {
    class       = "TQBR",
    sec         = "SBER",
    minTrade    = 4000,         -- ћинимальна€ сделка отображаема€ на графике
    minQuote    = 1000,         -- ћинимальна€ ставка в стакане, отображаема€ на графике
    minCenterTrade  = 100,      -- ћинимум дл€ отображени€ центра т€жести сделок
    minCenterQuote  = 100       -- ћинимум дл€ отображени€ центра т€жести котировок
}

is_run = true

function main()
    local lastSec = 0

    while is_run do
        date    = os.date("*t")
        sec     = tonumber(date.sec)
        if (sec < 1) and (lastSec > 0) then
            drawCenterTrades()
            --drawCenterQuotes()

            --drawMaxTrades()
            drawMaxQuotes()

            sales:clear()
            buys:clear()
        end
        lastSec = sec

        sleep(400)
    end
end

function drawCenterTrades()
    local price,quantity = sales:getCenterTrade()
    if quantity > config.minCenterTrade then
        markCenterSellTrade(price, quantity)
    end

    price,quantity = buys:getCenterTrade()
    if quantity > config.minCenterTrade then
        markCenterBuyTrade(price, quantity)
    end
end

-- ¬ы€сн€ет и рисует центры т€жести котировок
function drawCenterQuotes()
    local price,quantity = sales:getCenterQuote()
    if quantity > config.minCenterQuote then
        markCenterSellQuote(price, quantity)
    end

    price,quantity = buys:getCenterQuote()
    if quantity > config.minCenterQuote then
        markCenterBuyQuote(price, quantity)
    end
end

-- ¬ы€сн€ет и рисует максимальные котировки
function drawMaxQuotes()
    local price,quantity = sales:getMaxQuote()
    if quantity > config.minQuote then
        markSellQuote(price, quantity)
    end

    price,quantity = buys:getMaxQuote()
    if quantity > config.minQuote then
        markBuyQuote(price, quantity)
    end
end

-- вы€сн€ет и рисует максимальные сделки
function drawMaxTrades()
    local price,quantity = sales:getMaxTrade()
    if quantity > config.minTrade then
        markSellTrade(price, quantity)
    end

    price,quantity = buys:getMaxTrade()
    if quantity > config.minTrade then
        markBuyTrade(price, quantity)
    end
end

function OnQuote(class, sec )
    if class == config.class and sec == config.sec then
        local quotes = getQuoteLevel2 ( config.class , config.sec)
        if quotes.bid ~= nil and quotes.bid ~= "" then
            message(quotes.bid)
            for k, v in pairs(quotes.bid) do
                buys:addQuote(v.price,v.quantity)
            end
        end

        if quotes.offer ~= nil and quotes.offer ~= "" then
            for k, v in pairs(quotes.offer) do
                sales:addQuote(v.price,v.quantity)
            end
        end
    end
end

function OnAllTrade( trade )                -- ѕрилетела обезличенна€ сделка
    if  trade.class_code == config.class   and trade.sec_code == config.sec then
        if bit.band( trade.flags, 1) ~= 0 then
            sales:addTrade(trade.price, trade.qty)
        else
            buys:addTrade( trade.price, trade.qty)
        end
    end
end

function OnInit()
    sales = logger:new()
    buys  = logger:new()
end

function OnStop()
    is_run = false
end
