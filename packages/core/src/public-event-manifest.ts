export * as PublicEventManifest from "./public-event-manifest"

import { Event } from "@nobody0x/schema/event"
import { EventManifest } from "@nobody0x/schema/event-manifest"

export const Definitions = EventManifest.ServerDefinitions
export const Latest = Event.latest(Definitions)
