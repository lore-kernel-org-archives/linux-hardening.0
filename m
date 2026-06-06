Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322CA3C4573
	for <linux-hardening@vger.kernel.org>; Sat,  6 Jun 2026 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777646; cv=none; b=k7ktDwYWmH0oRgtg8xEbbLqpBzeBW7Jfe5onKpPC+AoGM695o+ShxK6R9B+f2kz3fO3CAD1fG0yyrcJPZHTZw1MiTX4p/DnvWq7v6f4a30QlyTsWYYxf0/XYyEDaug6TzXhcad3mtlyXmo2NjsWNho0XhmNDEWCAHMrw3gtCozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777646; c=relaxed/simple;
	bh=KwpYQR2QSZiEsaf9ZSQ81tnllE2+9uTsvaoY+bEkKbM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uw+mLbZHqIxEf02XUv8AXVcBcT+lcimmxgckxdgIxAWOX/uwqmP4+E/3RItDhEAYPrQkuhQDLYsMRJT0kSG464v/jwxkZ/Od42xa2Rym3cWT1liax8v3vn8ZUztpM3WYQvJqL24mv68uXuMsh2TiNmFwmwwvTiBMsxjUo27k4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=C5nqByvC; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="C5nqByvC"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxc0-007NTZ-PW; Sat, 06 Jun 2026 22:27:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=d/9GTztrEzzPXewpLi5FMtWP2P8vhwjGmFMrZobrZ+E=; b=C5nqBy
	vCdtOKXayjTSILT/KY8/J23khkIaz9jxUa7FaZqqJg8Rehuzlk73faTUqByLiB4pMBNu3ruYxJC6K
	zVAjgVTWmYF1W3CRfVx5Q5JeYlvCtxrMs845MPpOS4bQt+kCBF7P+vXLzIH/MSiAnICKPjLiPUpS3
	RrZTBf/yM1QcfXWGw+zz0hKh7Dkcu6KXOvSlv3MsyjXhwxbQEBYae9YlShitvN5mGeKq8FY4SMAbz
	jKX6eeOlbeoUNq+yqSzKgQbUNnE04v28ubZCFy2B0v1NwxcV890chn1287/S2mxCSum4v6mPag0n3
	RLIjzHCZ+JqwA+tt2aVZSac4ns3g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbv-0000u8-6n; Sat, 06 Jun 2026 22:27:15 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbp-006V18-2Y;
	Sat, 06 Jun 2026 22:27:09 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Joern Engel <joern@lazybastard.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/mtd/devices/block2mtd: Replace strnlen() strcpy() pair with strscpy()
Date: Sat,  6 Jun 2026 21:26:33 +0100
Message-Id: <20260606202633.5018-39-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Use the result of strscpy() for the overflow check.

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

 drivers/mtd/devices/block2mtd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 03e80b2c4f5a..466a061fa9bd 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -415,12 +415,11 @@ static int block2mtd_setup2(const char *val)
 	unsigned long timeout = MTD_DEFAULT_TIMEOUT;
 	int i, ret;
 
-	if (strnlen(val, sizeof(buf)) >= sizeof(buf)) {
+	if (strscpy(buf, val) < 0) {
 		pr_err("parameter too long\n");
 		return 0;
 	}
 
-	strcpy(str, val);
 	kill_final_newline(str);
 
 	for (i = 0; i < BLOCK2MTD_PARAM_MAX_COUNT; i++)
-- 
2.39.5

