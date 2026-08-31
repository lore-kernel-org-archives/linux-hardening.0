Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF13B0597;
	Mon, 31 Aug 2026 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788148228; cv=none; b=m/A+vvv++7nDJeatfNRAz5dWZrA3B0O3R3TiYLA1CDmvXMuU5VxdhU7/Zn4+yAZzCXSgKNbWNmJOobCS6wqU2uKEh/BL//LwHY+R3bllXR1xwxtNsf6LR6MV4nxoac0lARAwoe1NuzDYV12y5LYFJoWQhiWFbDRqc/SZHX/FpRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788148228; c=relaxed/simple;
	bh=eMNksmG246mpogtFnGw7NQKjqaMgijpHuCZKhIxXsAw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ONriNG71fT2d73BaotF1p7+NaXyeDmk+9PKINYYNptNrj70dUnTgY+twGDBeM9SCRrAano6V0PQVbCrnBBKvk+Sm3Miy46+wEtQ/pTB0Vo8kE4Avue3w6STC1Gznrc2VIpWqs17M7eCdmmDVT3lwujXVDjDpxqzxRsUjhrJYbOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Lo1m7J8x; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Lo1m7J8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788147869;
	bh=QPr6gXN/7uyZQTV9SxUUgaKwIhtQfjpGIPQEZJv4uMI=;
	h=From:Subject:Date:To:Cc;
	b=Lo1m7J8xOkAuArwu5eemn9m5+2FQkF9s2x8QRF8vquy+Gi0AuMt8ejq67oG9UNdvK
	 xN2AS00sBio9maxwz/x9bZi392uOsNi2i7sz0B64V87hJmjZJAjS7+Pw1yFO0oVu4z
	 ybSqiirZPVCzmdfuGXrVPFJxaj8BN8bNHU80PzVVTqk9Ih4vZpmsu05MAW0AlVb3oy
	 ekFTEVXsc0XmeVA3evB6sy5+1GeRA8ad1a/Agt5pWRQaYW/pCS/QIHkPqR2ZE8uOZv
	 mjH2pXm3RcRSQV9YLoU1yunRIFxlRknQQYcIzVsFnSqiIS/QgsZVZpQC7UODEvrikV
	 nWPJlU3yueCaw==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 53CCD682D8; Mon, 31 Aug 2026 11:44:29 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Subject: [PATCH 0/7] net: mctp: usblib: Increase coverage of kunit testing
Date: Mon, 31 Aug 2026 11:43:39 +0800
Message-Id: <20260831-dev-mctp-usb-lib-test-v1-0-79699bf67a18@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGv4lGoC/x3MTQ5AMBBA4avIrE2iDYqriAU1mMRfOiUS6d01l
 t/ivReEHJNAk7zg6GbhY49QaQJ26feZkMdo0Jkus1IZHOnGzfoTLxlw5QE9iUdVKKMrY3KqC4j
 t6Wji5/+2XQgfJMCYtWcAAAA=
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
James Lee (7):
      net: mctp: usblib: Add to parameterized kunit tests.
      net: mctp: usblib: Add test for splits inside headers
      net: mctp: usblib: Add tests of invalid headers
      net: mctp: usblib: Complete rx tests
      net: mctp: usblib: Simplify allocation logic in mctp_usblib_test_rx_init
      net: mctp: usblib: Add initial kunit tx tests
      net: mctp: usblib: Add test for failing append

 drivers/net/mctp/mctp-usblib-test.c | 546 +++++++++++++++++++++++++++++++++++-
 1 file changed, 535 insertions(+), 11 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260617-dev-mctp-usb-lib-test-151728774e95

Best regards,
-- 
James Lee <james@codeconstruct.com.au>

