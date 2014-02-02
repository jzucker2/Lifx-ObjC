$(function(){

    window.onerror = function(e) {
        alert(JSON.stringify(e));
    }

    try {

        var pubnub = PUBNUB.init({
            publish_key: 'demo',
            subscribe_key: 'demo'
        });
         
        // create canvas and context objects

        var canvas = document.getElementById('picker');
        var ctx = canvas.getContext('2d');
        var tmp_ctx = canvas.getContext("2d").getImageData(0, 0, 300, 300);

        var pixel;
        var pixelColor;
        var savedPixelColor;
        var savedPixel;

        var initCanvas = function() {
            ctx.putImageData(tmp_ctx , 0, 0);
            ctx.drawImage(image, 0, 0, 300, 300); // draw the image on the canvas
        }

        function getMousePos(evt) {
            var rect = canvas.getBoundingClientRect();
            return {
                x: evt.clientX - rect.left,
                y: evt.clientY - rect.top
            };
        }

        var rgbToHsl = function(r, g, b) {
            r /= 255, g /= 255, b /= 255;
            var max = Math.max(r, g, b), min = Math.min(r, g, b);
            var h, s, l = (max + min) / 2;

            if(max == min){
                h = s = 0; // achromatic
            }else{
                var d = max - min;
                s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
                switch(max){
                    case r: h = (g - b) / d + (g < b ? 6 : 0); break;
                    case g: h = (b - r) / d + 2; break;
                    case b: h = (r - g) / d + 4; break;
                }
                h /= 6;
            }

            return {h: parseInt(h*65025), s: parseInt(s*65025), l: parseInt(l*65025)};
        }

        var sendColor = function() {
            var hsl = rgbToHsl(pixel[0], pixel[1], pixel[2]);
            pubnub.publish({
                channel: 'jordanlifx',
                message: hsl
            });
        }


        // drawing active image
        var image = new Image();
        image.onload = initCanvas;

        var initImage = function() {
            var imageSrc;
            switch ($(canvas).attr('var')) {
                case '1':
                    imageSrc = 'images/colorwheel1.png';
                    break;
                case '2':
                    imageSrc = 'images/colorwheel2.png';
                    break;
                case '3':
                    imageSrc = 'images/colorwheel3.png';
                    break;
                case '4':
                    imageSrc = 'images/colorwheel4.png';
                    break;
                case '5':
                    imageSrc = 'images/colorwheel5.png';
                    break;
                case '6':
                    imageSrc = 'images/colorwheel6.png';
                    break;
            }
            image.src = imageSrc;
        }

        window.initImage = initImage;

        initImage(); 


        var processColors = function() {
            if (!pixelColor || !pixel) {
                return;
            }

            if (pixel[0] === 0 && pixel[1] === 0 && pixel[2] === 0) {
                return;
            }

            $('.preview').css('backgroundColor', pixelColor);
            $('.saved').css('backgroundColor', savedPixelColor);

            // update controls
            $('#rVal').val(pixel[0]);
            $('#gVal').val(pixel[1]);
            $('#bVal').val(pixel[2]);
            $('#rgbVal').val(pixel[0]+','+pixel[1]+','+pixel[2]);

            var dColor = pixel[2] + 256 * pixel[1] + 65536 * pixel[0];
            $('#hexVal').val('#' + ('0000' + dColor.toString(16)).substr(-6));

            sendColor();
        }

        $('#picker').on('mousemove', _.throttle(function(e) {

            try {
     
                // get coordinates of current position
                var canvasX_Y = getMousePos(e);

                pixel = ctx.getImageData(canvasX_Y.x, canvasX_Y.y, 1, 1).data;
                pixelColor = "rgb("+pixel[0]+", "+pixel[1]+", "+pixel[2]+")";

                processColors();

            } catch (e) {
                alert(JSON.stringify(e));
            }

            
        }, 250));

        $('#picker').on('click', function(e) {
        
            savedPixelColor = pixelColor;
            savedPixel = pixel;
     
            // get coordinates of current position
            var canvasOffset = $(canvas).offset();
            var canvasX = Math.floor(e.pageX - canvasOffset.left);
            var canvasY = Math.floor(e.pageY - canvasOffset.top);

            initCanvas();

            ctx.beginPath();
            ctx.strokeStyle="rgb(255,255,255)"
            ctx.arc(canvasX,canvasY,3,0,2*Math.PI);
            ctx.stroke();

            processColors();

        });

        $('#picker').bind('mouseout', function() {

            pixelColor = savedPixelColor;
            pixel = savedPixel;
            processColors();
        });

        /*

        todo hold 2 colors up at once for side by side

        */

    } catch (e) {
        alert(JSON.stringify(e));
    }

});
