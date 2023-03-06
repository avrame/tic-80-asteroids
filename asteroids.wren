// title:   Asteroids
// author:  Avram Eisner, avrame@gmail.com
// desc:    A shameless Asteroids clone
// site:    website link
// license: MIT License (change this to your license of choice)
// version: 0.1
// script:  wren

var SCR_WIDTH = 240
var SCR_HEIGHT = 136

var BTN_P1 = {
    "up": 0,
    "down": 1,
    "left": 2,
    "right": 3,
    "a": 4,
    "b": 5,
    "x": 6,
    "y": 7,
}

class Game is TIC {

	construct new() {
        TIC.cls(0)

		_t=0

        _ship = Ship.new(SCR_WIDTH / 2, SCR_HEIGHT / 2)
	}
	
	TIC() {
        update()
		draw()
	}

    update() {
        if (TIC.btn(BTN_P1["up"])) {
            _ship.accelerate()
        }

        if (TIC.btn(BTN_P1["left"])) {
			_ship.rotate(-0.1)
		}

		if (TIC.btn(BTN_P1["right"])) {
			_ship.rotate(0.1)
		}

        _ship.move()
        // _t=_t+1
    }

    draw() {
        TIC.cls(0)
        _ship.draw()
    }
}

class VectorSprite {
    construct new(x, y, lines) {
        _x = x
        _y = y
        _rot = 0
        _lines = lines
        _vel = Vec.new(0, 0)
    }

    x { _x }
    x=(val) {
        _x = val
    }

    y { _y }
    y=(val) {
        _y = val
    }

    vel { _vel }
    vel=(val) {
        _vel = val
    }

    rot { _rot }

    add_line(line) {
        _lines.add(line)
    }

    rotate(deg) {
        _rot = _rot + deg
        for (line in _lines) {
            line.rotate(deg)
        }
    }

    move() {
        _x = _x + vel.x
        _y = _y + vel.y
        if (_x < 0) _x = SCR_WIDTH else if (_x > SCR_WIDTH) _x = 0
        if (_y < 0) _y = SCR_HEIGHT else if (_y > SCR_HEIGHT) _y = 0
    }

    draw() {
        for (line in _lines) {
            line.draw(_x, _y)
        }
    }
}

class Ship is VectorSprite {
    construct new(x, y) {
        var lines = [
            Line.new(0, -4, 4, 6),
            Line.new(3, 5, 0, 3),
            Line.new(0, 3, -4, 6),
            Line.new(0, -4, -4, 6),
        ]
        _thrust = 0.025
        super(x, y, lines)
    }

    accelerate() {
        vel.x = vel.x + rot.sin * _thrust
        vel.y = vel.y - rot.cos * _thrust
    }
}

class Line {
    construct new(x1, y1, x2, y2) {
        _x1 = x1
        _y1 = y1
        _x2 = x2
        _y2 = y2
        _color = 12
    }

    construct new_color(x1, y1, x2, y2, color) {
        _x1 = x1
        _y1 = y1
        _x2 = x2
        _y2 = y2
        _color = color
    }

    rotate(deg) {
        var x1 = _x1 * deg.cos - _y1 * deg.sin
        var y1 = _y1 * deg.cos + _x1 * deg.sin
        var x2 = _x2 * deg.cos - _y2 * deg.sin
        var y2 = _y2 * deg.cos + _x2 * deg.sin

        _x1 = x1
        _y1 = y1
        _x2 = x2
        _y2 = y2
    }

    draw() {
        TIC.line(_x1, _y1, _x2, _y2, _color)
    }

    draw(x_offset, y_offset) {
        TIC.line(_x1 + x_offset, _y1 + y_offset, _x2 + x_offset, _y2 + y_offset, _color)
    }
}

class Vec {
    construct new(x, y) {
        _x = x
        _y = y
    }

    x { _x }
    x=(val) {
        _x = val
    }

    y { _y }
    y=(val) {
        _y = val
    }
}

// <TILES>
// 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
// 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
// 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
// 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
// 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
// 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
// 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
// 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
// </TILES>

// <WAVES>
// 000:00000000ffffffff00000000ffffffff
// 001:0123456789abcdeffedcba9876543210
// 002:0123456789abcdef0123456789abcdef
// </WAVES>

// <SFX>
// 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
// </SFX>

// <TRACKS>
// 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// </TRACKS>

// <PALETTE>
// 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
// </PALETTE>

