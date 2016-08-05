////////////////////////////////////////////////////////////////////////
// OpenTibia - an opensource roleplaying game
////////////////////////////////////////////////////////////////////////
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
////////////////////////////////////////////////////////////////////////
#include "otpch.h"
#include <iostream>
#include <iomanip>

#include "tools.h"
#include "md5.h"
#include "sha1.h"

#include "vocation.h"
#include "configmanager.h"
extern ConfigManager g_config;

std::string transformToSHA1(std::string plainText, bool upperCase)
{
	SHA1 sha1;
	unsigned sha1Hash[5];
	std::stringstream hexStream;

	sha1.Input((const uint8_t*)plainText.c_str(), plainText.length());
	sha1.Result(sha1Hash);

	hexStream.flags(std::ios::hex | std::ios::uppercase);
	for(uint32_t i = 0; i < 5; ++i)
		hexStream << std::setw(8) << std::setfill('0') << (uint32_t)sha1Hash[i];

	std::string hexStr = hexStream.str();
	if(!upperCase)
		toLowerCaseString(hexStr);

	return hexStr;
}

std::string transformToMD5(std::string plainText, bool upperCase)
{
	MD5_CTX m_md5;
	std::stringstream hexStream;

	MD5Init(&m_md5, 0);
	MD5Update(&m_md5, (const uint8_t*)plainText.c_str(), plainText.length());
	MD5Final(&m_md5);

	hexStream.flags(std::ios::hex | std::ios::uppercase);
	for(uint32_t i = 0; i < 16; ++i)
		hexStream << std::setw(2) << std::setfill('0') << (uint32_t)m_md5.digest[i];

	std::string hexStr = hexStream.str();
	if(!upperCase)
		toLowerCaseString(hexStr);

	return hexStr;
}

void _encrypt(std::string& str, bool upperCase)
{
	switch(g_config.getNumber(ConfigManager::ENCRYPTION))
	{
		case ENCRYPTION_MD5:
			str = transformToMD5(str, upperCase);
			break;
		case ENCRYPTION_SHA1:
			str = transformToSHA1(str, upperCase);
			break;
		default:
		{
			if(upperCase)
				std::transform(str.begin(), str.end(), str.begin(), upchar);

			break;
		}
	}
}

bool encryptTest(std::string plain, std::string& hash)
{
	std::transform(hash.begin(), hash.end(), hash.begin(), upchar);
	_encrypt(plain, true);
	return plain == hash;
}

void replaceString(std::string& text, const std::string key, const std::string value)
{
	if(value.find(key) != std::string::npos) //don't allow infinite loops
		return;

	for(std::string::size_type keyStart = text.find(key); keyStart
		!= std::string::npos; keyStart = text.find(key))
		text.replace(keyStart, key.size(), value);
}

void trim_right(std::string& source, const std::string& t)
{
	source.erase(source.find_last_not_of(t)+1);
}

void trim_left(std::string& source, const std::string& t)
{
	source.erase(0, source.find_first_not_of(t));
}

void toLowerCaseString(std::string& source)
{
	std::transform(source.begin(), source.end(), source.begin(), tolower);
}

void toUpperCaseString(std::string& source)
{
	std::transform(source.begin(), source.end(), source.begin(), upchar);
}

std::string asLowerCaseString(const std::string& source)
{
	std::string s = source;
	toLowerCaseString(s);
	return s;
}

std::string asUpperCaseString(const std::string& source)
{
	std::string s = source;
	toUpperCaseString(s);
	return s;
}

bool booleanString(std::string source)
{
	toLowerCaseString(source);
	return (source == "yes" || source == "true" || atoi(source.c_str()) > 0);
}

bool readXMLInteger(xmlNodePtr node, const char* tag, int& value)
{
	char* nodeValue = (char*)xmlGetProp(node, (xmlChar*)tag);
	if(!nodeValue)
		return false;

	value = atoi(nodeValue);
	xmlFree(nodeValue);
	return true;
}

#if defined WINDOWS && !defined __GNUC__
bool readXMLInteger(xmlNodePtr node, const char* tag, int32_t& value)
{
	char* nodeValue = (char*)xmlGetProp(node, (xmlChar*)tag);
	if(!nodeValue)
		return false;

	value = atoi(nodeValue);
	xmlFree(nodeValue);
	return true;
}
#endif

bool readXMLInteger64(xmlNodePtr node, const char* tag, int64_t& value)
{
	char* nodeValue = (char*)xmlGetProp(node, (xmlChar*)tag);
	if(!nodeValue)
		return false;

	value = atoll(nodeValue);
	xmlFree(nodeValue);
	return true;
}

bool readXMLFloat(xmlNodePtr node, const char* tag, float& value)
{
	char* nodeValue = (char*)xmlGetProp(node, (xmlChar*)tag);
	if(!nodeValue)
		return false;

	value = atof(nodeValue);
	xmlFree(nodeValue);
	return true;
}

bool readXMLString(xmlNodePtr node, const char* tag, std::string& value)
{
	char* nodeValue = (char*)xmlGetProp(node, (xmlChar*)tag);
	if(!nodeValue)
		return false;

	if(!utf8ToLatin1(nodeValue, value))
		value = nodeValue;

	xmlFree(nodeValue);
	return true;
}

bool readXMLContentString(xmlNodePtr node, std::string& value)
{
	char* nodeValue = (char*)xmlNodeGetContent(node);
	if(!nodeValue)
		return false;

	if(!utf8ToLatin1(nodeValue, value))
		value = nodeValue;

	xmlFree(nodeValue);
	return true;
}

bool parseXMLContentString(xmlNodePtr node, std::string& value)
{
	bool result = false;
	std::string compareValue;
	while(node)
	{
		if(xmlStrcmp(node->name, (const xmlChar*)"text") && node->type != XML_CDATA_SECTION_NODE)
		{
			node = node->next;
			continue;
		}

		if(!readXMLContentString(node, compareValue))
		{
			node = node->next;
			continue;
		}

		trim_left(compareValue, "\r");
		trim_left(compareValue, "\n");
		trim_left(compareValue, " ");
		if(compareValue.length() > value.length())
		{
			value = compareValue;
			if(!result)
				result = true;
		}

		node = node->next;
	}

	return result;
}

std::string getLastXMLError()
{
	std::stringstream ss;
	xmlErrorPtr lastError = xmlGetLastError();
	if(lastError->line)
		ss << "Line: " << lastError->line << ", ";

	ss << "Info: " << lastError->message << std::endl;
	return ss.str();
}

bool utf8ToLatin1(char* intext, std::string& outtext)
{
	outtext = "";
	if(!intext)
		return false;

	int32_t inlen = strlen(intext);
	if(!inlen)
		return false;

	int32_t outlen = inlen * 2;
	uint8_t* outbuf = new uint8_t[outlen];

	int32_t res = UTF8Toisolat1(outbuf, &outlen, (uint8_t*)intext, &inlen);
	if(res < 0)
	{
		delete[] outbuf;
		return false;
	}

	outbuf[outlen] = '\0';
	outtext = (char*)outbuf;

	delete[] outbuf;
	return true;
}

StringVec explodeString(const std::string& string, const std::string& separator)
{
	StringVec returnVector;
	size_t start = 0, end = 0;
	while((end = string.find(separator, start)) != std::string::npos)
	{
		returnVector.push_back(string.substr(start, end - start));
		start = end + separator.size();
	}

	returnVector.push_back(string.substr(start));
	return returnVector;
}

IntegerVec vectorAtoi(StringVec stringVector)
{
	IntegerVec returnVector;
	for(StringVec::iterator it = stringVector.begin(); it != stringVector.end(); ++it)
		returnVector.push_back(atoi((*it).c_str()));

	return returnVector;
}

bool hasBitSet(uint32_t flag, uint32_t flags)
{
	return ((flags & flag) == flag);
}

int32_t round(float v)
{
	int32_t t = (int32_t)std::floor(v);
	if((v - t) > 0.5)
		return t + 1;

	return t;
}

uint32_t rand24b()
{
	return ((rand() << 12) ^ (rand())) & (0xFFFFFF);
}

float box_muller(float m, float s)
{
	// normal random variate generator
	// mean m, standard deviation s
	float x1, x2, w, y1;
	static float y2;

	static bool useLast = false;
	if(useLast) // use value from previous call
	{
		y1 = y2;
		useLast = false;
		return (m + y1 * s);
	}

	do
	{
		double r1 = (((float)(rand()) / RAND_MAX));
		double r2 = (((float)(rand()) / RAND_MAX));

		x1 = 2.0 * r1 - 1.0;
		x2 = 2.0 * r2 - 1.0;
		w = x1 * x1 + x2 * x2;
	}
	while(w >= 1.0);
	w = sqrt((-2.0 * log(w)) / w);

	y1 = x1 * w;
	y2 = x2 * w;

	useLast = true;
	return (m + y1 * s);
}

