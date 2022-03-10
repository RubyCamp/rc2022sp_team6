require_relative 'bullet'

class Player
  attr_accessor :mesh
  attr_reader :bullets
  attr_accessor :camera

  def initialize(x, y, z, renderer, scene, score)
    @mesh = Mittsu::Mesh.new(
      Mittsu::BoxGeometry.new(5, 5, 5),
      Mittsu::MeshBasicMaterial.new(color: 0x0ff00)
    )


    @photo_cnt=0
    # @mesh.position.set(x, y, z)


    @renderer = renderer
    @scene = scene
    
    @bullets = []
    # shotcount = 10
    lasttime=Time.now
    @renderer.window.on_key_typed do |key|
      case key
      when GLFW_KEY_SPACE
        nowtime=Time.now
        if  nowtime-lasttime > 1
          bullet = Bullet.new(@mesh.position.x, @mesh.position.y, @mesh.position.z, @scene)
          @scene.add(bullet.mesh)
          @bullets << bullet
          lasttime = nowtime
          # shotcount -= 1
        end
      end

      # if @mesh.position.z < -42
      #   def self.create_kuria
      #     Mittsu::ImageUtils.load_texture('images/kuria.png')
      #   end
      # end
    end

    @score = score
  end

  def update(enemies, enemies2, enemies4, enemies5, enemies6, enemies7)
    @mesh.position.z -= 0.12


    if @renderer.window.key_down?(GLFW_KEY_UP)
      @mesh.position.y +=0.1
      if @mesh.position.y > 5.0
        @mesh.position.y = 5.0
      end
    end

    if @renderer.window.key_down?(GLFW_KEY_DOWN)
      @mesh.position.y -= 0.1
      if @mesh.position.y < -5.0
        @mesh.position.y = -5.0
      end
    end

    if @renderer.window.key_down?(GLFW_KEY_LEFT)
      @mesh.position.x -=0.1
      if @mesh.position.x < -5.0
        @mesh.position.x = -5.0
      end
    end

    if @renderer.window.key_down?(GLFW_KEY_RIGHT)
      @mesh.position.x +=0.1
      if @mesh.position.x > 5.0
        @mesh.position.x = 5.0
      end
    end

   



    # @mesh.position.y += 0.1 if @renderer.window.key_down?(GLFW_KEY_UP)
    # @mesh.position.y -= 0.1 if @renderer.window.key_down?(GLFW_KEY_DOWN)
    # @mesh.position.x -= 0.1 if @renderer.window.key_down?(GLFW_KEY_LEFT)
    # @mesh.position.x += 0.1 if @renderer.window.key_down?(GLFW_KEY_RIGHT)
    # @mesh.position.z += 0.1 if @renderer.window.key_down?(GLFW_KEY_Z)
    # @mesh.position.z -= 0.1 if @renderer.window.key_down?(GLFW_KEY_A)

    @bullets.each do |bullet|
      bullet.update(enemies, enemies2, enemies4, enemies5, enemies6, enemies7)
      @bullets.delete_if {|bullet| bullet.invalid}
    end

      # ゴール時の写真アップする動作の実行（ここから）
    if  @mesh.position.z < -45 &&  @photo_cnt >=0 && @photo_cnt <=20
        @map_b = Mittsu::ImageUtils.load_texture(File.join File.dirname(__FILE__), './images/ending_description.png')
        @material_b = Mittsu::SpriteMaterial.new(map: @map_b, color: 0xffffff)
        @sprite = Mittsu::Sprite.new(@material_b)
        @sprite.position.set(0,0,-80)
        @sprite.scale.set(25,15,1.0)
        @scene.add(@sprite)
        @photo_cnt += 1
    end
    # （ここまで）
  end

  #接触処理判定
  def check(enemies, enemies2, enemies4, enemies5, enemies6, enemies7)
    enemies.each do |enemy|
      @bullets.each do |bullet|
        if bullet.mesh.position.distance_to(enemy.mesh.position) <= (0.1 + 0.5)
          enemy.mesh.material.color.set(0xff0000)
          @scene.remove(bullet.mesh)
          @bullets.delete(bullet)
          @score.points += 1
        end
      end
      if @mesh.position.distance_to(enemy.mesh.position) <= 2
        reset_position
      end

    end
    def reset_position
      @mesh.position.set(0, 0, 20)
    end

    # enemies2.each do |enemy|
    #   @bullets.each do |bullet|
    #     if bullet.mesh.position.distance_to(enemy.mesh.position) <= 0.1 + 0.5
    #       enemy.mesh.material.color.set(0xff0000)
    #       @scene.remove(bullet.mesh)
    #       @bullets.delete(bullet)
    #       @score.points += 1
    #     else
    #       # 衝突してない
    #     end
    #   end
    # end

    # enemies4.each do |enemy|
    #   @bullets.each do |bullet|
    #     if bullet.mesh.position.distance_to(enemy.mesh.position) <= 0.1 + 0.5
    #       enemy.mesh.material.color.set(0xff0000)
    #       @scene.remove(bullet.mesh)
    #       @bullets.delete(bullet)
    #       @score.points += 1
    #     else
    #       # 衝突してない
    #     end
    #   end
    # end

    # enemies5.each do |enemy|
    #   @bullets.each do |bullet|
    #     if bullet.mesh.position.distance_to(enemy.mesh.position) <= 0.1 + 0.5
    #       enemy.mesh.material.color.set(0xff0000)
    #       @scene.remove(bullet.mesh)
    #       @bullets.delete(bullet)
    #       @score.points += 1
    #     else
    #       # 衝突してない
    #     end
    #   end
    # end

    # enemies6.each do |enemy|
    #   @bullets.each do |bullet|
    #     if bullet.mesh.position.distance_to(enemy.mesh.position) <= 0.1 + 0.5
    #       enemy.mesh.material.color.set(0xff0000)
    #       @scene.remove(bullet.mesh)
    #       @bullets.delete(bullet)
    #       @score.points += 1
    #     else
    #       # 衝突してない
    #     end
    #   end
    # end

    # enemies7.each do |enemy|
    #   @bullets.each do |bullet|
    #     if bullet.mesh.position.distance_to(enemy.mesh.position) <= 0.1 + 0.5
    #       enemy.mesh.material.color.set(0xff0000)
    #       @scene.remove(bullet.mesh)
    #       @bullets.delete(bullet)
    #       @score.points += 1
    #     else
    #       # 衝突してない
    #     end
    #   end
    # end

    # enemies.each do |enemy|
    #   @bullets.each do |bullet|
    #     if bullet.mesh.position.distance_to(enemy.mesh.position) <= 0.1 + 0.5
    #       enemy.mesh.material.color.set(0xff0000)
    #       @scene.remove(bullet.mesh)
    #       @bullets.delete(bullet)
    #       @score.points += 1
    #     else
    #       # 衝突してない
    #     end
    #   end
    # end
  end
end