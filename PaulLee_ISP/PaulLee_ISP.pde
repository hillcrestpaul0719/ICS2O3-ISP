StringDict state = new StringDict();
PImage mazeImg;
PFont font;
StringList curVimDisplay;

void store(String dict_key, int value) {
    state.set(dict_key, str(value));
}

void store(String dict_key, float value) {
    state.set(dict_key, str(value));
}

void store(String dict_key, String value) {
    state.set(dict_key, value);
}

String fetch(String dict_key) {
   return state.get(dict_key);
}

int fetchInt(String dict_key) {
    return Integer.parseInt(fetch(dict_key));
}

float fetchFloat(String dict_key) {
    return Float.parseFloat(fetch(dict_key));
}

void setState() {

    store("curTime", millis());
    if (fetchInt("curTime") <= 5000) {
        loading();
    }
    if (fetchInt("curTime") < 35000 && fetchInt("curTime") > 5000) {
        animation();
    }
}

void animation() {
    store("state", "animation");
    store("aniTime", fetchInt("curTime") - 5000);
    if (fetchInt("aniTime") < 10000) {
        store("aniScene", "typing");
    } else if (fetchInt("aniTime") < 15000) {
        store("aniScene", "submitting");
    } else if (fetchInt("aniTime") < 20000) {
        store("aniScene", "frowning");
    } else if (fetchInt("aniTime") < 25000) {
        store("aniScene", "learning");
    } else {
        store("aniScene", "fadeout");
    }
}

void loading() {
    store("state", "loading");
    store("loadTime", fetchInt("curTime"));
    store("loadPercent", fetchInt("loadTime")/50);
    store("loadRectY", lerp(0, height, (100-fetchFloat("loadPercent"))/100));
}

void mainMenu() {
}

void station1() {

}

void station2() {

}

void station3() {

}

void station4() {

}

void station5() {

}

void help() {

}

void goodbye() {

}

void game() {
    
}

void draw() {
    setState();
    background(255);
    stroke(0);
    if (fetch("state").equals("loading")) {
        fill(255, 100, 100);
        rect(0, fetchFloat("loadRectY"), width, height);
        fill(0);
        textSize(20);
        textAlign(CENTER, CENTER);
        noStroke();
        text(fetch("loadPercent") + "%", width/2, height/2);
    } else if (fetch("state").equals("animation")) {
        if (fetch("aniScene").equals("typing") || fetch("aniScene").equals("submitting") || fetch("aniScene").equals("learning") || fetch("aniScene").equals("fadeout")) {
            rectMode(CORNERS); 
            fill(100);
            rect(50, 50, width-50, 400);
            fill(200);
            rect(75, 75, width-75, 375);
            fill(100);
            rect(width/2-50, 400, width/2+50, 425);
            rect(width/2-100, 425, width/2+100, 450);
            fill(150);
            rect(75, 500, width-75, 825);
            fill(175);
            for (int i=100; i<=width-150; i+=75) {
                for (int j=525; j<=height-150; j+=75) {
                    rect(i, j, i+50, j+50);
                }
            }
            if (fetch("aniScene").equals("typing")) {
                store("aniHandTime", fetchInt("aniTime") % 2000);
                store("aniHandHeightDelta", abs(fetchInt("aniHandTime") - 1000)/10);
                rect(width/2-100, 600 + fetchFloat("aniHandHeightDelta"), width/2-50, height);
                rect(width/2+50, 700 - fetchFloat("aniHandHeightDelta"), width/2+100, height);
            } else if (fetch("aniScene").equals("submitting")) {
                fill(255, 100, 100);
                textSize(25);
                text("Typing Speed: 10 Words Per Min", 100, 100, width-100, 350);
            } else if (fetch("aniScene").equals("learning") || fetch("aniScene").equals("fadeout")) {
                fill(100, 100, 255);
                textSize(25);
                text("Want to learn to type faster? Learn Vim!", 100, 100, width-100, 350);
            }
            if (fetch("aniScene").equals("fadeout")) {
              fill(0, (fetchInt("aniTime")-25000)/19.6);
              rect(0, 0, width, height);
            }
        } else if (fetch("aniScene").equals("frowning")) {
            ellipseMode(CENTER);
            fill(100, 100, 255);
            store("aniMouthPointsDelta", (fetchInt("aniTime")-15000)/100);
            rect(width/2-300, 150, width/2+300, height, 30, 30, 0, 0); 
            fill(255);
            circle(width/2, 150, 150);
            fill(155);
            circle(width/2-25, 125, 10);
            circle(width/2+25, 125, 10);
            bezier(width/2-40, 160+fetchFloat("aniMouthPointsDelta"), width/2-40, 210-fetchFloat("aniMouthPointsDelta"), width/2+40, 210-fetchFloat("aniMouthPointsDelta"), width/2+40, 160+fetchFloat("aniMouthPointsDelta"));
        }
    }
    fill(0);
    textSize(15);
    textAlign(LEFT, TOP);
    text("("+mouseX+", "+mouseY+")", mouseX, mouseY);
}

void setup() {
    size(900, 900);
    frameRate(30);
    font = createFont("font.ttf", 20);
    textFont(font);
    store("initTime", millis());   
    store("aniScene", "none");
}
