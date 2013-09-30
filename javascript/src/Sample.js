define(["require", "exports"], function(require, exports) {

    var Sample = (function () {

        function Sample() {
        }

        Sample.prototype.example = function () {
            return true;
        };

        return Sample;
    })();

    
    return Sample;
});