class Scene
    def enter()
    end
end

class Engine
    def initialize(scene_map)

    end

    def play()
    end

end


class Sherman < Scene
    def enter()

    end
end

class East < Scene
    def enter()

    end
end


class Road < Scene
    def enter()
    end
end

class Usdan < Scene
    def enter()

    end
end

class GYM < Scene
    def enter()

    end
end


class Map
    @@scenes{"East" => East.new(),
            "Sherman" => Sherman.new(),
            "Road" => Road.new()
            "Usdan" => Usdan.new()
            "GYM" => GYM.new()}
    
    def initialize(start_scene)
        @start_scene = start_scene
    end

    def next_scene(scene_name)
        return @@scenes[scene_name]
    end
end


map = Map.new("East")
engine = Engine.new(map)
