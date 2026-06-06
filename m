Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761763C343C
	for <linux-hardening@vger.kernel.org>; Sat,  6 Jun 2026 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777641; cv=none; b=l7beP6fDwbJB7eI7yGFmykYb8ltk8hBrSIutMsd7gd+RxeT5lGcCOXo5//45nlTHihPVbuRRTK0oHf2kCnhS8/Lp3vmQySr1SOXrVTiLbJgHCO/5X49V2N9fqvcZdsqFG/dHCtz8lsgZgTPJDz1yu6rqZrnCpw1ZcILS7R2D+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777641; c=relaxed/simple;
	bh=x34zKJLbHrcfl7PrIVfYPfgZXBOyFERJSkGeDrsYoZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pXvmKjqTqVPJUDzSUwcL/yo+BQENd0Pox5EgfJ+sTjAagzQD/tzDH7/PLrguKeeaPxfKwLPvGof62dNxXudTDfVAAdg1HrR4l5l0IhbpbLmYMSVK3eMjXEeZeHf/Vc1DKFhwkb86DVaVhZEqACjuvK3/ggpfA+HgzgDHrPH7Bh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=J26kTvRl; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="J26kTvRl"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbu-007NRK-RZ; Sat, 06 Jun 2026 22:27:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=1KyGr0RrzQAbPBe1OH55bwns/tP9FfEfmistj29ns+k=; b=J26kTv
	RlHV+T4PPuIPitv4867R4mIrOYWbuQxBwNpsVr8lFF2J42NiciZwKItnI8GVHd/sSZi20VROkHRm6
	sozRMYQ4yAf9w6BZmLey4u0kw3ledTVjpL3Kiy8VA21VJXOqnZ8LmxOcoNv71/NxOu0E977a71NKF
	UCBkdPk7WIYKO/kM0sh8kSnuYBDZfdEjkarzc1pH1mJCGXyELw/yiugyGHAedzVm0cQ1bey79pEd8
	pIjh0/28+dmCaT5BN4mxkICWYg65+OAtM3b1GkPmUxpHscnq4m/LxnlPAUlM6Pa76Zqxjm5EfHo3k
	uzOYSOWC3ujnplAnPXwliQXTvvxA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbu-0005D3-CD; Sat, 06 Jun 2026 22:27:14 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbg-006V18-Fq;
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
Subject: [PATCH net-next] drivers/net/ethernet/sfc/efx: User strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:12 +0100
Message-Id: <20260606202633.5018-18-david.laight.linux@gmail.com>
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

 drivers/net/ethernet/sfc/efx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 8f136a11d396..77d29773c5af 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -755,7 +755,7 @@ static int efx_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **xdpfs,
 
 static void efx_update_name(struct efx_nic *efx)
 {
-	strcpy(efx->name, efx->net_dev->name);
+	strscpy(efx->name, efx->net_dev->name);
 	efx_mtd_rename(efx);
 	efx_set_channel_names(efx);
 }
-- 
2.39.5

