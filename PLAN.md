# REBRAND PLAN: OpenCode → Nobody AI

> **Target:** nobody0x.com
> **Brand:** Nobody AI
> **NPM Scope:** `@nobody0x/*`
> **Domain:** nobody0x.com

---

## Brand Identity Summary

| Token | Value |
|-------|-------|
| Primary Red | `#ff3b30` |
| Dark Red | `#8a0000` |
| Mid Red | `#d42f26` |
| Accent Gradient | `linear-gradient(135deg, #ff3b30 0%, #e8342a 42%, #8a0000 100%)` |
| Background | `#030303` |
| Surface | `rgba(18, 18, 20, 0.72)` |
| Border | `rgba(255, 255, 255, 0.13)` |
| Text | `#ffffff` |
| Text Dim | `rgba(255, 255, 255, 0.42)` |
| Muted | `rgba(235, 235, 245, 0.66)` |
| Status Green | `#30d158` |

---

## Phase 1: Core Identity (HIGH PRIORITY)

### 1.1 Root package.json
**File:** `package.json`
- `"name"` → `"nobody-ai"`
- `"description"` → `"AI-powered development tool by Nobody AI"`
- `"repository.url"` → `"https://github.com/nobody0x/nobody-ai"`

### 1.2 All Package Names (38 packages)
Replace `@opencode-ai` scope with `@nobody0x` in every `packages/*/package.json`:

| Package | Old Name | New Name |
|---------|----------|----------|
| `packages/opencode/package.json` | `opencode` | `nobody-ai` |
| `packages/app/package.json` | `@opencode-ai/app` | `@nobody0x/app` |
| `packages/cli/package.json` | `@opencode-ai/cli` | `@nobody0x/cli` |
| `packages/client/package.json` | `@opencode-ai/client` | `@nobody0x/client` |
| `packages/core/package.json` | `@opencode-ai/core` | `@nobody0x/core` |
| `packages/desktop/package.json` | `@opencode-ai/desktop` | `@nobody0x/desktop` |
| `packages/llm/package.json` | `@opencode-ai/llm` | `@nobody0x/llm` |
| `packages/plugin/package.json` | `@opencode-ai/plugin` | `@nobody0x/plugin` |
| `packages/protocol/package.json` | `@opencode-ai/protocol` | `@nobody0x/protocol` |
| `packages/schema/package.json` | `@opencode-ai/schema` | `@nobody0x/schema` |
| `packages/server/package.json` | `@opencode-ai/server` | `@nobody0x/server` |
| `packages/tui/package.json` | `@opencode-ai/tui` | `@nobody0x/tui` |
| `packages/ui/package.json` | `@opencode-ai/ui` | `@nobody0x/ui` |
| `packages/web/package.json` | `@opencode-ai/web` | `@nobody0x/web` |
| `packages/sdk/js/package.json` | `@opencode-ai/sdk` | `@nobody0x/sdk` |
| (semua 38 packages lainnya) | `@opencode-ai/*` | `@nobody0x/*` |

### 1.3 Import Aliases di Root package.json
```json
"dependencies": {
  "@opencode-ai/plugin": "workspace:*",  →  "@nobody0x/plugin": "workspace:*",
  "@opencode-ai/script": "workspace:*",  →  "@nobody0x/script": "workspace:*",
  "@opencode-ai/sdk": "workspace:*",     →  "@nobody0x/sdk": "workspace:*"
}
```

### 1.4 VS Code Extension
**File:** `sdks/vscode/package.json`
- `"name"` → `"nobody-ai"`
- `"displayName"` → `"Nobody AI"`
- `"description"` → `"Nobody AI for VS Code"`
- `"publisher"` → (ganti ke publisher baru)
- Semua command IDs: `opencode.*` → `nobody-ai.*`

**File:** `sdks/vscode/src/extension.ts`
- `TERMINAL_NAME = "opencode"` → `"nobody-ai"`
- Semua command ID strings

---

## Phase 2: Domain & URLs (HIGH PRIORITY)

