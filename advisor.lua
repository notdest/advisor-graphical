dofile (getScriptPath() .. "\\logger.lua")
dofile (getScriptPath() .. "\\markFunctions.lua")
dofile (getScriptPath() .. "\\config.lua")


is_run = true

function main()
    local lastSec = 0

    while is_run do
        date    = os.date("*t")
        sec     = tonumber(date.sec)

        drawCenterTrades()
        drawMaxQuotes()

        if (sec < 1) and (lastSec > 0) then
            sales:clear()
            buys:clear()
        end
        lastSec = sec

        sleep(400)
    end
end

-- ¬ы€сн€ет и рисует центры т€жести сделок
oldT = {
    sales = {
        mark    = "",
        time    = "",
        markId  = 0
    },
    buys  = {
        mark    = "",
        time    = "",
        markId  = 0
    }
}
function drawCenterTrades()
    local price,quantity = sales:getCenterTrade()
    local time           = sales:getTime()
    local mark           = quantity > config.minCenterTrade and math.floor(quantity/config.multiplier)..'' or ""
    if ((oldT.sales.mark ~= mark) or ( oldT.sales.time ~= time)) and (mark ~= "") then
        if oldT.sales.time == time then
            DelLabel( config.chartTag, oldT.sales.markId)
        end

        oldT.sales.markId   = markCenterSellTrade(price, quantity,time)

        oldT.sales.mark     = mark
        oldT.sales.time     = time
    end


    price,quantity = buys:getCenterTrade()
    time           = buys:getTime()
    mark           = quantity > config.minCenterTrade and math.floor(quantity/config.multiplier)..'' or ""
    if (( oldT.buys.mark ~= mark) or (oldT.buys.time ~= time)) and (mark ~= "") then
        if oldT.buys.time == time then
            DelLabel( config.chartTag, oldT.buys.markId)
        end

        oldT.buys.markId = markCenterBuyTrade(price, quantity,time)

        oldT.buys.mark    = mark
        oldT.buys.time    = time
    end
end

-- ¬ы€сн€ет и рисует максимальные котировки
oldQ = {
    sales = {
        mark    = "",
        time    = "",
        markId  = 0
    },
    buys  = {
        mark    = "",
        time    = "",
        markId  = 0
    }
}
function drawMaxQuotes()
    local price,quantity = sales:getMaxQuote()
    local time           = sales:getTime()
    local mark           = quantity > config.minQuote and math.floor(quantity/config.multiplier)..'' or ""
    if ((oldQ.sales.mark ~= mark) or ( oldQ.sales.time ~= time)) and (mark ~= "") then
        if oldQ.sales.time == time then
            DelLabel( config.chartTag, oldQ.sales.markId)
        end

        oldQ.sales.markId   = markSellQuote(price, quantity,time)

        oldQ.sales.mark = mark
        oldQ.sales.time = time
    end

    price,quantity = buys:getMaxQuote()
    time           = buys:getTime()
    mark           = quantity > config.minQuote and math.floor(quantity/config.multiplier)..'' or ""
    if (( oldQ.buys.mark ~= mark) or (oldQ.buys.time ~= time)) and (mark ~= "") then
        if oldQ.buys.time == time then
            DelLabel( config.chartTag, oldQ.buys.markId)
        end

        oldQ.buys.markId    = markBuyQuote(price, quantity,time)

        oldQ.buys.mark  = mark
        oldQ.buys.time  = time
    end
end

function OnQuote(class, sec )
    if class == config.class and sec == config.sec then
        local quotes = getQuoteLevel2 ( config.class , config.sec)
        if quotes.bid ~= nil and quotes.bid ~= "" then
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
