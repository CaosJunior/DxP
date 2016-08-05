function getItemAttack(item)
	return getItemAttribute(item.uid, "attack") or getItemInfo(item.itemid).attack
end

function getItemDefense(item)
	return getItemAttribute(item.uid, "defense") or getItemInfo(item.itemid).defense
end

function getItemArmor(item)
	return getItemAttribute(item.uid, "armor") or getItemInfo(item.itemid).armor
end

function getItemExtraAttack(item)
	return getItemAttribute(item.uid, "extraattack") or getItemInfo(item.itemid).extraattack
end

function getItemExtraDefense(item)
	return getItemAttribute(item.uid, "extradefense") or getItemInfo(item.itemid).extradefense
end

function setItemAttack(item, value)
	return doItemSetAttribute(item.uid, "attack", value)
end

function setItemDefense(item, value)
	return doItemSetAttribute(item.uid, "defense", value)
end

function setItemArmor(item, value)
	return doItemSetAttribute(item.uid, "armor", value)
end

function setItemExtraAttack(item, value)
	return doItemSetAttribute(item.uid, "extraattack", value)
end

function setItemExtraDefense(item, value)
	return doItemSetAttribute(item.uid, "extradefense", value)
end

function isWeapon(item)
	return isInArray({1, 2, 3}, getItemWeaponType(item.uid))
end

function isShield(item)
	return (getItemWeaponType(item.uid) == 5 and true or false)
end

function isArmor(item)
	return (getItemWeaponType(item.uid) == 0 and true or false)
end