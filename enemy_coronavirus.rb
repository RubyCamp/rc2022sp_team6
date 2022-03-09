class Enemy_virus
    attr_accessor :mesh
  
    def initialize(x, y, z, renderer, scene)
      @mesh = Mittsu::Group.new
      
      body_radius = 0.5 #球の半径
      line_long = 0.2   #スパイクの長さ

      @mesh = Mittsu::Group.new

      #本体部分
      body = Mittsu::Mesh.new(
        Mittsu::SphereGeometry.new(body_radius, 8, 8),
        Mittsu::MeshBasicMaterial.new(color: 0x8b008b)
      )

      #棒部分
      lines = []
      19.times do
        line = Mittsu::Mesh.new(
              Mittsu::CylinderGeometry.new(0.05, 0.05, 2*line_long),
              Mittsu::MeshBasicMaterial.new(color: 0x8b008b)
            )
        lines << line
      end
      
      #小さい球部分
      spheres = []
      19.times do
        sphere = Mittsu::Mesh.new(
              Mittsu::SphereGeometry.new(0.1, 4, 4),
              Mittsu::MeshBasicMaterial.new(color: 0xff7f50)
            )
        spheres << sphere
      end
      
      @mesh.add(body)
      
      #スパイクの追加
      for i in 0..7 do
        mesh.add(lines[i])
        mesh.add(spheres[i])
        theta_virus = Math::PI/4*i
        lines[i].position.x = Math.sin(theta_virus)*body_radius
        lines[i].position.y = Math.cos(theta_virus)*body_radius
        lines[i].rotation.z = -theta_virus
        spheres[i].position.x = Math.sin(theta_virus)*(body_radius+line_long)
        spheres[i].position.y = Math.cos(theta_virus)*(body_radius+line_long)
      end
      
      for i in 1..7 do
        mesh.add(lines[i+7])
        mesh.add(spheres[i+7])
        theta_virus = Math::PI/4*i
        lines[i+7].position.z = Math.sin(theta_virus)*body_radius
        lines[i+7].position.x = Math.cos(theta_virus)*body_radius
        lines[i+7].rotation.y = -theta_virus
        lines[i+7].rotation.z = -Math::PI/2
        spheres[i+7].position.z = Math.sin(theta_virus)*(body_radius+line_long)
        spheres[i+7].position.x = Math.cos(theta_virus)*(body_radius+line_long)
      end
      
      for i in 1..4 do
        mesh.add(lines[i+14])
        mesh.add(spheres[i+14])
        theta_virus = Math::PI/4 + Math::PI/2*i
        lines[i+14].position.z = Math.sin(theta_virus)*body_radius
        lines[i+14].position.y = Math.cos(theta_virus)*body_radius
        lines[i+14].rotation.x = theta_virus
        spheres[i+14].position.z = Math.sin(theta_virus)*(body_radius+line_long)
        spheres[i+14].position.y = Math.cos(theta_virus)*(body_radius+line_long)
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