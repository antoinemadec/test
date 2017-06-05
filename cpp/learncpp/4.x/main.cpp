#include <iostream>
#include <cstdio>
#include <stdint.h>


enum class MonsterType
{
    OGRE,
    DRAGON,
    ORC,
    GIANT_SPIDER,
    SLIME
};

struct Monster
{
    MonsterType type;
    std::string name;
    int health;
};

// Return the name of the monster's type as a string
// Since this could be used elsewhere, it's better to make this its own function
std::string getMonsterTypeString(Monster monster)
{
	if (monster.type == MonsterType::OGRE)
		return "Ogre";
	if (monster.type == MonsterType::DRAGON)
		return "Dragon";
	if (monster.type == MonsterType::ORC)
		return "Orc";
	if (monster.type == MonsterType::GIANT_SPIDER)
		return "Giant Spider";
	if (monster.type == MonsterType::SLIME)
		return "Slime";
	return "Unknown";
}

void printMonster(Monster monster)
{
    std::printf("%s %s %0d\n", monster.name.c_str(), getMonsterTypeString(monster).c_str(), monster.health);
}

int main()
{
    Monster a = {MonsterType::OGRE, "Nahtalie", 22};
    Monster b = {MonsterType::GIANT_SPIDER, "Antoine", 100};
    printMonster(a);
    printMonster(b);
    return 0;
}
