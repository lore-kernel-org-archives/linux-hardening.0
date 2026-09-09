Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0137C925;
	Wed,  9 Sep 2026 05:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932606; cv=none; b=OgQ+XjSnibC4OTkVt0YEShJirQV59mu/msApls132O56/XxQq2d7wZpZZr339ALRYK1bz0STUqmqZj92X3Diauxatejyp2NMGTn+t+sAjKJ6dbD5b/lG/Dh/3cQs0n6Zr3ycKWfstp/HkW6FD6N/54432avszpjK3GtsuvtRewE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932606; c=relaxed/simple;
	bh=o9nfCsYTxltVXYrwVbThce5LgyXRCN2/HfeCSJ8Gqss=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UIWUbJ3kw8Srj8znKOKgKH2CCmQTOzs0BbGZb0nKxOMaWtcWep7aGobHcZojwHLx0KNkdWnIt4yMn/ujgE0CvxPmJ3FaVqsUdB8YgMtU9+V7RHBZidblKbnpDhdHZhLqOQCrttVZuTJjXF/qYlLTVOwd2ElEVpOA6Jep4sKkJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot99fC05; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot99fC05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E9F1F00A3E;
	Wed,  9 Sep 2026 05:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932603;
	bh=gJIIfiOg3rJBLekyVRMXgTE4NaaPV1aUzOz9ZlrpZ5w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ot99fC0580vD6KsTdPX0Qdey9+2nAhvH2Sm9ZowKMXATWO9cRLqYOrFnE4zercrsS
	 0oZK4fWn3xWTmRmGF2xedwUnxaZwoNKZRP55zhNGZttQHNiB1V6PMBAJWuSIEUPmPh
	 WuEjg4cH1c+qBpgJmWz+VOE5dlbFyWRSS0Yt205h/YI8Yn9NZ/YN/v+bN+UJf+fzfB
	 R6aVODOYZjOmvz5Cd3u0nrPOgQiBVZAoTMuwzmVrHLLoqhWzmh0wQ6u5VDSl98fLLo
	 ojwfqk3sZQNDTNmWl6Vzish1DF1Fh73co/3GiFKtVWuRSqRnBd+qB40JvSgO5VwyFR
	 fxRxBYH8rEsHw==
Subject: Re: [PATCH net-next v2 4/7] net: mctp: usblib: Complete rx tests
From: netdev-bot+sashiko@kernel.org
To: james@codeconstruct.com.au
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Wed, 09 Sep 2026 05:43:22 +0000
Message-ID: <178893260269.219967.9773942785698590386@kernel.org>
In-Reply-To:
 <20260903-dev-mctp-usb-lib-test-v2-4-313cf15e0b56@codeconstruct.com.au>
References:
 <20260903-dev-mctp-usb-lib-test-v2-4-313cf15e0b56@codeconstruct.com.au>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] In mctp_usblib_test_rx_split_header() (drivers/net/mctp/mctp-
  usblib-test.c:436) an skb dequeued from dev->rx_pkts is released with…

--

net: mctp: usblib: Complete rx tests

This adds two KUnit cases to the mctp-usblib test suite exercising the
non-spanning receive path: a packet shorter than the minimum header length,
and a packet whose declared payload length is not satisfied by a single
submission. Both new cases are registered in mctp_usblib_test_cases[].

> diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
> index b0266be79e94..22aaa4795cbd 100644
> --- a/drivers/net/mctp/mctp-usblib-test.c
> +++ b/drivers/net/mctp/mctp-usblib-test.c

[ ... ]

> @@ -533,6 +593,8 @@ static struct kunit_case mctp_usblib_test_cases[] = {
>  	KUNIT_CASE(mctp_usblib_test_rx_header_splits),
              ^^^^

[Severity: Medium]
While looking at the suite that these two new cases join, is the skb
release in mctp_usblib_test_rx_split_header() correct?  That helper is not
touched by this patch (it comes from the earlier "Add test for splits
inside headers" change in the same series), but it is the only skb release
site in this file that does not use the skbuff API:

drivers/net/mctp/mctp-usblib-test.c:mctp_usblib_test_rx_split_header() {
	...
	skb = __skb_dequeue(&dev->rx_pkts);
	KUNIT_EXPECT_NOT_NULL(test, skb);
	if (skb) {
		KUNIT_EXPECT_EQ(test, skb->len, len - HDR_LEN);
		kfree(skb);
	}
}

Does this leak skb->head?  kfree() returns only the sk_buff head object to
its cache and never runs skb_release_all()/skb_release_data(), so the
separately allocated data buffer is never freed.

In span mode mctp_usblib_rx_prepare() sizes that buffer as
roundup(MCTP_USB_1_1_PKTLEN_MAX, ep_pktlen), i.e. 8192 bytes, and
mctp_usblib_test_rx_header_splits() calls the helper eight times, so a
single run of the suite would leak roughly 64 KB and likely trip kmemleak
in CI.  The other release sites in the same file use kfree_skb(), and
mctp_usblib_test_dev_action() uses skb_queue_purge().

Would kfree_skb(skb) be the right call here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-dev-mctp-usb-lib-test-v2-0-313cf15e0b56%40codeconstruct.com.au
