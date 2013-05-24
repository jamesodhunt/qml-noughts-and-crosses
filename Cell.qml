import QtQuick 2.0

/*

  Individual Cell for the noughts-and-crosses board.

 */

Rectangle {
    id: cell
    state: gameGrid.defaultText

    property alias textColor: cellText.color

    Text {
        id: cellText
        text: parent.state
        color: "silver"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 90
    }

    states: [
        State {
            name: cell.parent.defaultText
            PropertyChanges { target: gameGrid; player: "" }

            // (re-)set to default content+styling
            PropertyChanges { target:cellText; text: gameGrid.defaultText }
            PropertyChanges { target:cellText; color: "silver" }
            PropertyChanges { target:cell; color: "white" }
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
            if (gameGrid.finished)
                return;

            cell.state = (gameGrid.player == "O" ? "X" : "O");
            gameGrid.numberTurns += 1
            gameGrid.checkForWin();
        }
    }
}
