defmodule ExRLP.DecodeItem do
  @moduledoc """
  Captures bins and decodes them.
  """

  @spec decode_item(binary()) :: ExRLP.t()
  def decode_item(""), do: raise(ExRLP.DecodeError)
  def decode_item(rlp_binary), do: do_decode_item(rlp_binary, nil)
  ##
  ## HANDLING 0 - 127
  ##

  # decodes an item or a list of items from the given binary
  #
  # `payload` - binary containing the item(s) to decode
  # `list_result` - possibly a result of decoding a list payload:
  #   - if `nil`: we are not processing a list
  #   - if a list: we are processing a list, and we have this much currently
  @spec do_decode_item(payload :: binary(), list_result :: ExRLP.t()) :: ExRLP.t()
  defp do_decode_item(<<0, tail::binary>>, nil), do: do_decode_item(tail, <<0>>)
  defp do_decode_item(<<0, tail::binary>>, result), do: do_decode_item(tail, [<<0>> | result])
  defp do_decode_item(<<1, tail::binary>>, nil), do: do_decode_item(tail, <<1>>)
  defp do_decode_item(<<1, tail::binary>>, result), do: do_decode_item(tail, [<<1>> | result])
  defp do_decode_item(<<2, tail::binary>>, nil), do: do_decode_item(tail, <<2>>)
  defp do_decode_item(<<2, tail::binary>>, result), do: do_decode_item(tail, [<<2>> | result])
  defp do_decode_item(<<3, tail::binary>>, nil), do: do_decode_item(tail, <<3>>)
  defp do_decode_item(<<3, tail::binary>>, result), do: do_decode_item(tail, [<<3>> | result])
  defp do_decode_item(<<4, tail::binary>>, nil), do: do_decode_item(tail, <<4>>)
  defp do_decode_item(<<4, tail::binary>>, result), do: do_decode_item(tail, [<<4>> | result])
  defp do_decode_item(<<5, tail::binary>>, nil), do: do_decode_item(tail, <<5>>)
  defp do_decode_item(<<5, tail::binary>>, result), do: do_decode_item(tail, [<<5>> | result])
  defp do_decode_item(<<6, tail::binary>>, nil), do: do_decode_item(tail, <<6>>)
  defp do_decode_item(<<6, tail::binary>>, result), do: do_decode_item(tail, [<<6>> | result])
  defp do_decode_item(<<7, tail::binary>>, nil), do: do_decode_item(tail, <<7>>)
  defp do_decode_item(<<7, tail::binary>>, result), do: do_decode_item(tail, [<<7>> | result])
  defp do_decode_item(<<8, tail::binary>>, nil), do: do_decode_item(tail, <<8>>)
  defp do_decode_item(<<8, tail::binary>>, result), do: do_decode_item(tail, [<<8>> | result])
  defp do_decode_item(<<9, tail::binary>>, nil), do: do_decode_item(tail, <<9>>)
  defp do_decode_item(<<9, tail::binary>>, result), do: do_decode_item(tail, [<<9>> | result])
  defp do_decode_item(<<10, tail::binary>>, nil), do: do_decode_item(tail, <<10>>)
  defp do_decode_item(<<10, tail::binary>>, result), do: do_decode_item(tail, [<<10>> | result])
  defp do_decode_item(<<11, tail::binary>>, nil), do: do_decode_item(tail, <<11>>)
  defp do_decode_item(<<11, tail::binary>>, result), do: do_decode_item(tail, [<<11>> | result])
  defp do_decode_item(<<12, tail::binary>>, nil), do: do_decode_item(tail, <<12>>)
  defp do_decode_item(<<12, tail::binary>>, result), do: do_decode_item(tail, [<<12>> | result])
  defp do_decode_item(<<13, tail::binary>>, nil), do: do_decode_item(tail, <<13>>)
  defp do_decode_item(<<13, tail::binary>>, result), do: do_decode_item(tail, [<<13>> | result])
  defp do_decode_item(<<14, tail::binary>>, nil), do: do_decode_item(tail, <<14>>)
  defp do_decode_item(<<14, tail::binary>>, result), do: do_decode_item(tail, [<<14>> | result])
  defp do_decode_item(<<15, tail::binary>>, nil), do: do_decode_item(tail, <<15>>)
  defp do_decode_item(<<15, tail::binary>>, result), do: do_decode_item(tail, [<<15>> | result])
  defp do_decode_item(<<16, tail::binary>>, nil), do: do_decode_item(tail, <<16>>)
  defp do_decode_item(<<16, tail::binary>>, result), do: do_decode_item(tail, [<<16>> | result])
  defp do_decode_item(<<17, tail::binary>>, nil), do: do_decode_item(tail, <<17>>)
  defp do_decode_item(<<17, tail::binary>>, result), do: do_decode_item(tail, [<<17>> | result])
  defp do_decode_item(<<18, tail::binary>>, nil), do: do_decode_item(tail, <<18>>)
  defp do_decode_item(<<18, tail::binary>>, result), do: do_decode_item(tail, [<<18>> | result])
  defp do_decode_item(<<19, tail::binary>>, nil), do: do_decode_item(tail, <<19>>)
  defp do_decode_item(<<19, tail::binary>>, result), do: do_decode_item(tail, [<<19>> | result])
  defp do_decode_item(<<20, tail::binary>>, nil), do: do_decode_item(tail, <<20>>)
  defp do_decode_item(<<20, tail::binary>>, result), do: do_decode_item(tail, [<<20>> | result])
  defp do_decode_item(<<21, tail::binary>>, nil), do: do_decode_item(tail, <<21>>)
  defp do_decode_item(<<21, tail::binary>>, result), do: do_decode_item(tail, [<<21>> | result])
  defp do_decode_item(<<22, tail::binary>>, nil), do: do_decode_item(tail, <<22>>)
  defp do_decode_item(<<22, tail::binary>>, result), do: do_decode_item(tail, [<<22>> | result])
  defp do_decode_item(<<23, tail::binary>>, nil), do: do_decode_item(tail, <<23>>)
  defp do_decode_item(<<23, tail::binary>>, result), do: do_decode_item(tail, [<<23>> | result])
  defp do_decode_item(<<24, tail::binary>>, nil), do: do_decode_item(tail, <<24>>)
  defp do_decode_item(<<24, tail::binary>>, result), do: do_decode_item(tail, [<<24>> | result])
  defp do_decode_item(<<25, tail::binary>>, nil), do: do_decode_item(tail, <<25>>)
  defp do_decode_item(<<25, tail::binary>>, result), do: do_decode_item(tail, [<<25>> | result])
  defp do_decode_item(<<26, tail::binary>>, nil), do: do_decode_item(tail, <<26>>)
  defp do_decode_item(<<26, tail::binary>>, result), do: do_decode_item(tail, [<<26>> | result])
  defp do_decode_item(<<27, tail::binary>>, nil), do: do_decode_item(tail, <<27>>)
  defp do_decode_item(<<27, tail::binary>>, result), do: do_decode_item(tail, [<<27>> | result])
  defp do_decode_item(<<28, tail::binary>>, nil), do: do_decode_item(tail, <<28>>)
  defp do_decode_item(<<28, tail::binary>>, result), do: do_decode_item(tail, [<<28>> | result])
  defp do_decode_item(<<29, tail::binary>>, nil), do: do_decode_item(tail, <<29>>)
  defp do_decode_item(<<29, tail::binary>>, result), do: do_decode_item(tail, [<<29>> | result])
  defp do_decode_item(<<30, tail::binary>>, nil), do: do_decode_item(tail, <<30>>)
  defp do_decode_item(<<30, tail::binary>>, result), do: do_decode_item(tail, [<<30>> | result])
  defp do_decode_item(<<31, tail::binary>>, nil), do: do_decode_item(tail, <<31>>)
  defp do_decode_item(<<31, tail::binary>>, result), do: do_decode_item(tail, [<<31>> | result])
  defp do_decode_item(<<32, tail::binary>>, nil), do: do_decode_item(tail, <<32>>)
  defp do_decode_item(<<32, tail::binary>>, result), do: do_decode_item(tail, [<<32>> | result])
  defp do_decode_item(<<33, tail::binary>>, nil), do: do_decode_item(tail, <<33>>)
  defp do_decode_item(<<33, tail::binary>>, result), do: do_decode_item(tail, [<<33>> | result])
  defp do_decode_item(<<34, tail::binary>>, nil), do: do_decode_item(tail, <<34>>)
  defp do_decode_item(<<34, tail::binary>>, result), do: do_decode_item(tail, [<<34>> | result])
  defp do_decode_item(<<35, tail::binary>>, nil), do: do_decode_item(tail, <<35>>)
  defp do_decode_item(<<35, tail::binary>>, result), do: do_decode_item(tail, [<<35>> | result])
  defp do_decode_item(<<36, tail::binary>>, nil), do: do_decode_item(tail, <<36>>)
  defp do_decode_item(<<36, tail::binary>>, result), do: do_decode_item(tail, [<<36>> | result])
  defp do_decode_item(<<37, tail::binary>>, nil), do: do_decode_item(tail, <<37>>)
  defp do_decode_item(<<37, tail::binary>>, result), do: do_decode_item(tail, [<<37>> | result])
  defp do_decode_item(<<38, tail::binary>>, nil), do: do_decode_item(tail, <<38>>)
  defp do_decode_item(<<38, tail::binary>>, result), do: do_decode_item(tail, [<<38>> | result])
  defp do_decode_item(<<39, tail::binary>>, nil), do: do_decode_item(tail, <<39>>)
  defp do_decode_item(<<39, tail::binary>>, result), do: do_decode_item(tail, [<<39>> | result])
  defp do_decode_item(<<40, tail::binary>>, nil), do: do_decode_item(tail, <<40>>)
  defp do_decode_item(<<40, tail::binary>>, result), do: do_decode_item(tail, [<<40>> | result])
  defp do_decode_item(<<41, tail::binary>>, nil), do: do_decode_item(tail, <<41>>)
  defp do_decode_item(<<41, tail::binary>>, result), do: do_decode_item(tail, [<<41>> | result])
  defp do_decode_item(<<42, tail::binary>>, nil), do: do_decode_item(tail, <<42>>)
  defp do_decode_item(<<42, tail::binary>>, result), do: do_decode_item(tail, [<<42>> | result])
  defp do_decode_item(<<43, tail::binary>>, nil), do: do_decode_item(tail, <<43>>)
  defp do_decode_item(<<43, tail::binary>>, result), do: do_decode_item(tail, [<<43>> | result])
  defp do_decode_item(<<44, tail::binary>>, nil), do: do_decode_item(tail, <<44>>)
  defp do_decode_item(<<44, tail::binary>>, result), do: do_decode_item(tail, [<<44>> | result])
  defp do_decode_item(<<45, tail::binary>>, nil), do: do_decode_item(tail, <<45>>)
  defp do_decode_item(<<45, tail::binary>>, result), do: do_decode_item(tail, [<<45>> | result])
  defp do_decode_item(<<46, tail::binary>>, nil), do: do_decode_item(tail, <<46>>)
  defp do_decode_item(<<46, tail::binary>>, result), do: do_decode_item(tail, [<<46>> | result])
  defp do_decode_item(<<47, tail::binary>>, nil), do: do_decode_item(tail, <<47>>)
  defp do_decode_item(<<47, tail::binary>>, result), do: do_decode_item(tail, [<<47>> | result])
  defp do_decode_item(<<48, tail::binary>>, nil), do: do_decode_item(tail, <<48>>)
  defp do_decode_item(<<48, tail::binary>>, result), do: do_decode_item(tail, [<<48>> | result])
  defp do_decode_item(<<49, tail::binary>>, nil), do: do_decode_item(tail, <<49>>)
  defp do_decode_item(<<49, tail::binary>>, result), do: do_decode_item(tail, [<<49>> | result])
  defp do_decode_item(<<50, tail::binary>>, nil), do: do_decode_item(tail, <<50>>)
  defp do_decode_item(<<50, tail::binary>>, result), do: do_decode_item(tail, [<<50>> | result])
  defp do_decode_item(<<51, tail::binary>>, nil), do: do_decode_item(tail, <<51>>)
  defp do_decode_item(<<51, tail::binary>>, result), do: do_decode_item(tail, [<<51>> | result])
  defp do_decode_item(<<52, tail::binary>>, nil), do: do_decode_item(tail, <<52>>)
  defp do_decode_item(<<52, tail::binary>>, result), do: do_decode_item(tail, [<<52>> | result])
  defp do_decode_item(<<53, tail::binary>>, nil), do: do_decode_item(tail, <<53>>)
  defp do_decode_item(<<53, tail::binary>>, result), do: do_decode_item(tail, [<<53>> | result])
  defp do_decode_item(<<54, tail::binary>>, nil), do: do_decode_item(tail, <<54>>)
  defp do_decode_item(<<54, tail::binary>>, result), do: do_decode_item(tail, [<<54>> | result])
  defp do_decode_item(<<55, tail::binary>>, nil), do: do_decode_item(tail, <<55>>)
  defp do_decode_item(<<55, tail::binary>>, result), do: do_decode_item(tail, [<<55>> | result])
  defp do_decode_item(<<56, tail::binary>>, nil), do: do_decode_item(tail, <<56>>)
  defp do_decode_item(<<56, tail::binary>>, result), do: do_decode_item(tail, [<<56>> | result])
  defp do_decode_item(<<57, tail::binary>>, nil), do: do_decode_item(tail, <<57>>)
  defp do_decode_item(<<57, tail::binary>>, result), do: do_decode_item(tail, [<<57>> | result])
  defp do_decode_item(<<58, tail::binary>>, nil), do: do_decode_item(tail, <<58>>)
  defp do_decode_item(<<58, tail::binary>>, result), do: do_decode_item(tail, [<<58>> | result])
  defp do_decode_item(<<59, tail::binary>>, nil), do: do_decode_item(tail, <<59>>)
  defp do_decode_item(<<59, tail::binary>>, result), do: do_decode_item(tail, [<<59>> | result])
  defp do_decode_item(<<60, tail::binary>>, nil), do: do_decode_item(tail, <<60>>)
  defp do_decode_item(<<60, tail::binary>>, result), do: do_decode_item(tail, [<<60>> | result])
  defp do_decode_item(<<61, tail::binary>>, nil), do: do_decode_item(tail, <<61>>)
  defp do_decode_item(<<61, tail::binary>>, result), do: do_decode_item(tail, [<<61>> | result])
  defp do_decode_item(<<62, tail::binary>>, nil), do: do_decode_item(tail, <<62>>)
  defp do_decode_item(<<62, tail::binary>>, result), do: do_decode_item(tail, [<<62>> | result])
  defp do_decode_item(<<63, tail::binary>>, nil), do: do_decode_item(tail, <<63>>)
  defp do_decode_item(<<63, tail::binary>>, result), do: do_decode_item(tail, [<<63>> | result])
  defp do_decode_item(<<64, tail::binary>>, nil), do: do_decode_item(tail, <<64>>)
  defp do_decode_item(<<64, tail::binary>>, result), do: do_decode_item(tail, [<<64>> | result])
  defp do_decode_item(<<65, tail::binary>>, nil), do: do_decode_item(tail, <<65>>)
  defp do_decode_item(<<65, tail::binary>>, result), do: do_decode_item(tail, [<<65>> | result])
  defp do_decode_item(<<66, tail::binary>>, nil), do: do_decode_item(tail, <<66>>)
  defp do_decode_item(<<66, tail::binary>>, result), do: do_decode_item(tail, [<<66>> | result])
  defp do_decode_item(<<67, tail::binary>>, nil), do: do_decode_item(tail, <<67>>)
  defp do_decode_item(<<67, tail::binary>>, result), do: do_decode_item(tail, [<<67>> | result])
  defp do_decode_item(<<68, tail::binary>>, nil), do: do_decode_item(tail, <<68>>)
  defp do_decode_item(<<68, tail::binary>>, result), do: do_decode_item(tail, [<<68>> | result])
  defp do_decode_item(<<69, tail::binary>>, nil), do: do_decode_item(tail, <<69>>)
  defp do_decode_item(<<69, tail::binary>>, result), do: do_decode_item(tail, [<<69>> | result])
  defp do_decode_item(<<70, tail::binary>>, nil), do: do_decode_item(tail, <<70>>)
  defp do_decode_item(<<70, tail::binary>>, result), do: do_decode_item(tail, [<<70>> | result])
  defp do_decode_item(<<71, tail::binary>>, nil), do: do_decode_item(tail, <<71>>)
  defp do_decode_item(<<71, tail::binary>>, result), do: do_decode_item(tail, [<<71>> | result])
  defp do_decode_item(<<72, tail::binary>>, nil), do: do_decode_item(tail, <<72>>)
  defp do_decode_item(<<72, tail::binary>>, result), do: do_decode_item(tail, [<<72>> | result])
  defp do_decode_item(<<73, tail::binary>>, nil), do: do_decode_item(tail, <<73>>)
  defp do_decode_item(<<73, tail::binary>>, result), do: do_decode_item(tail, [<<73>> | result])
  defp do_decode_item(<<74, tail::binary>>, nil), do: do_decode_item(tail, <<74>>)
  defp do_decode_item(<<74, tail::binary>>, result), do: do_decode_item(tail, [<<74>> | result])
  defp do_decode_item(<<75, tail::binary>>, nil), do: do_decode_item(tail, <<75>>)
  defp do_decode_item(<<75, tail::binary>>, result), do: do_decode_item(tail, [<<75>> | result])
  defp do_decode_item(<<76, tail::binary>>, nil), do: do_decode_item(tail, <<76>>)
  defp do_decode_item(<<76, tail::binary>>, result), do: do_decode_item(tail, [<<76>> | result])
  defp do_decode_item(<<77, tail::binary>>, nil), do: do_decode_item(tail, <<77>>)
  defp do_decode_item(<<77, tail::binary>>, result), do: do_decode_item(tail, [<<77>> | result])
  defp do_decode_item(<<78, tail::binary>>, nil), do: do_decode_item(tail, <<78>>)
  defp do_decode_item(<<78, tail::binary>>, result), do: do_decode_item(tail, [<<78>> | result])
  defp do_decode_item(<<79, tail::binary>>, nil), do: do_decode_item(tail, <<79>>)
  defp do_decode_item(<<79, tail::binary>>, result), do: do_decode_item(tail, [<<79>> | result])
  defp do_decode_item(<<80, tail::binary>>, nil), do: do_decode_item(tail, <<80>>)
  defp do_decode_item(<<80, tail::binary>>, result), do: do_decode_item(tail, [<<80>> | result])
  defp do_decode_item(<<81, tail::binary>>, nil), do: do_decode_item(tail, <<81>>)
  defp do_decode_item(<<81, tail::binary>>, result), do: do_decode_item(tail, [<<81>> | result])
  defp do_decode_item(<<82, tail::binary>>, nil), do: do_decode_item(tail, <<82>>)
  defp do_decode_item(<<82, tail::binary>>, result), do: do_decode_item(tail, [<<82>> | result])
  defp do_decode_item(<<83, tail::binary>>, nil), do: do_decode_item(tail, <<83>>)
  defp do_decode_item(<<83, tail::binary>>, result), do: do_decode_item(tail, [<<83>> | result])
  defp do_decode_item(<<84, tail::binary>>, nil), do: do_decode_item(tail, <<84>>)
  defp do_decode_item(<<84, tail::binary>>, result), do: do_decode_item(tail, [<<84>> | result])
  defp do_decode_item(<<85, tail::binary>>, nil), do: do_decode_item(tail, <<85>>)
  defp do_decode_item(<<85, tail::binary>>, result), do: do_decode_item(tail, [<<85>> | result])
  defp do_decode_item(<<86, tail::binary>>, nil), do: do_decode_item(tail, <<86>>)
  defp do_decode_item(<<86, tail::binary>>, result), do: do_decode_item(tail, [<<86>> | result])
  defp do_decode_item(<<87, tail::binary>>, nil), do: do_decode_item(tail, <<87>>)
  defp do_decode_item(<<87, tail::binary>>, result), do: do_decode_item(tail, [<<87>> | result])
  defp do_decode_item(<<88, tail::binary>>, nil), do: do_decode_item(tail, <<88>>)
  defp do_decode_item(<<88, tail::binary>>, result), do: do_decode_item(tail, [<<88>> | result])
  defp do_decode_item(<<89, tail::binary>>, nil), do: do_decode_item(tail, <<89>>)
  defp do_decode_item(<<89, tail::binary>>, result), do: do_decode_item(tail, [<<89>> | result])
  defp do_decode_item(<<90, tail::binary>>, nil), do: do_decode_item(tail, <<90>>)
  defp do_decode_item(<<90, tail::binary>>, result), do: do_decode_item(tail, [<<90>> | result])
  defp do_decode_item(<<91, tail::binary>>, nil), do: do_decode_item(tail, <<91>>)
  defp do_decode_item(<<91, tail::binary>>, result), do: do_decode_item(tail, [<<91>> | result])
  defp do_decode_item(<<92, tail::binary>>, nil), do: do_decode_item(tail, <<92>>)
  defp do_decode_item(<<92, tail::binary>>, result), do: do_decode_item(tail, [<<92>> | result])
  defp do_decode_item(<<93, tail::binary>>, nil), do: do_decode_item(tail, <<93>>)
  defp do_decode_item(<<93, tail::binary>>, result), do: do_decode_item(tail, [<<93>> | result])
  defp do_decode_item(<<94, tail::binary>>, nil), do: do_decode_item(tail, <<94>>)
  defp do_decode_item(<<94, tail::binary>>, result), do: do_decode_item(tail, [<<94>> | result])
  defp do_decode_item(<<95, tail::binary>>, nil), do: do_decode_item(tail, <<95>>)
  defp do_decode_item(<<95, tail::binary>>, result), do: do_decode_item(tail, [<<95>> | result])
  defp do_decode_item(<<96, tail::binary>>, nil), do: do_decode_item(tail, <<96>>)
  defp do_decode_item(<<96, tail::binary>>, result), do: do_decode_item(tail, [<<96>> | result])
  defp do_decode_item(<<97, tail::binary>>, nil), do: do_decode_item(tail, <<97>>)
  defp do_decode_item(<<97, tail::binary>>, result), do: do_decode_item(tail, [<<97>> | result])
  defp do_decode_item(<<98, tail::binary>>, nil), do: do_decode_item(tail, <<98>>)
  defp do_decode_item(<<98, tail::binary>>, result), do: do_decode_item(tail, [<<98>> | result])
  defp do_decode_item(<<99, tail::binary>>, nil), do: do_decode_item(tail, <<99>>)
  defp do_decode_item(<<99, tail::binary>>, result), do: do_decode_item(tail, [<<99>> | result])
  defp do_decode_item(<<100, tail::binary>>, nil), do: do_decode_item(tail, <<100>>)
  defp do_decode_item(<<100, tail::binary>>, result), do: do_decode_item(tail, [<<100>> | result])
  defp do_decode_item(<<101, tail::binary>>, nil), do: do_decode_item(tail, <<101>>)
  defp do_decode_item(<<101, tail::binary>>, result), do: do_decode_item(tail, [<<101>> | result])
  defp do_decode_item(<<102, tail::binary>>, nil), do: do_decode_item(tail, <<102>>)
  defp do_decode_item(<<102, tail::binary>>, result), do: do_decode_item(tail, [<<102>> | result])
  defp do_decode_item(<<103, tail::binary>>, nil), do: do_decode_item(tail, <<103>>)
  defp do_decode_item(<<103, tail::binary>>, result), do: do_decode_item(tail, [<<103>> | result])
  defp do_decode_item(<<104, tail::binary>>, nil), do: do_decode_item(tail, <<104>>)
  defp do_decode_item(<<104, tail::binary>>, result), do: do_decode_item(tail, [<<104>> | result])
  defp do_decode_item(<<105, tail::binary>>, nil), do: do_decode_item(tail, <<105>>)
  defp do_decode_item(<<105, tail::binary>>, result), do: do_decode_item(tail, [<<105>> | result])
  defp do_decode_item(<<106, tail::binary>>, nil), do: do_decode_item(tail, <<106>>)
  defp do_decode_item(<<106, tail::binary>>, result), do: do_decode_item(tail, [<<106>> | result])
  defp do_decode_item(<<107, tail::binary>>, nil), do: do_decode_item(tail, <<107>>)
  defp do_decode_item(<<107, tail::binary>>, result), do: do_decode_item(tail, [<<107>> | result])
  defp do_decode_item(<<108, tail::binary>>, nil), do: do_decode_item(tail, <<108>>)
  defp do_decode_item(<<108, tail::binary>>, result), do: do_decode_item(tail, [<<108>> | result])
  defp do_decode_item(<<109, tail::binary>>, nil), do: do_decode_item(tail, <<109>>)
  defp do_decode_item(<<109, tail::binary>>, result), do: do_decode_item(tail, [<<109>> | result])
  defp do_decode_item(<<110, tail::binary>>, nil), do: do_decode_item(tail, <<110>>)
  defp do_decode_item(<<110, tail::binary>>, result), do: do_decode_item(tail, [<<110>> | result])
  defp do_decode_item(<<111, tail::binary>>, nil), do: do_decode_item(tail, <<111>>)
  defp do_decode_item(<<111, tail::binary>>, result), do: do_decode_item(tail, [<<111>> | result])
  defp do_decode_item(<<112, tail::binary>>, nil), do: do_decode_item(tail, <<112>>)
  defp do_decode_item(<<112, tail::binary>>, result), do: do_decode_item(tail, [<<112>> | result])
  defp do_decode_item(<<113, tail::binary>>, nil), do: do_decode_item(tail, <<113>>)
  defp do_decode_item(<<113, tail::binary>>, result), do: do_decode_item(tail, [<<113>> | result])
  defp do_decode_item(<<114, tail::binary>>, nil), do: do_decode_item(tail, <<114>>)
  defp do_decode_item(<<114, tail::binary>>, result), do: do_decode_item(tail, [<<114>> | result])
  defp do_decode_item(<<115, tail::binary>>, nil), do: do_decode_item(tail, <<115>>)
  defp do_decode_item(<<115, tail::binary>>, result), do: do_decode_item(tail, [<<115>> | result])
  defp do_decode_item(<<116, tail::binary>>, nil), do: do_decode_item(tail, <<116>>)
  defp do_decode_item(<<116, tail::binary>>, result), do: do_decode_item(tail, [<<116>> | result])
  defp do_decode_item(<<117, tail::binary>>, nil), do: do_decode_item(tail, <<117>>)
  defp do_decode_item(<<117, tail::binary>>, result), do: do_decode_item(tail, [<<117>> | result])
  defp do_decode_item(<<118, tail::binary>>, nil), do: do_decode_item(tail, <<118>>)
  defp do_decode_item(<<118, tail::binary>>, result), do: do_decode_item(tail, [<<118>> | result])
  defp do_decode_item(<<119, tail::binary>>, nil), do: do_decode_item(tail, <<119>>)
  defp do_decode_item(<<119, tail::binary>>, result), do: do_decode_item(tail, [<<119>> | result])
  defp do_decode_item(<<120, tail::binary>>, nil), do: do_decode_item(tail, <<120>>)
  defp do_decode_item(<<120, tail::binary>>, result), do: do_decode_item(tail, [<<120>> | result])
  defp do_decode_item(<<121, tail::binary>>, nil), do: do_decode_item(tail, <<121>>)
  defp do_decode_item(<<121, tail::binary>>, result), do: do_decode_item(tail, [<<121>> | result])
  defp do_decode_item(<<122, tail::binary>>, nil), do: do_decode_item(tail, <<122>>)
  defp do_decode_item(<<122, tail::binary>>, result), do: do_decode_item(tail, [<<122>> | result])
  defp do_decode_item(<<123, tail::binary>>, nil), do: do_decode_item(tail, <<123>>)
  defp do_decode_item(<<123, tail::binary>>, result), do: do_decode_item(tail, [<<123>> | result])
  defp do_decode_item(<<124, tail::binary>>, nil), do: do_decode_item(tail, <<124>>)
  defp do_decode_item(<<124, tail::binary>>, result), do: do_decode_item(tail, [<<124>> | result])
  defp do_decode_item(<<125, tail::binary>>, nil), do: do_decode_item(tail, <<125>>)
  defp do_decode_item(<<125, tail::binary>>, result), do: do_decode_item(tail, [<<125>> | result])
  defp do_decode_item(<<126, tail::binary>>, nil), do: do_decode_item(tail, <<126>>)
  defp do_decode_item(<<126, tail::binary>>, result), do: do_decode_item(tail, [<<126>> | result])
  defp do_decode_item(<<127, tail::binary>>, nil), do: do_decode_item(tail, <<127>>)
  defp do_decode_item(<<127, tail::binary>>, result), do: do_decode_item(tail, [<<127>> | result])
  ##
  ## FINISHED HANDLING 0 - 127
  ##

  ##
  ## HANDLING 128 - 183
  ##
  defp do_decode_item(<<128, tail::binary>>, nil) do
    recursion_iter(0, tail, nil)
  end

  defp do_decode_item(<<128, tail::binary>>, result) do
    recursion_iter(0, tail, result)
  end

  defp do_decode_item(<<129, bad::little-size(8), _tail::binary>>, _) when bad < 128 do
    raise(ExRLP.DecodeError)
  end

  defp do_decode_item(<<129, bad::little-size(8)>>, _) when bad < 128 do
    raise(ExRLP.DecodeError)
  end

  defp do_decode_item(<<129, tail::binary>>, nil) do
    recursion_iter(1, tail, nil)
  end

  defp do_decode_item(<<129, tail::binary>>, result) do
    recursion_iter(1, tail, result)
  end

  defp do_decode_item(<<130, tail::binary>>, nil) do
    recursion_iter(2, tail, nil)
  end

  defp do_decode_item(<<130, tail::binary>>, result) do
    recursion_iter(2, tail, result)
  end

  defp do_decode_item(<<131, tail::binary>>, nil) do
    recursion_iter(3, tail, nil)
  end

  defp do_decode_item(<<131, tail::binary>>, result) do
    recursion_iter(3, tail, result)
  end

  defp do_decode_item(<<132, tail::binary>>, nil) do
    recursion_iter(4, tail, nil)
  end

  defp do_decode_item(<<132, tail::binary>>, result) do
    recursion_iter(4, tail, result)
  end

  defp do_decode_item(<<133, tail::binary>>, nil) do
    recursion_iter(5, tail, nil)
  end

  defp do_decode_item(<<133, tail::binary>>, result) do
    recursion_iter(5, tail, result)
  end

  defp do_decode_item(<<134, tail::binary>>, nil) do
    recursion_iter(6, tail, nil)
  end

  defp do_decode_item(<<134, tail::binary>>, result) do
    recursion_iter(6, tail, result)
  end

  defp do_decode_item(<<135, tail::binary>>, nil) do
    recursion_iter(7, tail, nil)
  end

  defp do_decode_item(<<135, tail::binary>>, result) do
    recursion_iter(7, tail, result)
  end

  defp do_decode_item(<<136, tail::binary>>, nil) do
    recursion_iter(8, tail, nil)
  end

  defp do_decode_item(<<136, tail::binary>>, result) do
    recursion_iter(8, tail, result)
  end

  defp do_decode_item(<<137, tail::binary>>, nil) do
    recursion_iter(9, tail, nil)
  end

  defp do_decode_item(<<137, tail::binary>>, result) do
    recursion_iter(9, tail, result)
  end

  defp do_decode_item(<<138, tail::binary>>, nil) do
    recursion_iter(10, tail, nil)
  end

  defp do_decode_item(<<138, tail::binary>>, result) do
    recursion_iter(10, tail, result)
  end

  defp do_decode_item(<<139, tail::binary>>, nil) do
    recursion_iter(11, tail, nil)
  end

  defp do_decode_item(<<139, tail::binary>>, result) do
    recursion_iter(11, tail, result)
  end

  defp do_decode_item(<<140, tail::binary>>, nil) do
    recursion_iter(12, tail, nil)
  end

  defp do_decode_item(<<140, tail::binary>>, result) do
    recursion_iter(12, tail, result)
  end

  defp do_decode_item(<<141, tail::binary>>, nil) do
    recursion_iter(13, tail, nil)
  end

  defp do_decode_item(<<141, tail::binary>>, result) do
    recursion_iter(13, tail, result)
  end

  defp do_decode_item(<<142, tail::binary>>, nil) do
    recursion_iter(14, tail, nil)
  end

  defp do_decode_item(<<142, tail::binary>>, result) do
    recursion_iter(14, tail, result)
  end

  defp do_decode_item(<<143, tail::binary>>, nil) do
    recursion_iter(15, tail, nil)
  end

  defp do_decode_item(<<143, tail::binary>>, result) do
    recursion_iter(15, tail, result)
  end

  defp do_decode_item(<<144, tail::binary>>, nil) do
    recursion_iter(16, tail, nil)
  end

  defp do_decode_item(<<144, tail::binary>>, result) do
    recursion_iter(16, tail, result)
  end

  defp do_decode_item(<<145, tail::binary>>, nil) do
    recursion_iter(17, tail, nil)
  end

  defp do_decode_item(<<145, tail::binary>>, result) do
    recursion_iter(17, tail, result)
  end

  defp do_decode_item(<<146, tail::binary>>, nil) do
    recursion_iter(18, tail, nil)
  end

  defp do_decode_item(<<146, tail::binary>>, result) do
    recursion_iter(18, tail, result)
  end

  defp do_decode_item(<<147, tail::binary>>, nil) do
    recursion_iter(19, tail, nil)
  end

  defp do_decode_item(<<147, tail::binary>>, result) do
    recursion_iter(19, tail, result)
  end

  defp do_decode_item(<<148, tail::binary>>, nil) do
    recursion_iter(20, tail, nil)
  end

  defp do_decode_item(<<148, tail::binary>>, result) do
    recursion_iter(20, tail, result)
  end

  defp do_decode_item(<<149, tail::binary>>, nil) do
    recursion_iter(21, tail, nil)
  end

  defp do_decode_item(<<149, tail::binary>>, result) do
    recursion_iter(21, tail, result)
  end

  defp do_decode_item(<<150, tail::binary>>, nil) do
    recursion_iter(22, tail, nil)
  end

  defp do_decode_item(<<150, tail::binary>>, result) do
    recursion_iter(22, tail, result)
  end

  defp do_decode_item(<<151, tail::binary>>, nil) do
    recursion_iter(23, tail, nil)
  end

  defp do_decode_item(<<151, tail::binary>>, result) do
    recursion_iter(23, tail, result)
  end

  defp do_decode_item(<<152, tail::binary>>, nil) do
    recursion_iter(24, tail, nil)
  end

  defp do_decode_item(<<152, tail::binary>>, result) do
    recursion_iter(24, tail, result)
  end

  defp do_decode_item(<<153, tail::binary>>, nil) do
    recursion_iter(25, tail, nil)
  end

  defp do_decode_item(<<153, tail::binary>>, result) do
    recursion_iter(25, tail, result)
  end

  defp do_decode_item(<<154, tail::binary>>, nil) do
    recursion_iter(26, tail, nil)
  end

  defp do_decode_item(<<154, tail::binary>>, result) do
    recursion_iter(26, tail, result)
  end

  defp do_decode_item(<<155, tail::binary>>, nil) do
    recursion_iter(27, tail, nil)
  end

  defp do_decode_item(<<155, tail::binary>>, result) do
    recursion_iter(27, tail, result)
  end

  defp do_decode_item(<<156, tail::binary>>, nil) do
    recursion_iter(28, tail, nil)
  end

  defp do_decode_item(<<156, tail::binary>>, result) do
    recursion_iter(28, tail, result)
  end

  defp do_decode_item(<<157, tail::binary>>, nil) do
    recursion_iter(29, tail, nil)
  end

  defp do_decode_item(<<157, tail::binary>>, result) do
    recursion_iter(29, tail, result)
  end

  defp do_decode_item(<<158, tail::binary>>, nil) do
    recursion_iter(30, tail, nil)
  end

  defp do_decode_item(<<158, tail::binary>>, result) do
    recursion_iter(30, tail, result)
  end

  defp do_decode_item(<<159, tail::binary>>, nil) do
    recursion_iter(31, tail, nil)
  end

  defp do_decode_item(<<159, tail::binary>>, result) do
    recursion_iter(31, tail, result)
  end

  defp do_decode_item(<<160, tail::binary>>, nil) do
    recursion_iter(32, tail, nil)
  end

  defp do_decode_item(<<160, tail::binary>>, result) do
    recursion_iter(32, tail, result)
  end

  defp do_decode_item(<<161, tail::binary>>, nil) do
    recursion_iter(33, tail, nil)
  end

  defp do_decode_item(<<161, tail::binary>>, result) do
    recursion_iter(33, tail, result)
  end

  defp do_decode_item(<<162, tail::binary>>, nil) do
    recursion_iter(34, tail, nil)
  end

  defp do_decode_item(<<162, tail::binary>>, result) do
    recursion_iter(34, tail, result)
  end

  defp do_decode_item(<<163, tail::binary>>, nil) do
    recursion_iter(35, tail, nil)
  end

  defp do_decode_item(<<163, tail::binary>>, result) do
    recursion_iter(35, tail, result)
  end

  defp do_decode_item(<<164, tail::binary>>, nil) do
    recursion_iter(36, tail, nil)
  end

  defp do_decode_item(<<164, tail::binary>>, result) do
    recursion_iter(36, tail, result)
  end

  defp do_decode_item(<<165, tail::binary>>, nil) do
    recursion_iter(37, tail, nil)
  end

  defp do_decode_item(<<165, tail::binary>>, result) do
    recursion_iter(37, tail, result)
  end

  defp do_decode_item(<<166, tail::binary>>, nil) do
    recursion_iter(38, tail, nil)
  end

  defp do_decode_item(<<166, tail::binary>>, result) do
    recursion_iter(38, tail, result)
  end

  defp do_decode_item(<<167, tail::binary>>, nil) do
    recursion_iter(39, tail, nil)
  end

  defp do_decode_item(<<167, tail::binary>>, result) do
    recursion_iter(39, tail, result)
  end

  defp do_decode_item(<<168, tail::binary>>, nil) do
    recursion_iter(40, tail, nil)
  end

  defp do_decode_item(<<168, tail::binary>>, result) do
    recursion_iter(40, tail, result)
  end

  defp do_decode_item(<<169, tail::binary>>, nil) do
    recursion_iter(41, tail, nil)
  end

  defp do_decode_item(<<169, tail::binary>>, result) do
    recursion_iter(41, tail, result)
  end

  defp do_decode_item(<<170, tail::binary>>, nil) do
    recursion_iter(42, tail, nil)
  end

  defp do_decode_item(<<170, tail::binary>>, result) do
    recursion_iter(42, tail, result)
  end

  defp do_decode_item(<<171, tail::binary>>, nil) do
    recursion_iter(43, tail, nil)
  end

  defp do_decode_item(<<171, tail::binary>>, result) do
    recursion_iter(43, tail, result)
  end

  defp do_decode_item(<<172, tail::binary>>, nil) do
    recursion_iter(44, tail, nil)
  end

  defp do_decode_item(<<172, tail::binary>>, result) do
    recursion_iter(44, tail, result)
  end

  defp do_decode_item(<<173, tail::binary>>, nil) do
    recursion_iter(45, tail, nil)
  end

  defp do_decode_item(<<173, tail::binary>>, result) do
    recursion_iter(45, tail, result)
  end

  defp do_decode_item(<<174, tail::binary>>, nil) do
    recursion_iter(46, tail, nil)
  end

  defp do_decode_item(<<174, tail::binary>>, result) do
    recursion_iter(46, tail, result)
  end

  defp do_decode_item(<<175, tail::binary>>, nil) do
    recursion_iter(47, tail, nil)
  end

  defp do_decode_item(<<175, tail::binary>>, result) do
    recursion_iter(47, tail, result)
  end

  defp do_decode_item(<<176, tail::binary>>, nil) do
    recursion_iter(48, tail, nil)
  end

  defp do_decode_item(<<176, tail::binary>>, result) do
    recursion_iter(48, tail, result)
  end

  defp do_decode_item(<<177, tail::binary>>, nil) do
    recursion_iter(49, tail, nil)
  end

  defp do_decode_item(<<177, tail::binary>>, result) do
    recursion_iter(49, tail, result)
  end

  defp do_decode_item(<<178, tail::binary>>, nil) do
    recursion_iter(50, tail, nil)
  end

  defp do_decode_item(<<178, tail::binary>>, result) do
    recursion_iter(50, tail, result)
  end

  defp do_decode_item(<<179, tail::binary>>, nil) do
    recursion_iter(51, tail, nil)
  end

  defp do_decode_item(<<179, tail::binary>>, result) do
    recursion_iter(51, tail, result)
  end

  defp do_decode_item(<<180, tail::binary>>, nil) do
    recursion_iter(52, tail, nil)
  end

  defp do_decode_item(<<180, tail::binary>>, result) do
    recursion_iter(52, tail, result)
  end

  defp do_decode_item(<<181, tail::binary>>, nil) do
    recursion_iter(53, tail, nil)
  end

  defp do_decode_item(<<181, tail::binary>>, result) do
    recursion_iter(53, tail, result)
  end

  defp do_decode_item(<<182, tail::binary>>, nil) do
    recursion_iter(54, tail, nil)
  end

  defp do_decode_item(<<182, tail::binary>>, result) do
    recursion_iter(54, tail, result)
  end

  defp do_decode_item(<<183, tail::binary>>, nil) do
    recursion_iter(55, tail, nil)
  end

  defp do_decode_item(<<183, tail::binary>>, result) do
    recursion_iter(55, tail, result)
  end

  ##
  ## FINISHED HANDLING 128-183
  ##

  # decode_long_binary - CAN'T OPTIMISE FOR NOW
  defp do_decode_item(<<be_size_prefix, tail::binary>>, nil) when be_size_prefix < 192 do
    {new_item, new_tail} = decode_long_binary(be_size_prefix - 183, tail)

    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<be_size_prefix, tail::binary>>, result) when be_size_prefix < 192 do
    {new_item, new_tail} = decode_long_binary(be_size_prefix - 183, tail)

    do_decode_item(new_tail, [new_item | result])
  end

  ##
  ## HANDLING 192
  ##
  defp do_decode_item(<<192, tail::binary>>, nil) do
    do_decode_item(tail, [])
  end

  defp do_decode_item(<<192, tail::binary>>, result) do
    do_decode_item(tail, [[] | result])
  end

  ##
  ## FINISHED HANDLING 192
  ##

  ##
  ## HANDLING 193-247
  ##
  defp do_decode_item(<<193, tail::binary>>, nil) do
    <<item::binary-size(1), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<193, tail::binary>>, result) do
    <<item::binary-size(1), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<194, tail::binary>>, nil) do
    <<item::binary-size(2), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<194, tail::binary>>, result) do
    <<item::binary-size(2), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<195, tail::binary>>, nil) do
    <<item::binary-size(3), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<195, tail::binary>>, result) do
    <<item::binary-size(3), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<196, tail::binary>>, nil) do
    <<item::binary-size(4), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<196, tail::binary>>, result) do
    <<item::binary-size(4), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<197, tail::binary>>, nil) when byte_size(tail) >= 5 do
    <<item::binary-size(5), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<197, tail::binary>>, result) when byte_size(tail) >= 5 do
    <<item::binary-size(5), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<198, tail::binary>>, nil) do
    <<item::binary-size(6), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<198, tail::binary>>, result) do
    <<item::binary-size(6), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<199, tail::binary>>, nil) do
    <<item::binary-size(7), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<199, tail::binary>>, result) do
    <<item::binary-size(7), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<200, tail::binary>>, nil) do
    <<item::binary-size(8), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<200, tail::binary>>, result) do
    <<item::binary-size(8), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<201, tail::binary>>, nil) do
    <<item::binary-size(9), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<201, tail::binary>>, result) do
    <<item::binary-size(9), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<202, tail::binary>>, nil) do
    <<item::binary-size(10), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<202, tail::binary>>, result) do
    <<item::binary-size(10), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<203, tail::binary>>, nil) do
    <<item::binary-size(11), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<203, tail::binary>>, result) do
    <<item::binary-size(11), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<204, tail::binary>>, nil) do
    <<item::binary-size(12), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<204, tail::binary>>, result) do
    <<item::binary-size(12), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<205, tail::binary>>, nil) do
    <<item::binary-size(13), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<205, tail::binary>>, result) do
    <<item::binary-size(13), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<206, tail::binary>>, nil) do
    <<item::binary-size(14), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<206, tail::binary>>, result) do
    <<item::binary-size(14), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<207, tail::binary>>, nil) do
    <<item::binary-size(15), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<207, tail::binary>>, result) do
    <<item::binary-size(15), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<208, tail::binary>>, nil) do
    <<item::binary-size(16), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<208, tail::binary>>, result) do
    <<item::binary-size(16), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<209, tail::binary>>, nil) do
    <<item::binary-size(17), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<209, tail::binary>>, result) do
    <<item::binary-size(17), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<210, tail::binary>>, nil) do
    <<item::binary-size(18), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<210, tail::binary>>, result) do
    <<item::binary-size(18), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<211, tail::binary>>, nil) do
    <<item::binary-size(19), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<211, tail::binary>>, result) do
    <<item::binary-size(19), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<212, tail::binary>>, nil) do
    <<item::binary-size(20), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<212, tail::binary>>, result) do
    <<item::binary-size(20), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<213, tail::binary>>, nil) do
    <<item::binary-size(21), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<213, tail::binary>>, result) do
    <<item::binary-size(21), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<214, tail::binary>>, nil) do
    <<item::binary-size(22), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<214, tail::binary>>, result) do
    <<item::binary-size(22), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<215, tail::binary>>, nil) do
    <<item::binary-size(23), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<215, tail::binary>>, result) do
    <<item::binary-size(23), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<216, tail::binary>>, nil) do
    <<item::binary-size(24), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<216, tail::binary>>, result) do
    <<item::binary-size(24), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<217, tail::binary>>, nil) do
    <<item::binary-size(25), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<217, tail::binary>>, result) do
    <<item::binary-size(25), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<218, tail::binary>>, nil) do
    <<item::binary-size(26), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<218, tail::binary>>, result) do
    <<item::binary-size(26), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<219, tail::binary>>, nil) do
    <<item::binary-size(27), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<219, tail::binary>>, result) do
    <<item::binary-size(27), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<220, tail::binary>>, nil) do
    <<item::binary-size(28), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<220, tail::binary>>, result) do
    <<item::binary-size(28), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<221, tail::binary>>, nil) do
    <<item::binary-size(29), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<221, tail::binary>>, result) do
    <<item::binary-size(29), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<222, tail::binary>>, nil) do
    <<item::binary-size(30), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<222, tail::binary>>, result) do
    <<item::binary-size(30), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<223, tail::binary>>, nil) do
    <<item::binary-size(31), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<223, tail::binary>>, result) do
    <<item::binary-size(31), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<224, tail::binary>>, nil) do
    <<item::binary-size(32), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<224, tail::binary>>, result) do
    <<item::binary-size(32), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<225, tail::binary>>, nil) do
    <<item::binary-size(33), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<225, tail::binary>>, result) do
    <<item::binary-size(33), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<226, tail::binary>>, nil) when byte_size(tail) >= 34 do
    <<item::binary-size(34), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<226, tail::binary>>, result) when byte_size(tail) >= 34 do
    <<item::binary-size(34), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<227, tail::binary>>, nil) do
    <<item::binary-size(35), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<227, tail::binary>>, result) do
    <<item::binary-size(35), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<228, tail::binary>>, nil) do
    <<item::binary-size(36), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<228, tail::binary>>, result) do
    <<item::binary-size(36), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<229, tail::binary>>, nil) do
    <<item::binary-size(37), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<229, tail::binary>>, result) do
    <<item::binary-size(37), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<230, tail::binary>>, nil) do
    <<item::binary-size(38), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<230, tail::binary>>, result) do
    <<item::binary-size(38), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<231, tail::binary>>, nil) do
    <<item::binary-size(39), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<231, tail::binary>>, result) do
    <<item::binary-size(39), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<232, tail::binary>>, nil) do
    <<item::binary-size(40), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<232, tail::binary>>, result) do
    <<item::binary-size(40), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<233, tail::binary>>, nil) do
    <<item::binary-size(41), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<233, tail::binary>>, result) do
    <<item::binary-size(41), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<234, tail::binary>>, nil) do
    <<item::binary-size(42), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<234, tail::binary>>, result) do
    <<item::binary-size(42), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<235, tail::binary>>, nil) do
    <<item::binary-size(43), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<235, tail::binary>>, result) do
    <<item::binary-size(43), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<236, tail::binary>>, nil) do
    <<item::binary-size(44), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<236, tail::binary>>, result) do
    <<item::binary-size(44), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<237, tail::binary>>, nil) do
    <<item::binary-size(45), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<237, tail::binary>>, result) do
    <<item::binary-size(45), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<238, tail::binary>>, nil) do
    <<item::binary-size(46), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<238, tail::binary>>, result) do
    <<item::binary-size(46), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<239, tail::binary>>, nil) do
    <<item::binary-size(47), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<239, tail::binary>>, result) do
    <<item::binary-size(47), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<240, tail::binary>>, nil) do
    <<item::binary-size(48), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<240, tail::binary>>, result) do
    <<item::binary-size(48), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<241, tail::binary>>, nil) do
    <<item::binary-size(49), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<241, tail::binary>>, result) do
    <<item::binary-size(49), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<242, tail::binary>>, nil) do
    <<item::binary-size(50), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<242, tail::binary>>, result) do
    <<item::binary-size(50), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<243, tail::binary>>, nil) do
    <<item::binary-size(51), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<243, tail::binary>>, result) do
    <<item::binary-size(51), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<244, tail::binary>>, nil) do
    <<item::binary-size(52), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<244, tail::binary>>, result) do
    <<item::binary-size(52), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<245, tail::binary>>, nil) do
    <<item::binary-size(53), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<245, tail::binary>>, result) do
    <<item::binary-size(53), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<246, tail::binary>>, nil) do
    <<item::binary-size(54), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<246, tail::binary>>, result) do
    <<item::binary-size(54), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  defp do_decode_item(<<247, tail::binary>>, nil) do
    <<item::binary-size(55), new_tail::binary>> = tail
    new_item = Enum.reverse(do_decode_item(item, []))
    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<247, tail::binary>>, result) do
    <<item::binary-size(55), new_tail::binary>> = tail
    new_item = do_decode_item(item, [])
    do_decode_item(new_tail, [new_item | result])
  end

  ##
  ## FINISHED HANDLING 193-247
  ##

  # decode_long_binary - CAN'T OPTIMISE FOR NOW
  defp do_decode_item(<<be_size_prefix, tail::binary>>, nil) when be_size_prefix > 247 do
    {list_binary, new_tail} = decode_long_binary(be_size_prefix - 247, tail)
    reversed_list = do_decode_item(list_binary, [])
    new_result = Enum.reverse(reversed_list)

    do_decode_item(new_tail, new_result)
  end

  defp do_decode_item(<<be_size_prefix, tail::binary>>, result) when be_size_prefix > 247 do
    {list_binary, new_tail} = decode_long_binary(be_size_prefix - 247, tail)
    list = do_decode_item(list_binary, [])

    do_decode_item(new_tail, [list | result])
  end

  defp do_decode_item(<<>>, result) when is_list(result) do
    Enum.reverse(result)
  end

  defp do_decode_item(<<>>, result), do: result

  defp do_decode_item(_, _), do: raise(ExRLP.DecodeError)

  defp recursion_iter(size, tail, result) when byte_size(tail) >= size do
    <<item::binary-size(size), new_tail::binary>> = tail
    do_decode_item(new_tail, [item | result])
  end

  defp recursion_iter(_, _, _), do: raise(ExRLP.DecodeError)

  # decodes a long string or long list, based on the already decoded size of length provided (`be_size`)
  #
  # `be_size` - size of the length component in `tail`
  # `tail` - chunk of the binary containing the length and then the payload
  #
  # returns the resulting `item` and `new_tail` which is the remainder of the RLP structure to decode, if encoding OK
  @spec decode_long_binary(integer(), binary()) :: {binary(), binary()}

  # leading zeroes in length
  defp decode_long_binary(_, <<0, _::binary>>), do: raise(ExRLP.DecodeError)

  defp decode_long_binary(be_size, tail) when be_size > 0 and byte_size(tail) > 0 do
    <<be::binary-size(be_size), data::binary>> = tail

    item_length = :binary.decode_unsigned(be)

    case {item_length, data} do
      # item length doesn't mandate long array / long list
      {bad_length, _} when bad_length < 55 -> raise(ExRLP.DecodeError)
      # all good
      {_, <<item::binary-size(item_length), new_tail::binary>>} -> {item, new_tail}
      # not enough of bytes in the payload
      {_, short_binary} when is_binary(short_binary) -> raise(ExRLP.DecodeError)
    end
  end

  defp decode_long_binary(_, _), do: raise(ExRLP.DecodeError)
end
