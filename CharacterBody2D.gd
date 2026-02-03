extends CharacterBody2D

# ===== متغيرات اللاعب =====
var player_id: int = 0

# الحركة
const SPEED := 300
const JUMP_VELOCITY := -400
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# ===== AnimatedSprite2D =====
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# ===== التحكم =====
var facing_right := true

func _physics_process(delta):
	# تحكم فقط باللاعب المحلي
	if player_id != multiplayer.get_unique_id():
		return

	# الجاذبية
	if not is_on_floor():
		velocity.y += gravity * delta

	# القفز
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# الحركة
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		# فليب الشخصية حسب الاتجاه
		sprite.flip_h = direction > 0
		facing_right = direction < 0
		# تشغيل انيميشن المشي
		sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		# انيميشن idle
		if is_on_floor():
			sprite.play("idle")

	# انيميشن القفز والسقوط
	if not is_on_floor():
		if velocity.y < 0:
			sprite.play("jump")
		else:
			sprite.play("fall")

	move_and_slide()

