

$(function () {

  function getPieces (game_id) {
    $.get("/games/" + game_id + "/get_pieces").success( function (data) {
      console.log(data);
    });
  }
  console.log('test1');
  function fillBoard (pieces) {

    //Create the hashes to map pieces to there html code
    var whitePieces = {};
    var blackPieces = {};
    var pieceNames = ['king', 'queen', 'rook', 'bishop', 'knight', 'pawn'];
    pieceNames.forEach( function(element, index) {
      whitePieces[element] = "&#" + (9812 + index) + ";";
      blackPieces[element] = "&#" + (9818 + index) + ";";
    });
    // var pieces = $.parseJSON(piecesString);
    pieces.forEach( function(element, index) {
      console.log(element);
    });
    // $('#test').html(pieces);pie
    //Convert the ruby pieces to a javascript 2D array

  }


});