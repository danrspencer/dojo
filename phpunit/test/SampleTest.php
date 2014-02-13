<?php

require __DIR__ . '/../helper/ExpectTestCase.php';
require __DIR__ . '/../src/Sample.php';

class SampleTest extends ExpectTestCase
{
    /** @test */
    function it_returns_true()
    {
        $sample = new Sample();

        $this->expect($sample->example())->toBeTrue();
    }
}
 