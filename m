Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6C35AC33;
	Mon, 31 Aug 2026 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788147888; cv=none; b=tjln2ONfVGffok7dNllf9My3a3mjkGe0B/G80r3/cAgspxXXnsLY18DPuiuDqJjbjrGhI+UoHw46R/2CXh4Hw4Xd1J6GEZy/aVWtcr+MvdoZNWjLaciZLtCK+N5CoA+VLoFpQ3KXKyRhF4NWeKhLXEcyhAqNhYAvqgA2kko8kBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788147888; c=relaxed/simple;
	bh=V72aHCmF4b7VfASa0RriukX8iwwBYX/nI2WEc7fM5oI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHtZUanWeM+BwF++hCFCT4HIGCYN+nxMOrppTc7If+BoojBuBspAsYYjwozW7rsDcBi6UyRvlOdXaJ20sDM38q4/XBs42bgtQGbvB6GIAJ0d9BXCYne5hn9ELyPLxoBwJdDEZjDxdVnN3/8/8LVB7k90QoFcVJFD8fl9LVmnTEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=M3T2hIth; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="M3T2hIth"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788147871;
	bh=tcBolFJ4EIF2q/e/NdkFEkTsXlaM1Jg3zKGnjeS3tug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=M3T2hIthfByLiB53LvXYC1lLRJ9iwPqGavMIuY/iRqEuVRNCxkNJDRSbqfqlosVkr
	 yl0sGf/rcW8X1q3cY6M4ObHO1nY+mkXjSZBFyg3qIm/V/UtTFB7nG7ucSqNY7ad9iw
	 69PLZc4E4NDvOKLCCIHd1sau2tpgbvSV98H7JppBH0vRECNXW59faZDQq1JXCGZ+An
	 Wvmyk7MBTPk3kXC6Nd3HM8eGsI5yaOWR/HHz5VNRuKvq4oaZ+oSkNyF6bfRvWoDWFu
	 U9Fm7Yg2YX9Gbn/k4T7WlOR1+ghJRdP+17bKP+DkSCyFIDVm/CHn3vkvuBrxwzFsxH
	 Zwa1nmrTxjOFQ==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 799F368450; Mon, 31 Aug 2026 11:44:31 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Mon, 31 Aug 2026 11:43:44 +0800
Subject: [PATCH 5/7] net: mctp: usblib: Simplify allocation logic in
 mctp_usblib_test_rx_init
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-dev-mctp-usb-lib-test-v1-5-79699bf67a18@codeconstruct.com.au>
References: <20260831-dev-mctp-usb-lib-test-v1-0-79699bf67a18@codeconstruct.com.au>
In-Reply-To: <20260831-dev-mctp-usb-lib-test-v1-0-79699bf67a18@codeconstruct.com.au>
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
index ab323a31161a415d93eafe4314e0e52cedfcd42e..772484df32a7d7b4d30e51808e06853febe272b6 100644
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

