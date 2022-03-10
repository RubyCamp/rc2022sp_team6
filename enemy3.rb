class Enemy3  # 赤い壁
  attr_accessor :mesh
  attr_reader :invalid, :distance

  def initialize(x, y, z, renderer, scene)
    @mesh = Mittsu::Mesh.new(
      Mittsu::PlaneGeometry.new(50, 24),
      Mittsu::MeshPhongMaterial.new(color: 0xFF0000)
    )
    @mesh.position.set(x, y, z)

    @renderer = renderer
    @scene = scene
    @invalid = false
    @distance = 3
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
