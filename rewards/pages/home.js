import {
  useAddress,
  useDisconnect,
  useEditionDrop,
  useOwnedNFTs,
} from "@thirdweb-dev/react";
import { useRouter } from "next/router";
import { useEffect } from "react";
import useSWR from "swr";
import toast, { Toaster } from "react-hot-toast";

const fetcher = (...args) => fetch(...args).then((res) => res.json());

const Home = () => {
  const contracts = [
    "0x4731Ba26a3bB52789d8a3273249ba0232aE11979",
    "0x025C278C573100A751352f2Bf813381389375881",
    "0x396bd3C2986975f8bfec4EAa6290f0839164292a",
  ];

  const address = useAddress();
  const router = useRouter();
  const disconnect = useDisconnect();

  const ip = useSWR("https://ipapi.co/json", fetcher);

  const { data } = useSWR(
    `http://localhost:8080/user/${ip?.data?.ip}`,
    fetcher
  );

  useEffect(() => {
    if (!address) {
      router.push("/");
    }
  });

  const token = useEditionDrop(contracts[0]);
  const { data: ownedNFTs, isLoading } = useOwnedNFTs(token, address);

  const mintFirstNFT = () => {
    try {
      token.claim(0, 1);
    } catch (e) {
      console.error(e.message);
    }
  };

  if (!data || isLoading) {
    return <div>Loading...</div>;
  }

  return (
    <>
      <h1 className="ml-8 mt-12 text-5xl">
        <b>Hello, </b>
        {data?.name}
      </h1>
      <p className="ml-8 mt-4 text-xl">
        You have recorded <b>{`${data?.reports.length} seconds`}</b>
      </p>
      {ownedNFTs.length > 0 ? (
        <h1>{ownedNFTs[0].metadata.name}</h1>
      ) : (
        <>
          <button
            className="bg-black text-white m-6 px-6 py-1 text-3xl rounded-full"
            onClick={mintFirstNFT}
          >
            Get your first reward
          </button>
        </>
      )}
      <button
        className="bg-black text-white m-6 px-6 py-1 text-3xl rounded-full"
        onClick={disconnect}
      >
        disconnect
      </button>
      <p>{`Your address: ${address}`}</p>
      <Toaster />
    </>
  );
};

export default Home;
