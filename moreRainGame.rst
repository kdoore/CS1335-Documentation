.. _moreRainGame:

======================
Rain Game - Extended
======================

In the previous section, we reviewed Daniel Shiffman's Rain Game, Object-Oriented Game.  Now, we want
to customize the game to make it a bit more interesting.   The first change we'll make is to add a
paddle that can catch or hit the falling objects.  If we allow the objects to bounce, then that could
provide a user with extra scoring opportunities.  For now, let's just look at how we can implement
a paddle that moves left and right in response to keyboard input.  

Pong Game
===========

`Dr Doane`_, in his online article: `Thinking Through a Basic Pong Game in Processing` provides a nice tutorial 
on how to create a pong game using processing.  While it's not an object-oriented approach, it still provides 
a very good overview and details of ideas we'll want to implement. To start with, he discusses how we can use 
the processing keyboard functions to control movement of the paddle.  Just as with mouseEvents, 
when a user presses a key, we can use that input to allow interaction with our program.  


.. _Dr Doane: http://drdoane.com/thinking-through-a-basic-pong-game-in-processing/