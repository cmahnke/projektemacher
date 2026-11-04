import 'bootstrap';
// Resolved from the theme's assets (ts/iiif-image-viewer.ts) via Hugo's merged assets FS at build time
// @ts-expect-error Not visible to tsc - the theme is a separate module
import './iiif-image-viewer';
