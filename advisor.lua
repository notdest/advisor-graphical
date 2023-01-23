dofile (getScriptPath() .. "\\logger.lua")
dofile (getScriptPath() .. "\\markFunctions.lua")

config  = {
    class       = "TQBR",
    sec         = "SBER",
    minTrade    = 100,          -- Минимальная сделка отображаемая на графике
    minQuote    = 1000          -- Минимальная ставка в стакане, отображаемая на графике
}

is_run = true

function main()
    local seconds = 0

    while is_run do
        date    = os.date("*t")
        if seconds > date.sec then
            drawMaxTrades()
            drawMaxQuotes()

            sales:clear()
            buys:clear()
        end
        seconds = date.sec

        sleep(400)
    end
end

-- Выясняет и рисует максимальные котировки
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

-- выясняет и рисует максимальные сделки
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
        for k, v in pairs(quotes.bid) do
            buys:addQuote(v.price,tonumber(v.quantity))
        end

        for k, v in pairs(quotes.offer) do
            sales:addQuote(v.price,tonumber(v.quantity))
        end
    end
end

function OnAllTrade( trade )                -- Прилетела обезличенная сделка
    if  trade.class_code == config.class   and trade.sec_code == config.sec then
        if bit.band( trade.flags, 1) ~= 0 then
            sales:addTrade(trade.price, tonumber(trade.qty))
        else
            buys:addTrade( trade.price, tonumber(trade.qty))
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
