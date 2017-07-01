// import InitialModelObserver from "InitialModelObserver";
// import array from " ./array";
// import MenuToolbarHelper from " ./MenuToolbarHelper";
// import gridletThemes from " ./gridletThemes";
// import LayoutHelper from " ./LayoutHelper";
// import lang from " ./lang";
// import json from " ./json";
// import LayoutPosition from " ./LayoutPosition";
// import constants from " ./constants";
// import HighChartsHelper from " ./HighChartsHelper";
// import EntityLongIdHelpe from " ./EntityLongIdHelpe";

function hasStaticElements(dashboardElements) {
  var addedStaticElement = false;
  for (
    var elementIndex = 0;
    elementIndex < dashboardElements.length;
    elementIndex++
  ) {
    var currentDashboardElement = dashboardElements[elementIndex];
    if (
      !currentDashboardElement.layoutPosition &&
      currentDashboardElement.dashboardElementType ===
        constants.dashboardElementType.STATIC_TEXT
    ) {
      addedStaticElement = true;
    }
  }
  return addedStaticElement;
}

function getDefaultPageSelectorOptionsForElement(dashboardElement) {
  return {
    showModuleName: array.indexOf(
      ["GRID", "CHART"],
      dashboardElement.dashboardElementType
    ) > -1,
    synchronisedPagingInfos: []
  };
}

function determineLayoutPositionForDashboardElement(
  currentDashboardElement,
  addedStaticElement,
  elementIndex,
  layoutObj,
  noLayoutCount
) {
  // Determine layout position for the current element
  if (
    !currentDashboardElement.layoutPosition &&
    currentDashboardElement.dashboardElementType ===
      constants.dashboardElementType.STATIC_TEXT
  ) {
    lang.mixin(currentDashboardElement, {
      layoutPosition: new LayoutPosition({
        rowIndex: 0,
        columnIndex: 0
      }).toString()
    });
  } else if (addedStaticElement) {
    currentDashboardElement.layoutPosition = LayoutHelper.incrementDashboardRow(
      currentDashboardElement.layoutPosition
    );
  } else if (!currentDashboardElement.layoutPosition) {
    console.info(
      "mixing in default layout position for element " + elementIndex
    );
    lang.mixin(currentDashboardElement, {
      layoutPosition: new LayoutPosition({
        rowIndex: layoutObj.rows.length + noLayoutCount,
        columnIndex: 0
      }).toString()
    });
    return noLayoutCount + 1;
  }
  return noLayoutCount;
}

function determineSizeOfDashboardElement(
  currentDashboardElement,
  elementIndex,
  contentBox
) {
  // Determine the size of the current element
  if (!currentDashboardElement.size) {
    console.info("mixing in default size for element " + elementIndex);
    lang.mixin(currentDashboardElement, {
      size: LayoutHelper.getDefaultSizeForElement(
        currentDashboardElement,
        contentBox
      )
    });
  }
}

function setGridConfigurations(
  currentDashboardElement,
  showBreakbackMarkersOnStartup,
  fallbackTheme
) {
  lang.mixin(currentDashboardElement, {
    showBreakbackMarkers: showBreakbackMarkersOnStartup
  });

  if (!currentDashboardElement.themeId) {
    //saved theme doesn't exist, so use default fall back theme (classic)
    currentDashboardElement.themeId = fallbackTheme;
  }

  setMenuOptionConfigurations(currentDashboardElement);
}

function setChartConfigurations(currentDashboardElement) {
  if (!currentDashboardElement.chartConfig) {
    lang.mixin(currentDashboardElement, {
      chartConfig: json.stringify(
        HighChartsHelper.getDefaultChartOptionsForElement(
          currentDashboardElement
        )
      )
    });
  }

  setMenuOptionConfigurations(currentDashboardElement);
}

function setMenuOptionConfigurations(currentDashboardElement) {
  var menuToolbarOptions = MenuToolbarHelper.getDefaultMenuToolbarOptionsForElement(
    currentDashboardElement
  );
  if (currentDashboardElement.menuToolbarOptions) {
    lang.mixin(
      menuToolbarOptions,
      json.parse(currentDashboardElement.menuToolbarOptions)
    );
  }
  currentDashboardElement.menuToolbarOptions = json.stringify(
    menuToolbarOptions
  );
}