int32_t random_range(int32_t lowestNumber, int32_t highestNumber, DistributionType_t type /*= DISTRO_UNIFORM*/)
{
	if(highestNumber == lowestNumber)
		return lowestNumber;

	if(lowestNumber > highestNumber)
		std::swap(lowestNumber, highestNumber);

	switch(type)
	{
		case DISTRO_UNIFORM:
			return (lowestNumber + ((int32_t)rand24b() % (highestNumber - lowestNumber + 1)));
		case DISTRO_NORMAL:
			return (lowestNumber + int32_t(float(highestNumber - lowestNumber) * (float)std::min((float)1, std::max((float)0, box_muller(0.5, 0.25)))));
		default:
			break;
	}

	const float randMax = 16777216;
	return (lowestNumber + int32_t(float(highestNumber - lowestNumber) * float(1.f - sqrt((1.f * rand24b()) / randMax))));
}

char upchar(char character)
{
	if((character >= 97 && character <= 122) || (character <= -1 && character >= -32))
		character -= 32;

	return character;
}

bool isNumber(char character)
{
	return (character >= 48 && character <= 57);
}

bool isLowercaseLetter(char character)
{
	return (character >= 97 && character <= 122);
}

bool isUppercaseLetter(char character)
{
	return (character >= 65 && character <= 90);
}

bool isPasswordCharacter(char character)
{
	return ((character >= 33 && character <= 47) || (character >= 58 && character <= 64) || (character >= 91 && character <= 96) || (character >= 123 && character <= 126));
}

bool isValidAccountName(std::string text)
{
	toLowerCaseString(text);

	uint32_t textLength = text.length();
	for(uint32_t size = 0; size < textLength; size++)
	{
		if(!isLowercaseLetter(text[size]) && !isNumber(text[size]))
			return false;
	}

	return true;
}

bool isValidPassword(std::string text)
{
	toLowerCaseString(text);

	uint32_t textLength = text.length();
	for(uint32_t size = 0; size < textLength; size++)
	{
		if(!isLowercaseLetter(text[size]) && !isNumber(text[size]) && !isPasswordCharacter(text[size]))
			return false;
	}

	return true;
}

bool isValidName(std::string text, bool forceUppercaseOnFirstLetter/* = true*/)
{
	uint32_t textLength = text.length(), lenBeforeSpace = 1, lenBeforeQuote = 1, lenBeforeDash = 1, repeatedCharacter = 0;
	char lastChar = 32;
	if(forceUppercaseOnFirstLetter)
	{
		if(!isUppercaseLetter(text[0]))
			return false;
	}
	else if(!isLowercaseLetter(text[0]) && !isUppercaseLetter(text[0]))
		return false;

	for(uint32_t size = 1; size < textLength; size++)
	{
		if(text[size] != 32)
		{
			lenBeforeSpace++;

			if(text[size] != 39)
				lenBeforeQuote++;
			else
			{
				if(lenBeforeQuote <= 1 || size == textLength - 1 || text[size + 1] == 32)
					return false;

				lenBeforeQuote = 0;
			}

			if(text[size] != 45)
				lenBeforeDash++;
			else
			{
				if(lenBeforeDash <= 1 || size == textLength - 1 || text[size + 1] == 32)
					return false;

				lenBeforeDash = 0;
			}

			if(text[size] == lastChar)
			{
				repeatedCharacter++;
				if(repeatedCharacter > 2)
					return false;
			}
			else
				repeatedCharacter = 0;

			lastChar = text[size];
		}
		else
		{
			if(lenBeforeSpace <= 1 || size == textLength - 1 || text[size + 1] == 32)
				return false;

			lenBeforeSpace = lenBeforeQuote = lenBeforeDash = 0;
		}

		if(!(isLowercaseLetter(text[size]) || text[size] == 32 || text[size] == 39 || text[size] == 45
			|| (isUppercaseLetter(text[size]) && text[size - 1] == 32)))
			return false;
	}

	return true;
}

bool isNumbers(std::string text)
{
	uint32_t textLength = text.length();
	for(uint32_t size = 0; size < textLength; size++)
	{
		if(!isNumber(text[size]))
			return false;
	}

	return true;
}

bool checkText(std::string text, std::string str)
{
	trimString(text);
	return asLowerCaseString(text) == str;
}

std::string generateRecoveryKey(int32_t fieldCount, int32_t fieldLenght)
{
	std::stringstream key;
	int32_t i = 0, j = 0, lastNumber = 99, number = 0;

	char character = 0, lastCharacter = 0;
	bool madeNumber = false, madeCharacter = false;
	do
	{
		do
		{
			madeNumber = madeCharacter = false;
			if((bool)random_range(0, 1))
			{
				number = random_range(2, 9);
				if(number != lastNumber)
				{
					key << number;
					lastNumber = number;
					madeNumber = true;
				}
			}
			else
			{
				character = (char)random_range(65, 90);
				if(character != lastCharacter)
				{
					key << character;
					lastCharacter = character;
					madeCharacter = true;
				}
			}
		}
		while((!madeCharacter && !madeNumber) ? true : (++j && j < fieldLenght));
		lastCharacter = character = number = j = 0;

		lastNumber = 99;
		if(i < fieldCount - 1)
			key << "-";
	}
	while(++i && i < fieldCount);
	return key.str();
}

std::string trimString(std::string& str)
{
	str.erase(str.find_last_not_of(" ") + 1);
	return str.erase(0, str.find_first_not_of(" "));
}

std::string parseParams(tokenizer::iterator &it, tokenizer::iterator end)
{
	if(it == end)
		return "";

	std::string tmp = (*it);
	++it;
	if(tmp[0] == '"')
	{
		tmp.erase(0, 1);
		while(it != end && tmp[tmp.length() - 1] != '"')
		{
			tmp += " " + (*it);
			++it;
		}

		if(tmp.length() > 0 && tmp[tmp.length() - 1] == '"')
			tmp.erase(tmp.length() - 1);
	}

	return tmp;
}

std::string formatDate(time_t _time/* = 0*/)
{
	char buffer[21];
	if(!_time)
		_time = time(NULL);

	const tm* tms = localtime(&_time);
	if(tms)
		sprintf(buffer, "%02d/%02d/%04d %02d:%02d:%02d", tms->tm_mday, tms->tm_mon + 1, tms->tm_year + 1900, tms->tm_hour, tms->tm_min, tms->tm_sec);
	else
		sprintf(buffer, "UNIX Time: %d", (int32_t)_time);

	return buffer;
}

std::string formatDateShort(time_t _time, bool detailed/* = false*/)
{
	char buffer[21];
	if(!_time)
		_time = time(NULL);

	const tm* tms = localtime(&_time);
	if(tms)
	{
		std::string format = "%d %b %Y";
		if(detailed)
			format += " %H:%M:%S";

		strftime(buffer, 25, format.c_str(), tms);
	}
	else
		sprintf(buffer, "UNIX Time: %d", (int32_t)_time);

	return buffer;
}

std::string formatTime(int32_t hours, int32_t minutes)
{
	std::stringstream time;
	if(hours)
		time << hours << " " << (hours > 1 ? "hours" : "hour") << (minutes ? " and " : "");

	if(minutes)
		time << minutes << " " << (minutes > 1 ? "minutes" : "minute");

	return time.str();
}

std::string convertIPAddress(uint32_t ip)
{
	char buffer[17];
	sprintf(buffer, "%d.%d.%d.%d", ip & 0xFF, (ip >> 8) & 0xFF, (ip >> 16) & 0xFF, (ip >> 24));
	return buffer;
}

Skulls_t getSkull(std::string strValue)
{
	std::string tmpStrValue = asLowerCaseString(strValue);
	if(tmpStrValue == "black" || tmpStrValue == "5")
		return SKULL_BLACK;
	else if(tmpStrValue == "red" || tmpStrValue == "4")
		return SKULL_RED;
	else if(tmpStrValue == "white" || tmpStrValue == "3")
		return SKULL_WHITE;
	else if(tmpStrValue == "green" || tmpStrValue == "2")
		return SKULL_GREEN;
	else if(tmpStrValue == "yellow" || tmpStrValue == "1")
		return SKULL_YELLOW;

	return SKULL_NONE;
}

PartyShields_t getPartyShield(std::string strValue)
{
	std::string tmpStrValue = asLowerCaseString(strValue);
	if(tmpStrValue == "whitenoshareoff" || tmpStrValue == "10")
		return SHIELD_YELLOW_NOSHAREDEXP;
	else if(tmpStrValue == "blueshareoff" || tmpStrValue == "9")
		return SHIELD_BLUE_NOSHAREDEXP;
	else if(tmpStrValue == "yellowshareblink" || tmpStrValue == "8")
		return SHIELD_YELLOW_NOSHAREDEXP_BLINK;
	else if(tmpStrValue == "blueshareblink" || tmpStrValue == "7")
		return SHIELD_BLUE_NOSHAREDEXP_BLINK;
	else if(tmpStrValue == "yellowshareon" || tmpStrValue == "6")
		return SHIELD_YELLOW_SHAREDEXP;
	else if(tmpStrValue == "blueshareon" || tmpStrValue == "5")
		return SHIELD_BLUE_SHAREDEXP;
	else if(tmpStrValue == "yellow" || tmpStrValue == "4")
		return SHIELD_YELLOW;
	else if(tmpStrValue == "blue" || tmpStrValue == "3")
		return SHIELD_BLUE;
	else if(tmpStrValue == "whiteyellow" || tmpStrValue == "2")
		return SHIELD_WHITEYELLOW;
	else if(tmpStrValue == "whiteblue" || tmpStrValue == "1")
		return SHIELD_WHITEBLUE;

	return SHIELD_NONE;
}

