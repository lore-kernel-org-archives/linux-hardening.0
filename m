Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A500347FC8;
	Thu,  3 Sep 2026 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788403370; cv=none; b=GKtJMqcdFb5S/tkXv0FkuNrqsH9/mpxlC0uclwhaVTwy48PNA/XQWmgUdKZjp17E7rmAs9olUc4l0QrrXWr3hlNYj4lWc/8kvf/eKFwSmps2AuSvzrU5BJM+vwOilTz6yOLMTa+mteYU1Hu+FcgnQbWFQagSmeHKO2ors5lXPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788403370; c=relaxed/simple;
	bh=/7F6gkJ9MHJM/0tqgcWWALlBoQYrcAEkqXWUZGAWjNI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CxgAhovge2CbULwf7+cVQuV9XG6M/hCJIXhaPlxrsjaVwMpdkGaNAlWrzvuGXkNqLYyPGKl3IASbNlhw2rPGgdrDsLrqk+Kqbpy5iiUHS4YC7MMfhHUL/9vy43Hoj498yBEtMuFjm/yRCUVTLReZO8mDUTSp3yXtr1vWQ0fIlT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VSp0SlRF; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VSp0SlRF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788403358;
	bh=XbYVM2YpKiO6TInWC4TDk3UHoElUpLyhLKsD4xlj9uU=;
	h=From:Subject:Date:To:Cc;
	b=VSp0SlRFdxMLg6O/lF9WiF86SgC3CxoTobknBeuNihr9/MHJiIToeSebQPeyotoyF
	 hJ06Eo1/3TyQUhJnmlLPAqcx7S5ripWM0AIu4XnVhyiGXgJfVGk6+GcWDxnxODG+T1
	 IE2AU8D69bK+QTlIvLH4OC6TUBA3d98P1OSTqFxoH6IyEZrEi+Cj264x06ufpaqwUj
	 /sZSf6BeNF08/mgFazzsOEACU2WC8X4wQCpUBYvDt0JRKFYnJM7iF1RN3nt6SZKq3y
	 VmeleEsR3EG14HDAXj/6FW4D+XcfmGKfwAw2EnBpdd6WF2k8z2MzMVQamuTV23wndP
	 jD8YwYT/lW+Xg==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id A8B3A68686; Thu,  3 Sep 2026 10:42:38 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Subject: [PATCH net-next v2 0/7] net: mctp: usblib: Increase coverage of
 kunit testing
Date: Thu, 03 Sep 2026 10:42:17 +0800
Message-Id: <20260903-dev-mctp-usb-lib-test-v2-0-313cf15e0b56@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIremGoC/3WNwQ6DIBAFf6XZc9cIrSA99T8aD4prJalgAImN8
 d9LuPc4mbx5BwTyhgI8Lgd4SiYYZzPw6wX03Ns3oRkzA6+5qAWTOFLCRccVtzDgxwwYKURkDZO
 8lfJOqoG8XT1NZi/dF1iKaGmP0GUzmxCd/5bDxIov7fbG/rQTwxqlEkoNk5A9a5/ajaSdDdFvO
 lbaLVW/QXee5w9uWZLwzwAAAA==
X-Change-ID: 20260617-dev-mctp-usb-lib-test-151728774e95
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, James Lee <james@codeconstruct.com.au>
X-Mailer: b4 0.14.2

Current usblib tests only check receipt of a limited combination of 
packets lengths.

Added tests of receiving packets with invalid fields, and more complex
packet spanning. Also created tests for transmitting packets, covering
most code, except for mctp_usblib_tx_cancel() and allocation failures.

Signed-off-by: James Lee <james@codeconstruct.com.au>
---
Changes in v2:
- Address concerns identified by Sashiko
- Add missing net-next prefix
- Link to v1: https://lore.kernel.org/r/20260831-dev-mctp-usb-lib-test-v1-0-79699bf67a18@codeconstruct.com.au

---
James Lee (7):
      net: mctp: usblib: Add to parameterized kunit tests.
      net: mctp: usblib: Add test for splits inside headers
      net: mctp: usblib: Add tests of invalid headers
      net: mctp: usblib: Complete rx tests
      net: mctp: usblib: Simplify allocation logic in mctp_usblib_test_rx_init
      net: mctp: usblib: Add initial kunit tx tests
      net: mctp: usblib: Add test for failing append

 drivers/net/mctp/mctp-usblib-test.c | 542 +++++++++++++++++++++++++++++++++++-
 1 file changed, 531 insertions(+), 11 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260617-dev-mctp-usb-lib-test-151728774e95

Best regards,
-- 
James Lee <james@codeconstruct.com.au>

