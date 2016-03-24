
int pins = [1,2,3,4];

bool pattern = [[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]];
int counter = 0;

int lastupdate = 0;
int max_speed = 100; //in steps per ms
int current_speed = 0;
int acceleration = 10;
int slack = 21;
int position = 0;
int target_position = 0;

void step(bool direction)
{
	if (direction == true)
	{
		counter++;
		position++;
	}
	else
	{
		counter--;
		position--;
	}
	if ( counter > len(pattern)-1 )
		counter = 0;
	else if ( counter < 0)
	{
		counter = len(pattern)-1;
	}

	for (i=0;i<4;i++)
	{
		pins[i] = pattern[counter][i];
	}

}

void timer_loop()
{
	
}

