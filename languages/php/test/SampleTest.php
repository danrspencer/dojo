<?php

require __DIR__ . '/../helper/TestCase.php';
require __DIR__ . '/../src/Sample.php';

class SampleTest extends TestCase
{
    /** @test */
    function it_gets_a_simple_message()
    {
        $sample = new Sample();

        $result = $sample->getMessage();

        // Traditional
        $this->assertEquals('hello world', $result);

        // Alternative
        expect($result)->toEqual('hello world');
    }
}
 