function setDefaultPageSelectorIfNeeded(currentDashboardElement) {
  // Does the current element need a page selector?
  if (!currentDashboardElement.pageSelectorOptions) {
    lang.mixin(currentDashboardElement, {
      pageSelectorOptions: getDefaultPageSelectorOptionsForElement(
        currentDashboardElement
      )
    });
  }
}

/**
     * Helper function to return an array of model observers and run some custom logic on each element to figure out what pages to apply
     * @param dashboardDefinition
     * @param dashboardEntityLongId
     * @param setViewDefinition {function} - function to determine the current pages of the given widget
     * @returns {Array}
     * @private
     */
function getInitialModelObservers(
  dashboardDefinition,
  dashboardEntityLongId,
  setViewDefinition
) {
  var _initialModelObservers = [];

  dashboardDefinition.dashboardElements.forEach(function(de, elementIndex) {
    var clonedDashboardElement = lang.clone(de);
    clonedDashboardElement.containerEntityLongId = dashboardEntityLongId;

    if (
      clonedDashboardElement.dashboardElementType !==
        constants.dashboardElementType.TEXT &&
      clonedDashboardElement.viewDefinition
    ) {
      setViewDefinition(clonedDashboardElement, elementIndex);
    }

    _initialModelObservers.push(
      new InitialModelObserver(clonedDashboardElement)
    );
  });

  return _initialModelObservers;
}

