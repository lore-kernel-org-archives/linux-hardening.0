Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8992D3C0A15
	for <linux-hardening@vger.kernel.org>; Sat,  6 Jun 2026 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777640; cv=none; b=SVpArN+DmousBnWSftsjPKXt7duf3j5STFDJCA9VaxPPFYXZ/pf1j0+hdYi+xTycJBhpQEJ6tUXy1qHXF7KO0wKxyRpD0NCvK+yiCjxDhywkc7nHzO/8hgsu6as1adytAUiOoLQaEBcvPpcqMtpLoV7BDJftPWA06KJs+KnqczI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777640; c=relaxed/simple;
	bh=8WsZo2uD3Ic6JcqSST4DIWo7T0OLmGNFHElL2tGM7+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f0HAie9frZfvMeCctxqMWJbQK5W55Q04o5FPmkQ28Byr5OEFMA1hi9VnUOmDaSLPFJwI5nMwmZqMpvMUwc0OkQIltJA0WQCtRSh8VSOeiB9EmK06O1/au/VqZYRXtcMB6IypZcWIrCn7EWzfOuQ99jQ1u8sM/eOLu9nD1GJo9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=YRXnFUNn; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="YRXnFUNn"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbu-007cH4-Kh; Sat, 06 Jun 2026 22:27:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=/XypvNHBLtGuNNU4DGSzapBmyHJWYnckw+LASZ5j7ZM=; b=YRXnFU
	NnPncDO7bbgmK/rOMFDQIlzqLsujVSooP+wShnT3IF0FV8LTXX/SR0YLlBk8tj2tyzTbD/Zc0pDmQ
	wJnSu4nTIDx7nJ8eA+hzs1izuV1StYlmfO1Sq6xyIoHhyhBMcbeY84KXXCJQaivMU3C98tKpv4kTx
	C0Yzq6RTcxfv2S4Acg6blXEzJdix0RsCdKZ3rgiNOUChVyXenWPvVcbZh6qF/L/jXBfe5D+Yl8BJD
	yNTN965nv5cKcR2aTx9xECjuZQzvmZtVjmRo5P85uddTxj5CD4x50imZMGPqTBY2EvXf9VdXFEB0B
	AKUa5zP+/RpC4QvZaUgICc/83RtA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbu-0005Cy-4d; Sat, 06 Jun 2026 22:27:14 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbg-006V18-07;
	Sat, 06 Jun 2026 22:27:00 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/ethernet/sfc/ef100_netdev: User strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:11 +0100
Message-Id: <20260606202633.5018-17-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/net/ethernet/sfc/ef100_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/ef100_netdev.c b/drivers/net/ethernet/sfc/ef100_netdev.c
index 3a06e3b1bd6b..f2309e79dab5 100644
--- a/drivers/net/ethernet/sfc/ef100_netdev.c
+++ b/drivers/net/ethernet/sfc/ef100_netdev.c
@@ -29,7 +29,7 @@
 
 static void ef100_update_name(struct efx_nic *efx)
 {
-	strcpy(efx->name, efx->net_dev->name);
+	strscpy(efx->name, efx->net_dev->name);
 }
 
 static int ef100_alloc_vis(struct efx_nic *efx, unsigned int *allocated_vis)
-- 
2.39.5

