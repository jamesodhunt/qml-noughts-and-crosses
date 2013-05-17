import QtQuick 2.0

/*

  Individual Cell for the noughts-and-crosses board.

 */

Rectangle {
    id: cell
    width: 100
    height: 100
    state: gameGrid.defaultText

    property alias textColor: cellText.color

    Text {
        id: cellText
        text: parent.state
        color: "silver"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 48
    }

    function reset(ch) {
        cellText.text = cell.defaultText
    }

    states: [
        State {
            name: cell.parent.defaultText
            PropertyChanges { target: gameGrid; player: "" }
        },
        State {
            name: "O"
            PropertyChanges { target: gameGrid; player: cell.state }
        },
        State {
            name: "X"
            PropertyChanges { target: gameGrid; player: cell.state }
        }
    ]

    // when clicked,
    MouseArea {
        anchors.fill: parent
        onClicked: {
            cell.state = (gameGrid.player == "O" ? "X" : "O");
            gameGrid.numberTurns += 1
            gameGrid.checkForWin();
        }
    }
}
