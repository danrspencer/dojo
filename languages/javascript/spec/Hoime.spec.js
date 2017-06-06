import { factorise } from "../src/Hoime";

describe("Factorise", () => {
    it('returns an empty array when given 1', () => {
        expect(factorise(1)).toEqual([]);
    });

    it('returns 2 when given 2', () => {
        expect(factorise(2)).toEqual([2]);
    });

    it('returns 3 when given 3', () => {
        expect(factorise(3)).toEqual([3]);
    });

    it('returns 2, 2 when given 4', () => {
        expect(factorise(4)).toEqual([2,2]);
    });

    it('returns 5 when given 5', () => {
        expect(factorise(5)).toEqual([5]);
    });

    it('returns 2, 3 when given 6', () => {
        expect(factorise(6)).toEqual([2, 3]);
    });

    it('returns 7 when given 7', () => {
        expect(factorise(7)).toEqual([7]);
    });

    it('returns 2, 2, 2 when given 8', () => {
        expect(factorise(8)).toEqual([2, 2, 2]);
    });

    it('returns 3, 3 when given 9', () => {
        expect(factorise(9)).toEqual([3, 3]);
    });
});