// Slides are loaded from slides-data.js — run update-slides.ps1 to regenerate it.
// slides-data.js must be included before this script in each HTML file.
let SLIDES = window.SLIDES_DATA || [];

function applySyntaxEnclose() {
    document.querySelectorAll("code .var").forEach(function (el) {
        const text = el.textContent;
        const match = text.match(/^([$@&])(\{)(.*?)(\})$/);
        if (!match) return;
        el.innerHTML =
            '<span class="sigil">' + match[1] + '</span>' +
            '<span class="enclose">' + match[2] + '</span>' +
            match[3] +
            '<span class="enclose">' + match[4] + '</span>';
    });

    document.querySelectorAll("code .kw-stg").forEach(function (el) {
        const text = el.textContent;
        const match = text.match(/^(\[)(.*?)(\])$/);
        if (!match) return;
        el.innerHTML =
            '<span class="enclose">' + match[1] + '</span>' +
            match[2] +
            '<span class="enclose">' + match[3] + '</span>';
    });
}

function getCurrentSlide() {
    const parts = window.location.pathname.split("/");
    return parts[parts.length - 2] + "/" + parts[parts.length - 1];
}

function injectPageNumber(idx, total) {
    const badge = document.createElement("div");
    badge.id = "slide-page-badge";
    badge.textContent = (idx + 1) + " / " + total;
    badge.style.cssText = [
        "position:fixed", "bottom:1rem", "right:1.5rem",
        "font-family:var(--font-body,sans-serif)", "font-size:0.8rem",
        "color:var(--text-muted,#6B6560)", "background:var(--bg,#FAF8F5)",
        "border:1px solid var(--border,#D8CFC4)", "border-radius:999px",
        "padding:0.2em 0.8em", "opacity:0.8", "pointer-events:none"
    ].join(";");
    document.body.appendChild(badge);
}

document.addEventListener("DOMContentLoaded", function () {
    applySyntaxEnclose();

    const idx = SLIDES.findIndex(function (s) {
        return s.path === getCurrentSlide();
    });
    if (idx !== -1) {
        injectPageNumber(idx, SLIDES.length);
    }
});

document.addEventListener("keydown", function (e) {
    if (e.key !== "ArrowLeft" && e.key !== "ArrowRight") return;

    const idx = SLIDES.findIndex(function (s) {
        return s.path === getCurrentSlide();
    });
    if (idx === -1) return;

    if (e.key === "ArrowRight" && idx < SLIDES.length - 1) {
        window.location.href = "../" + SLIDES[idx + 1].path;
    } else if (e.key === "ArrowLeft" && idx > 0) {
        window.location.href = "../" + SLIDES[idx - 1].path;
    }
});

