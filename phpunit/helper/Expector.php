<?php

class Expector
{

    /** @var \PHPUnit_Framework_TestCase */
    private $_testCase;

    private $_value;

    private $_message;

    function __construct(\PHPUnit_Framework_TestCase $testCase, $value, $message = '')
    {
        $this->_testCase = $testCase;
        $this->_value = $value;
        $this->_message = $message;
    }

    public function arrayToHaveKey(array $array)
    {
        $this->_testCase->assertArrayHasKey($this->_testCase, $array);
    }

    public function arrayToNotHaveKey(array $array)
    {
        $this->_testCase->assertArrayNotHasKey($this->_testCase, $array);
    }

    public function toEqual($expected)
    {
        $this->_testCase->assertEquals($expected, $this->_value);
    }

    public function toHaveAttribute($attributeName)
    {
        $this->_testCase->assertObjectHasAttribute($attributeName, $this->_value);
    }

    public function toBeTrue()
    {
        $this->_testCase->assertTrue($this->_value);
    }

    public function toBeFalse()
    {
        $this->_testCase->assertFalse($this->_value);
    }

    public function toMatch($regex)
    {
        $this->_testCase->assertRegExp($regex, $this->_value);
    }

    public function toContain($needle)
    {
        $this->_testCase->assertContains($needle, $this->_value);
    }

    public function toBeInstanceOf($expected)
    {
        $this->_testCase->assertInstanceOf($expected, $this->_value);
    }
}
