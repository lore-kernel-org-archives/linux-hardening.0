Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255B377A8C;
	Thu,  3 Sep 2026 02:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788403374; cv=none; b=q10XqVd3WLUyYAae9C1utZGg5vuU0+V3HYQgw7yyRkn+QpAkRevbiggp+x3B3HCkUdepPn2UXrAYucet2D/OgSkZ3Swg0xyMK9mZPseNQShh30H/cM9EHbLg8dqV6SJ84k9M3AUjrni8Llh/UzVawmLPjuYB6aRFuL29FePU0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788403374; c=relaxed/simple;
	bh=rOFunRHFKWI5h6ur/4rVmZMP1w6CoMS/2GbTmoqrM8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAvi1wdeUqFm1OpVeNn+AZtqzx+Q+wU6RCYmPtc4Ybi8MCesa0mDjEvqgB2DiJ3V67lFRCvBqyf03zQHDgCnyRtLhzNzgCA2UTzWPbfQbn8KbwBZNe/ZH0/SRBiavD3a2WJaHb2FLFIhKVegQfjzmrm13yPmKrfEtf7erSHtb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=UUl36rYV; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="UUl36rYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788403360;
	bh=aazRtG4rLctFxMuy96ogLq9723zz+Ybi5VOk8UWTfPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UUl36rYVxov/4LQF06r2p/lHZ2IcZPW3XL6CdoSm5n7wqFbJh1rzBdWNXEkJjGIas
	 TT82Yovcfs2c6tUMPmRdLBfVK+UZ3LufNaNnWaQtBP+tyYgsAh4wsYRaJL+Vczl94L
	 6OCu9HY/NFOpwqhN4x7Lk/+81IOm1OB7owyafbKJsYMJEx5Hg806H9vB2YOrV9i+rB
	 A+cKeSiljCYs9BdWWDJN4Exsm0o3k9Bt+04BB75OrW31CIQAnmxooWPZzF1yHQ/ct2
	 Bcbsk2gJ7HzDAknrSxmk//pGtMUphC6CefS/Q/MjWzeRVcbDWjRBYw4ZEXXWbLO8iq
	 5am41GYVIM+pA==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 9339A68695; Thu,  3 Sep 2026 10:42:40 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Thu, 03 Sep 2026 10:42:22 +0800
Subject: [PATCH net-next v2 5/7] net: mctp: usblib: Simplify allocation
 logic in mctp_usblib_test_rx_init
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-dev-mctp-usb-lib-test-v2-5-313cf15e0b56@codeconstruct.com.au>
References: <20260903-dev-mctp-usb-lib-test-v2-0-313cf15e0b56@codeconstruct.com.au>
In-Reply-To: <20260903-dev-mctp-usb-lib-test-v2-0-313cf15e0b56@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, James Lee <james@codeconstruct.com.au>
X-Mailer: b4 0.14.2

The if statement testing rx's allocation is unneeded.

Signed-off-by: James Lee <james@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usblib-test.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index 22aaa4795cbdd13432a3c1e7cc85ecbb3a30fe88..64c758013854c697767d3cc80d46ebaa310188a4 100644
--- a/drivers/net/mctp/mctp-usblib-test.c
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -202,11 +202,9 @@ mctp_usblib_test_rx_init(struct kunit *test, bool span)
 	int rc;
 
 	rx = kzalloc_obj(*rx);
-	if (rx) {
-		rc = kunit_add_action_or_reset(test, action_rx_fini, rx);
-		KUNIT_ASSERT_EQ(test, rc, 0);
-	}
 	KUNIT_ASSERT_NOT_NULL(test, rx);
+	rc = kunit_add_action_or_reset(test, action_rx_fini, rx);
+	KUNIT_ASSERT_EQ(test, rc, 0);
 
 	rc = mctp_usblib_rx_init(rx, ep_maxpacket, span);
 	KUNIT_ASSERT_EQ(test, rc, 0);

-- 
2.47.3

