class Enemy_virus
    attr_accessor :mesh
  
    def initialize(x, y, z, renderer, scene)
      @mesh = Mittsu::Group.new
      
      body_radius = 0.5
      line_long = 0.2

      @mesh = Mittsu::Group.new
      body = Mittsu::Mesh.new(
        Mittsu::SphereGeometry.new(body_radius, 16, 16),
        Mittsu::MeshBasicMaterial.new(color: 0x8b008b)
      )

      lines = []
      27.times do
        line = Mittsu::Mesh.new(
              Mittsu::CylinderGeometry.new(0.05, 0.05, 2*line_long),
              Mittsu::MeshBasicMaterial.new(color: 0x8b008b)
            )
        lines << line
      end
      
      spheres = []
      27.times do
        sphere = Mittsu::Mesh.new(
              Mittsu::SphereGeometry.new(0.1, 16, 16),
              Mittsu::MeshBasicMaterial.new(color: 0xff7f50)
            )
        spheres << sphere
      end
      
      @mesh.add(body)
      
      for i in 0..8 do
        @mesh.add(lines[i])
        @mesh.add(spheres[i])
        lines[i].position.x = Math.sin(Math::PI/4*i)*body_radius
        lines[i].position.y = Math.cos(Math::PI/4*i)*body_radius
        lines[i].rotation.z = -Math::PI/4*i
        spheres[i].position.x = Math.sin(Math::PI/4*i)*(body_radius+line_long)
        spheres[i].position.y = Math.cos(Math::PI/4*i)*(body_radius+line_long)
      end
      
      for i in 0..8 do
        @mesh.add(lines[i+9])
        @mesh.add(spheres[i+9])
        lines[i+9].position.x = Math.sin(Math::PI/4*i)*body_radius
        lines[i+9].position.z = Math.cos(Math::PI/4*i)*body_radius
        lines[i+9].rotation.z = -Math::PI/4*i
        lines[i+9].rotation.x = Math::PI/2
        spheres[i+9].position.x = Math.sin(Math::PI/4*i)*(body_radius+line_long)
        spheres[i+9].position.z = Math.cos(Math::PI/4*i)*(body_radius+line_long)
      end
      
      for i in 0..8 do
        @mesh.add(lines[i+18])
        @mesh.add(spheres[i+18])
        lines[i+18].position.z = Math.sin(Math::PI/4*i)*body_radius
        lines[i+18].position.y = Math.cos(Math::PI/4*i)*body_radius
        lines[i+18].rotation.x = Math::PI/4*i
        spheres[i+18].position.z = Math.sin(Math::PI/4*i)*(body_radius+line_long)
        spheres[i+18].position.y = Math.cos(Math::PI/4*i)*(body_radius+line_long)
      end
      
      @mesh.position.set(x, y, z)
  
      @renderer = renderer
      @scene = scene
    end
  
    def update
      @mesh.rotation.z += 0.1
      @mesh.rotation.y += 0.1
    end
  end