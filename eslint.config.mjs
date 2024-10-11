import html from "eslint-plugin-html";
import js from "@eslint/js";

export default [
    js.configs.recommended,
    {
        files: ["docs/*.html"],
        plugins: {
            html,
        },
    },
    {
        files: ["docs/*.{html,js}"],
        rules: {
            "no-undef": "off",
            "no-redeclare": "off",
            "no-unused-vars": "off",
        },
    },
];