const exports = {
  /**
     * Do some tidy up and set appropiate defaults on the dashboard definition items
     * @param currentDefinition
     * @param contentBox
     * @param showBreakbackMarkersOnStartup
     * @returns {Array}
     */
  cleanDefinition: function(
    currentDefinition,
    contentBox,
    showBreakbackMarkersOnStartup
  ) {
    var fallbackTheme = gridletThemes.getFallBackTheme();
    var dashboardElements = [];

    if (currentDefinition !== null) {
      dashboardElements = currentDefinition.dashboardElements;
    }

    // No elements so no point continuing
    if (!dashboardElements || !dashboardElements.length) {
      return [];
    }

    var layoutObj = LayoutHelper.parseDashboardElements(dashboardElements);
    var elementsWithNoLayoutPositionCount = 0;
    var addedStaticElement = hasStaticElements(dashboardElements);

    dashboardElements.forEach(function(currentDashboardElement, elementIndex) {
      elementsWithNoLayoutPositionCount = determineLayoutPositionForDashboardElement(
        currentDashboardElement,
        addedStaticElement,
        elementIndex,
        layoutObj,
        elementsWithNoLayoutPositionCount
      );

      determineSizeOfDashboardElement(
        currentDashboardElement,
        elementIndex,
        contentBox
      );

      setDefaultPageSelectorIfNeeded(currentDashboardElement);

      if (
        currentDashboardElement.dashboardElementType ===
        constants.dashboardElementType.CHART
      ) {
        setChartConfigurations(currentDashboardElement);
      }

      if (
        currentDashboardElement.dashboardElementType ===
        constants.dashboardElementType.GRID
      ) {
        setGridConfigurations(
          currentDashboardElement,
          showBreakbackMarkersOnStartup,
          fallbackTheme
        );
      }
    });
  },

  /**
     * Get the initial observers for a default dashboard
     * Pages set in the following priority: 1) Initial Pages 2) Global Context 3) Server Default.
     * @param dashboardDefinition
     * @param globalContextIdentifiers
     * @param dashboardEntityLongId
     * @returns {Array}
     */
  getObserversForDefinitionWithGlobalContext: function(
    dashboardDefinition,
    globalContextIdentifiers,
    dashboardEntityLongId
  ) {
    var setViewDefinition = function(dashboardElement, elementIndex) {
      var currentPages = [];

      if (dashboardElement.pageSelectorOptions) {
        var pageSelectorOptions = dashboardElement.pageSelectorOptions;

        if (pageSelectorOptions.synchronisedPagingInfos) {
          // Loop over Page Selectors
          pageSelectorOptions.synchronisedPagingInfos.forEach(function(
            pagingInfo
          ) {
            if (pagingInfo.initialPage) {
              currentPages.push(pagingInfo.initialPage);
            }
          });
        }
      }

      // Convert entity long ids to entity long id identifiers
      var identifiers = EntityLongIdHelper.entityLongIdsToEntityLongIdIdentifiers(
        currentPages
      );

      dashboardElement.viewDefinition.globalContextIdentifiers = globalContextIdentifiers;
      dashboardElement.viewDefinition.currentPageIdentifiers = identifiers;
    };

    return getInitialModelObservers(
      dashboardDefinition,
      dashboardEntityLongId,
      setViewDefinition
    );
  },

  /**
     * Get the iniital observers for an 'end user view'
     * Pages set in the following priority: 1) Global Context 2) Supplied pages 3) Server default.
     * @param dashboardDefinition
     * @param globalContextIdentifiers
     * @param dashboardEntityLongId
     * @param dashboardContext
     */
  getObserversForInitialEndUserView: function(
    dashboardDefinition,
    globalContextIdentifiers,
    dashboardContext,
    dashboardEntityLongId
  ) {
    var globalContextEntityLongIds = EntityLongIdHelper.entityLongIdIdentifiersToEntityLongIds(
      globalContextIdentifiers
    );
    var globalEntityTypeIndexes = EntityLongIdHelper.entityLongIdsToEntityTypeIndexes(
      globalContextEntityLongIds
    );

    var setViewDefinition = function(dashboardElement, elementIndex) {
      var currentPages = dashboardContext[elementIndex]
        ? dashboardContext[elementIndex].currentPages
        : [];

      // Clone because we don't want to modify the dashboard context
      var clonedCurrentPages = lang.clone(currentPages);

      if (globalEntityTypeIndexes.length > 0) {
        // Any matching values in global context take priority over the user saved selections
        globalEntityTypeIndexes.forEach(function(
          globalEntityTypeIndex,
          globalContextIndex
        ) {
          for (var i = 0; i < clonedCurrentPages.length; i++) {
            var entityLongId = clonedCurrentPages[i];
            var entityTypeIndex = EntityLongIdHelper.getEntityTypeIndex(
              entityLongId
            );

            if (entityTypeIndex === globalEntityTypeIndex) {
              clonedCurrentPages[i] =
                globalContextEntityLongIds[globalContextIndex];
              break;
            }
          }
        });
      }

      // Convert entity long ids to entity long id identifiers
      var identifiers = EntityLongIdHelper.entityLongIdsToEntityLongIdIdentifiers(
        clonedCurrentPages
      );

      // Don't use global context, instead set what initial pages we wish to open on creation within currentPages
      dashboardElement.viewDefinition.globalContextIdentifiers = [];
      dashboardElement.viewDefinition.currentPageIdentifiers = identifiers;
    };

    return getInitialModelObservers(
      dashboardDefinition,
      dashboardEntityLongId,
      setViewDefinition
    );
  },

  /**
     * Get the initial observers given a dashboard definition & a dashboard context
     * Pages set in the following priority: 1) Supplied pages 2) Server default.
     * @param dashboardDefinition
     * @param dashboardContext
     * @param dashboardEntityLongId
     * @returns {Array}
     */
  getObserversForGivenContext: function(
    dashboardDefinition,
    dashboardContext,
    dashboardEntityLongId
  ) {
    var setViewDefinition = function(dashboardElement, elementIndex) {
      var currentPages = dashboardContext[elementIndex]
        ? dashboardContext[elementIndex].currentPages
        : [];

      // Convert entity long ids to entity long id identifiers
      var identifiers = EntityLongIdHelper.entityLongIdsToEntityLongIdIdentifiers(
        currentPages
      );

      // Don't use global context, instead set what initial pages we wish to open on creation within currentPages
      dashboardElement.viewDefinition.globalContextIdentifiers = [];
      dashboardElement.viewDefinition.currentPageIdentifiers = identifiers;
    };

    return getInitialModelObservers(
      dashboardDefinition,
      dashboardEntityLongId,
      setViewDefinition
    );
  }
};

function getInitialModelObservers(
  dashboardDefinition,
  dashboardEntityLongId,
  setViewDefinition
) {
  return dashboardDefinition.dashboardElements.map(function(
    dashboardElement,
    elementIndex
  ) {
    dashboardElement.containerEntityLongId = dashboardEntityLongId;

    if (
      dashboardElement.dashboardElementType !== "TEXT" &&
      dashboardElement.viewDefinition
    ) {
      setViewDefinition(dashboardElement, elementIndex);
    }

    return dashboardElement;
  });
}

export default exports;
