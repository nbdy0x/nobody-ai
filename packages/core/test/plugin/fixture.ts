import { AgentV2 } from "@nobody0x/core/agent"
import { AISDK } from "@nobody0x/core/aisdk"
import { Catalog } from "@nobody0x/core/catalog"
import { CommandV2 } from "@nobody0x/core/command"
import { Credential } from "@nobody0x/core/credential"
import { AppNodeBuilder } from "@nobody0x/core/effect/app-node-builder"
import { LayerNodePlatform } from "@nobody0x/core/effect/app-node-platform"
import { LayerNode } from "@nobody0x/core/effect/layer-node"
import { EventV2 } from "@nobody0x/core/event"
import { FileSystem } from "@nobody0x/core/filesystem"
import { FSUtil } from "@nobody0x/core/fs-util"
import { Integration } from "@nobody0x/core/integration"
import { Location } from "@nobody0x/core/location"
import { Npm } from "@nobody0x/core/npm"
import { PluginV2 } from "@nobody0x/core/plugin"
import { Reference } from "@nobody0x/core/reference"
import { SkillV2 } from "@nobody0x/core/skill"
import { Effect, Layer } from "effect"
import { tempLocationLayer } from "../fixture/location"

const npmLayer = Layer.succeed(
  Npm.Service,
  Npm.Service.of({
    add: () => Effect.succeed({ directory: "", entrypoint: undefined }),
    install: () => Effect.void,
    which: () => Effect.succeed(undefined),
  }),
)

export const PluginTestLayer = AppNodeBuilder.build(
  LayerNode.group([
    FileSystem.node,
    FSUtil.node,
    Location.node,
    Npm.node,
    Credential.node,
    EventV2.node,
    LayerNodePlatform.httpClient,
    PluginV2.node,
    AgentV2.node,
    AISDK.node,
    Catalog.node,
    CommandV2.node,
    Integration.node,
    Reference.node,
    SkillV2.node,
  ]),
  [
    [Location.node, tempLocationLayer],
    [Npm.node, npmLayer],
  ],
)
