String insertNewline(String input, int maxCharacter) {
  if (input.length <= maxCharacter) {
    return input;
  }
  int spaceIndex = input.lastIndexOf(' ', maxCharacter);
  if (spaceIndex == -1) {
    // If no space is found within the first 30 characters, just break at 30 characters
    spaceIndex = maxCharacter;
  }
  return '${input.substring(0, spaceIndex)}\n${input.substring(spaceIndex + 1)}';
}
