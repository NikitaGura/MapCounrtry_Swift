//
//  ViewController.swift
//  Map_Country
//
//  Created by Nikita Gura on 5/8/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {
    
    //MARK: variables
    private let cellId = "CountryCellId"
    private var countries = [Country]()
    private var filteredCountries = [Country]()
    private var isSearching = false
    
    private let countriesCollectionView: UICollectionView = {
        let layout = CountriesCollectionViewFlowLayuot()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.keyboardDismissMode = .onDrag
        return collection
    }()
    
    private let countrySearchBar = UISearchBar()
    
    init(countries: [Country] = [Country]()){
        super.init(nibName: nil, bundle: nil)
        self.countries = countries
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCountriesCollectionView()
        setupCountryBarSearch()
        view.addSubview(countriesCollectionView)
        view.addSubview(countrySearchBar)
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkRefreshConection()
    }
    
    //MARK: Methods
    private func checkRefreshConection(){
        if countries.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Error connection", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Refresh", style: UIAlertAction.Style.default, handler: { action in
                
                let networkProcessor = NetworkProcessor()
                networkProcessor.getJsonAllCoutry(completion: {
                    [weak self] countryModels in
                        DispatchQueue.main.async {
                            self?.countries = countryModels
                            self?.countriesCollectionView.reloadData()
                        }
                    },
                    getError: {self.checkRefreshConection()})
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    private func setupCountriesCollectionView(){
        countriesCollectionView.dataSource = self
        countriesCollectionView.delegate = self
        countriesCollectionView.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func setupCountryBarSearch(){
        countrySearchBar.returnKeyType = UIReturnKeyType.done
        countrySearchBar.barTintColor = .black
        countrySearchBar.delegate = self
    }
    
    private func setupView(){
        view.backgroundColor = .black
    }
    
    private func setupLayout(){
        countriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        countrySearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countrySearchBar.heightAnchor.constraint(equalToConstant: 70),
            countrySearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            countrySearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            countrySearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            countriesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            countriesCollectionView.topAnchor.constraint(equalTo: countrySearchBar.bottomAnchor),
            countriesCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            countriesCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
            ])
    }
    
}


// MARK: DataSource collection
extension CountriesViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return isSearching ? filteredCountries.count : countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = countriesCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CountryCollectionViewCell
        cell.country = isSearching ? filteredCountries[indexPath.row] : countries[indexPath.row]
        return cell
    }
    
}

//MARK: - Delegate Collection
extension CountriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let country = isSearching ?  filteredCountries[indexPath.row]: countries[indexPath.row]
       present(MapViewController(country: country), animated: true, completion: nil)
    }
}

// MARK: CountrySearchBar delegate
extension CountriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            isSearching = false
            view.endEditing(true)
            countriesCollectionView.reloadData()
        }else{
            isSearching = true
            filteredCountries = countries.filter({$0.name.lowercased().prefix(searchText.count).elementsEqual(searchText.lowercased())})
            countriesCollectionView.reloadData()
        }
    }
}
