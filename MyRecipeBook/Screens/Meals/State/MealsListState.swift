//
//  MealsListState.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 28.08.2024.
//

import Foundation

extension MealsViewModel {
    
    // MARK: - MealDetailsState
    enum MealsListState {
        case idle
        case loading
        case error(String)
        
        var error: String? {
            switch self {
            case .error(let error):
                return error
            default:
                return nil
            }
        }
        
        var isError: Bool {
            switch self {
            case .error:
                return true
            default:
                return false
            }
        }
        
        var isLoading: Bool {
            switch self {
            case .loading:
                return true
            default:
                return false
            }
        }
    }
}
