<?php

require __DIR__ . '/Expector.php';

class ExpectTestCase extends \PHPUnit_Framework_TestCase
{
    // Setup expect function - in case PHP 5.3 (no traits)
    public function expect($actual)
    {
        return new Expector($this, $actual);
    }
    // ------------------------------------------------

    /**
     * Returns a mock object for the specified class.
     * [[Overrides the default to call original constructor]]
     *
     * @param  string     $originalClassName       Name of the class to mock.
     * @param  array|null $methods                 When provided, only methods whose names are in the array
     *                                             are replaced with a configurable test double. The behavior
     *                                             of the other methods is not changed.
     *                                             Providing null means that no methods will be replaced.
     * @param  array      $arguments               Parameters to pass to the original class' constructor.
     * @param  string     $mockClassName           Class name for the generated test double class.
     * @param  boolean    $callOriginalConstructor Can be used to disable the call to the original class' constructor.
     * @param  boolean    $callOriginalClone       Can be used to disable the call to the original class' clone constructor.
     * @param  boolean    $callAutoload            Can be used to disable __autoload() during the generation of the test double class.
     * @param  boolean    $cloneArguments
     * @return \PHPUnit_Framework_MockObject_MockObject
     * @throws \PHPUnit_Framework_Exception
     * @since  Method available since Release 3.0.0
     */
    public function getMock(
        $originalClassName,
        $methods = array(),
        array $arguments = array(),
        $mockClassName = '',
        $callOriginalConstructor = false,
        $callOriginalClone = true,
        $callAutoload = true,
        $cloneArguments = false
    ) {
        return parent::getMock(
            $originalClassName,
            $methods,
            $arguments,
            $mockClassName,
            $callOriginalConstructor,
            $callOriginalClone,
            $callAutoload,
            $cloneArguments
        );
    }
}
