class Ruby
  attr_accessor :mesh
  
    def initialize(x, y, z, renderer, scene)
      #renderer.shadow_map_enabled = true
      #renderer.shadow_map_type = Mittsu::PCFSoftShadowMap

      loader = Mittsu::OBJMTLLoader.new
      @mesh = loader.load('ruby.obj', 'ruby.mtl')
      @mesh.scale.x = 0.5
      @mesh.scale.y = 0.5
      @mesh.scale.z = 0.5
      @mesh.position.set(x, y, z)
      @mesh.rotation.z = Math::PI/7

      r = 5
      @theta = 0
      light_ruby = Mittsu::DirectionalLight.new(0xffffff)
      @mesh.add(light_ruby)
      light_ruby.position.set(r * Math.cos(@theta), 0.0, r * Math.sin(@theta))


      @scene = scene
      @renderer = renderer
    end

    def update
      @mesh.rotation.y += 0.01
      @theta += 2.0
      #renderer.render(scene, camera)
    end

end