class OrdersHelperClass
  AddCostume: (evt) ->
    ThisCostumeContainer = $(evt.srcElement).parent();
    CostumeSelector = ThisCostumeContainer.find("select");
    SelectedOption = CostumeSelector.find('option:selected')
    AddedCostumeVal = SelectedOption.val()
    AddedCostumeName = SelectedOption.text()
    AddedCostumePrice = SelectedOption.attr("price")
    SelectedOption.remove()
    CostumeSelector = $("#costume_selector");
    CostumeSelector.parent().css("display", "none") if CostumeSelector.find("option").size() == 0
    NewCostumeContainer = $("<span>" + AddedCostumeName + "</span>")
    NewCostumeContainer.attr("price", AddedCostumePrice)
    NewCostumeInput = $("<input />")
    NewCostumeInput.attr("type", "hidden")
    NewCostumeInput.attr("name", "order[costumes]")
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

(exports ? this).OrdersHelper = new OrdersHelperClass