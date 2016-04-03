require 'yaml'
require 'pry'
require 'readline'

class Question
  def initialize(question, yes, no)
    @question = question
    @correct = yes
    @incorrect = no
  end

  def walk
    puts "#{@question.text}"
    ww = Readline.readline("", true)
    ww.chomp!
    if ww.eql? 'yes'
      right.walk
    elsif ww.eql? 'no'
      left.walk
    else
      walk
    end
  end
end

class Animal
  attr_accessor :text
  attr_accessor :parent

  def initialize(text)
    @text = text
  end

  def walk
    puts "r u guessing #{text}"
    ww = Readline.readline("", true)
    if (ww.chomp.eql? 'yes')
      puts "i win !!!"
      exit(0)
    else
      puts "you win.Help me learn from my mistake before you go..."
      puts "What animal were you thinking of?"
      ww = Readline.readline("", true)
      new_animal = Animal.new(ww.chomp)
      puts "Give me a question to distinguish a #{text} from an #{text}"
      ww = Readline.readline("", true)
      Question.new(ww.chomp, new_animal, self)
      # update_tree(self, ques, ans)
      exit(22)
    end
  end

  def update_tree(curr_node, ques, ans)
    # create new node
    ques.right = ans
    ques.left = curr_node

    # append to prev nodes
    if curr_node.parent #later runs
      if curr_node.parent.left == curr_node
        curr_node.parent.left = ques
      else
        curr_node.parent.right = ques
      end
    end

    # set hierarchy
    ques.parent = curr_node.parent
    curr_node.parent = ques
    ans.parent = ques

    # move to root
    curr_node = curr_node.parent while (curr_node.parent)

    # binding.pry
    save_file(curr_node)
  end

  def save_file obj
    File.open('quiz.yml', 'w') do |h|
      h.write obj.to_yaml
    end
  end
end

class Quiz
  def self.start
    if File.exist? "animals.yml"
      current = open("animals.yml") { |f| YAML.load(f.read) }
    else
      current = Animal.new("mouse")
    end
    puts "Think of an animal..."
    new.start(current)
  end

  def start(curr_node)
    while true
      curr_node.walk
    end
  end
end

Quiz.start
