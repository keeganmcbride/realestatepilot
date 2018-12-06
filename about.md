# Innovation in Real Estate - Fighting Information Asymmetry in the Estonian Real Estate Market

This application has been developed as part of the Horizon2020 Funded [OpenGovIntelligence](http://www.opengovintelligence.eu) Project. This pilot application has been developed by Tallinn University of Technology's [Ragnar Nurkse Department of Innovation and Governance](https://www.ttu.ee/institutes/ragnar-nurkse-department-of-innovation-and-governance) in cooperation with Estonia's [Ministry of Economic Affairs and Communications](https://www.mkm.ee/en). The purpose of this pilot program is to fight information asymmetry in the real estate market and provide an easy way to access real estate data. The pilot is intended to give real estate agents, property developers, investors, and those involved in the real estate market (buyers, sellers, renters, students, new arrivals etc.) a deeper knowledge of the marketplace.



This application was built using multiple different sources of Open Government Data. In Estonia, the [Open Government Data portal](opendata.riik.ee) contains many datasets that were used for developing this application. The datasets that were used and where you can find them are listed below:
* Crime data (https://opendata.riik.ee/andmehulgad/?organization=politsei-ja-piirivalveamet-ppa) and (https://www2.politsei.ee/et/organisatsioon/analuus-ja-statistika/avaandmed.dot)
* School locations (https://info.haridus.ee/Asutused/Kool)
* Test scores (https://www.haridussilm.ee/)
* Real Estate Prices (http://www.maaamet.ee/kinnisvara/htraru/)
* Sports Facilities (http://statistika.tallinn.ee/index.php)
* Traffic safety (Data provided from Eesti Liikluskindlustuse Fond for 2013-2016)
* Child Playgrounds and Dog Parks (https://www.manguvaljakud.tallinn.ee)
* Building information (http://opendata.mkm.ee/ehr/)

For questions and more information, please contact tarmo.kalvet@taltech.ee or keegan.mcbride@taltech.ee

### Credits

R Packages Used
* [Shiny](https://cran.r-project.org/web/packages/shiny/)
* [GGMap](https://cran.r-project.org/web/packages/ggmap/index.html)
* [Leaflet](https://cran.r-project.org/web/packages/leaflet/)
* [Esquisse](https://github.com/dreamRs/esquisse)
* [Dplyr](https://cran.r-project.org/web/packages/dplyr/index.html)

Some code used within this service was first written by [@TraffordDataLab](https://github.com/traffordDataLab/projects/tree/master/opengovintelligence) and [@Annegretepeek](https://github.com/annegretepeek). The application [Kuritegevu Eestis](https://github.com/andmeteadus/2018/blob/gh-pages/Rakendused/KuritegevusEestis/app_KuritegevusEestis.R) also provided some inspiration.

------


<div class='svg_holder' style="float: left; margin-right: 12px;">
  <svg width="81" height="54">
  	<desc>European flag</desc>
  	<g transform="scale(0.1)">
  	<defs><g id="s"><g id="c"><path id="t" d="M0,0v1h0.5z" transform="translate(0,-1)rotate(18)"/><use xlink:href="#t" transform="scale(-1,1)"/></g><g id="a"><use xlink:href="#c" transform="rotate(72)"/><use xlink:href="#c" transform="rotate(144)"/></g><use xlink:href="#a" transform="scale(-1,1)"/></g></defs>
  	<rect fill="#039" width="810" height="540"/><g fill="#fc0" transform="scale(30)translate(13.5,9)"><use xlink:href="#s" y="-6"/><use xlink:href="#s" y="6"/><g id="l"><use xlink:href="#s" x="-6"/><use xlink:href="#s" transform="rotate(150)translate(0,6)rotate(66)"/><use xlink:href="#s" transform="rotate(120)translate(0,6)rotate(24)"/><use xlink:href="#s" transform="rotate(60)translate(0,6)rotate(12)"/><use xlink:href="#s" transform="rotate(30)translate(0,6)rotate(42)"/></g><use xlink:href="#l" transform="scale(-1,1)"/></g></g>
  </svg>
</div>
<p>This project has received funding from the European Union’s Horizon 2020 research and innovation programme under grant agreement No 693849.</p>
