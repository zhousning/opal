$(".trees").ready(function() {
  var leafs = gon.leafs;
  for (var i=0; i < leafs; i++){ 
    start();
  }
});

function start() {
	var imgObj=document.createElement("img");
	imgObj.setAttribute("src","/assets/leaf-ac237c1f2fe10aa7f5a9842a64f200de79c50462395461fda2ed290561eae1b2.png");
	var width=getRandom(15,85);
	imgObj.setAttribute("width",width);
	var x=getRandom(0,window.innerWidth);
	var y=getRandom(0,window.innerHeight);
	imgObj.setAttribute("style","position:absolute;left:"+x+"px;top:"+y+"px");
	document.body.appendChild(imgObj);
}

function getRandom(min,max){
	var random=Math.random()*(max-min)+min;
	random=Math.floor(random);
	return random;
}
