class Ruby
  attr_accessor :mesh
  
    def initialize(x, y, z, renderer, scene)
      #renderer.shadow_map_enabled = true
      #renderer.shadow_map_type = Mittsu::PCFSoftShadowMap

      loader = Mittsu::OBJMTLLoader.new
      @mesh = loader.load('ruby.obj', 'ruby.mtl')

=begin
      r = 10
      @theta = 0
      light_ruby = Mittsu::SpotLight.new(0xffffff, 1.0)
      light_ruby.position.set(r * Math.cos(@theta), 0.0, r * Math.sin(@theta))
=end


      @scene = scene
      @renderer = renderer
    end

    def update
      @mesh.rotation.y += 0.01
      #@theta += 0.3
      #renderer.render(scene, camera)
    end

end