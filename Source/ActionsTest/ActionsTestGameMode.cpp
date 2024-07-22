// Copyright Epic Games, Inc. All Rights Reserved.

#include "ActionsTestGameMode.h"
#include "ActionsTestCharacter.h"
#include "UObject/ConstructorHelpers.h"

AActionsTestGameMode::AActionsTestGameMode()
{
	// set default pawn class to our Blueprinted character
	static ConstructorHelpers::FClassFinder<APawn> PlayerPawnBPClass(TEXT("/Game/ThirdPerson/Blueprints/BP_ThirdPersonCharacter"));
	if (PlayerPawnBPClass.Class != NULL)
	{
		DefaultPawnClass = PlayerPawnBPClass.Class;
	}
}
