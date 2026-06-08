Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CC63BB9EF
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912553; cv=none; b=OvkmzHM+rMLGOrob32PmHLA1gcL5YLcRayDzIHMdiHgUQIsg+MxG7KMw1ocuZbz4aTM8RCkMsYbgpJMbVSiKfsJzDy99KQJOl5U7H21wd3d59xlLRJ+zH5xOkLwcr1eyEiEbQ/Z8lRu7LNG2HY9ri/utP7v7Hv1e18JqYvzRasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912553; c=relaxed/simple;
	bh=KxPNcO8WRmEs8BuXXWxnncdnBhxwODwk8znXxeuMves=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eMm+or/vIUsK9VqymQnDcpEbbBPEgCkDdZ2f0n5LRQITexT/ecfdYPyMWuoqDdcn1eu+OW+gfiGolJiV6hlNUkiSvlFSYPxdazIS0JzyEs7IJY5LwoSuL6SwsugrQdIa/meEU/qJa/Wfz8k4Eor3oyjWHq5s193UxOO+XFBHCmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=hunvNFQ7; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="hunvNFQ7"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhu-00BS3I-BO; Mon, 08 Jun 2026 11:55:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=B1BeOIM4uXGD6GiA0pEKXq5UZVRP7MPwiY3AoYdOTbw=; b=hunvNF
	Q7yfOkxG3DKupAm47EQUszVkGzcmfjADhyjLyUdxsCl2TgE8YTlDE2h8ETxzbE0wpfIW3zDKqvyzh
	RwRV9fliVRCJd5t220BOYz1Rvp7PfpGAqF5Z3R4wEe+uq3lnvlhttX3LYli5a0adULjSiAmnnxGgt
	mtL+868Ic0bgsSwDrEgKME6jf4Ov3yhO4n6DDImVDntyWYblxkUpjf3gFFqbi3oms2mNLhUYg+xTe
	3VEgK18PMksP9dzvRFCWYmFY09JGTEPNAYI5aIvS34n71Ah1uD4LQh25ajqB4zdPljlt6K7vtGvXs
	uKVghmn0i6kv0AvBh+V5903IDENQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWht-0000K0-BW; Mon, 08 Jun 2026 11:55:45 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhm-00Ag6G-Bw;
	Mon, 08 Jun 2026 11:55:38 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/of/overlay: Use memcpy() to copy known length strings
Date: Mon,  8 Jun 2026 10:55:16 +0100
Message-Id: <20260608095523.2606-32-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The lengths have been used for the kzalloc(), use the same ones for the copy.

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

 drivers/of/overlay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index c1c5686fc7b1..656867009514 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -258,8 +258,8 @@ static struct property *dup_and_fixup_symbol_prop(
 	if (!new_prop->name || !new_prop->value)
 		goto err_free_new_prop;
 
-	strcpy(new_prop->value, target_path);
-	strcpy(new_prop->value + target_path_len, path_tail);
+	memcpy(new_prop->value, target_path, target_path_len);
+	memcpy(new_prop->value + target_path_len, path_tail, path_tail_len);
 
 	of_property_set_flag(new_prop, OF_DYNAMIC);
 
-- 
2.39.5

