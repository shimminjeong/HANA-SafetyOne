<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Draggable Clock Hour Hand</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }

        .clock {
            position: relative;
            width: 200px;
            height: 200px;
            background-color: #fff;
            border-radius: 50%;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
        }

        .hour-hand {
            position: absolute;
            width: 4px;
            height: 70px;
            background-color: #000;
            transform-origin: bottom center;
            transform: translateX(-50%) rotate(0deg);
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="clock">
    <div class="hour-hand"></div>
</div>
<script>
    const clock = document.querySelector('.clock');
    const hourHand = document.querySelector('.hour-hand');
    let isDragging = false;

    hourHand.addEventListener('mousedown', (e) => {
        isDragging = true;
        const rect = hourHand.getBoundingClientRect();
        const offsetX = e.clientX - rect.left;
        const offsetY = e.clientY - rect.top;

        document.addEventListener('mousemove', moveHourHand);

        document.addEventListener('mouseup', () => {
            isDragging = false;
            document.removeEventListener('mousemove', moveHourHand);
        });

        function moveHourHand(e) {
            if (!isDragging) return;

            const clockRect = clock.getBoundingClientRect();
            const centerX = clockRect.left + clockRect.width / 2;
            const centerY = clockRect.top + clockRect.height / 2;

            const angle = Math.atan2(e.clientY - centerY, e.clientX - centerX);
            const angleDegrees = angle * (180 / Math.PI);
            const hour = Math.floor(((angleDegrees + 90) % 360) / 30);

            hourHand.style.transform = `translateX(-50%) rotate(${angleDegrees}deg)`;
            document.title = `Hour: ${hour}`;
        }
    });
</script>
</body>
</html>