### 2.1 Console Config
**File:** `packages/console/app/src/config.ts`
```ts
baseUrl: "https://nobody0x.com",
github: { repoUrl: "https://github.com/nobody0x/nobody-ai" },
social: {
  twitter: "https://x.com/nobody0x",
  discord: "https://discord.gg/nobody0x",  // atau WhatsApp community
}
```

### 2.2 Infrastructure
**File:** `infra/stage.ts`
- `opencode.ai` → `nobody0x.com`
- `dev.opencode.ai` → `dev.nobody0x.com`

### 2.3 Hardcoded URLs (~40+ files)
Ganti semua `https://opencode.ai/*` → `https://nobody0x.com/*` di:
- `packages/opencode/src/config/config.ts` — schema URLs
- `packages/opencode/src/config/tui.ts` — TUI schema
- `packages/opencode/src/config/tui-migrate.ts` — TUI schema URL
- `packages/opencode/src/config/managed.ts` — managed config paths
- `packages/desktop/src/main/wsl/runtime.ts` — install command
- `packages/desktop/src/renderer/index.tsx` — favicon URL
- `packages/desktop/scripts/copy-metainfo.ts` — homepage URL
- `packages/app/src/entry.tsx` — favicon URL, hostname check
- `packages/app/src/pages/layout.tsx` — feedback link
- `packages/app/src/pages/home.tsx` — feedback link
- `packages/app/src/pages/error.tsx` — feedback link
- `packages/app/src/pages/layout/helpers.ts` — OPENCODE_PROJECT_ID favicon
- `packages/app/src/desktop-menu.ts` — docs link
- `packages/app/src/context/highlights.tsx` — changelog URL
- `packages/app/src/components/dialog-custom-provider.tsx` — docs link
- `packages/app/src/components/dialog-connect-provider.tsx` — zen link
- `packages/app/src/components/settings-general.tsx` — themes docs
- `packages/app/src/components/settings-v2/general.tsx` — themes docs
- `packages/tui/src/app.tsx` — docs link
- `packages/tui/src/component/dialog-retry-action.tsx` — GO_URL
- `packages/tui/src/component/dialog-provider.tsx` — zen/go URLs
- `packages/tui/src/feature-plugins/home/tips-view.tsx` — share URL
- `packages/console/core/src/user.ts` — email URL
- `packages/console/function/src/auth.ts` — favicon URL
- `packages/console/app/src/routes/s/[id].ts` — docs URLs
- `packages/console/app/src/routes/docs/*.ts` — docs URLs
- `packages/console/app/src/lib/stats-proxy.ts` — stats URL
- `packages/console/app/src/routes/t/[...path].tsx` — enterprise URL
- `packages/console/app/src/routes/zen/util/handler.ts` — workspace URLs
- `packages/stats/app/src/lib/language.ts` — baseUrl
- `packages/stats/app/src/routes/compare/*.tsx` — stats fallback URL
- `packages/enterprise/src/routes/share/*.tsx` — opencode links
- `packages/ui/src/assets/favicon/site.webmanifest` — name
- `packages/web/public/theme.json` — schema URL
- `packages/console/app/public/theme.json` — schema URL
- `packages/sdk/openapi.json` — title

### 2.4 Config File Names
**File:** `packages/opencode/src/config/config.ts`
- Config file: `opencode.json` → `nobody-ai.json` atau tetap `opencode.json` (backward compatible)
- `.well-known/opencode` → `.well-known/nobody-ai`
- Plugin name: `@opencode-ai/plugin` → `@nobody0x/plugin`

**File:** `packages/opencode/src/config/managed.ts`
- `MANAGED_PLIST_DOMAIN = "ai.opencode.managed"` → `"com.nobody0x.managed"`
- `/Library/Application Support/opencode` → `/Library/Application Support/nobody-ai`
- `C:\ProgramData\opencode` → `C:\ProgramData\nobody-ai`
- `/etc/opencode` → `/etc/nobody-ai`

### 2.5 App HTML
**File:** `packages/app/index.html`
- `<title>OpenCode</title>` → `<title>Nobody AI</title>`

---

## Phase 3: Visual Assets (HIGH PRIORITY)

### 3.1 Logo Components
**File:** `packages/ui/src/components/logo.tsx`
- Regenerate SVG path data untuk menulis "Nobody AI" atau "n0body"
- Pertahankan CSS variable coloring (`--icon-base`, `--icon-weak-base`, `--icon-strong-base`)

