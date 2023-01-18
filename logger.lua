--[[
 ласс, в который € пр€чу сбор статистики о сделках и за€вках
то есть просто методы записать/стереть, а дальше он сам
--]]


logger = {}
function logger:new()
    newObj = {
        trades      = {},
        bids        = {}
    }


    self.__index = self
    return setmetatable(newObj, self)
end


function logger:addTrade(price,quantity)
    if self.trades[price] == nil then
        self.trades[price]  = quantity
    else
        self.trades[price]  = self.trades[price] + quantity
    end
end

function logger:addBid(price,quantity)
    if self.bids[price] == nil or self.bids[price] < quantity then
        self.bids[price] = quantity
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

function logger:getMaxBid()
    local priceMax      = 0
    local quantityMax   = 0
    for price, quantity in pairs(self.bids) do
        if quantity > quantityMax then
            quantityMax = quantity
            priceMax    = price
        end
    end

    return priceMax, quantityMax
end

-- ќтладочна€ функци€
function logger:printTrades()
    message(" ")
    for price, quantity in pairs(self.trades) do
        message(price..": "..quantity)
    end
end

-- ќтладочна€ функци€
function logger:printBids()
    message(" ")
    for price, quantity in pairs(self.bids) do
        message(price..": "..quantity)
    end
end

-- мы периодически обнул€ем накопленное
function logger:clear()
    self.trades = {}
    self.bids   = {}
end