Direction getDirection(std::string string)
{
	if(string == "north" || string == "n" || string == "0")
		return NORTH;
	else if(string == "east" || string == "e" || string == "1")
		return EAST;
	else if(string == "south" || string == "s" || string == "2")
		return SOUTH;
	else if(string == "west" || string == "w" || string == "3")
		return WEST;
	else if(string == "southwest" || string == "south west" || string == "south-west" || string == "sw" || string == "4")
		return SOUTHWEST;
	else if(string == "southeast" || string == "south east" || string == "south-east" || string == "se" || string == "5")
		return SOUTHEAST;
	else if(string == "northwest" || string == "north west" || string == "north-west" || string == "nw" || string == "6")
		return NORTHWEST;
	else if(string == "northeast" || string == "north east" || string == "north-east" || string == "ne" || string == "7")
		return NORTHEAST;

	return SOUTH;
}

Direction getDirectionTo(Position pos1, Position pos2, bool extended/* = true*/)
{
	Direction direction = NORTH;
	if(pos1.x > pos2.x)
	{
		direction = WEST;
		if(extended)
		{
			if(pos1.y > pos2.y)
				direction = NORTHWEST;
			else if(pos1.y < pos2.y)
				direction = SOUTHWEST;
		}
	}
	else if(pos1.x < pos2.x)
	{
		direction = EAST;
		if(extended)
		{
			if(pos1.y > pos2.y)
				direction = NORTHEAST;
			else if(pos1.y < pos2.y)
				direction = SOUTHEAST;
		}
	}
	else
	{
		if(pos1.y > pos2.y)
			direction = NORTH;
		else if(pos1.y < pos2.y)
			direction = SOUTH;
	}

	return direction;
}

Direction getReverseDirection(Direction dir)
{
	switch(dir)
	{
		case NORTH:
			return SOUTH;
		case SOUTH:
			return NORTH;
		case WEST:
			return EAST;
		case EAST:
			return WEST;
		case SOUTHWEST:
			return NORTHEAST;
		case NORTHWEST:
			return SOUTHEAST;
		case NORTHEAST:
			return SOUTHWEST;
		case SOUTHEAST:
			return NORTHWEST;
	}

	return SOUTH;
}

Position getNextPosition(Direction direction, Position pos)
{
	switch(direction)
	{
		case NORTH:
			pos.y--;
			break;
		case SOUTH:
			pos.y++;
			break;
		case WEST:
			pos.x--;
			break;
		case EAST:
			pos.x++;
			break;
		case SOUTHWEST:
			pos.x--;
			pos.y++;
			break;
		case NORTHWEST:
			pos.x--;
			pos.y--;
			break;
		case SOUTHEAST:
			pos.x++;
			pos.y++;
			break;
		case NORTHEAST:
			pos.x++;
			pos.y--;
			break;
	}

	return pos;
}

struct AmmoTypeNames
{
	const char* name;
	Ammo_t ammoType;
};

struct MagicEffectNames
{
	const char* name;
	MagicEffect_t magicEffect;
};

struct ShootTypeNames
{
	const char* name;
	ShootEffect_t shootType;
};

struct CombatTypeNames
{
	const char* name;
	CombatType_t combatType;
};

struct AmmoActionNames
{
	const char* name;
	AmmoAction_t ammoAction;
};

struct FluidTypeNames
{
	const char* name;
	FluidTypes_t fluidType;
};

struct SkillIdNames
{
	const char* name;
	skills_t skillId;
};

