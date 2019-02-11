module EchogramPyPlot

using PyPlot
using ColorTypes

export echogram, eghist, egshow, eg, EK500,  EK80_COLOURS, BW

const EK500 = [RGB(1, 1, 1),
                        RGB(159/255, 159/255, 159/255),
                        RGB(095/255, 095/255, 095/255),
                        RGB(000, 000, 1),
                        RGB(000, 000, 127/255),
                        RGB(000, 191/255, 000),
                        RGB(000, 127/255, 000),
                        RGB(1, 1, 000),
                        RGB(1, 127/255, 000),
                        RGB(1, 000, 191/255),
                        RGB(1, 000, 000),
                        RGB(166/255, 083/255, 060/255),
                        RGB(120/255, 060/255, 040/255)]

const BW = [RGB(0,0,0),
            RGB(1.0,1.0,1.0)]

const EK80_COLOURS = reverse([RGB(155/255, 7/255, 11/255),
                              RGB(154/255, 15/255, 22/255),
                              RGB(153/255, 23/255, 33/255),
                              RGB(151/255, 31/255, 45/255),
                              RGB(150/255, 39/255, 56/255),
                              RGB(153/255, 44/255, 58/255),
                              RGB(159/255, 47/255, 56/255),
                              RGB(165/255, 51/255, 54/255),
                              RGB(170/255, 54/255, 51/255),
                              RGB(176/255, 57/255, 49/255),
                              RGB(184/255, 57/255, 48/255),
                              RGB(198/255, 51/255, 49/255),
                              RGB(212/255, 44/255, 50/255),
                              RGB(226/255, 37/255, 51/255),
                              RGB(240/255, 30/255, 52/255),
                              RGB(255/255, 24/255, 54/255),
                              RGB(254/255, 36/255, 75/255),
                              RGB(253/255, 48/255, 96/255),
                              RGB(253/255, 61/255, 118/255),
                              RGB(252/255, 73/255, 139/255),
                              RGB(252/255, 85/255, 160/255),
                              RGB(252/255, 93/255, 153/255),
                              RGB(252/255, 99/255, 130/255),
                              RGB(252/255, 105/255, 108/255),
                              RGB(252/255, 110/255, 85/255),
                              RGB(252/255, 116/255, 63/255),
                              RGB(252/255, 128/255, 47/255),
                              RGB(252/255, 153/255, 46/255),
                              RGB(253/255, 179/255, 45/255),
                              RGB(253/255, 204/255, 44/255),
                              RGB(254/255, 229/255, 43/255),
                              RGB(255/255, 255/255, 42/255),
                              RGB(208/255, 231/255, 52/255),
                              RGB(161/255, 208/255, 62/255),
                              RGB(114/255, 185/255, 72/255),
                              RGB(68/255, 162/255, 82/255),
                              RGB(21/255, 139/255, 92/255),
                              RGB(10/255, 141/255, 99/255),
                              RGB(17/255, 156/255, 105/255),
                              RGB(24/255, 171/255, 111/255),
                              RGB(30/255, 185/255, 116/255),
                              RGB(37/255, 200/255, 122/255),
                              RGB(41/255, 197/255, 129/255),
                              RGB(40/255, 160/255, 138/255),
                              RGB(39/255, 123/255, 147/255),
                              RGB(38/255, 86/255, 156/255),
                              RGB(37/255, 49/255, 165/255),
                              RGB(36/255, 12/255, 174/255),
                              RGB(29/255, 30/255, 189/255),
                              RGB(22/255, 48/255, 204/255),
                              RGB(15/255, 66/255, 219/255),
                              RGB(9/255, 84/255, 234/255),
                              RGB(9/255, 102/255, 249/255),
                              RGB(9/255, 103/255, 232/255),
                              RGB(24/255, 96/255, 197/255),
                              RGB(39/255, 90/255, 163/255),
                              RGB(53/255, 83/255, 129/255),
                              RGB(68/255, 76/255, 94/255),
                              RGB(82/255, 76/255, 78/255),
                              RGB(97/255, 88/255, 96/255),
                              RGB(112/255, 100/255, 114/255),
                              RGB(126/255, 113/255, 132/255),
                              RGB(141/255, 125/255, 150/255),
                              RGB(156/255, 138/255, 168/255),
                              RGB(255/255, 255/255, 255/255)])

# echogram is for publication plots and composability, eg, egshow and
# eghist are for interactive use.

function echogram(m; vmin = nothing, vmax = nothing, cmap=nothing, range=nothing)

    y, x =size(m)
    
    if range==nothing
        top = 0.0
        bottom = y
    elseif isa(range, Number)
        top = 0.0
        bottom = range
    elseif isa(range, Tuple)
        top, bottom = range
    end
    
    stepr = 10^floor(log10(bottom-top))
    stepy = y * stepr / (bottom-top)
    yticks = 0:stepy:y
    yticklabels = top:stepr:bottom
    
    if length(yticks) < 3
        yticks = 0:stepy/5:y
        yticklabels = top:stepr/5:bottom
    end
    
    yticks = floor.(Int, yticks)
    yticklabels = floor.(Int, yticklabels)
    ax = gca()
    ax[:invert_yaxis]()
    ax[:set_yticks](yticks)
    ax[:set_yticklabels](yticklabels)

    pcolormesh(m, vmin = vmin, vmax = vmax, cmap=ColorMap(cmap))
end

function eg(A; vmin = nothing, vmax = nothing, cmap=nothing, range=nothing)
    figure()
    echogram(A; vmin = vmin, vmax = vmax, cmap=cmap, range=range)
    PyPlot.colorbar()
end


function egshow(A)
    figure()
    PyPlot.imshow(A)
    PyPlot.colorbar()
end

function eghist(A; nbins=256)
    figure()
    PyPlot.plt[:hist](A[:], nbins)
end


end # module
