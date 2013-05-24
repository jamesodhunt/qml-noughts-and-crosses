import QtQuick 2.0
import Ubuntu.Components 0.1

MainView {
    applicationName: "noughts-and-crosses"
    
    width: units.gu(100)
    height: units.gu(75)
    
    Page {
        title: "Noughts and Crosses"

        id: page

        Game {
            id: game
            boardSize: 3
        }

        tools: ToolbarActions {
            id: toolbar
            active: true

            Action {
                text: "New Game"
                onTriggered: game.newGame()
            }
        }
    }
}