MagicEffectNames magicEffectNames[] =
{
	{"redspark",		MAGIC_EFFECT_DRAW_BLOOD},
	{"bluebubble",		MAGIC_EFFECT_LOSE_ENERGY},
	{"poff",		MAGIC_EFFECT_POFF},
	{"yellowspark",		MAGIC_EFFECT_BLOCKHIT},
	{"explosionarea",	MAGIC_EFFECT_EXPLOSION_AREA},
	{"explosion",		MAGIC_EFFECT_EXPLOSION_DAMAGE},
	{"firearea",		MAGIC_EFFECT_FIRE_AREA},
	{"yellowbubble",	MAGIC_EFFECT_YELLOW_RINGS},
	{"greenbubble",		MAGIC_EFFECT_POISON_RINGS},
	{"blackspark",		MAGIC_EFFECT_HIT_AREA},
	{"teleport",		MAGIC_EFFECT_TELEPORT},
	{"energy",		MAGIC_EFFECT_ENERGY_DAMAGE},
	{"blueshimmer",		MAGIC_EFFECT_WRAPS_BLUE},
	{"redshimmer",		MAGIC_EFFECT_WRAPS_RED},
	{"greenshimmer",	MAGIC_EFFECT_WRAPS_GREEN},
	{"fire",		MAGIC_EFFECT_HITBY_FIRE},
	{"greenspark",		MAGIC_EFFECT_POISON},
	{"mortarea",		MAGIC_EFFECT_MORT_AREA},
	{"greennote",		MAGIC_EFFECT_SOUND_GREEN},
	{"rednote",		MAGIC_EFFECT_SOUND_RED},
	{"poison",		MAGIC_EFFECT_POISON_AREA},
	{"yellownote",		MAGIC_EFFECT_SOUND_YELLOW},
	{"purplenote",		MAGIC_EFFECT_SOUND_PURPLE},
	{"bluenote",		MAGIC_EFFECT_SOUND_BLUE},
	{"whitenote",		MAGIC_EFFECT_SOUND_WHITE},
	{"bubbles",		MAGIC_EFFECT_BUBBLES},
	{"dice",		MAGIC_EFFECT_CRAPS},
	{"giftwraps",		MAGIC_EFFECT_GIFT_WRAPS},
	{"yellowfirework",	MAGIC_EFFECT_FIREWORK_YELLOW},
	{"redfirework",		MAGIC_EFFECT_FIREWORK_RED},
	{"bluefirework",	MAGIC_EFFECT_FIREWORK_BLUE},
	{"stun",		MAGIC_EFFECT_STUN},
	{"sleep",		MAGIC_EFFECT_SLEEP},
	{"watercreature",	MAGIC_EFFECT_WATERCREATURE},
	{"groundshaker",	MAGIC_EFFECT_GROUNDSHAKER},
	{"hearts",		MAGIC_EFFECT_HEARTS},
	{"fireattack",		MAGIC_EFFECT_FIREATTACK},
	{"energyarea",		MAGIC_EFFECT_ENERGY_AREA},
	{"smallclouds",		MAGIC_EFFECT_SMALLCLOUDS},
	{"holydamage",		MAGIC_EFFECT_HOLYDAMAGE},
	{"bigclouds",		MAGIC_EFFECT_BIGCLOUDS},
	{"icearea",		MAGIC_EFFECT_ICEAREA},
	{"icetornado",		MAGIC_EFFECT_ICETORNADO},
	{"iceattack",		MAGIC_EFFECT_ICEATTACK},
	{"stones",		MAGIC_EFFECT_STONES},
	{"smallplants",		MAGIC_EFFECT_SMALLPLANTS},
	{"carniphila",		MAGIC_EFFECT_CARNIPHILA},
	{"purpleenergy",	MAGIC_EFFECT_PURPLEENERGY},
	{"yellowenergy",	MAGIC_EFFECT_YELLOWENERGY},
	{"holyarea",		MAGIC_EFFECT_HOLYAREA},
	{"bigplants",		MAGIC_EFFECT_BIGPLANTS},
	{"cake",		MAGIC_EFFECT_CAKE},
	{"giantice",		MAGIC_EFFECT_GIANTICE},
	{"watersplash",		MAGIC_EFFECT_WATERSPLASH},
	{"plantattack",		MAGIC_EFFECT_PLANTATTACK},
	{"tutorialarrow",	MAGIC_EFFECT_TUTORIALARROW},
	{"tutorialsquare",	MAGIC_EFFECT_TUTORIALSQUARE},
	{"mirrorhorizontal",	MAGIC_EFFECT_MIRRORHORIZONTAL},
	{"mirrorvertical",	MAGIC_EFFECT_MIRRORVERTICAL},
	{"skullhorizontal",	MAGIC_EFFECT_SKULLHORIZONTAL},
	{"skullvertical",	MAGIC_EFFECT_SKULLVERTICAL},
	{"assassin",		MAGIC_EFFECT_ASSASSIN},
	{"stepshorizontal",	MAGIC_EFFECT_STEPSHORIZONTAL},
	{"bloodysteps",		MAGIC_EFFECT_BLOODYSTEPS},
	{"stepsvertical",	MAGIC_EFFECT_STEPSVERTICAL},
	{"yalaharighost",	MAGIC_EFFECT_YALAHARIGHOST},
	{"bats",		MAGIC_EFFECT_BATS},
	{"smoke",		MAGIC_EFFECT_SMOKE},
	{"insects",		MAGIC_EFFECT_INSECTS},

	{"random1",    MAGIC_EFFECT_RANDOM1},//edited \/
    {"random2",    MAGIC_EFFECT_RANDOM2},
    {"random3",    MAGIC_EFFECT_RANDOM3},
    {"random4",    MAGIC_EFFECT_RANDOM4},
    {"random5",    MAGIC_EFFECT_RANDOM5},
    {"random6",    MAGIC_EFFECT_RANDOM6},
    {"random7",    MAGIC_EFFECT_RANDOM7},
    {"random8",    MAGIC_EFFECT_RANDOM8},
    {"random9",    MAGIC_EFFECT_RANDOM9},
    {"random10",    MAGIC_EFFECT_RANDOM10},
    {"random11",    MAGIC_EFFECT_RANDOM11},
    {"random12",    MAGIC_EFFECT_RANDOM12},
    {"random13",    MAGIC_EFFECT_RANDOM13},
    {"random14",    MAGIC_EFFECT_RANDOM14},
    {"random15",    MAGIC_EFFECT_RANDOM15},
    {"random16",    MAGIC_EFFECT_RANDOM16},
    {"random17",    MAGIC_EFFECT_RANDOM17},
    {"random18",    MAGIC_EFFECT_RANDOM18},
    {"random19",    MAGIC_EFFECT_RANDOM19},
    {"random20",    MAGIC_EFFECT_RANDOM20},
    {"random21",    MAGIC_EFFECT_RANDOM21},
    {"random22",    MAGIC_EFFECT_RANDOM22},
    {"random23",    MAGIC_EFFECT_RANDOM23},
    {"random24",    MAGIC_EFFECT_RANDOM24},
    {"random25",    MAGIC_EFFECT_RANDOM25},
    {"random26",    MAGIC_EFFECT_RANDOM26},
    {"random27",    MAGIC_EFFECT_RANDOM27},
    {"random28",    MAGIC_EFFECT_RANDOM28},
    {"random29",    MAGIC_EFFECT_RANDOM29},
    {"random30",    MAGIC_EFFECT_RANDOM30},
    {"random31",    MAGIC_EFFECT_RANDOM31},
    {"random32",    MAGIC_EFFECT_RANDOM32},
    {"random33",    MAGIC_EFFECT_RANDOM33},
    {"random34",    MAGIC_EFFECT_RANDOM34},
    {"random35",    MAGIC_EFFECT_RANDOM35},
    {"random36",    MAGIC_EFFECT_RANDOM36},
    {"random37",    MAGIC_EFFECT_RANDOM37},
    {"random38",    MAGIC_EFFECT_RANDOM38},
    {"random39",    MAGIC_EFFECT_RANDOM39},
    {"random40",    MAGIC_EFFECT_RANDOM40},
    {"random41",    MAGIC_EFFECT_RANDOM41},
    {"random42",    MAGIC_EFFECT_RANDOM42},
    {"random43",    MAGIC_EFFECT_RANDOM43},
    {"random44",    MAGIC_EFFECT_RANDOM44},
    {"random45",    MAGIC_EFFECT_RANDOM45},
    {"random46",    MAGIC_EFFECT_RANDOM46},
    {"random47",    MAGIC_EFFECT_RANDOM47},
    {"random48",    MAGIC_EFFECT_RANDOM48},
    {"random49",    MAGIC_EFFECT_RANDOM49},
    {"random50",    MAGIC_EFFECT_RANDOM50},
    {"random51",    MAGIC_EFFECT_RANDOM51},
    {"random52",    MAGIC_EFFECT_RANDOM52},
    {"random53",    MAGIC_EFFECT_RANDOM53},
    {"random54",    MAGIC_EFFECT_RANDOM54},
    {"random55",    MAGIC_EFFECT_RANDOM55},
    {"random56",    MAGIC_EFFECT_RANDOM56},
    {"random57",    MAGIC_EFFECT_RANDOM57},
    {"random58",    MAGIC_EFFECT_RANDOM58},
    {"random59",    MAGIC_EFFECT_RANDOM59},
    {"random60",    MAGIC_EFFECT_RANDOM60},
    {"random61",    MAGIC_EFFECT_RANDOM61},
    {"random62",    MAGIC_EFFECT_RANDOM62},
    {"random63",    MAGIC_EFFECT_RANDOM63},
    {"random64",    MAGIC_EFFECT_RANDOM64},
    {"random65",    MAGIC_EFFECT_RANDOM65},
    {"random66",    MAGIC_EFFECT_RANDOM66},
    {"random67",    MAGIC_EFFECT_RANDOM67},
    {"random68",    MAGIC_EFFECT_RANDOM68},
    {"random69",    MAGIC_EFFECT_RANDOM69},
    {"random70",    MAGIC_EFFECT_RANDOM70},
    {"random71",    MAGIC_EFFECT_RANDOM71},
    {"random72",    MAGIC_EFFECT_RANDOM72},
    {"random73",    MAGIC_EFFECT_RANDOM73},
    {"random74",    MAGIC_EFFECT_RANDOM74},
    {"random75",    MAGIC_EFFECT_RANDOM75},
    {"random76",    MAGIC_EFFECT_RANDOM76},
    {"random77",    MAGIC_EFFECT_RANDOM77},
    {"random78",    MAGIC_EFFECT_RANDOM78},
    {"random79",    MAGIC_EFFECT_RANDOM79},
    {"random80",    MAGIC_EFFECT_RANDOM80},
    {"random81",    MAGIC_EFFECT_RANDOM81},
    {"random82",    MAGIC_EFFECT_RANDOM82},
    {"random83",    MAGIC_EFFECT_RANDOM83},
    {"random84",    MAGIC_EFFECT_RANDOM84},
    {"random85",    MAGIC_EFFECT_RANDOM85},
    {"random86",    MAGIC_EFFECT_RANDOM86},
    {"random87",    MAGIC_EFFECT_RANDOM87},
    {"random88",    MAGIC_EFFECT_RANDOM88},
    {"random89",    MAGIC_EFFECT_RANDOM89},
    {"random90",    MAGIC_EFFECT_RANDOM90},
    {"random91",    MAGIC_EFFECT_RANDOM91},
    {"random92",    MAGIC_EFFECT_RANDOM92},
    {"random93",    MAGIC_EFFECT_RANDOM93},
    {"random94",    MAGIC_EFFECT_RANDOM94},
    {"random95",    MAGIC_EFFECT_RANDOM95},
    {"random96",    MAGIC_EFFECT_RANDOM96},
    {"random97",    MAGIC_EFFECT_RANDOM97},
    {"random98",    MAGIC_EFFECT_RANDOM98},
    {"random99",    MAGIC_EFFECT_RANDOM99},
    {"random100",    MAGIC_EFFECT_RANDOM100},
    {"random101",    MAGIC_EFFECT_RANDOM101},
    {"random102",    MAGIC_EFFECT_RANDOM102},
    {"random103",    MAGIC_EFFECT_RANDOM103},
    {"random104",    MAGIC_EFFECT_RANDOM104},
    {"random105",    MAGIC_EFFECT_RANDOM105},
    {"random106",    MAGIC_EFFECT_RANDOM106},
    {"random107",    MAGIC_EFFECT_RANDOM107},
    {"random108",    MAGIC_EFFECT_RANDOM108},
    {"random109",    MAGIC_EFFECT_RANDOM109},
    {"random110",    MAGIC_EFFECT_RANDOM110},
    {"random111",    MAGIC_EFFECT_RANDOM111},
    {"random112",    MAGIC_EFFECT_RANDOM112},
    {"random113",    MAGIC_EFFECT_RANDOM113},
    {"random114",    MAGIC_EFFECT_RANDOM114},
    {"random115",    MAGIC_EFFECT_RANDOM115},
    {"random116",    MAGIC_EFFECT_RANDOM116},
    {"random117",    MAGIC_EFFECT_RANDOM117},
    {"random118",    MAGIC_EFFECT_RANDOM118},
    {"random119",    MAGIC_EFFECT_RANDOM119},
    {"random120",    MAGIC_EFFECT_RANDOM120},
    {"random121",    MAGIC_EFFECT_RANDOM121},
    {"random122",    MAGIC_EFFECT_RANDOM122},
    {"random123",    MAGIC_EFFECT_RANDOM123},
    {"random124",    MAGIC_EFFECT_RANDOM124},
    {"random125",    MAGIC_EFFECT_RANDOM125},
    {"random126",    MAGIC_EFFECT_RANDOM126},
    {"random127",    MAGIC_EFFECT_RANDOM127},
    {"random128",    MAGIC_EFFECT_RANDOM128},
    {"random129",    MAGIC_EFFECT_RANDOM129},
    {"random130",    MAGIC_EFFECT_RANDOM130},
    {"random131",    MAGIC_EFFECT_RANDOM131},
    {"random132",    MAGIC_EFFECT_RANDOM132},
    {"random133",    MAGIC_EFFECT_RANDOM133},
    {"random134",    MAGIC_EFFECT_RANDOM134},
    {"random135",    MAGIC_EFFECT_RANDOM135},
    {"random136",    MAGIC_EFFECT_RANDOM136},
    {"random137",    MAGIC_EFFECT_RANDOM137},
    {"random138",    MAGIC_EFFECT_RANDOM138},
    {"random139",    MAGIC_EFFECT_RANDOM139},
    {"random140",    MAGIC_EFFECT_RANDOM140},
    {"random141",    MAGIC_EFFECT_RANDOM141},
    {"random142",    MAGIC_EFFECT_RANDOM142},
    {"random143",    MAGIC_EFFECT_RANDOM143},
    {"random144",    MAGIC_EFFECT_RANDOM144},
    {"random145",    MAGIC_EFFECT_RANDOM145},
    {"random146",    MAGIC_EFFECT_RANDOM146},
    {"random147",    MAGIC_EFFECT_RANDOM147},
    {"random148",    MAGIC_EFFECT_RANDOM148},
    {"random149",    MAGIC_EFFECT_RANDOM149},
    {"random150",    MAGIC_EFFECT_RANDOM150},
    {"random151",    MAGIC_EFFECT_RANDOM151},
    {"random152",    MAGIC_EFFECT_RANDOM152},
    {"random153",    MAGIC_EFFECT_RANDOM153},
    {"random154",    MAGIC_EFFECT_RANDOM154},
    {"random155",    MAGIC_EFFECT_RANDOM155},
    {"random156",    MAGIC_EFFECT_RANDOM156},
    {"random157",    MAGIC_EFFECT_RANDOM157},
    {"random158",    MAGIC_EFFECT_RANDOM158},
    {"random159",    MAGIC_EFFECT_RANDOM159},
    {"random160",    MAGIC_EFFECT_RANDOM160},
    {"random161",    MAGIC_EFFECT_RANDOM161},
    {"random162",    MAGIC_EFFECT_RANDOM162},
    {"random163",    MAGIC_EFFECT_RANDOM163},
    {"random164",    MAGIC_EFFECT_RANDOM164},
    {"random165",    MAGIC_EFFECT_RANDOM165},
    {"random166",    MAGIC_EFFECT_RANDOM166},
    {"random167",    MAGIC_EFFECT_RANDOM167},
    {"random168",    MAGIC_EFFECT_RANDOM168},
    {"random169",    MAGIC_EFFECT_RANDOM169},
    {"random170",    MAGIC_EFFECT_RANDOM170},
    {"random171",    MAGIC_EFFECT_RANDOM171},
    {"random172",    MAGIC_EFFECT_RANDOM172},
    {"random173",    MAGIC_EFFECT_RANDOM173},
    {"random174",    MAGIC_EFFECT_RANDOM174},
    {"random175",    MAGIC_EFFECT_RANDOM175},
    {"random176",    MAGIC_EFFECT_RANDOM176},
    {"random177",    MAGIC_EFFECT_RANDOM177},
    {"random178",    MAGIC_EFFECT_RANDOM178},
    {"random179",    MAGIC_EFFECT_RANDOM179},
    {"random180",    MAGIC_EFFECT_RANDOM180},
    {"random181",    MAGIC_EFFECT_RANDOM181},
    {"random182",    MAGIC_EFFECT_RANDOM182},
    {"random183",    MAGIC_EFFECT_RANDOM183},
    {"random184",    MAGIC_EFFECT_RANDOM184},
    {"random185",    MAGIC_EFFECT_RANDOM185},
    {"random186",    MAGIC_EFFECT_RANDOM186},
    
    //-- versao com 400 effects
    
    {"random187",    MAGIC_EFFECT_RANDOM187},
	{"random188",    MAGIC_EFFECT_RANDOM188},
	{"random189",    MAGIC_EFFECT_RANDOM189},
	{"random190",    MAGIC_EFFECT_RANDOM190},
	{"random191",    MAGIC_EFFECT_RANDOM191},
	{"random192",    MAGIC_EFFECT_RANDOM192},
	{"random193",    MAGIC_EFFECT_RANDOM193},
	{"random194",    MAGIC_EFFECT_RANDOM194},
	{"random195",    MAGIC_EFFECT_RANDOM195},
	{"random196",    MAGIC_EFFECT_RANDOM196},
	{"random197",    MAGIC_EFFECT_RANDOM197},
	{"random198",    MAGIC_EFFECT_RANDOM198},
	{"random199",    MAGIC_EFFECT_RANDOM199},
	{"random200",    MAGIC_EFFECT_RANDOM200},
	{"random201",    MAGIC_EFFECT_RANDOM201},
	{"random202",    MAGIC_EFFECT_RANDOM202},
	{"random203",    MAGIC_EFFECT_RANDOM203},
	{"random204",    MAGIC_EFFECT_RANDOM204},
	{"random205",    MAGIC_EFFECT_RANDOM205},
	{"random206",    MAGIC_EFFECT_RANDOM206},
	{"random207",    MAGIC_EFFECT_RANDOM207},
	{"random208",    MAGIC_EFFECT_RANDOM208},
	{"random209",    MAGIC_EFFECT_RANDOM209},
	{"random210",    MAGIC_EFFECT_RANDOM210},
	{"random211",    MAGIC_EFFECT_RANDOM211},
	{"random212",    MAGIC_EFFECT_RANDOM212},
	{"random213",    MAGIC_EFFECT_RANDOM213},
	{"random214",    MAGIC_EFFECT_RANDOM214},
	{"random215",    MAGIC_EFFECT_RANDOM215},
	{"random216",    MAGIC_EFFECT_RANDOM216},
	{"random217",    MAGIC_EFFECT_RANDOM217},
	{"random218",    MAGIC_EFFECT_RANDOM218},
	{"random219",    MAGIC_EFFECT_RANDOM219},
	{"random220",    MAGIC_EFFECT_RANDOM220},
	{"random221",    MAGIC_EFFECT_RANDOM221},
	{"random222",    MAGIC_EFFECT_RANDOM222},
	{"random223",    MAGIC_EFFECT_RANDOM223},
	{"random224",    MAGIC_EFFECT_RANDOM224},
	{"random225",    MAGIC_EFFECT_RANDOM225},
	{"random226",    MAGIC_EFFECT_RANDOM226},
	{"random227",    MAGIC_EFFECT_RANDOM227},
	{"random228",    MAGIC_EFFECT_RANDOM228},
	{"random229",    MAGIC_EFFECT_RANDOM229},
	{"random230",    MAGIC_EFFECT_RANDOM230},
	{"random231",    MAGIC_EFFECT_RANDOM231},
	{"random232",    MAGIC_EFFECT_RANDOM232},
	{"random233",    MAGIC_EFFECT_RANDOM233},
	{"random234",    MAGIC_EFFECT_RANDOM234},
	{"random235",    MAGIC_EFFECT_RANDOM235},
	{"random236",    MAGIC_EFFECT_RANDOM236},
	{"random237",    MAGIC_EFFECT_RANDOM237},
	{"random238",    MAGIC_EFFECT_RANDOM238},
	{"random239",    MAGIC_EFFECT_RANDOM239},
	{"random240",    MAGIC_EFFECT_RANDOM240},
	{"random241",    MAGIC_EFFECT_RANDOM241},
	{"random242",    MAGIC_EFFECT_RANDOM242},
	{"random243",    MAGIC_EFFECT_RANDOM243},
	{"random244",    MAGIC_EFFECT_RANDOM244},
	{"random245",    MAGIC_EFFECT_RANDOM245},
	{"random246",    MAGIC_EFFECT_RANDOM246},
	{"random247",    MAGIC_EFFECT_RANDOM247},
	{"random248",    MAGIC_EFFECT_RANDOM248},
	{"random249",    MAGIC_EFFECT_RANDOM249},
	{"random250",    MAGIC_EFFECT_RANDOM250},
	{"random251",    MAGIC_EFFECT_RANDOM251},
	{"random252",    MAGIC_EFFECT_RANDOM252},
	{"random253",    MAGIC_EFFECT_RANDOM253},
	{"random254",    MAGIC_EFFECT_RANDOM254},
	{"random255",    MAGIC_EFFECT_RANDOM255},
	{"random256",    MAGIC_EFFECT_RANDOM256},
	{"random257",    MAGIC_EFFECT_RANDOM257},
	{"random258",    MAGIC_EFFECT_RANDOM258},
	{"random259",    MAGIC_EFFECT_RANDOM259},
	{"random260",    MAGIC_EFFECT_RANDOM260},
	{"random261",    MAGIC_EFFECT_RANDOM261},
	{"random262",    MAGIC_EFFECT_RANDOM262},
	{"random263",    MAGIC_EFFECT_RANDOM263},
	{"random264",    MAGIC_EFFECT_RANDOM264},
	{"random265",    MAGIC_EFFECT_RANDOM265},
	{"random266",    MAGIC_EFFECT_RANDOM266},
	{"random267",    MAGIC_EFFECT_RANDOM267},
	{"random268",    MAGIC_EFFECT_RANDOM268},
	{"random269",    MAGIC_EFFECT_RANDOM269},
	{"random270",    MAGIC_EFFECT_RANDOM270},
	{"random271",    MAGIC_EFFECT_RANDOM271},
	{"random272",    MAGIC_EFFECT_RANDOM272},
	{"random273",    MAGIC_EFFECT_RANDOM273},
	{"random274",    MAGIC_EFFECT_RANDOM274},
	{"random275",    MAGIC_EFFECT_RANDOM275},
	{"random276",    MAGIC_EFFECT_RANDOM276},
	{"random277",    MAGIC_EFFECT_RANDOM277},
	{"random278",    MAGIC_EFFECT_RANDOM278},
	{"random279",    MAGIC_EFFECT_RANDOM279},
	{"random280",    MAGIC_EFFECT_RANDOM280},
	{"random281",    MAGIC_EFFECT_RANDOM281},
	{"random282",    MAGIC_EFFECT_RANDOM282},
	{"random283",    MAGIC_EFFECT_RANDOM283},
	{"random284",    MAGIC_EFFECT_RANDOM284},
	{"random285",    MAGIC_EFFECT_RANDOM285},
	{"random286",    MAGIC_EFFECT_RANDOM286},
	{"random287",    MAGIC_EFFECT_RANDOM287},
	{"random288",    MAGIC_EFFECT_RANDOM288},
	{"random289",    MAGIC_EFFECT_RANDOM289},
	{"random290",    MAGIC_EFFECT_RANDOM290},
	{"random291",    MAGIC_EFFECT_RANDOM291},
	{"random292",    MAGIC_EFFECT_RANDOM292},
	{"random293",    MAGIC_EFFECT_RANDOM293},
	{"random294",    MAGIC_EFFECT_RANDOM294},
	{"random295",    MAGIC_EFFECT_RANDOM295},
	{"random296",    MAGIC_EFFECT_RANDOM296},
	{"random297",    MAGIC_EFFECT_RANDOM297},
	{"random298",    MAGIC_EFFECT_RANDOM298},
	{"random299",    MAGIC_EFFECT_RANDOM299},
	{"random300",    MAGIC_EFFECT_RANDOM300},
	{"random301",    MAGIC_EFFECT_RANDOM301},
	{"random302",    MAGIC_EFFECT_RANDOM302},
	{"random303",    MAGIC_EFFECT_RANDOM303},
	{"random304",    MAGIC_EFFECT_RANDOM304},
	{"random305",    MAGIC_EFFECT_RANDOM305},
	{"random306",    MAGIC_EFFECT_RANDOM306},
	{"random307",    MAGIC_EFFECT_RANDOM307},
	{"random308",    MAGIC_EFFECT_RANDOM308},
	{"random309",    MAGIC_EFFECT_RANDOM309},
	{"random310",    MAGIC_EFFECT_RANDOM310},
	{"random311",    MAGIC_EFFECT_RANDOM311},
	{"random312",    MAGIC_EFFECT_RANDOM312},
	{"random313",    MAGIC_EFFECT_RANDOM313},
	{"random314",    MAGIC_EFFECT_RANDOM314},
	{"random315",    MAGIC_EFFECT_RANDOM315},
	{"random316",    MAGIC_EFFECT_RANDOM316},
	{"random317",    MAGIC_EFFECT_RANDOM317},
	{"random318",    MAGIC_EFFECT_RANDOM318},
	{"random319",    MAGIC_EFFECT_RANDOM319},
	{"random320",    MAGIC_EFFECT_RANDOM320},
	{"random321",    MAGIC_EFFECT_RANDOM321},
	{"random322",    MAGIC_EFFECT_RANDOM322},
	{"random323",    MAGIC_EFFECT_RANDOM323},
	{"random324",    MAGIC_EFFECT_RANDOM324},
	{"random325",    MAGIC_EFFECT_RANDOM325},
	{"random326",    MAGIC_EFFECT_RANDOM326},
	{"random327",    MAGIC_EFFECT_RANDOM327},
	{"random328",    MAGIC_EFFECT_RANDOM328},
	{"random329",    MAGIC_EFFECT_RANDOM329},
	{"random330",    MAGIC_EFFECT_RANDOM330},
	{"random331",    MAGIC_EFFECT_RANDOM331}
	
};

