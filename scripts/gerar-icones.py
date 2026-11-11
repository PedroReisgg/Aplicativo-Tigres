# Gera todos os ícones e imagens da marca a partir de public/brand/logo.png (fundo transparente).
# Uso: python3 scripts/gerar-icones.py
from PIL import Image, ImageDraw, ImageFilter
import glob

BG = (0x1C, 0x13, 0x0E, 255)
TIGER = (0xF2, 0x6B, 0x1D, 255)
logo = Image.open("public/brand/logo.png").convert("RGBA")


def fit(img, size):
    im = img.copy()
    im.thumbnail((size, size), Image.LANCZOS)
    return im


def glow(size, strength=110):
    """Brilho laranja suave atrás da logo."""
    g = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    d = ImageDraw.Draw(g)
    r = int(size * 0.34)
    c = size // 2
    d.ellipse([c - r, c - r, c + r, c + r], fill=TIGER[:3] + (strength,))
    return g.filter(ImageFilter.GaussianBlur(size * 0.12))


def tile(size, scale, rounded=0.0, bg=BG):
    im = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    if rounded:
        ImageDraw.Draw(im).rounded_rectangle([0, 0, size - 1, size - 1], radius=int(size * rounded), fill=bg)
    else:
        im.paste(bg, (0, 0, size, size))
    im.alpha_composite(glow(size))
    l = fit(logo, int(size * scale))
    im.alpha_composite(l, ((size - l.width) // 2, (size - l.height) // 2))
    return im


# Web / PWA
tile(512, 0.86).save("public/icon-512.png")
tile(192, 0.86).save("public/icon-192.png")
tile(512, 0.66).save("public/icon-maskable-512.png")
tile(192, 0.66).save("public/icon-maskable-192.png")
tile(180, 0.84).convert("RGB").save("public/apple-touch-icon.png")
tile(48, 0.92).save("src/app/icon.png")
tile(512, 0.86).save("public/brand/logo-fundo.png")
fit(logo, 256).save("capacitor-www/logo.png")

# Imagem de compartilhamento (1200x630)
og = Image.new("RGBA", (1200, 630), BG)
gl = glow(900, 120)
og.alpha_composite(gl, (150, -135))
l = fit(logo, 560)
og.alpha_composite(l, ((1200 - l.width) // 2, (630 - l.height) // 2))
og.convert("RGB").save("public/og.png", optimize=True)

# Android (Capacitor)
res = "android/app/src/main/res"
dens = {"mdpi": 1, "hdpi": 1.5, "xhdpi": 2, "xxhdpi": 3, "xxxhdpi": 4}
for d, f in dens.items():
    s = int(48 * f)
    tile(s, 0.88, rounded=0.22).save(f"{res}/mipmap-{d}/ic_launcher.png")
    rd = Image.new("RGBA", (s, s), (0, 0, 0, 0))
    mask = Image.new("L", (s, s), 0)
    ImageDraw.Draw(mask).ellipse([0, 0, s - 1, s - 1], fill=255)
    rd.paste(tile(s, 0.8), (0, 0), mask)
    rd.save(f"{res}/mipmap-{d}/ic_launcher_round.png")
    fs = int(108 * f)
    fg = Image.new("RGBA", (fs, fs), (0, 0, 0, 0))
    fg.alpha_composite(glow(fs, 90))
    l = fit(logo, int(fs * 0.62))
    fg.alpha_composite(l, ((fs - l.width) // 2, (fs - l.height) // 2))
    fg.save(f"{res}/mipmap-{d}/ic_launcher_foreground.png")
for p in glob.glob(f"{res}/drawable*/splash.png"):
    w, h = Image.open(p).size
    sp = Image.new("RGBA", (w, h), BG)
    m = int(min(w, h) * 0.55)
    sp.alpha_composite(glow(m, 120), ((w - m) // 2, (h - m) // 2))
    l = fit(logo, int(min(w, h) * 0.46))
    sp.alpha_composite(l, ((w - l.width) // 2, (h - l.height) // 2))
    sp.convert("RGB").save(p)
print("ok")
