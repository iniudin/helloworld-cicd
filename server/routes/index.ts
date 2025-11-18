import { eventHandler } from "h3"

// Learn more: https://nitro.build/guide/routing
export default eventHandler((event) => {
  return `
      <meta charset="utf-8">
      <h1>This is your brand new Nitro project 🚀 </h1>
      <p>Get started by editing the <code>server/routes/index.ts</code> file.</p>
      <p>Learn more from 📖 <a href="https://nitro.build/guide" target="_blank">Nitro Documentation</a></p>
      <p>Deployed by GitHub Actions CI/CD</p>
      <p>Visit <a href="https://github.com/iniudin/helloworld-cicd" target="_blank">GitHub Repository</a></p>
    `;
});