### 3.2 TUI ASCII Logo
**File:** `packages/tui/src/logo.ts`
- Ganti ASCII art "opencode" → ASCII art "NOBODY" atau "N0BODY"
- Update `logo.left`, `logo.right`, `go`, `marks`

### 3.3 Brand Marks (packages/identity/)
Regenerate semua file dengan brand mark baru:
- `mark.svg` — Dark background mark
- `mark-light.svg` — Light background mark
- `mark-96x96.png`, `mark-192x192.png`, `mark-512x512.png`, `mark-512x512-light.png`

### 3.4 Favicon Source (packages/ui/src/assets/favicon/)
Regenerate semua favicon:
- `favicon.svg` — Source SVG (v3 mark)
- `favicon-v3.svg` — New v3 mark
- `favicon.ico`, `favicon-v3.ico`
- `favicon-96x96.png`, `favicon-96x96-v3.png`
- `apple-touch-icon.png`, `apple-touch-icon-v3.png`
- `web-app-manifest-192x192.png`, `web-app-manifest-512x512.png`

### 3.5 Web App Manifest
**File:** `packages/ui/src/assets/favicon/site.webmanifest`
```json
{
  "name": "Nobody AI",
  "short_name": "Nobody AI",
  "theme_color": "#030303",
  "background_color": "#030303"
}
```

### 3.6 Landing Page Assets (packages/web/src/assets/)
- `logo-light.svg` → "Nobody AI" wordmark light
- `logo-dark.svg` → "Nobody AI" wordmark dark
- `logo-ornate-light.svg` → "Nobody AI" ornate light
- `logo-ornate-dark.svg` → "Nobody AI" ornate dark

### 3.7 Console Assets (packages/console/app/src/asset/)
**Logo files:**
- `logo.svg` — Wordmark
- `logo-ornate-light.svg`, `logo-ornate-dark.svg`
- Semua di `brand/` directory:
  - `opencode-logo-*.svg/png` → `nobody-ai-logo-*.svg/png`
  - `opencode-wordmark-*.svg/png` → `nobody-ai-wordmark-*.svg/png`
  - `opencode-brand-assets.zip` → `nobody-ai-brand-assets.zip`

**Lander files:**
- `opencode-logo-*.svg` → `nobody-ai-logo-*.svg`
- `opencode-wordmark-*.svg` → `nobody-ai-wordmark-*.svg`
- `opencode-poster.png`, `opencode-comparison-min.mp4`, dll

### 3.8 Public Favicons
Copy new favicons ke:
- `packages/web/public/` — Semua favicon variants
- `packages/app/public/` — Semua favicon variants
- `packages/enterprise/public/` — Semua favicon variants

### 3.9 Social Share Images
Regenerate OG images:
- `packages/ui/src/assets/images/social-share.png`
- `packages/ui/src/assets/images/social-share-zen.png`
- `packages/ui/src/assets/images/social-share-black.png`
- `packages/web/public/social-share.png`, `social-share-zen.png`

### 3.10 Stats App Assets
- `packages/stats/app/src/asset/logo-ornate-light.svg`
- `packages/stats/app/src/asset/logo-ornate-dark.svg`

### 3.11 Docs Assets
- `packages/docs/favicon.svg`
- `packages/docs/favicon-v3.svg`
- `packages/docs/logo/light.svg`
- `packages/docs/logo/dark.svg`

### 3.12 Email Template Logo
- `packages/console/mail/emails/templates/static/logo.png`
- `packages/console/mail/emails/templates/static/zen-logo.png`

---

## Phase 4: Theme & Colors (MEDIUM PRIORITY)

### 4.1 Default Themes
**File:** `packages/ui/src/theme/themes/opencode.json`
```json
{
  "$schema": "https://nobody0x.com/desktop-theme.json",
  "name": "Nobody AI",
  "id": "nobody-ai",
  "light": {
    "palette": {
      "primary": "#ff3b30",
      "accent": "#8a0000",
      "success": "#30d158",
      "warning": "#ff3b30",
      "error": "#ff3b30",
      "info": "#ff3b30"
    }
  },
  "dark": {
    "palette": {
      "primary": "#ff3b30",
      "accent": "#d42f26",
      "success": "#30d158",
      "warning": "#ff3b30",
      "error": "#ff3b30",
      "info": "#ff6b6b"
    }
  }
}
```

