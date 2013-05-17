import QtQuick 2.0
import Ubuntu.Components 0.1
import "game-logic.js" as GameLogic

/*
 The game board.

 */

Column {

    property alias boardSize: gameGrid.boardSize

    Label {
        id: text
        text: "Noughts goes first"
    }

    Grid {
        id: gameGrid

        // Default to a 3x3 board (we only support square boards).
        property real boardSize: 3

        // incremented each time a turn is taken
        property real numberTurns: 0

        // value to show in each cell initially
        property string defaultText: "·"

        // colours to highlight winning run of cells
        property color ubuntuColour: "#DD4814"
        property color canonicalColour: "#772953"

        // toggled between "O" and "X". The value specified below denotes
        // which side goes first.
        property string player: "O"

        columns: boardSize
        rows: boardSize

        // layout the appropriate number of cells for the board size
        Repeater {
            id: gridRepeater
            model: boardSize * boardSize

            Cell {
                width: 100
                height: width
            }
        }

        function newGame() {
            numberTurns = 0;
        }

    /* Loop through the cells, looking for a winning combination
     *
     * The algorithm used is not efficient, but it is simple to understand.
     *
     * A "win" is a contiguous run of either 'O's or 'X's that crosses the board horizontally,
     * vertically or diagonally.
     *
     * So, the algorithm used is to perform the following checks looking for a win:
     *
     * - Check each row looking for a contiguous run.
     * - Check each column looking for a contiguous run.
     * - Check the two diagonals looking for a coniguous run.
     *
     * The "Magic Square" algorithm could be considered in the future as it is
     * attractive and simple.
     */
        function checkForWin() {
            var initial;
            var winner;

            var winningCells = 0;

            // Only bother checking for a win if the minimum number
            // of turns to achieve a win have been taken.
            if (numberTurns < (boardSize * 2)-1)
                return;

            //---------------------------------------------------------
            // Check rows first
            for (var row = 0; row < boardSize; row++) {

                // reset
                initial = defaultText;
                winningCells = 0;

                for (var i = 0; i < boardSize; i++) {
                    var actualIndex = (row * boardSize) + i;

                    var element = gridRepeater.itemAt(actualIndex);

                    // Unclicked cell, so there cannot be a winner in this row
                    if (element.state === defaultText)
                        break;

                    if (initial == defaultText)
                        initial = element.state;

                    // detected non-contiguous cells, so no winner possible in this row
                    if (element.state != initial)
                        break;

                    winningCells++;
                }

                winner = initial;

                // Highlight winning cells
                if (winner !== undefined && winningCells == boardSize) {

                    // calculate actual index of first cell in winning row
                    var firstRowCellIndex = (row * boardSize);

                    // highlight the winning cells
                    for (var i = 0; i < boardSize; i++) {
                        var winner = gridRepeater.itemAt(firstRowCellIndex + i);
                        winner.color = canonicalColour;
                        winner.textColor = ubuntuColour;
                        text.text = "'" + winner.state + "'" + " wins";
                    }

                    return;
                }
            }

            //---------------------------------------------------------
            // Now check columns

            for (var col = 0; col < boardSize; col++) {

                // reset
                initial = defaultText;
                winningCells = 0;

                for (var i = 0; i < boardSize; i++) {
                    var actualIndex = col + (boardSize * i);

                    var element = gridRepeater.itemAt(actualIndex);

                    // Unclicked cell, so there cannot be a winner in this row
                    if (element.state === defaultText)
                        break;

                    if (initial == defaultText)
                        initial = element.state;

                    // detected non-contiguous cells, so no winner possible in this row
                    if (element.state != initial)
                        break;

                    winningCells++;
                }

                winner = initial;

                // Highlight winning cells
                if (winner !== undefined && winningCells == boardSize) {
                    var firstColCellIndex = col;

                    // highlight the winning cells
                    for (var i = 0; i < boardSize; i++) {
                        var winner = gridRepeater.itemAt((firstColCellIndex + (boardSize) * i));
                        winner.color = canonicalColour;
                        winner.textColor = ubuntuColour;
                        text.text = "'" + winner.state + "'" + " wins";
                    }

                    return;
                }
            }

            //---------------------------------------------------------
            // Now check diagonals

            // top-left to bottom right

            // reset
            initial = defaultText;
            winningCells = 0;

            for (var actualIndex = 0; actualIndex < (boardSize * boardSize); actualIndex += (boardSize+1)) {

                var element = gridRepeater.itemAt(actualIndex);

                // Unclicked cell, so there cannot be a winner in this row
                if (element.state === defaultText)
                    break;

                if (initial == defaultText)
                    initial = element.state;

                // detected non-contiguous cells, so no winner possible in this row
                if (element.state != initial)
                    break;

                winningCells++;

            }

            winner = initial;

            // Highlight winning cells
            if (winner !== undefined && winningCells == boardSize) {

                for (var actualIndex = 0; actualIndex < (boardSize * boardSize); actualIndex += (boardSize+1)) {
                    var winner = gridRepeater.itemAt(actualIndex);
                    winner.color = canonicalColour;
                    winner.textColor = ubuntuColour;
                    text.text = "'" + winner.state + "'" + " wins";
                }

                return;
            }

            // top-right to bottom-left

            // reset
            initial = defaultText;
            winningCells = 0;

            for (var actualIndex = boardSize-1; actualIndex < ((boardSize * boardSize)-1); actualIndex += (boardSize-1)) {

                var element = gridRepeater.itemAt(actualIndex);

                // Unclicked cell, so there cannot be a winner in this row
                if (element.state === defaultText)
                    break;

                if (initial == defaultText)
                    initial = element.state;

                // detected non-contiguous cells, so no winner possible in this row
                if (element.state != initial)
                    break;

                winningCells++;

            }

            winner = initial;

            // Highlight winning cells
            if (winner !== undefined && winningCells == boardSize) {

                for (var actualIndex = boardSize-1; actualIndex < ((boardSize * boardSize)-1); actualIndex += (boardSize-1)) {
                    var winner = gridRepeater.itemAt(actualIndex);
                    winner.color = canonicalColour;
                    winner.textColor = ubuntuColour;
                    text.text = "'" + winner.state + "'" + " wins";
                }

                return;
            }
        }
    }
}
