Pistachio Web Framework
=======================

Pistachio is a simple web framework for coldfusion, modelled to a fair extent 
after the CFML framework Coldbox, the Python framework Django, and the Ruby 
framework Rails.

Pistachio is a very light framework consisting of some features and 
conventions cherry picked from existing frameworks and worked into a pill that 
our existing legacy codebases would find palatable. If you want a full stack
web framework written for ColdFusion then I would recommend taking a look at
ColdBox (it's the only one I have any experience with), or, if you're not
constrained by language choice then I would HIGHLY recommend taking a look at
both Rails and Django.

Core principles of Pistachio
----------------------------

Modules, Plugins, Settings, and Forms. that's Pistachio!

Modules very closely resemble Django applications.

Plugins very closely resemble ColdBox plugins.

Settings are worked as a simple, flexible solution to listing a bunch of junk 
in your Application.cfc

Forms somewhat resemble Django forms, just stripped down, and without the 
rendering side of things. (I just wanted an easy way to do data validation and 
wasn't satisfied by the existing options)

Requirements
------------

Pistachio has been written for ColdFusion 9 and nothing else, and has never 
tested on Railo, or any other CFML engine. You will also need to have the 
coldfusion dotnet library installed as Pistachio makes use of dotnet regular 
expressions for routing module requests.

How to setup the example application
------------------------------------

You'll need to setup two mappings in your CFIDE administrator for this to work,
a /pistachio mapping pointing to the pistachio directory and an /example
mapping pointing to the example directory (this second one you can change,
however it will mean fiddling with the project settings before you can get the
application up and running.)

You'll need to setup a webserver to serve the application, setting the root dir
to the example/published directory.

Then you'll just need to open you browser and point it at the location you from
which your server is configured to serve the application and you'll be up and 
running.

What do I look at first?
------------------------

I would suggest looking first at the example code for the contactform module,
you can find it in example/modules/contactform. This should give you an idea
of how modules work, and provide a good starting point from which to explore
the codebase.

Questions
---------

Send your questions to oduignan@binaryvision.com.
