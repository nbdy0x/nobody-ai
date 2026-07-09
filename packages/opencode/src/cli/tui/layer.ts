import { run as runTui, type TuiInput } from "@nobody0x/tui"
import { Global } from "@nobody0x/core/global"
import { AppNodeBuilder } from "@nobody0x/core/effect/app-node-builder"
import { Effect } from "effect"

export function run(input: TuiInput) {
  return runTui(input).pipe(Effect.provide(AppNodeBuilder.build(Global.node)))
}
