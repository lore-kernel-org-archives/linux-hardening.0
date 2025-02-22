Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD6920AF98;
	Sat, 22 Feb 2025 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251999; cv=none; b=Z6ukhAloRbU7XavlqbSkI+FMwvQ7dauZ1oyGsSYWVXHFbqz9i19eK2NZKbOWUvlebaUcUdq52ww8naBRT44ZD65VknRzrTq0o+rUbkMdGO98Oqg17GgKkW1NNVc92TY/uAZ5Ya12OlOcm6N2TyO+rvQ4/yVaCJfM4xg5ZfIOG6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251999; c=relaxed/simple;
	bh=yOvvdjiU0jdJ3UdjDOTfD6mRKuTsj9mR2aIGQknKyaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o15aigJER+IRWLi82L7P9/BAQjCXjpyDUlfqlVG+abV8KvIMsvbTVBDLrHRmFiOFHyH2Mea12kTTWd5QmO39T2ugbcKv3j9jFQuiZju80Gc7aT5WTlV5xcMBKS8hqXtF1Q8ZSfXfKuQ1BvDIJ8vWebg9s8zmQiywS4RumglsA3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=C8qqaaTN; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="C8qqaaTN"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z0cJM2lr7z9snx;
	Sat, 22 Feb 2025 20:19:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740251987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5b6ehKCWNH72ToV9CKBN72vhsFPXWtjWbIceXxBIUQg=;
	b=C8qqaaTNpnIbwIbem6hbEmowvFzu34PishhG4VM6bU1Q0Ku6S15gIiyKty38oofGAozrRs
	YrXzjmDm12VvU9q8rOujPZfvAQe1H22HGWI4E4WHelfbUasdCVKAFkwaMP/0fzpqx0DNZ7
	qxX7J9EgnXI2gP2mRnA0/XxiIgKvduVx+YbJW82TNoBz80BW2NPndLEBvwrrm6mm+v6EGt
	TLE1udKEtDLHbLNmi4t+bkp5AXp1qKeS4LAh18nAAPofWp2LGJiEPpxYi3OrCzc1YR4bRs
	9NPbAD8lEWbzlrc2cnVRv/N/jcWzOS9z51Djx1JkW5TWLkKfoi6odcRa5sldzQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sat, 22 Feb 2025 14:19:43 -0500
Subject: [PATCH] mtd: rawnand: use kcalloc() instead of kzalloc()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-mtd-nand-kzalloc-v1-1-fbb41db6fd8e@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAE4jumcC/x3MQQ5AMBBA0avIrE1SgwRXEYtqBxOUtCJC3F1j+
 Rb/PxDYCwdokgc8nxJkcxFZmoCZtBsZxUYDKSoVEeF6WHTaWZxvvSybQaqNUVWWVz0VELPd8yD
 Xv2y79/0Aw7Y8gGIAAAA=
X-Change-ID: 20250222-mtd-nand-kzalloc-29cc08138b24
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=yOvvdjiU0jdJ3UdjDOTfD6mRKuTsj9mR2aIGQknKyaM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBPOVM5ai9XOTIzbnYvUHlpOTNtQmJML0NsMlZVUzNOClZleVhiY2VlMHJCN3J2OUZl
 ZDZPVWhZR01TNEdXVEZGbHY4NXlta1BOV2NvN1B6cjBnUXpoNVVKWkFnREY2Y0EKVENUZ0E4UC9
 6S0NjL0djdGgyMGNMSyt6Q3kvMGxQdHlZNVBJeHlYQlA5dkVuWVhMUk96RkdQNTdtOTI5R1RIRg
 pvdittMHNFZGJXZkxObXl1WGNvZkdIRlBndDh6M2FScmtqOHpBS2tHU2RNPQo9dDFVRQotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4Z0cJM2lr7z9snx

We are trying to get rid of all multiplications from allocation
functions to prevent integer overflows[1]. Here the multiplication is
obviously safe, but using kcalloc() is more appropriate and improves
readability. This patch has no effect on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/mtd/nand/raw/nand_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 53e16d39af4bf95c16505e0b528da1f3ba832010..13e4060bd1b6a1a360d430260b881edc8a3abeff 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1833,7 +1833,7 @@ int nand_readid_op(struct nand_chip *chip, u8 addr, void *buf,
 
 		/* READ_ID data bytes are received twice in NV-DDR mode */
 		if (len && nand_interface_is_nvddr(conf)) {
-			ddrbuf = kzalloc(len * 2, GFP_KERNEL);
+			ddrbuf = kcalloc(2, len, GFP_KERNEL);
 			if (!ddrbuf)
 				return -ENOMEM;
 
@@ -2203,7 +2203,7 @@ int nand_read_data_op(struct nand_chip *chip, void *buf, unsigned int len,
 		 * twice.
 		 */
 		if (force_8bit && nand_interface_is_nvddr(conf)) {
-			ddrbuf = kzalloc(len * 2, GFP_KERNEL);
+			ddrbuf = kcalloc(2, len, GFP_KERNEL);
 			if (!ddrbuf)
 				return -ENOMEM;
 

---
base-commit: d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa
change-id: 20250222-mtd-nand-kzalloc-29cc08138b24

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>

