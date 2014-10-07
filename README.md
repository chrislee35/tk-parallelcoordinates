# Tk::ParallelCoordinates

A parallel coordinate plot has multiple axes that are parallel to each other, as opposed to the normal perpendicular axes.  The advantage with parallel axes is that you can have more than just two axes so that you can represent higher-dimensional data.  However, when the data gets dense, it can quickly obscure details.

This implementation is for Ruby-Tk and has been tested in:
* ruby-1.8.7-p371
* ruby-1.9.3-p392
* ruby-2.0.0-p0
	
RVM install command example (rvm doesn't install with tk or tcl by default):

	rvm reinstall 1.9.3 --enable-shared --enable-pthread --with-tk --with-tcl

## Installation

Add this line to your application's Gemfile:

    gem 'tk-parallelcoordinates'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tk-parallelcoordinates

## Usage

Within a Tk project, you'll need to have a Window with a Frame to place the ParallelCoordinate within.  Here is an example with a few of the features turned on:

	require 'tk'
	require 'tk/parallelcoordinates'
	
	class TkPC_Callback
		def call(tuples)
			tuples.each do |t|
				puts t.join(" ")
			end
		end
	end

	def full_example
		# create the root window for this Tk app
		root = TkRoot.new() {
			title "Tk::ParallelCoordinates Test"
			protocol('WM_DELETE_WINDOW', proc{ exit })
		}
		# bind ctrl-c to exit
		root.bind('Control-c', proc{ exit })
		# create a frame to place the ParallelCoordinate within
		left_frame = TkFrame.new(root)
		left_frame.grid(:row=>0,:column=>0,:sticky=>'new')
		# create a model of the data to display
		model = [ 
			# model is an array of axes.  One hash per axis.  This model has two axes.
			# the first axis is called "Port", is a range, is scaled by the 3rd square root
			# has a min of 0, and max of 65535
			# formated by %d
			{ 
				:name => 'Port', 
				:type => 'range',
				:scale => '3rt',
				:min => 0,
				:max => 65535,
				:ofmt => '%d',
				#:items => [1,22,80,137,443,1024,5900,6667,31337,65335]
			},
			# the second axes is called "Host", contains a list of items.
			{
				:name => 'Host',
				:type => 'list',
				:list => ['192.168.0.1','192.168.0.4','192.168.0.2','192.168.0.3']
			}
		]
		# create the parallel coordinates frame
		pcp = Tk::ParallelCoordinates.new(left_frame, 500, 360, model)
		# add items to the parallel coordinates frame
		[[53,'192.168.0.1'],[53,'192.168.0.2'],[80,'192.168.0.2'],[43099,'192.168.0.3']].each do |t|
			key = t[0].to_s+":"+t[1]
			pcp.addtuple(key,Tk::ParallelCoordinates::STATE_NORMAL,t)
		end
		# install the select callback
		pcp.set_select_cb(TkPC_Callback.new)
		# enter the Tk mainloop
		Tk.mainloop()
	end
	
Great, so what options can Tk::ParallelCoordinates models take?

	name             # the name of the axes, any string you want
	type             # the type of data: range, list, or date
	min              # minimal value, not applicable to list type data
	max              # maximum value, not applicable to list type data
	ofmt             # the formating string or function
	ifmt             # the parsing string for date data
	items            # items for a list, OR items to display in a range

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2011 Chris Lee, PhD. See LICENSE.txt for
further details.
