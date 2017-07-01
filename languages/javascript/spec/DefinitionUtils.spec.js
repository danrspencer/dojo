import utils from "../src/DefinitionUtils";

//jest.mock("InitialModelObserver", () => {});

const getDashboardDefintion = () => ({
  dashboardElements: [
    {
      containerEntityLongId: 10,
      dashboardElementType: "DAVE",
      viewDefinition: {
        globalContextIdentifiers: [1, 2, 3, 4, 5],
        currentPageIdentifiers: []
      }
    }
  ]
});

describe("getObserversForGivenContext", () => {
  it("does not mutate the original object", () => {
    const definition = getDashboardDefintion();
    utils.getObserversForGivenContext(definition, [], 55);

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
        dashboardElementType: "DAVE",
        viewDefinition: {
          globalContextIdentifiers: [],
          currentPageIdentifiers: ["bunch", "of", "awesome", "ids"]
        }
      }
    ]);
  });

  it("doesn't update the viewDefinition if type = text", () => {
    const defintion = getDashboardDefintion();
    defintion.dashboardElements[0].dashboardElementType = "TEXT";

    const result = utils.getObserversForGivenContext(defintion, [], 55);

    expect(result).toEqual([
      {
        containerEntityLongId: 55,
        dashboardElementType: "TEXT",
        viewDefinition: {
          globalContextIdentifiers: [1, 2, 3, 4, 5],
          currentPageIdentifiers: []
        }
      }
    ]);
  });
});