ShootTypeNames shootTypeNames[] =
{
	{"spear",		SHOOT_EFFECT_SPEAR},
	{"bolt",		SHOOT_EFFECT_BOLT},
	{"arrow",		SHOOT_EFFECT_ARROW},
	{"fire",		SHOOT_EFFECT_FIRE},
	{"energy",		SHOOT_EFFECT_ENERGY},
	{"poisonarrow",		SHOOT_EFFECT_POISONARROW},
	{"burstarrow",		SHOOT_EFFECT_BURSTARROW},
	{"throwingstar",	SHOOT_EFFECT_THROWINGSTAR},
	{"throwingknife",	SHOOT_EFFECT_THROWINGKNIFE},
	{"smallstone",		SHOOT_EFFECT_SMALLSTONE},
	{"death",		SHOOT_EFFECT_DEATH},
	{"largerock",		SHOOT_EFFECT_LARGEROCK},
	{"snowball",		SHOOT_EFFECT_SNOWBALL},
	{"powerbolt",		SHOOT_EFFECT_POWERBOLT},
	{"poison",		SHOOT_EFFECT_POISONFIELD},
	{"infernalbolt",	SHOOT_EFFECT_INFERNALBOLT},
	{"huntingspear",	SHOOT_EFFECT_HUNTINGSPEAR},
	{"enchantedspear",	SHOOT_EFFECT_ENCHANTEDSPEAR},
	{"redstar",		SHOOT_EFFECT_REDSTAR},
	{"greenstar",		SHOOT_EFFECT_GREENSTAR},
	{"royalspear",		SHOOT_EFFECT_ROYALSPEAR},
	{"sniperarrow",		SHOOT_EFFECT_SNIPERARROW},
	{"onyxarrow",		SHOOT_EFFECT_ONYXARROW},
	{"piercingbolt",	SHOOT_EFFECT_PIERCINGBOLT},
	{"whirlwindsword",	SHOOT_EFFECT_WHIRLWINDSWORD},
	{"whirlwindaxe",	SHOOT_EFFECT_WHIRLWINDAXE},
	{"whirlwindclub",	SHOOT_EFFECT_WHIRLWINDCLUB},
	{"etherealspear",	SHOOT_EFFECT_ETHEREALSPEAR},
	{"ice",			SHOOT_EFFECT_ICE},
	{"earth",		SHOOT_EFFECT_EARTH},
	{"holy",		SHOOT_EFFECT_HOLY},
	{"suddendeath",		SHOOT_EFFECT_SUDDENDEATH},
	{"flasharrow",		SHOOT_EFFECT_FLASHARROW},
	{"flammingarrow",	SHOOT_EFFECT_FLAMMINGARROW},
	{"flamingarrow",	SHOOT_EFFECT_FLAMMINGARROW},
	{"shiverarrow",		SHOOT_EFFECT_SHIVERARROW},
	{"energyball",		SHOOT_EFFECT_ENERGYBALL},
	{"smallice",		SHOOT_EFFECT_SMALLICE},
	{"smallholy",		SHOOT_EFFECT_SMALLHOLY},
	{"smallearth",		SHOOT_EFFECT_SMALLEARTH},
	{"eartharrow",		SHOOT_EFFECT_EARTHARROW},
	{"explosion",		SHOOT_EFFECT_EXPLOSION},
	{"cake",		SHOOT_EFFECT_CAKE},
	
    {"random1",    SHOOT_EFFECT_RANDOM1},//edited \/
    {"random2",    SHOOT_EFFECT_RANDOM2},
    {"random3",    SHOOT_EFFECT_RANDOM3},
    {"random4",    SHOOT_EFFECT_RANDOM4},
    {"random5",    SHOOT_EFFECT_RANDOM5},
    {"random6",    SHOOT_EFFECT_RANDOM6},
    {"random7",    SHOOT_EFFECT_RANDOM7},
    {"random8",    SHOOT_EFFECT_RANDOM8},
    {"random9",    SHOOT_EFFECT_RANDOM9},
    {"random10",    SHOOT_EFFECT_RANDOM10},
    {"random11",    SHOOT_EFFECT_RANDOM11},
    {"random12",    SHOOT_EFFECT_RANDOM12},

	{"random13",    SHOOT_EFFECT_RANDOM13},
	{"random14",    SHOOT_EFFECT_RANDOM14},
	{"random15",    SHOOT_EFFECT_RANDOM15},
	{"random16",    SHOOT_EFFECT_RANDOM16},
	{"random17",    SHOOT_EFFECT_RANDOM17},
	{"random18",    SHOOT_EFFECT_RANDOM18},
	{"random19",    SHOOT_EFFECT_RANDOM19},
	{"random20",    SHOOT_EFFECT_RANDOM20},
	{"random21",    SHOOT_EFFECT_RANDOM21},
	{"random22",    SHOOT_EFFECT_RANDOM22},
	{"random23",    SHOOT_EFFECT_RANDOM23},
	{"random24",    SHOOT_EFFECT_RANDOM24},
	
	{"random25",    SHOOT_EFFECT_RANDOM25}, //-- 66~100
	{"random26",    SHOOT_EFFECT_RANDOM26},
	{"random27",    SHOOT_EFFECT_RANDOM27},
	{"random28",    SHOOT_EFFECT_RANDOM28},
	{"random29",    SHOOT_EFFECT_RANDOM29},
	{"random30",    SHOOT_EFFECT_RANDOM30},
	{"random31",    SHOOT_EFFECT_RANDOM31},
	{"random32",    SHOOT_EFFECT_RANDOM32},
	{"random33",    SHOOT_EFFECT_RANDOM33},
	{"random34",    SHOOT_EFFECT_RANDOM34},
	{"random35",    SHOOT_EFFECT_RANDOM35},
	{"random36",    SHOOT_EFFECT_RANDOM36},
	{"random37",    SHOOT_EFFECT_RANDOM37},
	{"random38",    SHOOT_EFFECT_RANDOM38},
	{"random39",    SHOOT_EFFECT_RANDOM39},
	{"random40",    SHOOT_EFFECT_RANDOM40},
	{"random41",    SHOOT_EFFECT_RANDOM41},
	{"random42",    SHOOT_EFFECT_RANDOM42},
	{"random43",    SHOOT_EFFECT_RANDOM43},
	{"random44",    SHOOT_EFFECT_RANDOM44},
	{"random45",    SHOOT_EFFECT_RANDOM45},
	{"random46",    SHOOT_EFFECT_RANDOM46},
	{"random47",    SHOOT_EFFECT_RANDOM47},
	{"random48",    SHOOT_EFFECT_RANDOM48},
	{"random49",    SHOOT_EFFECT_RANDOM49},
	{"random50",    SHOOT_EFFECT_RANDOM50},
	{"random51",    SHOOT_EFFECT_RANDOM51},
	{"random52",    SHOOT_EFFECT_RANDOM52},
	{"random53",    SHOOT_EFFECT_RANDOM53},
	{"random54",    SHOOT_EFFECT_RANDOM54},
	{"random55",    SHOOT_EFFECT_RANDOM55},
	{"random56",    SHOOT_EFFECT_RANDOM56},
	{"random57",    SHOOT_EFFECT_RANDOM57},
	{"random58",    SHOOT_EFFECT_RANDOM58},
	{"random59",    SHOOT_EFFECT_RANDOM59},
	{"random60",    SHOOT_EFFECT_RANDOM60},
	
	
        
};

