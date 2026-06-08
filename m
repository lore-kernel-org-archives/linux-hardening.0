Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBDD3B8BB9;
	Mon,  8 Jun 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912551; cv=none; b=ibfXmMPK8zJDMbqa1FI5RzLdZ1QaELlcmW8V7Z2hZy7W17scAZMaJULFP+Khf9OaDIxAkdkFTzyQo0PNJPqJ0QYeYfDb/tIBJ+vn240hLCGNI4aiteczTSZl8q0UDHT/eiTbx7SmE28M9140nUcttum0+uPUwM79HZm7raJU0bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912551; c=relaxed/simple;
	bh=Tk5KdqZhOv3D5nSna7itNU2kqJZQX5A5kJSFzhxGYO4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eXOY8gagSwC3+P71evoTUFNAkO9jHWpzY3NGAEOWoin/SmPjzKzp5sqhcP5CdKeS2hXe22DCrfWpv+QYBU2f+SldLpF84zVmUIeqpZLDEGdO5ngfQfCCzLTIMvTYrwPQ3BLB31Zinax6jbW/usmLmTbrjsVKbQCqcK7UcPrcmA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=mzwNQcpm; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="mzwNQcpm"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhq-00BrCR-JR; Mon, 08 Jun 2026 11:55:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=W+yU8trTCS2ysnxcAjmBSgusy/BoMx22FcIeM28Wuc0=; b=mzwNQc
	pmRu7sNwWZKLmlabv3eCEsKsj28PEwTYVAgbmxU8WuxSlvJ2JHOFiuUnqLQtSIM7svHv+aSmbwe2g
	q/QLJoMJeKOkwQpCO8xICGWS/9ndod9XYJx3MPCXFLY24UW59iyyMk/Cd163saubfjwrdvly+Q/Y9
	FcIFmPEWM16YncIkVk+Cz68K6rygpaOaa8b0lZRJPBNd6trvQxWrGixndC/J3I7t5fZTn/ORmzqqY
	3rnnc14tGc1bINlHKUZ4SHD58ej6ZpYpFauw1wT3SlYdHurSmb1IZprBu9DqYA/2EEC2cYhWZR/MJ
	0lSOz3yiAeTn9Qm0IfERQh7Wgg+A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhk-0003b8-U2; Mon, 08 Jun 2026 11:55:37 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhh-00Ag6G-KJ;
	Mon, 08 Jun 2026 11:55:33 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/mtd/parsers: Replace strcpy() into kmalloc()ed buffer
Date: Mon,  8 Jun 2026 10:55:04 +0100
Message-Id: <20260608095523.2606-20-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The length of nullname is known (and used for the kmalloc) so use
memcpy() instead of strcpy() to copy it into place.

Use strscpy() and the length it returns to copy over the names.

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

 drivers/mtd/parsers/redboot.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
index bf162c44eafe..e1e280b5fa40 100644
--- a/drivers/mtd/parsers/redboot.c
+++ b/drivers/mtd/parsers/redboot.c
@@ -249,7 +249,7 @@ static int parse_redboot_partitions(struct mtd_info *master,
 	nullname = (char *)&parts[nrparts];
 #ifdef CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED
 	if (nulllen > 0)
-		strcpy(nullname, nullstring);
+		memcpy(nullname, nullstring, nulllen);
 #endif
 	names = nullname + nulllen;
 
@@ -264,11 +264,13 @@ static int parse_redboot_partitions(struct mtd_info *master,
 	}
 #endif
 	for ( ; i < nrparts; i++) {
+		int len;
 		parts[i].size = fl->img->size;
 		parts[i].offset = fl->img->flash_base;
 		parts[i].name = names;
 
-		strcpy(names, fl->img->name);
+		len = strscpy(names, fl->img->name, namelen);
+		BUG_ON(len < 0);
 #ifdef CONFIG_MTD_REDBOOT_PARTS_READONLY
 		if (!strcmp(names, "RedBoot") ||
 		    !strcmp(names, "RedBoot config") ||
@@ -276,7 +278,8 @@ static int parse_redboot_partitions(struct mtd_info *master,
 			parts[i].mask_flags = MTD_WRITEABLE;
 		}
 #endif
-		names += strlen(names) + 1;
+		names += len + 1;
+		namelen -= len + 1;
 
 #ifdef CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED
 		if (fl->next && fl->img->flash_base + fl->img->size + master->erasesize <= fl->next->img->flash_base) {
-- 
2.39.5

