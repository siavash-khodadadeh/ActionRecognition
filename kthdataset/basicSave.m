function basicSave(address, data, useAscii)
    if useAscii == true
        save(address, data, '-ascii');
    else
        save(address, data);
    end
end