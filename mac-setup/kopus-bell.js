export const KopusBell = async ({ $ }) => {
  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        await $`printf '\a' > /dev/tty || printf '\a'`
      }
    },
  }
}