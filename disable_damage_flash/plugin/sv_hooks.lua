function PLUGIN:PlayerTakeDamage()
	local shouldHideFlash = Clockwork.config:Get("disable_damage_flash"):Get();

	if (shouldHideFlash) then
		return true;
	end;
end;
