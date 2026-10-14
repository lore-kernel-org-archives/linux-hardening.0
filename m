Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F39034041B;
	Wed, 14 Oct 2026 04:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791953278; cv=none; b=mQCz4PSL3amT8z+KIKBiWNbZY1fg9x+j2LaS8cXXU6/sQlEMtxzk19hNuey22ayr1laMEp/FF0s7BLM/GlBxwbVZ6lWNJkJZqHPRtO5b38Igdnl0f32DKDk01GEhfFI+CQgqCrhDYUKLyiIW8ZcQa+yINRq+Djack3GI/hgc12Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791953278; c=relaxed/simple;
	bh=3HxdIodxvqDy8zLP11Zt9JaYGoD0FvpuHddar5O6S2E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dZMEg3mw860tISlfZ1himcNNo8R6/R4RKx9HFQ2gMh8U/p2inCzdyEJQrY2S1JM6wVj5MVFRcETXSzKthTY68D6QWHnExigwR59z5OXTXf2/+DpXIMAMQhYBTUeoEYxXuSi4EQw4bAgzIkRUpc4e7K+/0Vsr58g+tC/gQsMZwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TdVQgEiI; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TdVQgEiI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1791953275;
	bh=F9WWTCKHYk7tgfb2e93KmQU8fxBtczyT7NWtjQ+eaG8=;
	h=From:Subject:Date:To:Cc;
	b=TdVQgEiIstrPi0mxbGr6kd2p2a/LlHjq6G4bEsawt2z3SGie1WOTRsLhqyu5WZCQR
	 MKugGjy+geWs9swgxtrYdXtkagr2toa46Lwgj3GifbL05Pp8v4VHL+4n8SoIUuJAPx
	 i/aF9ZdP1OStB2ZCP6QvIyENuxR8OO/Em4PKljVm22+0BuEjKAXcd4ySML2EVteo+c
	 TmUzEyHQLcg/9qUISGp0aPEKOMX3tcDsQHTf5BOUsbuI4vdKv0rIQIZGgb/NT5AQl0
	 3hRKoDCFpr9DQnKSUn8FsTFeW2y5DkQouW76rC98aTjIoDRw880ujHbE8HW1WYcTds
	 789HD7uUkKjRw==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 01B2D6FD4E; Wed, 14 Oct 2026 12:47:54 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Subject: [PATCH net-next v3 0/7] net: mctp: usblib: Increase coverage of
 kunit testing
Date: Wed, 14 Oct 2026 12:47:30 +0800
Message-Id: <20261014-dev-mctp-usb-lib-test-v3-0-ee5bc3ea1db1@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGIJz2oC/3XNQQ7CIBQE0KsY1n7DBwvFlfcwLlr6qyQKBijRm
 N5dwsZVl5PJvPmyRNFRYqfdl0UqLrnga5D7HbP3wd8I3FQzE1worlDDRAWeNr9gSSM83AiZUgb
 sUIte6yOZjtXtK9Ls3s29ME8ZPL0zu9bm7lIO8dMOC7a+2b3EDbsgcNBGGTPOSg/Yn22YyAafc
 lxsPtjwPAxLw4v4g4bLLVBUUKK0M3bEx05tgOu6/gDMfc0NIAEAAA==
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
Changes in v3:
- Address concerens identified by Sashiko and Simon Horman
- Link to v2: https://lore.kernel.org/r/20260903-dev-mctp-usb-lib-test-v2-0-313cf15e0b56@codeconstruct.com.au

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

 drivers/net/mctp/mctp-usblib-test.c | 543 +++++++++++++++++++++++++++++++++++-
 1 file changed, 532 insertions(+), 11 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260617-dev-mctp-usb-lib-test-151728774e95

Best regards,
-- 
James Lee <james@codeconstruct.com.au>

