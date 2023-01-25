-- сюда вынес отрисовку метод, потому что это по большому счёту настройки цвета/шрифтов

function markSellQuote(price,volume)
    date    = os.date("*t",os.time()-30)
    AddLabel("share",{
        TEXT        = math.floor(volume/1000)..'',
        IMAGE_PATH  = "",

        ALIGNMENT   = "TOP",

        YVALUE   = price,
        DATE     = os.date("%Y%m%d"),
        TIME     = string.format("%02d%02d00" , date.hour,date.min),

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

function markBuyQuote(price,volume)
    date    = os.date("*t",os.time()-30)
    AddLabel("share",{
        TEXT        = math.floor(volume/1000)..'',
        IMAGE_PATH  = "",

        ALIGNMENT   = "BOTTOM",

        YVALUE   = price,
        DATE     = os.date("%Y%m%d"),
        TIME     = string.format("%02d%02d00" , date.hour,date.min),

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
        TEXT        = math.floor(volume/1000).."*",
        IMAGE_PATH  = "",

        ALIGNMENT   = "TOP",

        YVALUE   = price,
        DATE     = os.date("%Y%m%d"),
        TIME     = string.format("%02d%02d00" , date.hour,date.min),

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
        TEXT        = math.floor(volume/1000).."*",
        IMAGE_PATH  = "",

        ALIGNMENT   = "BOTTOM",

        YVALUE   = price,
        DATE     = os.date("%Y%m%d"),
        TIME     = string.format("%02d%02d00" , date.hour,date.min),

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


function markCenterSellQuote(price,volume)
    date    = os.date("*t",os.time()-30)
    AddLabel("share",{
        TEXT        = math.floor(volume/1000)..'c',
        IMAGE_PATH  = "",

        ALIGNMENT   = "TOP",

        YVALUE   = price,
        DATE     = os.date("%Y%m%d"),
        TIME     = string.format("%02d%02d00" , date.hour,date.min),

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

function markCenterBuyQuote(price,volume)
    date    = os.date("*t",os.time()-30)
    AddLabel("share",{
        TEXT        = math.floor(volume/1000)..'c',
        IMAGE_PATH  = "",

        ALIGNMENT   = "BOTTOM",

        YVALUE   = price,
        DATE     = os.date("%Y%m%d"),
        TIME     = string.format("%02d%02d00" , date.hour,date.min),

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

function markCenterSellTrade(price,volume)
    date    = os.date("*t",os.time()-30)
    AddLabel("share",{
        TEXT        = math.floor(volume/1000)..'',
        IMAGE_PATH  = "",

        ALIGNMENT   = "TOP",

        YVALUE   = price,
        DATE     = os.date("%Y%m%d"),
        TIME     = string.format("%02d%02d00" , date.hour,date.min),

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

function markCenterBuyTrade(price,volume)
    date    = os.date("*t",os.time()-30)
    AddLabel("share",{
        TEXT        = math.floor(volume/1000)..'',
        IMAGE_PATH  = "",

        ALIGNMENT   = "BOTTOM",

        YVALUE   = price,
        DATE     = os.date("%Y%m%d"),
        TIME     = string.format("%02d%02d00" , date.hour,date.min),

        R              = 179,
        G              = 255,
        B              = 255,
        TRANSPARENCY   = 0,

        TRANSPARENT_BACKGROUND  = 1,
        FONT_FACE_NAME          = "Arial",
        FONT_HEIGHT             = 9,
        HINT                    = "Сделка покупка "..price..":"..volume,
      })
end
