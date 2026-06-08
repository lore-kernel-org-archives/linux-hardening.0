Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F413BBA01;
	Mon,  8 Jun 2026 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912553; cv=none; b=Eg3f2Ateb+n9mvcTW/7jjgJb1Z/LkeYEHudPe3DkprYDDK9FVLvk9sAFTxLodob8gwUfmo2GxDiRIHZoG8s+vKRv2o1UV8sKuxX9xsKlhZ5hAEg3NQjU0AsGRTPE2/u2eGpaOvTJPe4m/zIMDJWqygZdNV4KDTREkId15JYtGao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912553; c=relaxed/simple;
	bh=0bV27Saa3wWGMVsjWlD0vqohFUhjmyy0zMWbVtULwRI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tU/cErXqgxP79QPPdyGqiNpQcQ+Lhcv55vLJ0a4Wmp1U9fWMnu2YSkJj7xUgIgt4/PmlUX2wtT0dH7sAWrM5+z/UUcfwLUc+wCKv6sDWX4PbyMtdFR1dgYvAn5NSuw+N+JRahBZp+3vLv7Gsgk87fzx6CxXs05E4ngK325eL6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=PriPD+e5; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="PriPD+e5"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhu-00BS3J-Ds; Mon, 08 Jun 2026 11:55:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=rJXrSZN5DyUFNSHv1rFfjYOv9L+IYPP1kteB5w3rjQo=; b=PriPD+
	e5gB7zb3SfWr8uHPyXtDXmXe0QsfmEZQcW9C8sISfItCGciN9NtBngTC9OW7uCsOBT3Quew+NjNQ0
	0io6Myas9p9zNJkDCav7LAqpiPVNJYc6YVIT9ri6id48cK6VBQruN9cbKA5wPKTJXpPsnr09iBf/8
	zPYm/j1hH6mdtEWnfni43Ubt0kryj11cHktf47LSD79QRt+goPnMIYZs/fmE9ZYXA7pNRtdcDAW0j
	sw2RQPBMTvKte8bZtnoXLcn53UbvHcTGvfjjIKhfSzczSY3hQZHht9g08zDItglIiFHd6ixnAvs0o
	btUsoej0GT/uvmg+dF5NTt/9hSsA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhn-0003cd-LO; Mon, 08 Jun 2026 11:55:40 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhk-00Ag6G-Ht;
	Mon, 08 Jun 2026 11:55:36 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/ethernet/freescale/gianfar: Use bounded string ops when setting ethtool stat strings
Date: Mon,  8 Jun 2026 10:55:11 +0100
Message-Id: <20260608095523.2606-27-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Replace sprintf() with snprintf() and strcpy() with strscpy().
Length is ETH_GSTRING_LEN.

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

 drivers/net/ethernet/freescale/gianfar.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 3271de5844f8..10ab1d1e63ef 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -3281,14 +3281,14 @@ static int gfar_probe(struct platform_device *ofdev)
 	for (i = 0; i < priv->num_grps; i++) {
 		struct gfar_priv_grp *grp = &priv->gfargrp[i];
 		if (priv->device_flags & FSL_GIANFAR_DEV_HAS_MULTI_INTR) {
-			sprintf(gfar_irq(grp, TX)->name, "%s%s%c%s",
-				dev->name, "_g", '0' + i, "_tx");
-			sprintf(gfar_irq(grp, RX)->name, "%s%s%c%s",
-				dev->name, "_g", '0' + i, "_rx");
-			sprintf(gfar_irq(grp, ER)->name, "%s%s%c%s",
-				dev->name, "_g", '0' + i, "_er");
+			snprintf(gfar_irq(grp, TX)->name, sizeof (gfar_irq(grp, ER)->name),
+				 "%s_g%c_tx", dev->name, '0' + i);
+			snprintf(gfar_irq(grp, RX)->name, sizeof (gfar_irq(grp, ER)->name),
+				 "%s_g%c_rx", dev->name, '0' + i);
+			snprintf(gfar_irq(grp, ER)->name, sizeof (gfar_irq(grp, ER)->name),
+				 "%s_g%c-er", dev->name, '0' + i);
 		} else
-			strcpy(gfar_irq(grp, TX)->name, dev->name);
+			strscpy(gfar_irq(grp, TX)->name, dev->name);
 	}
 
 	/* Initialize the filer table */
-- 
2.39.5

