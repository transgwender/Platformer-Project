/// @description Default Variables

hasCollided = false; // Has Mario Collided with a roof yet (X)
hasPressed = false; // Has Space been pressed yet (X)
hasJumped = false; // Has Mario Jumped yet (X)
hasDived = false; // Has Mario Dived yet (X)
hasLanded = false; // Has Mario Landed yet (x)
hasSideCollided = false; // Has Mario Collided with a side yet (x)

currentJumpLength = 0; // Current Jump Length (X)
currentFallLength = 0; // Current Fall Length (X)
currentGroundLength = 0; // Current Ground Length (X)
currentDiveLengthX = 0; // Current Dive Length (X)
currentDiveLengthY = 0; // Current Dive Length (X)
currentDirection = 1; // Current Direction being faced (X)

jumpStart = 5; // Starting Value for Jumping
jumpModifier = 1; // Starting Value for a Modifier for Jumping
jumpSpeed = 0; // How fast is Mario currently going with jumping (X)
jumpTotal = 0; // How many times Mario has jumped (X)

tJumpGracePeriod = 0.3; // How long Mario can be on the ground before jump is reset.

moveSpeed = 5; // Movement Speed
moveDirection = 0; // Movement Direction (X)

diveSpeed = 0.5; // How much speed is applied to the dive
diveSpeedMax = 10;

grav = 0.5; // Gravity Speed