**File:** `packages/ui/src/theme/themes/oc-2.json`
- Ganti `$schema` → `https://nobody0x.com/desktop-theme.json`
- Rename `"OC-2"` → `"Nobody AI Dark"` atau custom
- Update primary colors ke red theme

### 4.2 Theme Default Registry
**File:** `packages/ui/src/theme/default-themes.ts`
- Rename import dari `opencode.json` → `nobody-ai.json`
- Update theme ID references

### 4.3 Provider Icons
- `packages/ui/src/assets/icons/provider/opencode.svg` → `nobody-ai.svg`
- `packages/ui/src/assets/icons/provider/opencode-go.svg` → `nobody-ai-go.svg`

---

## Phase 5: Desktop App (MEDIUM PRIORITY)

### 5.1 Electron Builder Config
**File:** `packages/desktop/electron-builder.config.ts`
```ts
const APP_IDS = {
  dev: "com.nobody0x.desktop.dev",
  beta: "com.nobody0x.desktop.beta",
  prod: "com.nobody0x.desktop",
}

artifactName: "nobody-ai-desktop-${os}-${arch}.${ext}"

protocols: { name: "Nobody AI", schemes: ["nobody0x"] }

// Product names
productName: "Nobody AI"
productName: "Nobody AI Dev"
productName: "Nobody AI Beta"

// RPM packages
rpm: { packageName: "nobody-ai" }
```

### 5.2 Desktop Icons
Regenerate semua icon sets di:
- `packages/desktop/icons/prod/` — Production icons
- `packages/desktop/icons/dev/` — Dev icons
- `packages/desktop/icons/beta/` — Beta icons

Termasuk: `icon.png`, `icon.ico`, `icon.icns`, `dock.png`, `32x32.png`, `64x64.png`, `128x128.png`, `128x128@2x.png`, `StoreLogo.png`, `Square*.png`, iOS icons

### 5.3 Linux Desktop Entry
**File:** `packages/desktop/resources/linux/opencode-desktop.desktop`
```
Name=Nobody AI
Exec=/opt/NobodyAI/com.nobody0x.desktop
Icon=com.nobody0x.desktop
Comment=AI-powered development tool by Nobody AI
```

### 5.4 Linux Legacy Desktop Entry
**File:** `packages/desktop/resources/linux/opencode-desktop.desktop` (keep for backwards compat)
- Rename file to `nobody-ai-desktop.desktop`

---

## Phase 6: Email & Legal (MEDIUM PRIORITY)

### 6.1 Email Template
**File:** `packages/console/mail/emails/templates/InviteEmail.tsx`
```tsx
CONSOLE_URL = "https://nobody0x.com/"
title = "Nobody AI"
text = "Join your team's Nobody AI workspace"
logo alt = "Nobody AI Logo"
```

### 6.2 Legal Pages
- `packages/console/app/src/routes/legal/terms-of-service/index.tsx` — Update all `opencode.ai` → `nobody0x.com`
- `packages/console/app/src/routes/legal/privacy-policy/index.tsx` — Update all `opencode.ai` → `nobody0x.com`

### 6.3 Landing/Download Pages
- `packages/console/app/src/routes/index.tsx` — Install command
- `packages/console/app/src/routes/download/index.tsx` — Download links
- `packages/console/app/src/routes/temp.tsx` — Temp page

---

## Phase 7: i18n & Localization (MEDIUM PRIORITY)

### 7.1 App i18n Files (18 files)
Update semua di `packages/app/src/i18n/`:
- `ar.ts`, `br.ts`, `bs.ts`, `da.ts`, `de.ts`, `en.ts`, `es.ts`, `fr.ts`
- `ja.ts`, `ko.ts`, `no.ts`, `pl.ts`, `ru.ts`, `th.ts`, `tr.ts`
- `uk.ts`, `zh.ts`, `zht.ts`

Ganti: `opencode.ai/zen` → `nobody0x.com/workspace`

