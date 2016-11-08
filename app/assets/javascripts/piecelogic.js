

$(document).ready(function () {

  function getPieces (game_id) {
    $.get("/games/" + game_id + "/get_pieces")
      .success( function (data) {
        fillBoard(data);
      });

    }

  function fillBoard (pieces) {
    //Create the hashes to map pieces to there html code
    var whitePieces = {};
    var blackPieces = {};
    var pieceNames = ['king', 'queen', 'rook', 'bishop', 'knight', 'pawn'];
    pieceNames.forEach( function(element, index) {
      whitePieces[element] = "&#" + (9812 + index) + ";";
      blackPieces[element] = "&#" + (9818 + index) + ";";
    });
    pieces.forEach( function(element) {
      
    });

  }

  $('#test').ready(function () {
    var path = window.location.pathname.split('/');
    var game_id = parseInt(path[path.length -1]);
    var pieces = getPieces(game_id);

});

});