--[[
�����, � ������� � ����� ���� ���������� � ������� � �������
�� ���� ������ ������ ��������/�������, � ������ �� ���
--]]


logger = {}
function logger:new()
    date    = os.date("*t")
    newObj = {
        trades      = {},
        quotes      = {},
        time        = string.format("%02d%02d00" , date.hour,date.min)
    }


    self.__index = self
    return setmetatable(newObj, self)
end

-- ������, �� ������� ���������� ������
function logger:getTime()
    return self.time
end

function logger:addTrade(price,quantity)
    price    = tonumber(price)
    quantity = tonumber(quantity)

    if self.trades[price] == nil then
        self.trades[price]  = quantity
    else
        self.trades[price]  = self.trades[price] + quantity
    end
end

function logger:addQuote(price,quantity)
    price    = tonumber(price)
    quantity = tonumber(quantity)
    if self.quotes[price] == nil or self.quotes[price] < quantity then
        self.quotes[price] = quantity
    end
end

function logger:getMaxTrade()
    local priceMax      = 0
    local quantityMax   = 0
    for price, quantity in pairs(self.trades) do
        if quantity > quantityMax then
            quantityMax = quantity
            priceMax    = price
        end
    end

    return priceMax, quantityMax
end

function logger:getMaxQuote()
    local priceMax      = 0
    local quantityMax   = 0
    for price, quantity in pairs(self.quotes) do
        if quantity > quantityMax then
            quantityMax = quantity
            priceMax    = price
        end
    end

    return priceMax, quantityMax
end

-- ���������� "����� ����" - ������� ���� � ����� ���������
function logger:getCenterQuote()
    local centerPrice   = 0
    local quantitySum   = 0
    local weightedSum   = 0

    for price, quantity in pairs(self.quotes) do
        quantitySum = quantitySum + quantity
        weightedSum = weightedSum + price*quantity
    end

    centerPrice = weightedSum/quantitySum
    centerPrice = math.floor(centerPrice*100 + 0.5)/100

    return centerPrice, quantitySum
end

-- ���������� "����� ����" - ������� ���� � ����� ������
function logger:getCenterTrade()
    local centerPrice   = 0
    local quantitySum   = 0
    local weightedSum   = 0

    for price, quantity in pairs(self.trades) do
        quantitySum = quantitySum + quantity
        weightedSum = weightedSum + price*quantity
    end

    centerPrice = weightedSum/quantitySum
    centerPrice = math.floor(centerPrice*100 + 0.5)/100

    return centerPrice, quantitySum
end

-- ���������� �������
function logger:printTrades()
    message(" ")
    for price, quantity in pairs(self.trades) do
        message(price..": "..quantity)
    end
end

-- ���������� �������
function logger:printQuotes()
    message(" ")
    for price, quantity in pairs(self.quotes) do
        message(price..": "..quantity)
    end
end

-- �� ������������ �������� �����������
function logger:clear()
    date    = os.date("*t")
    self.trades = {}
    self.quotes = {}
    self.time   = string.format("%02d%02d00" , date.hour,date.min)
end