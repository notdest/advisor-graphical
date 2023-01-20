dofile (getScriptPath() .. "\\logger.lua")

config  = {
    class       = "TQBR",
    sec         = "SBER",
    minTrade    = 100,          -- Минимальная сделка отображаемая на графике
    minBid      = 1000          -- Минимальная ставка в стакане, отображаемая на графике
}

is_run = true

function main()
    local seconds = 0

    while is_run do
        date    = os.date("*t")
        if seconds > date.sec then
            STPrice,STQuantity = sales:getMaxTrade()
            BTPrice,BTQuantity = buys:getMaxTrade()


            SBPrice,SBQuantity = sales:getMaxBid()
            BBPrice,BBQuantity = buys:getMaxBid()

            if STQuantity > config.minTrade then
                markSellTrade(STPrice, STQuantity)
            end

            if BTQuantity > config.minTrade then
                markBuyTrade(BTPrice, BTQuantity)
            end

            if SBQuantity > config.minBid then
                markSellBid(SBPrice, SBQuantity)
            end

            if BBQuantity > config.minBid then
                markBuyBid(BBPrice, BBQuantity)
            end

            sales:clear()
            buys:clear()
        end
        seconds = date.sec

        sleep(400)
    end
end

function OnQuote(class, sec )
    if class == config.class and sec == config.sec then
        local quotes = getQuoteLevel2 ( config.class , config.sec)
        for k, v in pairs(quotes.bid) do
            buys:addBid(v.price,tonumber(v.quantity))
        end

        for k, v in pairs(quotes.offer) do
            sales:addBid(v.price,tonumber(v.quantity))
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





function markSellBid(price,volume)
    date    = os.date("*t",os.time()-30)
    AddLabel("share",{
        TEXT        = math.floor(volume/1000)..'',
        IMAGE_PATH  = "",
        
        ALIGNMENT   = "TOP",

        YVALUE   = tonumber(price),
        DATE     = os.date("%Y%m%d"),
        TIME     = date.hour..date.min.."00",

        R              = 255,
        G              = 0,
        B              = 0,
        TRANSPARENCY   = 0,

        TRANSPARENT_BACKGROUND  = 1,
        FONT_FACE_NAME          = "Arial",
        FONT_HEIGHT             = 9,
        HINT                    = "Заявка продажа "..price..":"..volume,
      })
end

function markBuyBid(price,volume)
    date    = os.date("*t",os.time()-30)
    AddLabel("share",{
        TEXT        = math.floor(volume/1000)..'',
        IMAGE_PATH  = "",
        
        ALIGNMENT   = "BOTTOM",

        YVALUE   = tonumber(price),
        DATE     = os.date("%Y%m%d"),
        TIME     = date.hour..date.min.."00",

        R              = 0,
        G              = 255,
        B              = 0,
        TRANSPARENCY   = 0,

        TRANSPARENT_BACKGROUND  = 1,
        FONT_FACE_NAME          = "Arial",
        FONT_HEIGHT             = 9,
        HINT                    = "Заявка покупка "..price..":"..volume,
      })
end

function markSellTrade(price,volume)
    date    = os.date("*t",os.time()-30)
    AddLabel("share",{
        TEXT        = math.floor(volume/1000)..'',
        IMAGE_PATH  = "",
        
        ALIGNMENT   = "TOP",

        YVALUE   = tonumber(price),
        DATE     = os.date("%Y%m%d"),
        TIME     = date.hour..date.min.."00",

        R              = 255,
        G              = 255,
        B              = 0,
        TRANSPARENCY   = 0,

        TRANSPARENT_BACKGROUND  = 1,
        FONT_FACE_NAME          = "Arial",
        FONT_HEIGHT             = 9,
        HINT                    = "Сделка продажа "..price..":"..volume,
      })
end

function markBuyTrade(price,volume)
    date    = os.date("*t",os.time()-30)
    AddLabel("share",{
        TEXT        = math.floor(volume/1000)..'',
        IMAGE_PATH  = "",
        
        ALIGNMENT   = "BOTTOM",

        YVALUE   = tonumber(price),
        DATE     = os.date("%Y%m%d"),
        TIME     = date.hour..date.min.."00",

        R              = 0,
        G              = 150,
        B              = 255,
        TRANSPARENCY   = 0,

        TRANSPARENT_BACKGROUND  = 1,
        FONT_FACE_NAME          = "Arial",
        FONT_HEIGHT             = 9,
        HINT                    = "Сделка покупка "..price..":"..volume,
      })
end