### 7.2 Web i18n Files (18 files)
Update semua di `packages/web/src/content/i18n/`:
- `ar.json`, `da.json`, `de.json`, `en.json`, `es.json`, `fr.json`, `it.json`, `ja.json`
- `ko.json`, `nb.json`, `pl.json`, `pt-BR.json`, `ru.json`, `th.json`, `tr.json`
- `zh-CN.json`, `zh-TW.json`

Ganti: `"share.opencode_name": "opencode"` → `"share.nobodyai_name": "nobody ai"`

### 7.3 Web Docs (17 theme MDX files)
Update semua di `packages/web/src/content/docs/*/themes.mdx`

---

## Phase 8: Documentation (LOW PRIORITY)

### 8.1 README Files (20+ files)
- `README.md` — Main English
- `README.ar.md`, `README.bn.md`, `README.br.md`, `README.bs.md`, `README.da.md`
- `README.de.md`, `README.es.md`, `README.fr.md`, `README.gr.md`, `README.it.md`
- `README.ja.md`, `README.ko.md`, `README.no.md`, `README.pl.md`, `README.ru.md`
- `README.th.md`, `README.tr.md`, `README.uk.md`, `README.vi.md`, `README.zh.md`, `README.zht.md`

### 8.2 Docs Site
**File:** `packages/docs/docs.json`
- `"name"` → `"@nobody0x/docs"`
- primary color → `#ff3b30`
- OpenAPI URL → `https://nobody0x.com/openapi.json`

### 8.3 AGENTS.md, CONTRIBUTING.md, SECURITY.md
- Update brand references

---

## Phase 9: Tests & Generated (LOW PRIORITY)

### 9.1 Test Fixtures
Update `opencode.ai` references di:
- `packages/opencode/test/config/config.test.ts`
- `packages/opencode/test/fixture/fixture.ts`
- `packages/opencode/test/session/*.test.ts`
- `packages/opencode/test/server/*.test.ts`
- `packages/opencode/test/cli/run/footer.view.test.tsx`
- `packages/session-ui/src/components/markdown-inline-code-kind.test.ts`

### 9.2 SDK Generated Types
**File:** `packages/sdk/js/src/gen/types.gen.ts`
- Update JSDoc URLs

---

## Phase 10: Final Cleanup

### 10.1 Git & CI
- Update `.github/workflows/` — repository references
- Update `CONTRIBUTING.md` — repo URL
- Update `SECURITY.md` — contact email

### 10.2 Install Script
**File:** `install`
- Update `opencode.ai/install` → `nobody0x.com/install`

### 10.3 SST Config
**File:** `sst.config.ts`
- Domain references

### 10.4 Nix Flake
**File:** `flake.nix`
- Package name references

---

## Execution Order

1. **Phase 1** (Core Identity) — Package names, imports
2. **Phase 2** (Domain & URLs) — All URL references
3. **Phase 3** (Visual Assets) — Logos, favicons, icons
4. **Phase 4** (Theme & Colors) — Color scheme rebrand
5. **Phase 5** (Desktop) — App IDs, icons, protocols
6. **Phase 6** (Email & Legal) — Templates, legal pages
7. **Phase 7** (i18n) — All locale files
8. **Phase 8** (Docs) — Documentation updates
9. **Phase 9** (Tests) — Test fixtures
10. **Phase 10** (Cleanup) — CI, install script, final checks

---

## Estimated File Count

| Category | Files |
|----------|-------|
| package.json files | 38+ |
| Source code with URLs | 40+ |
| Visual assets (SVG/PNG/ICO) | 80+ |
| Theme/color files | 10+ |
| Desktop icons | 100+ |
| i18n files | 36 |
| Documentation | 25+ |
| Test files | 10+ |
| **TOTAL** | **~350+ files** |

---

## Notes

- **Backward Compatibility:** Consider keeping `opencode.json` config file name as alias
- **Binary Name:** `opencode` CLI binary → `nobody-ai` or `n0x`
- **Protocol:** `opencode://` → `nobody0x://`
- **GitHub:** Create new repo `nobody0x/nobody-ai`
- **NPM:** Publish under `@nobody0x/*` scope