CombatTypeNames combatTypeNames[] =
{
	{"physical",		COMBAT_PHYSICALDAMAGE},
	{"energy",		COMBAT_ENERGYDAMAGE},
	{"earth",		COMBAT_EARTHDAMAGE},
	{"fire",		COMBAT_FIREDAMAGE},
	{"undefined",		COMBAT_UNDEFINEDDAMAGE},
	{"lifedrain",		COMBAT_LIFEDRAIN},
	{"life drain",		COMBAT_LIFEDRAIN},
	{"manadrain",		COMBAT_MANADRAIN},
	{"mana drain",		COMBAT_MANADRAIN},
	{"healing",		COMBAT_HEALING},
	{"drown",		COMBAT_DROWNDAMAGE},
	{"ice",			COMBAT_ICEDAMAGE},
	{"holy",		COMBAT_HOLYDAMAGE},
	{"death",		COMBAT_DEATHDAMAGE},
	{"test",		COMBAT_TESTDAMAGE},
	{"electric",		COMBAT_ELECTRICDAMAGE},
	{"rock",		COMBAT_ROCKDAMAGE},
	{"fly",		COMBAT_FLYDAMAGE},
	{"fight",		COMBAT_FIGHTDAMAGE},
	{"venom",		COMBAT_VENOMDAMAGE},
	{"dragon",		COMBAT_DRAGONDAMAGE},
	{"bug",		COMBAT_BUGDAMAGE}
};

