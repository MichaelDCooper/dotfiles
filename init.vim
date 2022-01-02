set relativenumber                                                                        
set cc=90                                                                                 
set hlsearch                                                                              
set tabstop=4                                                                             
set softtabstop=4                                                                         
set expandtab                                                                             
set shiftwidth=4                                                                          
set autoindent                                                                            
set scrolloff=18                                                                          
set ttyfast                                                                               
set guifont=Jetbrains\ Mono                                                               

call plug#begin('~/.vim/plugged')                                                         
 Plug 'morhetz/gruvbox'                                                                   
 Plug 'ryanoasis/vim-devicons'                                                            
 Plug 'scrooloose/nerdtree'                                                               
 Plug 'preservim/nerdcommenter'                                                           
 Plug 'mhinz/vim-startify'                                                                
 Plug 'neoclide/coc.nvim', {'branch': 'release'}                                          
call plug#end()                                                                           
                                                                                            
set termguicolors                                                                         
syntax enable                                                                             
set background=dark                                                                       
let g:gruvbox_contrast_dark='hard'                                                        
colorscheme gruvbox                                                                       
                                                                                            

