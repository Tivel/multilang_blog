var TxtType = function(el, toRotate, period) {
    this.toRotate = toRotate;
    this.el = el;
    this.loopNum = 0;
    this.period = parseInt(period, 10) || 2000;
    this.txt = '';
    this.tick();
    this.isDeleting = false;
};

TxtType.prototype.tick = function() {
    var i = this.loopNum % this.toRotate.length;
    var fullTxt = this.toRotate[i];

    if (this.isDeleting) {
        this.txt = fullTxt.substring(0, this.txt.length - 1);
    } else {
        this.txt = fullTxt.substring(0, this.txt.length + 1);
    }

    this.el.innerHTML = '<span class="wrap">'+this.txt+'</span>';

    var that = this;
    var delta = 80;

    if (this.isDeleting) { delta /= 2; }

    if (!this.isDeleting && this.txt === fullTxt) {
        delta = this.period;
        this.isDeleting = true;
    } else if (this.isDeleting && this.txt === '') {
        this.isDeleting = false;
        this.loopNum++;
        delta = 500;
    }

    setTimeout(function() {
        that.tick();
    }, delta);
};

window.onload = function() {
    var elements = document.getElementsByClassName('typewrite');
    for (var i=0; i<elements.length; i++) {
        var toRotate = elements[i].getAttribute('data-type');
        var period = elements[i].getAttribute('data-period');
        if (toRotate) {
            new TxtType(elements[i], JSON.parse(toRotate), period);
        }
    }
    // INJECT CSS
    var css = document.createElement("style");
    css.type = "text/css";
    css.innerHTML = ".typewrite > .wrap { border-right: 0.08em solid #fff}";
    document.body.appendChild(css);
};
$(document).ready(function() {
    $(".back_button").click(function () {
        window.location.href = "/";
    });

    $(".arrow").click(function () {
        var element_to_scroll_to = $('.header')[0];
        $('html, body').animate({ scrollTop: $(element_to_scroll_to).offset().top }, 500);
    });

    $(".up_link").click(function () {
        var element_to_scroll_to = $('.header')[0];
        $('html, body').animate({ scrollTop: $(element_to_scroll_to).offset().top }, 500);
    });

    $('.up').hide();

    $(window).scroll(function() {
        if($(this).scrollTop() > document.documentElement.clientHeight) {
            $('.up').fadeIn();
        } else {
            $('.up').fadeOut();
        }
    });

    $('.up_images').hide();
    $(window).scroll(function() {
        if($(this).scrollTop() > 0) {
            $('.up_images').fadeIn();
        } else {
            $('.up_images').fadeOut();
        }
    });

    if (window.location.href.indexOf("new") > -1 || window.location.href.indexOf("edit") > -1) {
        var element_to_scroll_to = $('.header')[0];
        $('html, body').animate({scrollTop: $(element_to_scroll_to).offset().top}, 500);
    }

});