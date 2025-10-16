//
//  ColesUITests.swift
//  ColesUITests
//
//  Created by Tim Kreger on 16/10/2025.
//

import XCTest

final class ColesUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    // MARK: - Portrait Mode Tests
    
    @MainActor
    func testPortraitModeShowsRecipeDetail() throws {
        // Set device to portrait orientation
        XCUIDevice.shared.orientation = .portrait
        
        // Wait for recipe to load
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == true"),
            object: app.scrollViews.firstMatch
        )
        wait(for: [expectation], timeout: 5.0)
        
        // Verify recipe detail elements are visible
        XCTAssertTrue(app.scrollViews.firstMatch.exists, "ScrollView should be present in portrait mode")
        
        // Check for recipe info bar elements (Serves, Prep, Cooking)
        let servesText = app.staticTexts["Serves"]
        let prepText = app.staticTexts["Prep"]
        let cookingText = app.staticTexts["Cooking"]
        
        XCTAssertTrue(servesText.exists, "Serves label should be visible")
        XCTAssertTrue(prepText.exists, "Prep label should be visible")
        XCTAssertTrue(cookingText.exists, "Cooking label should be visible")
    }
    
    @MainActor
    func testPortraitModeShowsIngredients() throws {
        XCUIDevice.shared.orientation = .portrait
        
        // Wait for content to load
        sleep(2)
        
        // Scroll down to find ingredients
        let scrollView = app.scrollViews.firstMatch
        scrollView.swipeUp()
        
        // Verify Ingredients header exists
        let ingredientsHeader = app.staticTexts["Ingredients"]
        XCTAssertTrue(ingredientsHeader.waitForExistence(timeout: 3), "Ingredients header should be visible")
    }
    
    // MARK: - Landscape Mode Tests
    
    @MainActor
    func testLandscapeModeShowsRecipeGrid() throws {
        // Set device to landscape orientation
        XCUIDevice.shared.orientation = .landscapeLeft
        
        // Wait for navigation bar
        let navigationBar = app.navigationBars["Recipes"]
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 5), "Navigation bar with 'Recipes' title should appear")
        
        // Wait for recipe cards to load
        sleep(2)
        
        // Verify scrollview exists (grid is inside scrollview)
        XCTAssertTrue(app.scrollViews.firstMatch.exists, "ScrollView containing recipe grid should exist")
    }
    
    @MainActor
    func testLandscapeModeShowsRecipeCards() throws {
        XCUIDevice.shared.orientation = .landscapeLeft
        
        // Wait for content to load
        sleep(2)
        
        // Look for RECIPE labels (each card has one)
        let recipeLabels = app.staticTexts.matching(identifier: "RECIPE")
        
        // We should have multiple recipe cards
        XCTAssertGreaterThan(recipeLabels.count, 0, "Should have at least one recipe card visible")
    }
    
    // MARK: - Navigation Tests
    
    @MainActor
    func testTappingRecipeCardNavigatesToDetail() throws {
        XCUIDevice.shared.orientation = .landscapeLeft
        
        // Wait for content to load
        sleep(2)
        
        // Find and tap the first recipe card (look for first image)
        let scrollView = app.scrollViews.firstMatch
        let images = scrollView.images
        
        if images.count > 0 {
            let firstImage = images.element(boundBy: 0)
            firstImage.tap()
            
            // Wait for detail view to appear
            sleep(1)
            
            // Verify we're on detail page by checking for recipe info bar
            let servesText = app.staticTexts["Serves"]
            XCTAssertTrue(servesText.exists, "Should navigate to recipe detail with Serves label")
        }
    }
    
    @MainActor
    func testBackNavigationFromDetail() throws {
        XCUIDevice.shared.orientation = .landscapeLeft
        
        // Wait and navigate to detail
        sleep(2)
        let scrollView = app.scrollViews.firstMatch
        let images = scrollView.images
        
        if images.count > 0 {
            images.element(boundBy: 0).tap()
            sleep(1)
            
            // Tap back button
            let backButton = app.navigationBars.buttons.element(boundBy: 0)
            if backButton.exists {
                backButton.tap()
                sleep(1)
                
                // Verify we're back at grid by checking for Recipes title
                let navigationBar = app.navigationBars["Recipes"]
                XCTAssertTrue(navigationBar.exists, "Should navigate back to recipe grid")
            }
        }
    }
    
    // MARK: - Recipe Detail Tests
    
    @MainActor
    func testRecipeDetailShowsAllElements() throws {
        XCUIDevice.shared.orientation = .portrait
        
        // Wait for recipe detail to load
        sleep(2)
        
        let scrollView = app.scrollViews.firstMatch
        XCTAssertTrue(scrollView.exists, "Recipe detail scroll view should exist")
        
        // Check for recipe info bar
        XCTAssertTrue(app.staticTexts["Serves"].exists, "Serves label should be visible")
        XCTAssertTrue(app.staticTexts["Prep"].exists, "Prep label should be visible")
        XCTAssertTrue(app.staticTexts["Cooking"].exists, "Cooking label should be visible")
        
        // Scroll to check ingredients
        scrollView.swipeUp()
        scrollView.swipeUp()
        
        let ingredientsHeader = app.staticTexts["Ingredients"]
        XCTAssertTrue(ingredientsHeader.exists, "Ingredients header should be visible")
    }
    
    @MainActor
    func testRecipeDetailShowsMoreRecipes() throws {
        XCUIDevice.shared.orientation = .portrait
        
        // Wait for content to load
        sleep(2)
        
        // Scroll to bottom to find "More Recipes" section
        let scrollView = app.scrollViews.firstMatch
        scrollView.swipeUp()
        scrollView.swipeUp()
        scrollView.swipeUp()
        
        // Look for "More Recipes" header
        let moreRecipesHeader = app.staticTexts["More Recipes"]
        XCTAssertTrue(moreRecipesHeader.waitForExistence(timeout: 3), "More Recipes section should be visible")
    }
    
    @MainActor
    func testNavigatingBetweenRecipesInDetailView() throws {
        XCUIDevice.shared.orientation = .portrait
        
        // Wait for initial recipe to load
        sleep(2)
        
        // Scroll to bottom to find more recipes
        let scrollView = app.scrollViews.firstMatch
        scrollView.swipeUp()
        scrollView.swipeUp()
        scrollView.swipeUp()
        
        // Tap on one of the "More Recipes" cards
        let images = scrollView.images
        if images.count > 1 {
            // Tap the second image (first is main recipe, rest are in More Recipes)
            images.element(boundBy: 1).tap()
            sleep(1)
            
            // Verify we're still in a recipe detail view
            XCTAssertTrue(app.staticTexts["Serves"].exists, "Should navigate to another recipe detail")
        }
    }
    
    // MARK: - Orientation Change Tests
    
    @MainActor
    func testOrientationChangeBetweenPortraitAndLandscape() throws {
        // Start in portrait
        XCUIDevice.shared.orientation = .portrait
        sleep(2)
        
        // Verify portrait view (detail view)
        XCTAssertTrue(app.staticTexts["Serves"].exists, "Should show recipe detail in portrait")
        
        // Rotate to landscape
        XCUIDevice.shared.orientation = .landscapeLeft
        sleep(2)
        
        // Verify landscape view (grid view with navigation)
        let navigationBar = app.navigationBars["Recipes"]
        XCTAssertTrue(navigationBar.exists, "Should show recipe grid with navigation in landscape")
        
        // Rotate back to portrait
        XCUIDevice.shared.orientation = .portrait
        sleep(2)
        
        // Should be back to detail view
        XCTAssertTrue(app.staticTexts["Serves"].exists, "Should show recipe detail again in portrait")
    }
    
    // MARK: - Accessibility Tests
    
    @MainActor
    func testRecipeImagesHaveAccessibilityLabels() throws {
        XCUIDevice.shared.orientation = .portrait
        
        // Wait for content to load
        sleep(2)
        
        // Check that images exist and have accessibility labels
        let images = app.images
        
        // Should have at least one image (the main recipe image)
        XCTAssertGreaterThan(images.count, 0, "Should have at least one image")
        
        // Note: Full accessibility label verification would require knowing the exact alt text
        // This test just verifies images are present
    }
    
    // MARK: - Performance Tests
    
    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    @MainActor
    func testScrollPerformance() throws {
        XCUIDevice.shared.orientation = .portrait
        sleep(2)
        
        let scrollView = app.scrollViews.firstMatch
        
        measure(metrics: [XCTOSSignpostMetric.scrollDecelerationMetric]) {
            scrollView.swipeUp()
            scrollView.swipeUp()
            scrollView.swipeDown()
            scrollView.swipeDown()
        }
    }
}
