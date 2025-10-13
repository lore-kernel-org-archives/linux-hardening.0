Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0342AA3
	for <linux-hardening@vger.kernel.org>; Mon, 13 Oct 2025 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356348; cv=none; b=ShNjbTaJu8uoI5xohR7AMUrS1GMBQ3xPXUDQ0zAPvXPVprs56uRSJqR2a7G2yWdWGDoRHUQBAB1afj51C4cOeHJpem6O1qDXL+P95fSc6cyzCM+Dum9uagTZUBI0RjD5zASGu+6HVu3azMShRfd6pcP7MchbB6z7KnNJ7dc8zAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356348; c=relaxed/simple;
	bh=V2qDYbbuoTEkBT2HL0t17NuHFHKoI+ou5Hi6gsPWzL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ilbBeQI6Zv8KVnsmZC+Y+TTSssemYKC4DUW1TKwZaDYVPc+xMird4wzDQCbiYOCo7JzvqYgW0HmK5XlfCGRoa9h7rH9P9vstpkeJjF3OQp3jZnaBtpCwdsMzDkdbKhF6A9yo+OIIYKEGV45U856SRIqrt29Yz+uCC6TmO4vE024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PSjKTqJP; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PSjKTqJP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760356330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Uibbwg5d/wwFpFMHDXbH4NfA15Tu+IH7YaAVA/rb1c=;
	b=PSjKTqJP9pqAYoHdIVOFzclMViJVzEjidiANqm0xzTACFLXxwbrBrac1PxqPu8OpRK7v8K
	f5VNqEXqNzQuzlJ/I9TthmxUsJBt/QWf/pwZLjULfY+HDFyvClU5vNWjzfmBeYxGjQOAd/
	UmVyha1g5IPcarqIKYH4G8XdsWvPncU=
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
Subject: [PATCH v2] drivers/xen/xenbus: Replace deprecated strcpy in xenbus_transaction_end
Date: Mon, 13 Oct 2025 13:51:25 +0200
Message-ID: <20251013115129.30304-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; inline the read-only string instead. Fix the
function comment and use bool instead of int while we're at it.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/xen/xenbus/xenbus_xs.c | 14 ++++----------
 include/xen/xenbus.h           |  2 +-
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 528682bf0c7f..5d95a5f83119 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -546,18 +546,12 @@ int xenbus_transaction_start(struct xenbus_transaction *t)
 EXPORT_SYMBOL_GPL(xenbus_transaction_start);
 
 /* End a transaction.
- * If abandon is true, transaction is discarded instead of committed.
+ * If abort is true, transaction is discarded instead of committed.
  */
-int xenbus_transaction_end(struct xenbus_transaction t, int abort)
+int xenbus_transaction_end(struct xenbus_transaction t, bool abort)
 {
-	char abortstr[2];
-
-	if (abort)
-		strcpy(abortstr, "F");
-	else
-		strcpy(abortstr, "T");
-
-	return xs_error(xs_single(t, XS_TRANSACTION_END, abortstr, NULL));
+	return xs_error(xs_single(t, XS_TRANSACTION_END, abort ? "F" : "T",
+				  NULL));
 }
 EXPORT_SYMBOL_GPL(xenbus_transaction_end);
 
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

