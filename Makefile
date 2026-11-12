# 用 XeLaTeX 编译本目录下的 LaTeX 文档
#   make             编译全部 .tex 为 PDF
#   make foo.pdf     只编译 foo.tex
#   make clean       删除 XeLaTeX 生成的中间文件
#   make distclean   同时删除由 .tex 生成的 PDF（不影响其他 PDF，如论文原文）

XELATEX       := xelatex
XELATEX_FLAGS := -interaction=nonstopmode -halt-on-error -file-line-error

TEX := $(wildcard *.tex)
PDF := $(TEX:.tex=.pdf)

AUX_EXT := aux log out toc lof lot xdv synctex.gz fls fdb_latexmk bbl blg nav snm vrb

.PHONY: all clean distclean

all: $(PDF)

# 编译两遍，以解析交叉引用和参考文献
%.pdf: %.tex
	$(XELATEX) $(XELATEX_FLAGS) $<
	$(XELATEX) $(XELATEX_FLAGS) $<

clean:
	rm -f $(foreach ext,$(AUX_EXT),$(TEX:.tex=.$(ext)))

distclean: clean
	rm -f $(PDF)
