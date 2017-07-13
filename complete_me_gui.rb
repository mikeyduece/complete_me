require './lib/complete_me'

cm = CompleteMe.new
dictionary = File.read("/usr/share/dict/words")
cm.populate(dictionary)

Shoes.app(title: "CompleteMe", width: 550) do
  flow(margin: [15, 15, 15, 5]) do
    para("Enter the start of a word to see suggestions.")
  end
  flow(margin: [15, 0, 15, 15]) do
    @prefix = edit_line
    @suggest_button = button "Suggest"

    button "Clear" do
      @results.clear
    end
  end

  @suggest_button.click do
    @results.clear if @results
    @suggestions = cm.suggest(@prefix.text)
    @results = flow(margin: [15, 0, 15, 0]) do
      @suggestions.each do |word|
        para(
          link(word, stroke: "black").click do
            cm.select(@prefix.text, word)
          end
        )
      end
    end
  end
end
