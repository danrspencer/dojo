///<reference path='../jasmine.d.ts' />
///<reference path='../jasmine_sss.ts' />

import Sample = require('src/Sample');

describe('Sample', () => {

  var sample;

  beforeEach(() => {
    sample = new Sample();
  });

  it('is initializable', () => {

  });

  it('returns true', () => {
    expect(sample.example()).toBe(true);
  });

});