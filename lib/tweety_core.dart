import 'package:puppeteer/puppeteer.dart';
import 'package:puppeteer/src/devices.dart';

/// TweetyCore provides access to puppeteer apis and
class TweetyCore {
  /// A puppeteer [Browser] instance.
  late Browser browser;

  /// A puppeteer [Page] instance.
  late Page page;

  Future<void> initialize() async {
    browser = await puppeteer.launch(headless: true);
    page = await browser.newPage();

    // Setup the dimensions and user-agent of a particular device
    await page.emulate(devices.laptopWithHiDPIScreen);
    await page.setUserAgent(
      'Mozilla/5.0 (Macintosh; '
      'Intel Mac OS X 10_15_7) '
      'AppleWebKit/537.36 (KHTML, like Gecko) '
      'Chrome/95.0.4638.69'
      'Safari/537.36',
    );
  }

  /// Close puppeteer browser window
  Future<void> closeBrowser() async => browser.close();

  /// Navigate to a  `url`
  Future<Response> goto(String url) {
    return page.goto(
      url,
      wait: Until.networkIdle,
    );
  }

  /// Grabs a screenshot of a twitter post and return the bytes
  Future<List<int>> screenshotTweet() async {
    final tweet = await page.$('article');
    return tweet.screenshot();
  }

  /// Grabs the tweet content of a tweet
  Future<T?> getTweetText<T>() async {
    final tweet = await page.$('article div[lang]');
    return tweet.$$eval(
      'article div[lang]',
      '(tweets) => tweets.map((tweet) => tweet.textContent)',
    );
  }
}
