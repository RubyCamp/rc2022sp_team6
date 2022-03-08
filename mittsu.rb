require 'mittsu'

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
ASPECT = SCREEN_WIDTH.to_f / SCREEN_HEIGHT.to_f

renderer = Mittsu::OpenGLRenderer.new width: SCREEN_WIDTH, height: SCREEN_HEIGHT, title: 'Hello, World!'

scene = Mittsu::Scene.new

camera = Mittsu::PerspectiveCamera.new(75.0, ASPECT, 0.1, 1000.0)
camera.position.z = 5.0

box = Mittsu::Mesh.new(
  Mittsu::BoxGeometry.new(1.0, 1.0, 1.0),
  Mittsu::MeshBasicMaterial.new(color: 0x00ff00)
)

scene.add(box)

count = 0
renderer.window.run do
  # box.rotation.x += 0.1
  # box.rotation.y += 0.1

  if count == 0
    renderer.render(scene, camera)
  end
  count += 1
  puts count
  if count == 10
    break
  end
  # renderer.render(scene, camera)
end