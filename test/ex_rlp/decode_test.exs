defmodule ExRLP.DecodeTest do
  use ExUnit.Case
  alias ExRLP.Decode
  import ExRLP.TestUtils

  describe "decode/2" do
    test "correctly decodes objects" do
      test_file_name = "rlptest.json"

      test_file_name
      |> read_json_file
      |> Enum.each(fn {test_name, %{"in" => expected_result, "out" => input}} ->
        expected_result = normalize_data(expected_result)

        result =
          input
          |> normalize_data()
          |> Decode.decode()
          |> normalize_decoded_data(expected_result)

        assert result == expected_result, "#{test_name} failed"
      end)
    end

    test "correctly refuses to decode invalid" do
      test_file_name = "invalidRLPTest.json"

      test_file_name
      |> read_json_file
      |> Enum.each(fn {test_name, %{"in" => expected_result, "out" => input}} ->
        # there are only INVALID cases today, testing if this is still the case
        assert expected_result == "INVALID"
        normalized_input = normalize_invalid_case_data(input)

        assert_raise ExRLP.DecodeError, fn ->
          Decode.decode(normalized_input)
          IO.puts("#{test_name} failed to raise")
        end
      end)
    end

    test "decodes nested lists" do
      expected_result =
        [["key1", "val1"], ["key2", "val2"], ["key3", "val3"], ["key4", "val4"]]
        |> normalize_data

      input =
        "ecca846b6579318476616c31ca846b6579328476616c32ca846b6579338476616c33ca846b6579348476616c34"

      result =
        input
        |> Decode.decode(encoding: :hex)
        |> normalize_decoded_data(expected_result)

      assert result == expected_result
    end

    test "decodes a stream (one by one)" do
      input =
        "b84f00f84ca0aa515b011bf12ac657b553406524ffd50374cd364f67c388deabca14e6aeaad3837e62aca0b8c59117fab23e3bab884d82d1f8663cc42e153322d61ea68dca12301100cf848463bc25fec0b84f00f84ca066e87b7ed4d870a90303c6efa3e24a52d765b711c7b4b08e3fe588375afdae77837e62aca0b8c59117fab23e3bab884d82d1f8663cc42e153322d61ea68dca12301100cf848463bc2600c0b84f00f84ca05394068243652c3a99957c25140dcc990d1779d08451b59394d3d1b1eadc92a1837e62aca0b8c59117fab23e3bab884d82d1f8663cc42e153322d61ea68dca12301100cf848463bc2602c0b84f00f84ca02e737a53e6f65143585d1bb566afcc6727ba223c06861af30b5a7bedb5406c36837e62aca0b8c59117fab23e3bab884d82d1f8663cc42e153322d61ea68dca12301100cf848463bc2604c0b84f00f84ca00ef88ba04224d10a07a37b3eba5dcf0da4bef39324b1024407a103258cbd5e40837e62aca0b8c59117fab23e3bab884d82d1f8663cc42e153322d61ea68dca12301100cf848463bc2606c0b84f00f84ca0b1214f92574ece688a9de5b6550d4f6753bb58f9be973cf28d1e871e84634427837e62aca0b8c59117fab23e3bab884d82d1f8663cc42e153322d61ea68dca12301100cf848463bc2608c0b84f00f84ca083daccac8ed34a8b1ce9a5f596a1f2b40245365316b397621ee09d276fd84a40837e62ada082b9c7a1ab48f891abeae5c68ff996d0c0652801de30208d47f8aa0ff32168bc8463bc260ac0b9030e00f9030aa0e61b6b1e235f293e7acf34ee7abe8f9b2c59a6630f894f51e62aa85e818bdd7e837e62ada082b9c7a1ab48f891abeae5c68ff996d0c0652801de30208d47f8aa0ff32168bc8463bc260cf902bcb902b902f902b58203868205fb849502f900849502f94e8307a12094d273437fb85167f5a32aa2c2f7ac0537e62ba2d480b90244c98075390000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000018000000000000000000000000000000000000000000000000000000000000001e0000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e00000000000000000000000236ca51ca6b5a6a224e6ad3afcc984c400000fa60500030400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000500000000000000000000000000000000000000000000000000000000000000027856314a6e0a0b0248179aaf6dc1f0ab38f907f08af87b210945a2f759eb936cdcf9ee0ed79cc2859846593ca37b9bd48e7aa125076571f2fd8df553da4c3ea600000000000000000000000000000000000000000000000000000000000000022f9d71eb098e8cbbb53010162ac75aa29c55cd027311579e66780701feb643fa5d6679f100662a69e4c10418e797edb819e686c9804715c46a7d6c81c287ca24c080a05d264fa6897b7b58002065182fdf920352fd863292a62bb15471fdf65cefc964a05b983978d4f9ae95c5bcbee9c9286c99bb57d7145b4b438bbbf8dd61d700c34eb84f00f84ca02f6a7f3b48e786e125d83d3ff13238a7397d7f166218dc596f3d0b98d0b50003837e62ada082b9c7a1ab48f891abeae5c68ff996d0c0652801de30208d47f8aa0ff32168bc8463bc260ec0b84f00f84ca0aad73e8161e3252b006cf15266ad0de0699978d4c5fc25bf1c0e2886787c9c1f837e62ada082b9c7a1ab48f891abeae5c68ff996d0c0652801de30208d47f8aa0ff32168bc8463bc2610c0b84f00f84ca0a1bc16efce7c07c56e1b7ef94137938aca090439c9e94d7b6bae9ef8bcbc8854837e62ada082b9c7a1ab48f891abeae5c68ff996d0c0652801de30208d47f8aa0ff32168bc8463bc2612c0b84f00f84ca0d3e2520c0887370fd58ed693aa8ad67be3035dc9d939816c7ab839405c513a6a837e62ada082b9c7a1ab48f891abeae5c68ff996d0c0652801de30208d47f8aa0ff32168bc8463bc2614c0b84f00f84ca021b6815ffa9636f87826be08335b41ea667c1e994b4a597dfc82c38d633b6c28837e62ada082b9c7a1ab48f891abeae5c68ff996d0c0652801de30208d47f8aa0ff32168bc8463bc2616c0b84f00f84ca0111c38c918fc331bf71b36a24bb71256c022219e4b5082a0f7166a40ae15816a837e62aea0874e872c4e5f2a3d66e214ed30228a9acaf246b363a8a05b123d231ac25f81968463bc2618c0b84f00f84ca0a3dd1bdf1f752853f2076d9de784c2d6c62f5b57c4383707014e26111727875a837e62aea0874e872c4e5f2a3d66e214ed30228a9acaf246b363a8a05b123d231ac25f81968463bc261ac0b84f00f84ca0df992270cde7118ee03da1d97e49bb3cbb42fffda0903c8611bb83a91a126635837e62aea0874e872c4e5f2a3d66e214ed30228a9acaf246b363a8a05b123d231ac25f81968463bc261cc0"
        |> String.downcase()
        |> Base.decode16!(case: :lower)

      expected_items = [
        <<0, 248, 76, 160, 170, 81, 91, 1, 27, 241, 42, 198, 87, 181, 83, 64, 101, 36, 255, 213,
          3, 116, 205, 54, 79, 103, 195, 136, 222, 171, 202, 20, 230, 174, 170, 211, 131, 126, 98,
          172, 160, 184, 197, 145, 23, 250, 178, 62, 59, 171, 136, 77, 130, 209, 248, 102, 60,
          196, 46, 21, 51, 34, 214, 30, 166, 141, 202, 18, 48, 17, 0, 207, 132, 132, 99, 188, 37,
          254, 192>>,
        <<0, 248, 76, 160, 102, 232, 123, 126, 212, 216, 112, 169, 3, 3, 198, 239, 163, 226, 74,
          82, 215, 101, 183, 17, 199, 180, 176, 142, 63, 229, 136, 55, 90, 253, 174, 119, 131,
          126, 98, 172, 160, 184, 197, 145, 23, 250, 178, 62, 59, 171, 136, 77, 130, 209, 248,
          102, 60, 196, 46, 21, 51, 34, 214, 30, 166, 141, 202, 18, 48, 17, 0, 207, 132, 132, 99,
          188, 38, 0, 192>>,
        <<0, 248, 76, 160, 83, 148, 6, 130, 67, 101, 44, 58, 153, 149, 124, 37, 20, 13, 204, 153,
          13, 23, 121, 208, 132, 81, 181, 147, 148, 211, 209, 177, 234, 220, 146, 161, 131, 126,
          98, 172, 160, 184, 197, 145, 23, 250, 178, 62, 59, 171, 136, 77, 130, 209, 248, 102, 60,
          196, 46, 21, 51, 34, 214, 30, 166, 141, 202, 18, 48, 17, 0, 207, 132, 132, 99, 188, 38,
          2, 192>>,
        <<0, 248, 76, 160, 46, 115, 122, 83, 230, 246, 81, 67, 88, 93, 27, 181, 102, 175, 204,
          103, 39, 186, 34, 60, 6, 134, 26, 243, 11, 90, 123, 237, 181, 64, 108, 54, 131, 126, 98,
          172, 160, 184, 197, 145, 23, 250, 178, 62, 59, 171, 136, 77, 130, 209, 248, 102, 60,
          196, 46, 21, 51, 34, 214, 30, 166, 141, 202, 18, 48, 17, 0, 207, 132, 132, 99, 188, 38,
          4, 192>>,
        <<0, 248, 76, 160, 14, 248, 139, 160, 66, 36, 209, 10, 7, 163, 123, 62, 186, 93, 207, 13,
          164, 190, 243, 147, 36, 177, 2, 68, 7, 161, 3, 37, 140, 189, 94, 64, 131, 126, 98, 172,
          160, 184, 197, 145, 23, 250, 178, 62, 59, 171, 136, 77, 130, 209, 248, 102, 60, 196, 46,
          21, 51, 34, 214, 30, 166, 141, 202, 18, 48, 17, 0, 207, 132, 132, 99, 188, 38, 6, 192>>,
        <<0, 248, 76, 160, 177, 33, 79, 146, 87, 78, 206, 104, 138, 157, 229, 182, 85, 13, 79,
          103, 83, 187, 88, 249, 190, 151, 60, 242, 141, 30, 135, 30, 132, 99, 68, 39, 131, 126,
          98, 172, 160, 184, 197, 145, 23, 250, 178, 62, 59, 171, 136, 77, 130, 209, 248, 102, 60,
          196, 46, 21, 51, 34, 214, 30, 166, 141, 202, 18, 48, 17, 0, 207, 132, 132, 99, 188, 38,
          8, 192>>,
        <<0, 248, 76, 160, 131, 218, 204, 172, 142, 211, 74, 139, 28, 233, 165, 245, 150, 161,
          242, 180, 2, 69, 54, 83, 22, 179, 151, 98, 30, 224, 157, 39, 111, 216, 74, 64, 131, 126,
          98, 173, 160, 130, 185, 199, 161, 171, 72, 248, 145, 171, 234, 229, 198, 143, 249, 150,
          208, 192, 101, 40, 1, 222, 48, 32, 141, 71, 248, 170, 15, 243, 33, 104, 188, 132, 99,
          188, 38, 10, 192>>,
        <<0, 249, 3, 10, 160, 230, 27, 107, 30, 35, 95, 41, 62, 122, 207, 52, 238, 122, 190, 143,
          155, 44, 89, 166, 99, 15, 137, 79, 81, 230, 42, 168, 94, 129, 139, 221, 126, 131, 126,
          98, 173, 160, 130, 185, 199, 161, 171, 72, 248, 145, 171, 234, 229, 198, 143, 249, 150,
          208, 192, 101, 40, 1, 222, 48, 32, 141, 71, 248, 170, 15, 243, 33, 104, 188, 132, 99,
          188, 38, 12, 249, 2, 188, 185, 2, 185, 2, 249, 2, 181, 130, 3, 134, 130, 5, 251, 132,
          149, 2, 249, 0, 132, 149, 2, 249, 78, 131, 7, 161, 32, 148, 210, 115, 67, 127, 184, 81,
          103, 245, 163, 42, 162, 194, 247, 172, 5, 55, 230, 43, 162, 212, 128, 185, 2, 68, 201,
          128, 117, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 1, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 224, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 35, 108, 165, 28, 166, 181, 166, 162, 36, 230, 173, 58, 252, 201, 132, 196, 0, 0, 15,
          166, 5, 0, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 120, 86, 49, 74,
          110, 10, 11, 2, 72, 23, 154, 175, 109, 193, 240, 171, 56, 249, 7, 240, 138, 248, 123,
          33, 9, 69, 162, 247, 89, 235, 147, 108, 220, 249, 238, 14, 215, 156, 194, 133, 152, 70,
          89, 60, 163, 123, 155, 212, 142, 122, 161, 37, 7, 101, 113, 242, 253, 141, 245, 83, 218,
          76, 62, 166, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 2, 47, 157, 113, 235, 9, 142, 140, 187, 181, 48, 16, 22, 42, 199, 90,
          162, 156, 85, 205, 2, 115, 17, 87, 158, 102, 120, 7, 1, 254, 182, 67, 250, 93, 102, 121,
          241, 0, 102, 42, 105, 228, 193, 4, 24, 231, 151, 237, 184, 25, 230, 134, 201, 128, 71,
          21, 196, 106, 125, 108, 129, 194, 135, 202, 36, 192, 128, 160, 93, 38, 79, 166, 137,
          123, 123, 88, 0, 32, 101, 24, 47, 223, 146, 3, 82, 253, 134, 50, 146, 166, 43, 177, 84,
          113, 253, 246, 92, 239, 201, 100, 160, 91, 152, 57, 120, 212, 249, 174, 149, 197, 188,
          190, 233, 201, 40, 108, 153, 187, 87, 215, 20, 91, 75, 67, 139, 187, 248, 221, 97, 215,
          0, 195, 78>>,
        <<0, 248, 76, 160, 47, 106, 127, 59, 72, 231, 134, 225, 37, 216, 61, 63, 241, 50, 56, 167,
          57, 125, 127, 22, 98, 24, 220, 89, 111, 61, 11, 152, 208, 181, 0, 3, 131, 126, 98, 173,
          160, 130, 185, 199, 161, 171, 72, 248, 145, 171, 234, 229, 198, 143, 249, 150, 208, 192,
          101, 40, 1, 222, 48, 32, 141, 71, 248, 170, 15, 243, 33, 104, 188, 132, 99, 188, 38, 14,
          192>>,
        <<0, 248, 76, 160, 170, 215, 62, 129, 97, 227, 37, 43, 0, 108, 241, 82, 102, 173, 13, 224,
          105, 153, 120, 212, 197, 252, 37, 191, 28, 14, 40, 134, 120, 124, 156, 31, 131, 126, 98,
          173, 160, 130, 185, 199, 161, 171, 72, 248, 145, 171, 234, 229, 198, 143, 249, 150, 208,
          192, 101, 40, 1, 222, 48, 32, 141, 71, 248, 170, 15, 243, 33, 104, 188, 132, 99, 188,
          38, 16, 192>>,
        <<0, 248, 76, 160, 161, 188, 22, 239, 206, 124, 7, 197, 110, 27, 126, 249, 65, 55, 147,
          138, 202, 9, 4, 57, 201, 233, 77, 123, 107, 174, 158, 248, 188, 188, 136, 84, 131, 126,
          98, 173, 160, 130, 185, 199, 161, 171, 72, 248, 145, 171, 234, 229, 198, 143, 249, 150,
          208, 192, 101, 40, 1, 222, 48, 32, 141, 71, 248, 170, 15, 243, 33, 104, 188, 132, 99,
          188, 38, 18, 192>>,
        <<0, 248, 76, 160, 211, 226, 82, 12, 8, 135, 55, 15, 213, 142, 214, 147, 170, 138, 214,
          123, 227, 3, 93, 201, 217, 57, 129, 108, 122, 184, 57, 64, 92, 81, 58, 106, 131, 126,
          98, 173, 160, 130, 185, 199, 161, 171, 72, 248, 145, 171, 234, 229, 198, 143, 249, 150,
          208, 192, 101, 40, 1, 222, 48, 32, 141, 71, 248, 170, 15, 243, 33, 104, 188, 132, 99,
          188, 38, 20, 192>>,
        <<0, 248, 76, 160, 33, 182, 129, 95, 250, 150, 54, 248, 120, 38, 190, 8, 51, 91, 65, 234,
          102, 124, 30, 153, 75, 74, 89, 125, 252, 130, 195, 141, 99, 59, 108, 40, 131, 126, 98,
          173, 160, 130, 185, 199, 161, 171, 72, 248, 145, 171, 234, 229, 198, 143, 249, 150, 208,
          192, 101, 40, 1, 222, 48, 32, 141, 71, 248, 170, 15, 243, 33, 104, 188, 132, 99, 188,
          38, 22, 192>>,
        <<0, 248, 76, 160, 17, 28, 56, 201, 24, 252, 51, 27, 247, 27, 54, 162, 75, 183, 18, 86,
          192, 34, 33, 158, 75, 80, 130, 160, 247, 22, 106, 64, 174, 21, 129, 106, 131, 126, 98,
          174, 160, 135, 78, 135, 44, 78, 95, 42, 61, 102, 226, 20, 237, 48, 34, 138, 154, 202,
          242, 70, 179, 99, 168, 160, 91, 18, 61, 35, 26, 194, 95, 129, 150, 132, 99, 188, 38, 24,
          192>>,
        <<0, 248, 76, 160, 163, 221, 27, 223, 31, 117, 40, 83, 242, 7, 109, 157, 231, 132, 194,
          214, 198, 47, 91, 87, 196, 56, 55, 7, 1, 78, 38, 17, 23, 39, 135, 90, 131, 126, 98, 174,
          160, 135, 78, 135, 44, 78, 95, 42, 61, 102, 226, 20, 237, 48, 34, 138, 154, 202, 242,
          70, 179, 99, 168, 160, 91, 18, 61, 35, 26, 194, 95, 129, 150, 132, 99, 188, 38, 26,
          192>>,
        <<0, 248, 76, 160, 223, 153, 34, 112, 205, 231, 17, 142, 224, 61, 161, 217, 126, 73, 187,
          60, 187, 66, 255, 253, 160, 144, 60, 134, 17, 187, 131, 169, 26, 18, 102, 53, 131, 126,
          98, 174, 160, 135, 78, 135, 44, 78, 95, 42, 61, 102, 226, 20, 237, 48, 34, 138, 154,
          202, 242, 70, 179, 99, 168, 160, 91, 18, 61, 35, 26, 194, 95, 129, 150, 132, 99, 188,
          38, 28, 192>>
      ]

      Enum.reduce(expected_items, input, fn item, current_input ->
        assert {^item, remaining_input} = Decode.decode(current_input, stream: true)

        remaining_input
      end)
    end
  end
end
