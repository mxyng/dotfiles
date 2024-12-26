from os.path import basename
from datetime import datetime
from contextlib import contextmanager
from contextvars import ContextVar
from dataclasses import dataclass
from typing import Optional
from getpass import getuser

from kitty.fast_data_types import Screen, add_timer, get_boss, get_options
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_tab_with_powerline,
)
from kitty.utils import color_as_int, log_error


@dataclass
class Divider:
    soft: str
    hard: str
    hard_reverse: str


LeftDivider = Divider(soft="", hard="", hard_reverse="")
RightDivider = Divider(soft="", hard="", hard_reverse="")


@dataclass
class Cell:
    icon: str = ""
    text: str = ""
    fmt: str = "{icon} {text}"
    align: str = "left"

    text_width: Optional[int] = None
    text_min_width: Optional[int] = None
    text_max_width: Optional[int] = None

    fg: Optional[int] = None
    bg: Optional[int] = None
    bold: Optional[bool] = None
    italic: Optional[bool] = None

    def __repr__(self) -> str:
        return f"Cell(icon={self.icon!r}, text={self.text!r})"

    def getvalue(self) -> str:
        if self.icon and not self.text:
            return self.icon

        if (
            self.text_width
            and self.text_max_width
            and self.text_width != self.text_max_width
        ):
            log_error(
                f"{self} sets text_width ({self.text_width}) and text_max_width ({self.text_max_width}), using text_max_width",
            )
        if (
            self.text_width
            and self.text_min_width
            and self.text_width != self.text_min_width
        ):
            log_error(
                f"{self} sets text_width ({self.text_width}) and text_max_width ({self.text_min_width}), using text_min_width",
            )

        text = self.text
        if max_width := (self.text_max_width or self.text_width):
            text = text[:max_width]
        if min_width := (self.text_min_width or self.text_width):
            match self.align:
                case "left":
                    text = text.ljust(min_width)
                case "right":
                    text = text.rjust(min_width)
                case "center":
                    text = text.center(min_width)

        if not self.icon:
            return text

        return self.fmt.format(icon=self.icon, text=text)

    def draw(
        self,
        screen: Screen,
        fg: Optional[int] = None,
        bg: Optional[int] = None,
        bold: Optional[bool] = None,
        italic: Optional[bool] = None,
    ) -> bool:
        with keep_style(screen):
            if fg or self.fg:
                screen.cursor.fg = fg or self.fg
            if bg or self.bg:
                screen.cursor.bg = bg or self.bg
            if bold or self.bold:
                screen.cursor.bold = bold or self.bold
            if italic or self.italic:
                screen.cursor.italic = italic or self.italic

            if (value := self.getvalue()).strip():
                screen.draw(value)

            return self.getvalue().strip() != ""


opts = get_options()


@contextmanager
def keep_style(screen: Screen):
    old_fg = screen.cursor.fg
    old_bg = screen.cursor.bg
    old_bold = screen.cursor.bold
    old_italic = screen.cursor.italic

    draw_attributed_string(Formatter.reset, screen)
    yield

    screen.cursor.fg = old_fg
    screen.cursor.bg = old_bg
    screen.cursor.bold = old_bold
    screen.cursor.italic = old_italic


def draw_status_left(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    extra_data: ExtraData,
):
    boss = get_boss()
    separator = Cell(text="|", text_width=3, align="center")
    cells: list[Cell] = [
        Cell(
            icon="",  # nf-fa-user
            text=getuser(),
            fg=as_rgb(color_as_int(opts.color7)),
            bold=True,
        ),
        Cell(
            icon="",  # nf-cod-multiple_windows
            text=basename(boss.active_tab.get_exe_of_active_window()),
            fg=as_rgb(color_as_int(opts.color3)),
        ),
    ]

    with keep_style(screen):
        tab_bg = as_rgb(draw_data.tab_bg(tab))
        for index, cell in enumerate(cells):
            if cell.draw(screen) and index != len(cells) - 1:
                separator.draw(screen)

        Cell(
            text=RightDivider.hard_reverse,
            text_width=2,
            align="right",
            fg=tab_bg,
            bg=as_rgb(color_as_int(draw_data.default_bg)),
        ).draw(screen)

        screen.cursor.bg = tab_bg
        screen.draw(" ")

    return screen.cursor.x


def draw_status_right(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    extra_data: ExtraData,
):
    boss = get_boss()
    separator = Cell(text="|", text_width=3, align="center")
    cells: list[Cell] = [
        Cell(
            text=boss.mappings.current_keyboard_mode_name.upper(),
            fg=as_rgb(color_as_int(opts.color1)),
            bold=True,
        ),
        Cell(
            icon="",  # nf-cod-editor_layout
            text=boss.active_tab.current_layout.name.upper(),
            text_width=3,
            fg=as_rgb(color_as_int(opts.color4)),
        ),
        Cell(
            icon="󰃰",  # nf-md-calendar_clock
            text=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            fg=as_rgb(color_as_int(opts.color6)),
            bold=True,
        ),
    ]

    padding = (
        screen.columns
        - screen.cursor.x
        - len(
            separator.getvalue().join(
                c.getvalue() for c in cells if c.getvalue().strip()
            )
        )
    )

    with keep_style(screen):
        screen.cursor.x += padding

        for index, cell in enumerate(cells):
            if cell.draw(screen) and index != len(cells) - 1:
                separator.draw(screen, fg=cell.fg, bg=cell.bg)

    return screen.cursor.x


timer_id: ContextVar[int] = ContextVar("timer_id", default=-1)


def redraw_tab(_) -> None:
    if tm := get_boss().active_tab_manager:
        tm.mark_tab_bar_dirty()


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
):
    if timer_id.get() == -1:
        timer_id.set(add_timer(redraw_tab, 1, True))

    if index == 1:
        draw_status_left(draw_data, screen, tab, extra_data)

    end = draw_tab_with_powerline(
        draw_data,
        screen,
        tab,
        before,
        max_tab_length,
        index,
        is_last,
        extra_data,
    )

    if is_last:
        draw_status_right(draw_data, screen, tab, extra_data)

    return end
