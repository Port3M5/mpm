require 'rubygems'
require 'mpm/config'
require 'mpm/packagemanager'
require 'profligacy/swing'
require 'profligacy/lel'

module Ui
  include_package 'javax.swing'
  include Profligacy

  layout = "
    [ menubar       ]
    [ title         ]
    [ (200)*list    ]
    [ buttons       ]
  "

  ui = Swing::LEL.new(JFrame, layout) do |c, i|
    c.menubar = JMenuBar.new
    c.title = JLabel.new "MPM"
    c.list  = JList.new
    populate_list! c.list
    c.buttons = JPanel.new

  end

  frame = ui.build :args => 'MPM'
  frame.default_close_operation = JFrame::EXIT_ON_CLOSE

  def self.populate_list! list
    config = MPMConfig.new
    pm = MPMPackageManager.new config.options

    pm.list.each do |i|
      list.add i
    end
  end
end
