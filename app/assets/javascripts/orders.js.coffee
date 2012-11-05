class OrdersHelperClass
  AddCostume: (evt) ->
    ThisCostumeContainer = $(evt.srcElement).parent();
    CostumeSelector = ThisCostumeContainer.find("select");
    SelectedOption = CostumeSelector.find('option:selected')
    AddedCostumeId = SelectedOption.val()
    AddedCostumeName = SelectedOption.text()
    AddedCostumePrice = SelectedOption.attr("price")
    SelectedOption.remove()
    CostumeSelector = $("#costume_selector");
    CostumeSelector.parent().css("display", "none") if CostumeSelector.find("option").size() == 0
    NewCostumeContainer = $("<span>" + AddedCostumeName + "</span>")
    NewCostumeContainer.attr("price", AddedCostumePrice)
    NewCostumeInput = $("<input />")
    NewCostumeInput.attr("type", "hidden")
    NewCostumeInput.attr("name", "order_costumes[]")
    NewCostumeInput.val(AddedCostumeId)
    NameCostumeButton = $("<button type='button'>Удалить</button>")
    NameCostumeButton.click(OrdersHelper.RemoveCostume)
    NewCostumeContainer.append(NewCostumeInput)
    NewCostumeContainer.append(document.createTextNode(" "))
    NewCostumeContainer.append(NameCostumeButton)
    NewCostumeContainer.append("<br>")
    $("#costumes").append(NewCostumeContainer)
    PriceControl = $("#order_price")
    PriceControl.val(parseInt(PriceControl.val()) + parseInt(AddedCostumePrice))
    
  RemoveCostume: (evt) ->
    ThisCostumeContainer = $(evt.srcElement).parent();
    TextNode = ThisCostumeContainer.contents().eq(0)
    Input = ThisCostumeContainer.find("input")
    CostumePrice = ThisCostumeContainer.attr("price")
    NewOption = $("<option>" + TextNode.text() + "</option>");
    NewOption.attr("value", Input.val())
    NewOption.attr("price", CostumePrice)
    ThisCostumeContainer.remove();
    CostumeSelector = $("#costume_selector");
    CostumeSelector.append(NewOption)
    CostumeSelector.parent().css("display", "inline");
    PriceControl = $("#order_price")
    NewPrice = parseInt(PriceControl.val()) - parseInt(CostumePrice)
    NewPrice = 0 if(NewPrice < 0)
    PriceControl.val(NewPrice)
    
  UpdateOrderState: (evt, data) ->
    if data.status == "ok"
      container = $(evt.currentTarget).closest(".operations")
      evt.data.self._setActivityDisplay container, data.activity
    else
      alert data.error_message        

  FailUpdatingOrderState: (evt) ->
    alert("Can't access server")
    
  _setActivityDisplay: (container, isActive) ->
    activeOrderOperations = container.find(".active-operations")
    archiveOrderOperations = container.find(".archive-operations")
    orderTableRow = container.closest(".table-row")
    if isActive
        activeOrderOperations.removeClass("hidden")
        archiveOrderOperations.addClass("hidden")
        orderTableRow.removeClass("archive")
    else
        activeOrderOperations.addClass("hidden")
        archiveOrderOperations.removeClass("hidden")
        orderTableRow.addClass("archive")        

(exports ? this).OrdersHelper = new OrdersHelperClass

$ ->
    $(".order-close, .order-reopen").on 'ajax:beforeSend', GlobalHelpers.ShowProgressBar
        
$ ->
    $(".order-close, .order-reopen").on 'ajax:complete', GlobalHelpers.HideProgressBar

$ ->
    $(".order-close, .order-reopen").on 'ajax:success', { self: OrdersHelper}, OrdersHelper.UpdateOrderState

$ ->
    $(".order-close, .order-reopen").on 'ajax:error', OrdersHelper.FailUpdatingOrderState