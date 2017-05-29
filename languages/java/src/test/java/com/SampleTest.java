package com;

import static org.fest.assertions.api.Assertions.assertThat;

import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SampleTest {

    private Sample sample = new Sample();

    private static final Logger LOG = LoggerFactory.getLogger(SampleTest.class);


    @Test()
    public void it_returns_true() {
        assertThat(sample.truth()).isTrue();
    }

}
