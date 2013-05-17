import QtQuick 2.0
import Ubuntu.Components 0.1

MainView {
    applicationName: "noughts-and-crosses"
    
    width: units.gu(100)
    height: units.gu(75)
    
    Page {
        title: "Noughts and Crosses"

        id: page


        Column {
            spacing: units.gu(1)

            anchors {
                margins: units.gu(2)
                fill: parent
            }

            Game {
                boardSize: 3
            }
        }
    }
}
