class Enemy7  # γγΎγθ²
  attr_accessor :mesh
  attr_reader :invalid, :distance

  def initialize(x, y, z, renderer, scene)
    @mesh = Mittsu::Mesh.new(
      Mittsu::BoxGeometry.new(5.0, 5.0, 2),
      Mittsu::MeshPhongMaterial.new(color: 0xeaee6d)
    )
    @mesh.position.set(x, y, z)

    @renderer = renderer
    @scene = scene
    @invalid = false
    @distance = 4
  end

  def update
    # @mesh.rotation.x += 0.1
    # @mesh.rotation.y += 0.1
    # @mesh.position.z += 0.01
  end
  def invalid!
    @invalid = true
  end
end
