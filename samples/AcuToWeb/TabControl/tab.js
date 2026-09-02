//alert("myscript-tab.js loaded");

completeTab(1);
//completeTab(2);
startTab(2);

function completeTab(index) {
    var li = $('#tab1.ui-control-tabs ul li[tab-index="' + (index - 1) + '"]');
    li.css({
        color: 'green',
        'border-right': '2px solid green'
    });
    li.attr('data-before', "✔");
}

function startTab(index) {
    var li = $('#tab1.ui-control-tabs ul li[tab-index="' + (index - 1) + '"]');
    li.css({
        color: 'black',
        'border-right': '2px solid indianred'
    });
    li.attr('data-before', "→");

	setTimeout(function() {
		li.mousedown();
	}, 1);
}

function complete() {
	setTimeout(function() {
		alert("form completed!");
	}, 1);
}