unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end

require_relative 'helper'

class TkPC_Callback
	def call(tuples)
		tuples.each do |t|
			puts t.join(" ")
		end
	end
end

class TestTkParallelCoordinates < Test::Unit::TestCase
	def test_instantiate
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
				:items => [1,22,80,137,443,1024,5900,6667,31337,65335]
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
			pcp.addtuple(t)
		end
		# install the select callback
		pcp.set_select_cb(TkPC_Callback.new)
		# enter the Tk mainloop
		Tk.mainloop()
	end
end
