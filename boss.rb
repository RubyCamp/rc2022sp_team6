class Enemy
  attr_accessor :mesh
  attr_reader :invalid, :distance

  def initialize(x, y, z, renderer, scene)
    @mesh = Mittsu::Mesh.new(
      Mittsu::BoxGeometry.new(1, 1, 1),
      Mittsu::MeshPhongMaterial.new(color: 0x0000ff)
    )
    @mesh.position.set(x, y, z)

    @renderer = renderer
    @scene = scene
    @invalid = false
    @distance = 6
  end

  def update
    @mesh.rotation.x += 0.1
    @mesh.rotation.y += 0.1
  end
  def invalid!
    @invalid = true
  end
end
