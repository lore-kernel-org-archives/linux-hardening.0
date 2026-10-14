Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2ED4964F;
	Wed, 14 Oct 2026 04:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791953278; cv=none; b=X/x2qGaZB6WUBkBopsPRMbTRYEEMbFLtFKN3CHgmet3qRL9j577ixBMP9KtEBcpQ4CW2XZ+riLrNPw4GDESWIwfYeDsKcsVi5c3YjOdG/U5KhwAkMxXbCnhklB19qJeYy6Tr4IgYtF8jEWOgiKMrZX/nWJyZAcdobJGpW7y+djs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791953278; c=relaxed/simple;
	bh=T2zwEOSKeJVPvjSKm2GKFRJuXwoncrPadWyEQ19not8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KcHaIhyoZJqaEXJyWe2zjlXS4R9NnN0JZKvSf6Fxnlkba6zIVSgZV3v8Urv3lfmHYLjFqEmUTdQuJd6kY1awco+hAz4zYNU51ZFW9tnvTuGxk9jfdOlH8Blv2vbGoQBPJ1eSdXyMmpMPxsQxMMQI81zMygD09FefrF8sm85EgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bHzVEkJo; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bHzVEkJo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1791953275;
	bh=PbFhoF6jYTVQDww2xy+ijFIf+3flRX07CkM/MkYCtcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bHzVEkJovDKrDCS2/sbEM5qk9Oso1W7pAkzVDG+FFfVCiq9DUBtONplQT3G4qzQok
	 DxCmQGmDLj9yJ94q7V8NqkkMN3rnwHf7VDuvpwkP6O8HIWP1cbySV7GdASuFQZ32Db
	 4hyi6OK8UgypSPHHhYT3y8JiAH7iwg22hx0XIfD/Nvsv2xKrL8baF+MTgbQ8Mpx1gN
	 IYhGbfVjd3cPlJdXnGMOpaoQ0lsYXMbTyWmLV/ODZllbMUBF3QesdOGIO8Kf8slGLP
	 wwQ68ryEvnZUGi1bt1nILTV6y+pUHJINKXq7spcm6fFF8ucTE9uOzVJy09u72dm6Qn
	 68rgCJ8rvZvfQ==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 52D406FD50; Wed, 14 Oct 2026 12:47:55 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Wed, 14 Oct 2026 12:47:31 +0800
Subject: [PATCH net-next v3 1/7] net: mctp: usblib: Add to parameterized
 kunit tests.
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-dev-mctp-usb-lib-test-v3-1-ee5bc3ea1db1@codeconstruct.com.au>
References: <20261014-dev-mctp-usb-lib-test-v3-0-ee5bc3ea1db1@codeconstruct.com.au>
In-Reply-To: <20261014-dev-mctp-usb-lib-test-v3-0-ee5bc3ea1db1@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, James Lee <james@codeconstruct.com.au>
X-Mailer: b4 0.14.2

Add parameterized tests to cover worst case scenarios for packet
splitting and length.

Signed-off-by: James Lee <james@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usblib-test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index 9df401a914ff537207911f03bd08f32b5a5e20d1..4c27307900fb6116572bc9d89f3def6f06c30397 100644
--- a/drivers/net/mctp/mctp-usblib-test.c
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -386,12 +386,18 @@ static const struct mctp_usblib_test_pkt_span mctp_usblib_test_pkt_spans[] = {
 	{ "1p2x-split-mctphdr", 1, { 16 }, 2, { 6, 10 } },
 	/* Single packet split over 3 transfers, middle entirely continuation */
 	{ "1p3x-split", 1, { 12 }, 3, { 4, 4, 4 } },
+	/* A packet split over 5 transfers, splitting on and between each header. */
+	{ "1p5x-split", 1, { 12 }, 5, { 3, 1, 1, 3, 4}},
 	/* Max-sized single transfer */
 	{ "1p1x-large", 1, { 8191 }, 1, { 8191 } },
 	/* Two large packets, split at the worst-case for allocation, with a
 	 * single byte continuing the span
 	 */
-	{ "2p2x-large-split", 2, { 8190, 8190 }, 2, { 8191, 8189 } },
+	{ "2p2x-large-split", 2, { 8190, 8191 }, 2, { 8191, 8190 } },
+	/* Three large packets, split at the worst-case for allocation,
+	 * with a single byte continuing each span
+	 */
+	{ "3p3x-large-split", 3, { 8190, 8191, 8191 }, 3, { 8191, 8191, 8190 } },
 };
 
 KUNIT_ARRAY_PARAM(mctp_usblib_test_rx_pkt_span, mctp_usblib_test_pkt_spans,

-- 
2.47.3

