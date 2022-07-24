import { useAddress, useMagic } from "@thirdweb-dev/react";
import { useState, useEffect } from "react";
import useSWR from "swr";
import { useRouter } from "next/router";

const fetcher = (...args) => fetch(...args).then((res) => res.json());

const App = () => {
  const fetchIp = useSWR("https://ipapi.co/json", fetcher);

  const router = useRouter();

  const connect = useMagic();
  const address = useAddress();

  const [email, setEmail] = useState("");
  const [name, setName] = useState("");

  const handleSubmit = async () => {
    const { data } = fetchIp;

    const response = await fetch("http://localhost:8080/user", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        name,
        uuid: data?.ip,
      }),
    });

    if (response.ok) {
      connect({ email });
    }
  };

  useEffect(() => {
    if (address) {
      router.push("/home");
    }
  });

  return (
    <main className="flex flex-col items-center justify-evenly min-h-full">
      <h1 className="text-6xl text-center">Welcome!</h1>
      <p className="text-2xl text-center mx-6 -mt-20">
        We generate a wallet for you using your email
      </p>
      <div className="flex flex-col items-center">
        <input
          className="mt-4 border-2 border-gray-600 rounded-lg p-2 w-full text-2xl"
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="Name"
        />
        <input
          className="mt-4 border-2 border-gray-600 rounded-lg p-2 w-full text-2xl"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          type="email"
          placeholder="Email"
        />
        <button
          className="bg-black text-white m-6 px-6 py-1 text-3xl rounded-full"
          onClick={handleSubmit}
        >
          Connect
        </button>
      </div>
    </main>
  );
};

export default App;
