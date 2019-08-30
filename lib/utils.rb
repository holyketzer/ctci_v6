# TODO: should be time = O(n*log(n)), mem = O(1)
def sort!(str)
  str.chars.sort!.join
end
