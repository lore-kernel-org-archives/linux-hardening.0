Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475C30C35F
	for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599056; cv=none; b=L5WeTqG8mAaqu7iN5zOKaI4OD9w601UdTr5YfmU5bRTS9k1qbDGI+4yUaGlYbI82bmGAOR9n8DiimYN2yZx9jjnvFw6/Ln3zaNEkGbH9T2VL9vm57IIUHFXpAAjcOs1K1UxX3IJHyqWZvHfXpdzVM3a6fkfuqy2jRJCsoxsfdRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599056; c=relaxed/simple;
	bh=5qGHrbETbnkQCEhw61vymQOpVfGIMhyW0YhkYa8YKnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbji5GGWWvyp6RHSNgR+goJP/ARcbS6hYljTFRwRBktCqHmnk6hSRxVmwhnSHtBG6nE8oTigNu4eKnot2neM7omdNrzCzCvNGQp72UWBOtRBb0WqEFh6qvPQX3P3l/OJy0f/r1tC8rjdBXEc91/hc3CM9wj8Hw+tEn3HC3OtUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZuquCRj5; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZuquCRj5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755599041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vKWmZt8ypwV6+dYKs/xoeIekRcxze7cLQDSxbkdqqpU=;
	b=ZuquCRj5N2LgW+btJvB4kkYQ5J2pvYOUsJ99Wh69B5CEpy4otq6mRfw2LEthmA5+Rl2aDl
	zNLFcbyh+lhhQjMtALpY04YRFLCG2N2JiJtIHmmqAHVIBynOcrJ0X5RRQhtxcCEUZXUYhw
	tcQcFtcUeXAq+/WFGyRmrqjNAAsrT9w=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Loongson64: Replace deprecated strcpy() with strscpy_pad()
Date: Tue, 19 Aug 2025 12:23:19 +0200
Message-ID: <20250819102319.711935-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy_pad() instead.

strscpy_pad() already copies the source strings and zero-pads the tail
of the destination buffers, making the explicit initializations to zero
redundant. Remove them to ensure the buffers are only written to once.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/mips/loongson64/boardinfo.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/loongson64/boardinfo.c b/arch/mips/loongson64/boardinfo.c
index 8bb275c93ac0..827ab94b98b3 100644
--- a/arch/mips/loongson64/boardinfo.c
+++ b/arch/mips/loongson64/boardinfo.c
@@ -1,17 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kobject.h>
+#include <linux/string.h>
 #include <boot_param.h>
 
 static ssize_t boardinfo_show(struct kobject *kobj,
 			      struct kobj_attribute *attr, char *buf)
 {
-	char board_manufacturer[64] = {0};
+	char board_manufacturer[64];
 	char *tmp_board_manufacturer = board_manufacturer;
-	char bios_vendor[64] = {0};
+	char bios_vendor[64];
 	char *tmp_bios_vendor = bios_vendor;
 
-	strcpy(board_manufacturer, eboard->name);
-	strcpy(bios_vendor, einter->description);
+	strscpy_pad(board_manufacturer, eboard->name);
+	strscpy_pad(bios_vendor, einter->description);
 
 	return sprintf(buf,
 		       "Board Info\n"
-- 
2.50.1

