Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF81509A0
	for <linux-hardening@vger.kernel.org>; Sun, 12 Oct 2025 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760298982; cv=none; b=EnhXYP5jPMWIGy0hxYS1YGoOA442fu84+bpsIkW/ZunK/ReGUqG/MRLS4fx9k0T/TX5xheCwIdhlATBN0pzmwXYLsBRFUZQFrAGxKrdWURuCm7ZNSEB/xse5VWhxKGtuYmBg1aT7qNqiM2tGVRKAp4cdRberBr6VSAwaP0f6vOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760298982; c=relaxed/simple;
	bh=rLv/ZL2NBVvf9mLYXm9Of1NE2v/PPNOYA2cCKfAYuSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sa7UmFnNZasU3QnluxGC/6FpylDenIT/bj2sfDTmrS2+NUmh+EIAcoHpNfcCfR6kTZulAkqsGV0rqQ9l2Jes4IL9j8XRDa3wQMjQdEmwkW8iGvPKDzVo4djvcBZL9i/pw19RDUqXKWCfJqmZhMRovIH+Djgkj796y/LEr2xz94E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lRmFaMe/; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lRmFaMe/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760298968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nwPjdHOW4dMG1T40eFmU0S20/6YP0v1nsjLRSvlumqM=;
	b=lRmFaMe/r96b5PSFLPOJlOmLetbJZ5sVbbBssHGRKkAyQv/yvLbnRCzsuX14hXf4VIeW68
	injMi22daXCMaSkVYEwO0MpJJUwnNbVwLTQDBzwV21Xdf2XMKxxRg/EcnZHLjLplUFFD8B
	JHNxIzUMnUusoY1mx9gg9/NAtYYNfgw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jason Andryuk <jason.andryuk@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/xen/xenbus: Replace deprecated strcpy in xenbus_transaction_end
Date: Sun, 12 Oct 2025 21:55:09 +0200
Message-ID: <20251012195514.39003-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead. Fix the function comment
and use bool instead of int while we're at it.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/xen/xenbus/xenbus_xs.c | 9 +++------
 include/xen/xenbus.h           | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 528682bf0c7f..970302b3dcc6 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -546,16 +546,13 @@ int xenbus_transaction_start(struct xenbus_transaction *t)
 EXPORT_SYMBOL_GPL(xenbus_transaction_start);
 
 /* End a transaction.
- * If abandon is true, transaction is discarded instead of committed.
+ * If abort is true, transaction is discarded instead of committed.
  */
-int xenbus_transaction_end(struct xenbus_transaction t, int abort)
+int xenbus_transaction_end(struct xenbus_transaction t, bool abort)
 {
 	char abortstr[2];
 
-	if (abort)
-		strcpy(abortstr, "F");
-	else
-		strcpy(abortstr, "T");
+	strscpy(abortstr, abort ? "F" : "T");
 
 	return xs_error(xs_single(t, XS_TRANSACTION_END, abortstr, NULL));
 }
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 7dab04cf4a36..c94caf852aea 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -158,7 +158,7 @@ int xenbus_exists(struct xenbus_transaction t,
 		  const char *dir, const char *node);
 int xenbus_rm(struct xenbus_transaction t, const char *dir, const char *node);
 int xenbus_transaction_start(struct xenbus_transaction *t);
-int xenbus_transaction_end(struct xenbus_transaction t, int abort);
+int xenbus_transaction_end(struct xenbus_transaction t, bool abort);
 
 /* Single read and scanf: returns -errno or num scanned if > 0. */
 __scanf(4, 5)
-- 
2.51.0

