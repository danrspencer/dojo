
define(["require", "exports", 'src/Sample'], function(require, exports, Sample) {

    describe('Sample', function () {
        var sample;

        beforeEach(function () {
            sample = new Sample();
        });

        it('is initializable', function () {

        });

        it('returns true', function () {
            expect(sample.example()).toBe(true);
        });
    });
});