AmmoTypeNames ammoTypeNames[] =
{
	{"spear",		AMMO_SPEAR},
	{"arrow",		AMMO_ARROW},
	{"poisonarrow",		AMMO_ARROW},
	{"burstarrow",		AMMO_ARROW},
	{"bolt",		AMMO_BOLT},
	{"powerbolt",		AMMO_BOLT},
	{"smallstone",		AMMO_STONE},
	{"largerock",		AMMO_STONE},
	{"throwingstar",	AMMO_THROWINGSTAR},
	{"throwingknife",	AMMO_THROWINGKNIFE},
	{"snowball",		AMMO_SNOWBALL},
	{"huntingspear",	AMMO_SPEAR},
	{"royalspear",		AMMO_SPEAR},
	{"enchantedspear",	AMMO_SPEAR},
	{"sniperarrow",		AMMO_ARROW},
	{"onyxarrow",		AMMO_ARROW},
	{"piercingbolt",	AMMO_BOLT},
	{"infernalbolt",	AMMO_BOLT},
	{"flasharrow",		AMMO_ARROW},
	{"flammingarrow",	AMMO_ARROW},
	{"flamingarrow",	AMMO_ARROW},
	{"shiverarrow",		AMMO_ARROW},
	{"eartharrow",		AMMO_ARROW},
	{"etherealspear",	AMMO_SPEAR}
};

AmmoActionNames ammoActionNames[] =
{
	{"move",		AMMOACTION_MOVE},
	{"moveback",		AMMOACTION_MOVEBACK},
	{"move back",		AMMOACTION_MOVEBACK},
	{"removecharge",	AMMOACTION_REMOVECHARGE},
	{"remove charge",	AMMOACTION_REMOVECHARGE},
	{"removecount",		AMMOACTION_REMOVECOUNT},
	{"remove count",	AMMOACTION_REMOVECOUNT}
};

FluidTypeNames fluidTypeNames[] =
{
	{"none",		FLUID_NONE},
	{"water",		FLUID_WATER},
	{"blood",		FLUID_BLOOD},
	{"beer",		FLUID_BEER},
	{"slime",		FLUID_SLIME},
	{"lemonade",		FLUID_LEMONADE},
	{"milk",		FLUID_MILK},
	{"mana",		FLUID_MANA},
	{"life",		FLUID_LIFE},
	{"oil",			FLUID_OIL},
	{"urine",		FLUID_URINE},
	{"coconutmilk",		FLUID_COCONUTMILK},
	{"coconut milk",	FLUID_COCONUTMILK},
	{"wine",		FLUID_WINE},
	{"mud",			FLUID_MUD},
	{"fruitjuice",		FLUID_FRUITJUICE},
	{"fruit juice",		FLUID_FRUITJUICE},
	{"lava",		FLUID_LAVA},
	{"rum",			FLUID_RUM},
	{"swamp",		FLUID_SWAMP}
};

SkillIdNames skillIdNames[] =
{
	{"fist",		SKILL_FIST},
	{"club",		SKILL_CLUB},
	{"sword",		SKILL_SWORD},
	{"axe",			SKILL_AXE},
	{"distance",		SKILL_DIST},
	{"dist",		SKILL_DIST},
	{"shielding",		SKILL_SHIELD},
	{"shield",		SKILL_SHIELD},
	{"fishing",		SKILL_FISH},
	{"fish",		SKILL_FISH},
	{"level",		SKILL__LEVEL},
	{"magiclevel",		SKILL__MAGLEVEL},
	{"magic level",		SKILL__MAGLEVEL}
};

MagicEffect_t getMagicEffect(const std::string& strValue)
{
	for(uint32_t i = 0; i < sizeof(magicEffectNames) / sizeof(MagicEffectNames); ++i)
	{
		if(!strcasecmp(strValue.c_str(), magicEffectNames[i].name))
			return magicEffectNames[i].magicEffect;
	}

	return MAGIC_EFFECT_UNKNOWN;
}

ShootEffect_t getShootType(const std::string& strValue)
{
	for(uint32_t i = 0; i < sizeof(shootTypeNames) / sizeof(ShootTypeNames); ++i)
	{
		if(!strcasecmp(strValue.c_str(), shootTypeNames[i].name))
			return shootTypeNames[i].shootType;
	}

	return SHOOT_EFFECT_UNKNOWN;
}

CombatType_t getCombatType(const std::string& strValue)
{
	for(uint32_t i = 0; i < sizeof(combatTypeNames) / sizeof(CombatTypeNames); ++i)
	{
		if(!strcasecmp(strValue.c_str(), combatTypeNames[i].name))
			return combatTypeNames[i].combatType;
	}

	return COMBAT_NONE;
}

Ammo_t getAmmoType(const std::string& strValue)
{
	for(uint32_t i = 0; i < sizeof(ammoTypeNames) / sizeof(AmmoTypeNames); ++i)
	{
		if(!strcasecmp(strValue.c_str(), ammoTypeNames[i].name))
			return ammoTypeNames[i].ammoType;
	}

	return AMMO_NONE;
}

AmmoAction_t getAmmoAction(const std::string& strValue)
{
	for(uint32_t i = 0; i < sizeof(ammoActionNames) / sizeof(AmmoActionNames); ++i)
	{
		if(!strcasecmp(strValue.c_str(), ammoActionNames[i].name))
			return ammoActionNames[i].ammoAction;
	}

	return AMMOACTION_NONE;
}

FluidTypes_t getFluidType(const std::string& strValue)
{
	for(uint32_t i = 0; i < sizeof(fluidTypeNames) / sizeof(FluidTypeNames); ++i)
	{
		if(!strcasecmp(strValue.c_str(), fluidTypeNames[i].name))
			return fluidTypeNames[i].fluidType;
	}

	return FLUID_NONE;
}

skills_t getSkillId(const std::string& strValue)
{
	for(uint32_t i = 0; i < sizeof(skillIdNames) / sizeof(SkillIdNames); ++i)
	{
		if(!strcasecmp(strValue.c_str(), skillIdNames[i].name))
			return skillIdNames[i].skillId;
	}

	return SKILL_FIST;
}

