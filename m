Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F141F376;
	Wed, 14 Oct 2026 04:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791953282; cv=none; b=R2DsczPaKi+EEOZjvZPqw4wsHpwq2RMHkXBejmWVfU2ifD8rbDG5L6GlG8EAqChAOEZuEL1RZuJDHb6hCk7ZB6kFK0M96Fi1GVWa5jaFbxDYf/vnWwBG/raKu7MYeitDm3ni+QwgJswi2eMKS5ZzMfqqALc9oUIXP5BNLB/WEDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791953282; c=relaxed/simple;
	bh=OHs8I4xAyy5uQDeBSzPDHM2x5Vxl3oJYkF5aB1g1rk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J/r/N20dCCBXRNtVxFR6Hdx2F4aO9sM8cS/zkLKMXx/kr4ZipVYHjnCV3nCMm3hb24T/M1ZZKEvBYR6nzc5v0GKbJoL41FsvLAqUA9pCHMvhFq/LqPHxEuEIiZhYgtZ1r+dzmNlRdKPTcz0htH/XYIMJMxG2PsLeqTUEUKr42E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ad/a7OpK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ad/a7OpK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1791953277;
	bh=NP6KXnXaoPUg2fq+HmQndlOs7BOCfABbKwsn5QaRyeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ad/a7OpKR73YpIq7oz/QK7u+qZMZABJ3lHU3NfylveejqTZrZgPn8Bewy/zdn2PvB
	 xYcwftknqrPmjmLtJfCNQS4xoYf1TjuXkeQXPQCIjRuqUY3v8zm2TI6q6DEMnpBFmy
	 29lLYt/s1Nfse1LyPttpRroFry8zG9hn17AGEj31BlWdhGL+EIupndFo7OJJRhXcsb
	 8orJ9ehmmOte2p/UM3LPZ3y7+47UrZAPJjpO2+sSxYY1nHXsaO8lP5Z1gsJ2HrOyWS
	 5nKFqv2Y+Jv6ejnIurI9vzfFk9JH+I1fAfDnjITstmnxe7pY4gCRFbiFG9J+1DQb02
	 v1UDrQHtvnnWg==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 0707B6FD58; Wed, 14 Oct 2026 12:47:57 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Wed, 14 Oct 2026 12:47:35 +0800
Subject: [PATCH net-next v3 5/7] net: mctp: usblib: Simplify allocation
 logic in mctp_usblib_test_rx_init
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-dev-mctp-usb-lib-test-v3-5-ee5bc3ea1db1@codeconstruct.com.au>
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

The if statement testing rx's allocation is unneeded.

Signed-off-by: James Lee <james@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usblib-test.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index ba2cd432355fe130a36d4f815c40ddb915db234a..4a8761618258dce08025fadc442c71f98e74026a 100644
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

