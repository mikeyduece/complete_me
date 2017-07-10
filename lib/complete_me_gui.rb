require './lib/complete_me'

cm = CompleteMe.new

Shoes.app :title => "Complete Me"

  flow do
    @desired_word = edit_line
    button "Insert" do
      @slot.clear if @slot
      cm.insert(desired_word)
    end
  end



