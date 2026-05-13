const fs = require("fs");
const path = require("path");

const file = path.join(__dirname, "..", "docs", "evals", "scenarios.json");
const scenarios = JSON.parse(fs.readFileSync(file, "utf8"));

const requiredStringFields = ["id", "name", "prompt", "trap", "expectedBehavior"];
const ids = new Set();
const errors = [];

if (!Array.isArray(scenarios)) {
  errors.push("scenarios.json must contain an array");
} else {
  scenarios.forEach((scenario, index) => {
    for (const field of requiredStringFields) {
      if (typeof scenario[field] !== "string" || scenario[field].trim() === "") {
        errors.push(`Scenario ${index + 1} is missing non-empty string field: ${field}`);
      }
    }

    if (!/^[a-z0-9]+(?:-[a-z0-9]+)*$/.test(scenario.id || "")) {
      errors.push(`Scenario ${index + 1} has invalid id: ${scenario.id}`);
    }

    if (ids.has(scenario.id)) {
      errors.push(`Duplicate scenario id: ${scenario.id}`);
    }
    ids.add(scenario.id);

    if (!Array.isArray(scenario.scoringFocus) || scenario.scoringFocus.length < 3) {
      errors.push(`Scenario ${scenario.id} must have at least three scoringFocus entries`);
    }
  });
}

if (errors.length > 0) {
  for (const error of errors) {
    console.error(error);
  }
  process.exit(1);
}

console.log(`Eval scenarios are structurally valid: ${scenarios.length} scenarios.`);
