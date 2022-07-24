import { ChainId, ThirdwebProvider } from "@thirdweb-dev/react";

import "../styles/global.css";

const App = ({ Component, pageProps }) => {
  return (
    <ThirdwebProvider
      desiredChainId={ChainId.Goerli}
      walletConnectors={[
        {
          name: "magic",
          options: {
            apiKey: "pk_live_22F92AC44726E6DA",
          },
        },
      ]}
    >
      <div className="flex items-center justify-center min-h-screen">
        <div className="max">
          <Component {...pageProps} />
        </div>
      </div>
    </ThirdwebProvider>
  );
};

export default App;
