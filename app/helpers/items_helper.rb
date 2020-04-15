module ItemsHelper
    def item_iterator(items)
        return ItemsController::INDEX_ROW_COUNT < items.length ? ItemsController::INDEX_ROW_COUNT : items.length
    end
end
