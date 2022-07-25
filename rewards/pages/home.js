import {
  useAddress,
  useDisconnect,
  useEditionDrop,
  useOwnedNFTs,
} from "@thirdweb-dev/react";
import { useRouter } from "next/router";
import { useEffect, useState } from "react";
import useSWR from "swr";

const fetcher = (...args) => fetch(...args).then((res) => res.json());

const Home = () => {
  const contract = "0x396bd3C2986975f8bfec4EAa6290f0839164292a";

  const prices = [0, 10, 30];

  const enable =
    "bg-black text-white m-2 px-6 py-1 text-3xl rounded-full w-full";
  const disabled =
    "bg-gray-500 text-white m-2 px-6 py-1 text-3xl rounded-full opacity-50 cursor-not-allowed w-full";

  const address = useAddress();
  const router = useRouter();
  const disconnect = useDisconnect();
  const token = useEditionDrop(contract);
  const { data: ownedNFTs, isLoading } = useOwnedNFTs(token, address);

  const [nfts, setNfts] = useState(null);

  const getNFTs = async () => {
    const res = await token.getAll();
    setNfts(res);
  };

  useEffect(() => {
    if (!address) {
      router.push("/");
    }

    getNFTs();
  });

  const ip = useSWR("https://ipapi.co/json", fetcher);

  const { data } = useSWR(
    `https://smogify.up.railway.app/user/${ip?.data?.ip}`,
    fetcher,
    {
      refreshInterval: 2,
    }
  );

  const mintFirstNFT = (id) => {
    try {
      token.claim(id, 1);
    } catch (e) {
      console.error(e.message);
    }
  };

  if (!data || isLoading || !nfts) {
    return (
      <div className="flex h-full">
        <div className="m-auto">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-gray-900" />
        </div>
      </div>
    );
  }

  const count = data?.reports.length;

  return (
    <main className="flex flex-col items-center justify-between min-h-full">
      <div>
        <h1 className="text-center mt-14 mb-4 text-5xl">
          <b>Hello, </b>
          {data?.name}
        </h1>
        <p className="text-center text-xl">
          You have recorded <b>{`${count} seconds`}</b>
        </p>
      </div>
      <div>
        {ownedNFTs.length > 0 ? (
          <section className="flex flex-col justify-between items-center min-h-full">
            {nfts.map((nft, k) => (
              <div
                key={k}
                className="border p-2 w-5/6 m-2 rounded-xl shadow-md flex flex-col items-center"
              >
                <div className="flex">
                  <img
                    className="h-24 rounded-xl shadow-md"
                    src={nft.metadata.image}
                  />
                  <div>
                    <h2 className="text-3xl font-bold ml-4">
                      {nft.metadata.name}
                    </h2>
                    <p className="text-2xl ml-4">{nft.metadata.description}</p>
                  </div>
                </div>
                <button
                  className={
                    ownedNFTs[k]
                      ? disabled
                      : prices[k] <= count
                      ? enable
                      : disabled
                  }
                  onClick={() => {
                    if (!ownedNFTs[k] && prices[k] <= count) {
                      mintFirstNFT(k);
                    }
                  }}
                >
                  {ownedNFTs[k]
                    ? "Claimed!"
                    : prices[k] <= count
                    ? "Claim"
                    : "Start recording"}
                </button>
              </div>
            ))}
          </section>
        ) : (
          <div className="flex flex-col items-center border m-2 p-4 rounded-xl mt-4 shadow-2xl">
            <h2 className="text-4xl text-center font-bold">
              Thank you for registering!
            </h2>
            <p className="text-center mx-4 text-xl mt-6">
              Don't worry, this can take some minutes, while you wait, start
              scanning
            </p>
            <button
              className="bg-black text-white m-6 px-6 py-1 text-3xl rounded-full"
              onClick={() => mintFirstNFT(0)}
            >
              Get your first reward
            </button>
          </div>
        )}
      </div>
      <div className="flex flex-col items-center mb-8">
        <button
          className="bg-black text-white m-6 px-6 py-1 text-3xl rounded-full"
          onClick={disconnect}
        >
          disconnect
        </button>
        <p className="text-center">{`Your address: ${address}`}</p>
      </div>
    </main>
  );
};

export default Home;
