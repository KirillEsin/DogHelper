protocol Coordinator: class {
    weak var parent: Coordinator? {get set}

    func start()
    func start(with option: DeepLinkOption?)
}
