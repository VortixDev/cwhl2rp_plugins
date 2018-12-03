function Schema:LoadCombineLocks()
	local combineLocks = Clockwork.kernel:RestoreSchemaData("plugins/locks/"..game.GetMap());
	
	for k, v in pairs(combineLocks) do
		local entity = ents.GetMapCreatedEntity(v.doorMapCreation);
		
		if (IsValid(entity)) then
			local combineLock = self:ApplyCombineLock(entity);
			
			if (combineLock) then
				Clockwork.player:GivePropertyOffline(v.key, v.uniqueID, entity);
				
				combineLock:SetLocalAngles(v.angles);
				combineLock:SetLocalPos(v.position);
				
				if (!v.locked) then
					combineLock:Unlock();
				else
					combineLock:Lock();
				end;
			end;
		end;
	end;
end;

function Schema:SaveCombineLocks()
	local combineLocks = {};
	
	for k, v in pairs(ents.FindByClass("cw_combinelock")) do
		if (IsValid(v.entity)) then
			combineLocks[#combineLocks + 1] = {
				doorMapCreation = v.entity:MapCreationID(),
				key = Clockwork.entity:QueryProperty(v, "key"),
				locked = v:IsLocked(),
				angles = v:GetLocalAngles(),
				position = v:GetLocalPos(),
				uniqueID = Clockwork.entity:QueryProperty(v, "uniqueID"),
				doorPosition = v.entity:GetPos()
			};
		end;
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/locks/" .. game.GetMap(), combineLocks);
end;
