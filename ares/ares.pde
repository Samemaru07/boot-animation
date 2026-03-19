PImage bg;
float SCALE = 2.0; // ← ここを変えると拡大率が変わる

void setup() {
    size(900, 540); // 450×270 の2倍
    bg = loadImage("/home/samemaru/Downloads/ares.jpg");
}

void draw() {
    background(0);
    image(bg, 0, 0, width, height);

    scale(SCALE); // 表示だけ拡大、座標系は450×270のまま
    translate(width / 2 / SCALE, height / 2 / SCALE);

    stroke(255);
    strokeWeight(1.0 / SCALE); // 線の太さが拡大されないように補正
    noFill();
    line(-225, 0, 225, 0);
    line(0, -135, 0, 135);

    int mx = (int)(mouseX / SCALE - width / 2 / SCALE);
    int my = (int)(mouseY / SCALE - height / 2 / SCALE);
    fill(255);
    textSize(12 / SCALE); // テキストも補正
    text(mx + ", " + my, mx, my);
}
