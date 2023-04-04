-- ���� ����� ��������� �����, ������ ��� ��� �� �������� ����� ��������� �����/�������

function markSellQuote(price,volume,time)
    return AddLabel(config.chartTag, {
        TEXT        = math.floor(volume/config.multiplier)..'',
        IMAGE_PATH  = "",

        ALIGNMENT   = "TOP",

        YVALUE   = price,
        DATE     = os.date("%Y%m%d"),
        TIME     = time,

        R              = 255,
        G              = 0,
        B              = 0,
        TRANSPARENCY   = 0,

        TRANSPARENT_BACKGROUND  = 1,
        FONT_FACE_NAME          = "Arial",
        FONT_HEIGHT             = 9,
        HINT                    = "������ ������� "..price..":"..volume,
      })
end

function markBuyQuote(price,volume,time)
    return AddLabel(config.chartTag, {
        TEXT        = math.floor(volume/config.multiplier)..'',
        IMAGE_PATH  = "",

        ALIGNMENT   = "BOTTOM",

        YVALUE   = price,
        DATE     = os.date("%Y%m%d"),
        TIME     = time,

        R              = 0,
        G              = 255,
        B              = 0,
        TRANSPARENCY   = 0,

        TRANSPARENT_BACKGROUND  = 1,
        FONT_FACE_NAME          = "Arial",
        FONT_HEIGHT             = 9,
        HINT                    = "������ ������� "..price..":"..volume,
      })
end

function markCenterSellTrade(price,volume,time)
    return AddLabel(config.chartTag, {
        TEXT        = math.floor(volume/config.multiplier)..'',
        IMAGE_PATH  = "",

        ALIGNMENT   = "TOP",

        YVALUE   = price,
        DATE     = os.date("%Y%m%d"),
        TIME     = time,

        R              = 255,
        G              = 255,
        B              = 0,
        TRANSPARENCY   = 0,

        TRANSPARENT_BACKGROUND  = 1,
        FONT_FACE_NAME          = "Arial",
        FONT_HEIGHT             = 9,
        HINT                    = "������ ������� "..price..":"..volume,
      })
end

function markCenterBuyTrade(price,volume,time)
    return AddLabel(config.chartTag, {
        TEXT        = math.floor(volume/config.multiplier)..'',
        IMAGE_PATH  = "",

        ALIGNMENT   = "BOTTOM",

        YVALUE   = price,
        DATE     = os.date("%Y%m%d"),
        TIME     = time,

        R              = 179,
        G              = 255,
        B              = 255,
        TRANSPARENCY   = 0,

        TRANSPARENT_BACKGROUND  = 1,
        FONT_FACE_NAME          = "Arial",
        FONT_HEIGHT             = 9,
        HINT                    = "������ ������� "..price..":"..volume,
      })
end
