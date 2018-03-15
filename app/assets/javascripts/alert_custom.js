$(function () {
    $(".alert-success").each(function () {
        var $this = $(this);
        var timeout = $this.data('timeout');
        var timer;
        window.clearTimeout(timer);
        timer = window.setTimeout(function () {
            $this.fadeOut();
            setTimeout(function () {$this.remove()}, 3000);
        },timeout);
    });
});
