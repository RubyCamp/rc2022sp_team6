class Enemy4  # オレンジの障害物
  attr_accessor :mesh

  def initialize(x, y, z, renderer, scene)
    @mesh = Mittsu::Mesh.new(
      Mittsu::OctahedronGeometry.new(radius = 3.0, detail = 0),
      Mittsu::MeshBasicMaterial.new(color: 0xF5A21B) # orange
    )
    @mesh.position.set(x, y, z)

    @renderer = renderer
    @scene = scene
  end

  def update
    @mesh.rotation.x += 0.01
    # @mesh.rotation.y += 0.01
    # @mesh.position.z += 0.01
  end
end