std::string getCombatName(CombatType_t combatType)
{
	switch(combatType)
	{
		case COMBAT_PHYSICALDAMAGE:
			return "physical";
		case COMBAT_ENERGYDAMAGE:
			return "energy";
		case COMBAT_EARTHDAMAGE:
			return "earth";
		case COMBAT_FIREDAMAGE:
			return "fire";
		case COMBAT_UNDEFINEDDAMAGE:
			return "undefined";
		case COMBAT_LIFEDRAIN:
			return "life drain";
		case COMBAT_MANADRAIN:
			return "mana drain";
		case COMBAT_HEALING:
			return "healing";
		case COMBAT_DROWNDAMAGE:
			return "drown";
		case COMBAT_ICEDAMAGE:
			return "ice";
		case COMBAT_HOLYDAMAGE:
			return "holy";
		case COMBAT_DEATHDAMAGE:
			return "death";
		default:
			break;
	}

	return "unknown";
}

std::string getSkillName(uint16_t skillId, bool suffix/* = true*/)
{
	switch(skillId)
	{
		case SKILL_FIST:
		{
			std::string tmp = "fist";
			if(suffix)
				tmp += " fighting";

			return tmp;
		}
		case SKILL_CLUB:
		{
			std::string tmp = "club";
			if(suffix)
				tmp += " fighting";

			return tmp;
		}
		case SKILL_SWORD:
		{
			std::string tmp = "sword";
			if(suffix)
				tmp += " fighting";

			return tmp;
		}
		case SKILL_AXE:
		{
			std::string tmp = "axe";
			if(suffix)
				tmp += " fighting";

			return tmp;
		}
		case SKILL_DIST:
		{
			std::string tmp = "distance";
			if(suffix)
				tmp += " fighting";

			return tmp;
		}
		case SKILL_SHIELD:
			return "shielding";
		case SKILL_FISH:
			return "fishing";
		case SKILL__MAGLEVEL:
			return "magic level";
		case SKILL__LEVEL:
			return "level";
		default:
			break;
	}

	return "unknown";
}

std::string getReason(int32_t reasonId)
{
	switch(reasonId)
	{
		case 0:
			return "Offensive Name";
		case 1:
			return "Invalid Name Format";
		case 2:
			return "Unsuitable Name";
		case 3:
			return "Name Inciting Rule Violation";
		case 4:
			return "Offensive Statement";
		case 5:
			return "Spamming";
		case 6:
			return "Illegal Advertising";
		case 7:
			return "Off-Topic Public Statement";
		case 8:
			return "Non-English Public Statement";
		case 9:
			return "Inciting Rule Violation";
		case 10:
			return "Bug Abuse";
		case 11:
			return "Game Weakness Abuse";
		case 12:
			return "Using Unofficial Software to Play";
		case 13:
			return "Hacking";
		case 14:
			return "Multi-Clienting";
		case 15:
			return "Account Trading or Sharing";
		case 16:
			return "Threatening Gamemaster";
		case 17:
			return "Pretending to Have Influence on Rule Enforcement";
		case 18:
			return "False Report to Gamemaster";
		case 19:
			return "Destructive Behaviour";
		case 20:
			return "Excessive Unjustified Player Killing";
		default:
			break;
	}

	return "Unknown Reason";
}

std::string getAction(ViolationAction_t actionId, bool ipBanishment)
{
	std::string action = "Unknown";
	switch(actionId)
	{
		case ACTION_NOTATION:
			action = "Notation";
			break;
		case ACTION_NAMEREPORT:
			action = "Name Report";
			break;
		case ACTION_BANISHMENT:
			action = "Banishment";
			break;
		case ACTION_BANREPORT:
			action = "Name Report + Banishment";
			break;
		case ACTION_BANFINAL:
			action = "Banishment + Final Warning";
			break;
		case ACTION_BANREPORTFINAL:
			action = "Name Report + Banishment + Final Warning";
			break;
		case ACTION_STATEMENT:
			action = "Statement Report";
			break;
		//internal use
		case ACTION_DELETION:
			action = "Deletion";
			break;
		case ACTION_NAMELOCK:
			action = "Name Lock";
			break;
		case ACTION_BANLOCK:
			action = "Name Lock + Banishment";
			break;
		case ACTION_BANLOCKFINAL:
			action = "Name Lock + Banishment + Final Warning";
			break;
		default:
			break;
	}

	if(ipBanishment)
		action += " + IP Banishment";

	return action;
}

std::string parseVocationString(StringVec vocStringVec)
{
	std::string str = "";
	if(!vocStringVec.empty())
	{
		for(StringVec::iterator it = vocStringVec.begin(); it != vocStringVec.end(); ++it)
		{
			if((*it) != vocStringVec.front())
			{
				if((*it) != vocStringVec.back())
					str += ", ";
				else
					str += " and ";
			}

			str += (*it);
			str += "s";
		}
	}

	return str;
}

bool parseVocationNode(xmlNodePtr vocationNode, VocationMap& vocationMap, StringVec& vocStringVec, std::string& errorStr)
{
	if(xmlStrcmp(vocationNode->name,(const xmlChar*)"vocation"))
		return true;

	int32_t vocationId = -1;
	std::string strValue, tmpStrValue;
	if(readXMLString(vocationNode, "name", strValue))
	{
		vocationId = Vocations::getInstance()->getVocationId(strValue);
		if(vocationId != -1)
		{
			vocationMap[vocationId] = true;
			int32_t promotedVocation = Vocations::getInstance()->getPromotedVocation(vocationId);
			if(promotedVocation != -1)
				vocationMap[promotedVocation] = true;
		}
		else
		{
			errorStr = "Wrong vocation name: " + strValue;
			return false;
		}
	}
	else if(readXMLString(vocationNode, "id", strValue))
	{
		IntegerVec intVector;
		if(!parseIntegerVec(strValue, intVector))
		{
			errorStr = "Invalid vocation id - '" + strValue + "'";
			return false;
		}

		size_t size = intVector.size();
		for(size_t i = 0; i < size; ++i)
		{
			Vocation* vocation = Vocations::getInstance()->getVocation(intVector[i]);
			if(vocation && vocation->getName() != "")
			{
				vocationId = vocation->getId();
				strValue = vocation->getName();

				vocationMap[vocationId] = true;
				int32_t promotedVocation = Vocations::getInstance()->getPromotedVocation(vocationId);
				if(promotedVocation != -1)
					vocationMap[promotedVocation] = true;
			}
			else
			{
				std::stringstream ss;
				ss << "Wrong vocation id: " << intVector[i];

				errorStr = ss.str();
				return false;
			}
		}
	}

	if(vocationId != -1 && (!readXMLString(vocationNode, "showInDescription", tmpStrValue) || booleanString(tmpStrValue)))
		vocStringVec.push_back(asLowerCaseString(strValue));

	return true;
}

bool parseIntegerVec(std::string str, IntegerVec& intVector)
{
	StringVec strVector = explodeString(str, ";");
	IntegerVec tmpIntVector;
	for(StringVec::iterator it = strVector.begin(); it != strVector.end(); ++it)
	{
		tmpIntVector = vectorAtoi(explodeString((*it), "-"));
		if(!tmpIntVector[0] && it->substr(0, 1) != "0")
			continue;

		intVector.push_back(tmpIntVector[0]);
		if(tmpIntVector.size() > 1)
		{
			while(tmpIntVector[0] < tmpIntVector[1])
				intVector.push_back(++tmpIntVector[0]);
		}
	}

	return true;
}

bool fileExists(const char* filename)
{
	FILE* f = fopen(filename, "rb");
	if(!f)
		return false;

	fclose(f);
	return true;
}

uint32_t adlerChecksum(uint8_t *data, size_t length)
{
	if(length > NETWORKMESSAGE_MAXSIZE || length < 0)
		return 0;

	const uint16_t adler = 65521;
	uint32_t a = 1, b = 0;
	while(length > 0)
	{
		size_t tmp = length > 5552 ? 5552 : length;
		length -= tmp;
		do
		{
			a += *data++;
			b += a;
		}
		while(--tmp);

		a %= adler;
		b %= adler;
	}

	return (b << 16) | a;
}

std::string getFilePath(FileType_t filetype, std::string filename)
{
	#ifdef __FILESYSTEM_HIERARCHY_STANDARD__
	std::string path = "/usr/share/tfs/";
	#endif
	std::string path = g_config.getString(ConfigManager::DATA_DIRECTORY);
	switch(filetype)
	{
		case FILE_TYPE_OTHER:
			path += filename;
			break;
		case FILE_TYPE_XML:
			path += "XML/" + filename;
			break;
		case FILE_TYPE_LOG:
			#ifndef __FILESYSTEM_HIERARCHY_STANDARD__
			path += "logs/" + filename;
			#else
			path = "/var/log/tfs/" + filename;
			#endif
			break;
		case FILE_TYPE_MOD:
		{
			#ifndef __FILESYSTEM_HIERARCHY_STANDARD__
			path = "mods/" + filename;
			#else
			path = "/etc/tfs/mods/" + filename;
			#endif
			break;
		}
		case FILE_TYPE_CONFIG:
		{
			#if defined(__FILESYSTEM_HIERARCHY_STANDARD__) && defined(__HOMEDIR_CONF__)
			if(fileExists("~/.tfs/" + filename))
				path = "~/.tfs/" + filename;
			else
				path = "/etc/tfs/" + filename;

			#elif defined(__FILESYSTEM_HIERARCHY_STANDARD__)
			path = "/etc/tfs/" + filename;
			#else
			path = filename;
			#endif
			break;
		}
		default:
			std::cout << "ERROR: Wrong file type!" << std::endl;
			break;
	}
	return path;
}
