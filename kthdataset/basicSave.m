function basicSave(address, data, useAscii)
    if useAscii == logical('true')
        save(address, data, '-ascii');
    else
        save(address, data);
    end
end