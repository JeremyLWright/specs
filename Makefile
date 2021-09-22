all: CommunityModules.jar CommunityModules-deps.jar tla2tools.jar

CommunityModules.jar:
	wget https://github.com/tlaplus/CommunityModules/releases/latest/download/CommunityModules.jar

CommunityModules-deps.jar:
	wget https://github.com/tlaplus/CommunityModules/releases/latest/download/CommunityModules-deps.jar

tla2tools.jar:
	wget https://github.com/tlaplus/tlaplus/releases/download/v1.8.0/tla2tools.jar
