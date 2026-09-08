local vide = require("../../vide")
local observers = require("../../observers")

local defaultSizeMultiplier = 0.1

local function MultiplyUDim2(original: UDim2, multiplier: number)
	return UDim2.new(original.X.Scale * multiplier, original.X.Offset * multiplier, original.Y.Scale * multiplier, original.Y.Offset * multiplier)
end

return function(period: number?, dampingRatio: number?, customSizeMultiplier: number?)
	return vide.action(function(button: any)
		local originalSize = button.Size:: UDim2
		local sizeSource = vide.source(originalSize)
		local sizeSpring = vide.spring(sizeSource, period, dampingRatio)
		
		local guiState = vide.source(Enum.GuiState.Idle)
		
		vide.effect(function()
			local sizeMultiplier = defaultSizeMultiplier()
			if customSizeMultiplier then
				sizeMultiplier = customSizeMultiplier
			end
			
			local currentGuiState = guiState()
			
			sizeSource(
				if currentGuiState == Enum.GuiState.Press then MultiplyUDim2(originalSize, 1-sizeMultiplier/2)
				elseif currentGuiState == Enum.GuiState.Hover then MultiplyUDim2(originalSize, 1+sizeMultiplier)
				else originalSize
			)
		end)
		
		vide.apply(button) {
			Size = sizeSpring,	
		}
		
		vide.cleanup(observers.observeProperty(button, "GuiState", guiState::any))
	end)
end