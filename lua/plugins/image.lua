-- Images inside Neovim (kitty graphics protocol; works inside tmux too):
--   • open an image file (png, jpg, heic, pdf, …) and it's shown instead of bytes
--   • the file picker (Space Space) previews images, e.g. iOS assets in *.xcassets
--   • images linked in markdown (Obsidian notes) show inline under the link
-- Anything but png is converted with ImageMagick (`magick`; pdf also needs Ghostscript).
-- Not working? :checkhealth snacks
return {
  "folke/snacks.nvim",
  opts = {
    image = { enabled = true },
  },
}
