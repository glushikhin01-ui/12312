
-------------------------------------------------
-- Set Model
-------------------------------------------------
ba.cmd.Create('SetModel', function(pl, args)
    args.target:SetModel(args.model)
end):AddParam('player_entity', 'target'):AddParam('string', 'model'):SetFlag('D'):SetHelp('Меняет модельку'):SetIcon('icon16/Heart.png')
