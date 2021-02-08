
require_relative "player"

class Scene
    def enter()
        puts "Needs to be defined in subclasses"
        exit(0)
    end
end

class Engine
    def initialize(scene_map)
        @scene_map = scene_map
    end

    def play()

        puts "Welcome to Brandeis simulator"
        puts "Your journey will start in East Qaud"
        puts "You goal is to get to Sherman by overcoming the obstacales on the way."

        current_scene = @scene_map.home()
        last_scene = @scene_map.next_scene("Sherman")

        while current_scene != last_scene
          #  puts "#{current_scene}"
            next_scene_name = current_scene.enter()
            current_scene = @scene_map.next_scene(next_scene_name)
        end

        current_scene.enter()
    end

end


class Sherman < Scene
    def enter()
        puts "You have reached Sherman"
        
        if $player.amulet == true and $player.answerd_correctly == true
            puts "You have succesfully completed all the hidden tasks"
            puts "Thus, earned the right to eat"
        else
            puts "You have failed the game"
            puts "Try again. This time try to make different choices than you have previously made"
            puts "Also make sure to answer the old man's question correctly"
        end
        
    end
end

class East < Scene
    def enter()
        puts "While sitting in your room in the East Quad, you get bored"
        puts "You feel a bit hungry, but you want to go excersing first."
        puts "It is also snowing."
        puts "to go to the GYM, type in \"GYM\""
        puts "to go dierctly to Sherman, type in \"Road\""
        print "> "
        
        answer = $stdin.gets.chomp

        if answer == "Road" 
            puts "Your hunger comes on top and you start your jouney to Sherman."
            return "Road"

        elsif answer == "GYM"
            puts "You decide you are not as hungry as you thought and that you could go to the GYM first"
            return "GYM"

        else
            
            puts "You either mistyped something, or you are not capbale of following simple instructions"
            puts "at any rate you start over."
            return "East"
        end
    end

        

end



class Road < Scene

    def enter()
        puts "You are walking towards Sherman."
        puts "It's really cold and wet."
        puts "You forgot your boots and you are freezing."
        puts "You see a fallen fellow student that are asking for your help."
        puts "Type in \"Help\" to help them, and \"Ignore\" to ignore them."
        print "> "

        help = $stdin.gets.chomp

        if help == "Help"
           puts "You help your fellow student, and they give you a gold amulet in exchange for your help"
           $player.amulet = true;
        else
            puts "You continue on your path..."
        end

        puts "You start shivering."
        puts "As you continue on your path, you come accross Usdan."
        puts "Usdan might be a better alternative to just walking down the path"
        puts "Type in \"Usdan\" to enter Usdan. Type in \"Continue\" to keep going on the road."
        print "> "

        answer = $stdin.gets.chomp

        if answer == "Usdan"
            return "Usdan"
        end

        puts "After some time, finally you see the lights coming from Sherman"
        puts "You rush to the door to satisfy your hunger finally"
        return "Sherman"

    end
end

class Usdan < Scene
    def enter()
        puts "The doors of Usdan are heavy"
        puts "You try opening the door, but it won't budge"
        puts "You will have to press the space bar repeadtely 10 times so that it opens"

        count = 10

        while count > 0
            puts"#{count} remaining pushes"
            puts"press the ENTER key"
            print "> "
            bar = $stdin.gets
            count-=1
            
        end

        puts "The door finally opens and you walk into the warmth of the building"
        puts "You start making your way into the building"
        puts "After some time, you come across the entrance of a tunnel"
        puts "But it's dark inside the tunnel"
        puts "There is a torch near the entrance, do you take it?"
        puts "Type in \"Yes\" to take it, \"No\" to proceed without the torch"
        print "> "

        torch = $stdin.gets.chomp

        if torch == "Yes"
            puts "You continue into the tunnel"
            puts "As you are moving, you come across an old man"
            puts "He says that you can only use this tunnel should you answer his question correctly"
            puts "He says that you have 3 tries to guess correctly"
            puts "He asks, \"What is the name of the new smoothie place that opened in Upper Usdan\""
            print "> "
            
            (0...3).each do |i|
                answer = $stdin.gets.chomp
                if answer == "Swirl"
                    $player.answerd_correctly = true
                    break
                end
                puts "Wrong"
                puts "Try again"

                if i == 2
                    puts "You are out of guesses"
                    puts "You decide to make a run for it"
                    puts "You push the old man and start running"
                    puts "This move will have consequences"
                end
            end
        
        else
            puts "It gets a bit too dark to see"
            puts "You don't know what to do"
            puts "You have been respawned near Usdan"
            return "Usdan"
        end

        puts "You come to the end of tunnel"
        puts "You exit the tunnel"
        puts "You are greeted by the sight of Sherman"
        return "Sherman"

    end
end

class GYM < Scene
    def enter()
        puts "You have come to the GYM"
        puts "This is a great place to work out and be healthy"
        puts "While you are working, someone tells you that"
        puts "If you can lift 150 pounds of weight 10 times they'll tell you about a scretdoorway to Sherman"
        puts "You agree."

        count = 10

        while count > 0
            puts"#{count} remaining lifts"
            puts"press the ENTER key"
            print "> "
            bar = $stdin.gets
            count-=1
        end

        puts "They show you the way to the secret tunnel"
        puts "You run through the tunnel and arrive at Sherman"
        return "Sherman"


    end
end


class Map
    @@scenes = {'East' => East.new(),
            'Sherman' => Sherman.new(),
            'Road' => Road.new(),
            'Usdan' => Usdan.new(),
            'GYM' => GYM.new()}
    
    def initialize(start_scene)
        @start_scene = start_scene
    end

    def next_scene(scene_name)
        val = @@scenes[scene_name]
        return val
    end

    def home()
        return next_scene(@start_scene)
    end
end


map = Map.new("East")
engine = Engine.new(map)
$player = Player.new()
engine.play()
