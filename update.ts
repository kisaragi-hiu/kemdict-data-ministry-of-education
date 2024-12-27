#!/usr/bin/env deno run

import { $ } from "zx";

export const dicts = {
  dict_concised: { v: "2014_20241226" },
  dict_idioms: { v: "2020_20241226" },
  dict_mini: { v: "2019_20241223" },
  dict_revised: { v: "2015_20241225" },
} as const;

async function download() {
  for (const [dict, { v: version }] of Object.entries(dicts)) {
    const url = `https://language.moe.gov.tw/001/Upload/Files/site_content/M0001/respub/download/${dict}_${version}.zip`;
    const dir = "原始資料";
    await $`curl -L ${url} > ${dir}/${dict}_${version}.zip`;
    await $`cd ${dir} && unzip -o ${dict}_${version}.zip`;
    await $`rm ${dir}/${dict}_${version}.zip`;
  }
}

await download();
await $`make all -j 4`;

console.log("Now go into diff/ and fiddle with it to produce the differences");
