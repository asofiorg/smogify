<div align="center">

# Smogify

**_Detecting smog using ML and rewarding users with NFTs_**

</div>

<div align="center">

![](https://img.shields.io/badge/Contributions-Welcome-brightgreen.svg)
![](https://img.shields.io/badge/Maintained%3F-Yes-brightgreen.svg)

</div>

## About The Project

![Smogify](https://github.com/asofiorg/smogify/raw/main/assets/mockup.png)

app in action: https://youtu.be/awJrP-sHb_I

Under the growing uncertainty of climate change, and the threat it poses to the health of
millions of people around the world exposed to the toxic levels of air pollution, _Smogify_ is a
mobile app powered by computer vision able to identify the pollution level of public routes
based on overlaid data consisting of the visible emissions from every individual actor in traffic.
Therefore, Smogify provides an insight into the distribution of pollution within an urban
community.

In order to calculate the visible emissions, the computer vision software is fed with data from video through crowdsourcing. This service is oriented on applying Artificial Intelligence to combat climate change by tracing pollution levels in the most contaminated areas due to transportation. Given the intersection between the climate crisis and other fields, _Smogify_ yields a wide range of benefits, including improving public health in areas affected by high levels of pollution, and even adding a novel criterion for finding the best route an Uber can take to be more environmentally friendly, get additional input over potential traffic congestion and avoid potential health threats.

### The problem that needs to be solved.

In Colombia, every car must undergo a technical inspection periodically to check for excess emissions and to repair the car if necessary. However diligent this inspection might be, we have been stuck behind a public-transport bus, bewildered by its pitch-black smog way too many times not to question: “is this even allowed?” – it is not. What is going wrong, then?

As per _Superfreakonomics_, 1 out of every 140 miles driven are driven drunk. Likewise, “There is just one arrest for every 27,000 miles driven while drunk.” This data, although from the United States, pertains to a great degree to our question: why are these deprecated vehicles still circulating? Perhaps, they are simply not being asked for their inspection certificates. After all, in Colombia, we sport not only one license plate, but two, and officers should be able to check for the revision of suspicious vehicles in an instant. The problem is how we identify a vehicle as suspicious. The human eye clearly doesn’t work for identifying drunk drivers, and we believe it doesn’t work for identifying polluting cars either. The smog is visible, but we have grown accustomed to it: currently, our only objective measure for our cars’ condition is the inspection. We want to add another objective measure with the help of AI. We want to identify the smog of every individual actor in traffic through crowdsourcing and overlay the data in GPS systems. Identifying a polluting car will draw a yellow trail for as long as the user’s camera and the polluting car stay in the same route. This yellow data should get overlaid for every polluting car, getting darker as they get stacked on top of each other. This way we get an estimate of the overall pollution in a given route.

We believe we are very repetitive in the routes we take: we go to school, to our friend’s house, or to the supermarket most of the time. Public transport buses follow the same route everyday and so do cargo trucks. Thus, the routes people take tell a story about their routine, and also about their car.

Cars that frequently go through polluted regions are likely polluting themselves.

Collecting this data can be extremely valuable because it provides statistically-prone pools to check for polluting cars. We believe it can also be highly valuable to public-health officials in identifying urban areas that suffer from vehicle contamination. Last but not least, we can add a layer of intelligence to GPS software: our goal shouldn’t just be to arrive in the shortest time possible, perhaps we want to avoid cancerogenous gasses as well.

[Read more](https://github.com/asofiorg/smogify/raw/main/assets/whitepaper.pdf)

<p align="right"><a href="#top">Back to top 🔼</a></p>

## Getting Started

### AI Model

Go to the AI folder in `/ai` and run the notebook.

### Swift App

Go to the Swift app folder in `/ios` and open it in Xcode.

### API

Install the dependencies:

```sh
$ cd api && yarn
```

Add environment variables:

```sh
cd api
touch .env

# Add your postgres connection url

echo "DB=**YOUR_URL**" >> ".env"
```

Run in dev mode with nodemon:

```sh
$ cd api && yarn dev
```

Start the server:

```sh
$ cd api && yarn start
```

### Rewards module

Install the dependencies:

```sh
$ cd rewards && yarn
```

Run in dev mode:

```sh
$ cd rewards && yarn dev
```

Make a build:

```sh
$ cd rewards && yarn build
```

Start the server:

```sh
$ cd rewards && yarn start
```

### Built With

- [Swift](https://swift.org/)
- [Python](https://www.python.org/)
- [Javascript](https://nodejs.org/)
- [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- [Tensorflow](https://www.tensorflow.org/)
- [CoreML](https://developer.apple.com/documentation/coreml)
- [Postgres](https://www.postgresql.org/)
- [Express](https://expressjs.com/)
- [Prisma](https://www.prisma.io/)
- [Swagger](https://swagger.io/)
- [React](https://reactjs.org)
- [Next.js](https://nextjs.org)
- [Magic link](https://magic.link)
- [Thirdweb](https://thirdweb.com)

<p align="right"><a href="#top">Back to top 🔼</a></p>

## Contributing

Contributions are what make the Open Source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a Pull Request. You can also simply [open an issue](https://github.com/asofiorg/smogify/issues) with the tag _enhancement_.

Don't forget to **give the project a star ⭐!** Thanks again!

1. Fork the project

2. Clone the repository

```bash
git clone https://github.com/@username/smogify
```

3. Create your Feature Branch

```bash
git checkout -b feature/AmazingFeature
```

4. Push to the Branch

```bash
git push origin feature/AmazingFeature
```

5. Open a Pull Request

<p align="right"><a href="#top">Back to top 🔼</a></p>

## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right"><a href="#top">Back to top 🔼</a></p>

## Contact 📭

**Juan Almanza @scidroid**
[@scidroid](https://scidroid.co/) - scidroid@scidroid.co

**Laura Gomezjurado @lauragomezjurado**
[@lauragomezjurado](https://github.com/lauragomezjurado) - laura.gomezjurado1@gmail.com

**Antonio Llano @llanoajm**
[@llanoajm](https://github.com/llanoajm) - llanoajm@gmail.com

<p align="right"><a href="#top">Back to top 🔼</a></p>
