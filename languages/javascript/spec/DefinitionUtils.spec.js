import utils from "../src/DefinitionUtils";

//jest.mock("InitialModelObserver", () => {});

const getDashboardDefintion = () => ({
  dashboardElements: [
    {
      containerEntityLongId: 10,
      dashboardElementType: "Dave"
    }
  ]
});

describe("getObserversForGivenContext", () => {
  it("does not mutate the original object", () => {
    const definition = getDashboardDefintion();

    const result = utils.getObserversForGivenContext(definition, [], 55);

    expect(definition).toEqual(getDashboardDefintion());
  });

  it("does something", () => {
    const result = utils.getObserversForGivenContext(
      getDashboardDefintion(),
      [],
      55
    );

    expect(result).toEqual([
      {
        containerEntityLongId: 55,
        dashboardElementType: "Dave"
      }
    ]);
  });
});
