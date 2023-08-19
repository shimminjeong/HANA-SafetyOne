
<!DOCTYPE html>
<html>
<body>

<canvas id="mc" width="400" height="400" style="background-color:white ">
</canvas>

<script>
    var mc = document.getElementById("mc");
    var ctx = mc.getContext("2d");
    var radius = mc.height /2;
    ctx.translate(radius, radius);;
    radius = radius * 0.90;
    setInterval(drawClock, 1000);


    function drawClock() {
        drawFace(ctx, radius);
        drawNumber(ctx, radius);
        showTime(ctx, radius)
    }

    function drawFace(ctx, radius) {
        var grad;
        ctx.beginPath();
        ctx.arc(0, 0, radius, 0, 2*Math.PI);
        ctx.fillStyle = 'pink';
        ctx.fill();
        grad = ctx.createRadialGradient(0,0,radius*0.95, 0,0,radius*1.05);
        grad.addColorStop(0, 'blue');
        grad.addColorStop(0.5, 'pink');
        grad.addColorStop(1, 'blue');
        ctx.strokeStyle = grad;
        ctx.lineWidth = radius*0.1;
        ctx.stroke();
        ctx.beginPath();
        ctx.arc(0, 0, radius*0.1, 0, 2*Math.PI);
        ctx.fillStyle = 'blue';
        ctx.fill();
    }

    function drawNumber(ctx, radius) {
        var ang;
        var num;
        ctx.font = radius*0.15 + "px 고딕";
        ctx.textBaseline="middle";
        ctx.textAlign="center";
        for(num = 1; num <= 12; num++){
            ang = num * 2 *Math.PI / 12;
            ctx.rotate(ang);
            ctx.translate(0, -radius*0.85);
            ctx.rotate(-ang);
            ctx.fillText(num.toString(), 0, 0);
            ctx.rotate(ang);
            ctx.translate(0, radius*0.85);
            ctx.rotate(-ang);
        }
    }

    function drawHand(ctx, pos, length, width) {
        ctx.beginPath();
        ctx.lineWidth = width;
        ctx.lineCap = "round";
        ctx.moveTo(0, 0)
        ctx.rotate(pos);
        ctx.lineTo(0, -length);
        ctx.stroke();
        ctx.rotate(-pos);
    }

    function showTime(ctx, radius){
        var now = new Date();
        var hour = now.getHours();
        var min = now.getMinutes();
        var sec = now.getSeconds();

        hour = hour%12;
        hour = (hour*2*Math.PI/12)+(min*2*Math.PI/(12*60))+(sec*2*Math.PI/(12*60*60));
        drawHand(ctx, hour, radius*0.5, radius*0.08);

        min = (min*2*Math.PI/60)+(sec*2*Math.PI/(60*60));
        drawHand(ctx, min, radius*0.8, radius*0.07);

        sec = sec*2*Math.PI/60;
        drawHand(ctx, sec, radius*0.9, radius*0.02);
    }
</script>

</body>
</html>