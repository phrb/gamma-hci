import QtQuick 2.2

Path {
    id: p
    property real width: 200
    property real height: 200
    property real margin: 50
    property real cx: width / 2
    property real cy: height / 2
    property real rx: width / 2 - margin
    property real ry: height / 2 - margin
    property real mx: rx * magic
    property real my: ry * magic
    property real magic: 0.551784
    startX: p.cx; startY: p.cy + p.ry


    // front arc
    PathAttribute { name: "itemZ"; value: 10 }
    PathAttribute { name: "itemScale"; value: 4.0 }
    PathAttribute { name: "itemOpacity"; value: 1.0 }
    PathCubic {
        control1X: p.cx - p.mx; control1Y: p.cy + p.ry
        control2X: p.cx - p.rx; control2Y: p.cy + p.my
        x: p.cx - p.rx; y: p.cy
    }

    // left arc
    PathAttribute { name: "itemZ"; value: 5 }
    PathAttribute { name: "itemScale"; value: 2.0 }
    PathAttribute { name: "itemOpacity"; value: 0.6 }
    PathCubic {
        control1X: p.cx - p.rx; control1Y: p.cy - p.my
        control2X: p.cx - p.mx; control2Y: p.cy - p.ry
        x: p.cx; y: p.cy - p.ry
    }

    // back arc
    PathAttribute { name: "itemZ"; value: 0 }
    PathAttribute { name: "itemScale"; value: 1.5 }
    PathAttribute { name: "itemOpacity"; value: 0.3 }
    PathCubic {
        control1X: p.cx + p.mx; control1Y: p.cy - p.ry
        control2X: p.cx + p.rx; control2Y: p.cy - p.my
        x: p.cx + p.rx; y: p.cy
    }

    // right arc
    PathAttribute { name: "itemZ"; value: 5 }
    PathAttribute { name: "itemScale"; value: 2.0 }
    PathAttribute { name: "itemOpacity"; value: 0.6 }
    PathCubic {
        control1X: p.cx + p.rx; control1Y: p.cy + p.my
        control2X: p.cx + p.mx; control2Y: p.cy + p.ry
        x: p.cx; y: p.cy + p.ry
    }
}
