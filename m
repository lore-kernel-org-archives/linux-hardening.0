Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F583C3787;
	Sat,  6 Jun 2026 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777646; cv=none; b=bcXv2H1DysGGdnOJs2fo1zwpFQMsCuhxSD4AtTlo4i/DH4y9ZoAkg3MA0SG6ZVHpIqm7l7hl2FjJ/T+dS0XUxtMCT9jtgpWcF7MAkVFc+1phDSwvmenn2IthZvYkoz4In6xhhef+9dk2yAN5zqwThxFzzPJkWlf4euPYb63NaAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777646; c=relaxed/simple;
	bh=67V5ijnjRJ3lxxwIA60f5TJywKUV13PourCP2H5oSxE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CRugCaneIbHPIK3YOQdJiFwK9EDfq0MRGIzVxdWj6JvZ7BQT5umsndFTnihtKSKjsgAx6U/cVfhaUOTLCdAk9JGAFod+DkRSCFitCpuJ9dCHRhro16loO6A68RCd0xdsTYjKkEgIwTWba7EQPTJ7H3EuVmjGdfKaQvD94Zts+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=MSRHak75; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="MSRHak75"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbv-007NRZ-Aw; Sat, 06 Jun 2026 22:27:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=V/S9cU6XmU1GBmWzRJOxuVRdqyanm3UqQ9caimRIc2E=; b=MSRHak
	7592Xha25bcKFHrrOdDKGvBEmrnsrAeLUuucA+hD3dtuhaaca27JpxntN/KWYFgMYcldL0pEShgkR
	Xh1bNwujQjESMOc79wbk9LBP5iVMt5zSc/HpTPnoXa0+gR0iv4QRk5O3xfDUIWeVr0+SHJeZzMCkp
	0cIzqtNHWj3PDE5/W2x32bK808FTiEsZDm9ImyJQHWT5jGjlVVqelP9vFkC+HiSjtix9CxWPwH4j4
	4unE3+YHw5aI33cXMeJP5S05j4NFtkCS1WjkvdXnXjlNS8Yld/ILPRCC9Ynz2tCt7TsG1d8WGGlnM
	8tUkfaPXehUhTV3GvBvLStZV4vdQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbu-0005DB-PI; Sat, 06 Jun 2026 22:27:14 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbf-006V18-GI;
	Sat, 06 Jun 2026 22:26:59 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/ethernet/broadcom/bnx2: User strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:10 +0100
Message-Id: <20260606202633.5018-16-david.laight.linux@gmail.com>
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

 drivers/net/ethernet/broadcom/bnx2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index f5722e929833..796851abf470 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -6306,7 +6306,7 @@ bnx2_setup_int_mode(struct bnx2 *bp, int dis_msi)
 	msix_vecs = min(msix_vecs, RX_MAX_RINGS);
 
 	bp->irq_tbl[0].handler = bnx2_interrupt;
-	strcpy(bp->irq_tbl[0].name, bp->dev->name);
+	strscpy(bp->irq_tbl[0].name, bp->dev->name);
 	bp->irq_nvecs = 1;
 	bp->irq_tbl[0].vector = bp->pdev->irq;
 
-- 
2.39.5

