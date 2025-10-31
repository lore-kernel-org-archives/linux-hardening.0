Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0282D2E401
	for <linux-hardening@vger.kernel.org>; Fri, 31 Oct 2025 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913199; cv=none; b=bnOEMAOAntxHrSg3dEpI89yr3JsS6YeeCtH9w2oYoMehXvUiWG92GLFAs0S7jVPRh9O5ToS2Lb/+Nwau31FU3sCPOUEZlpE7HaLkPHm1d0pEbFEehRCQ1cvV52D/akcVHdCWlhv96ROgovVECRz5eFp8isuY8aHLwynHPdcUtNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913199; c=relaxed/simple;
	bh=9JrQbTFVWDHfwPJ9t2AimbJl8IPZ9iJD9tJ9BlVMq1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMqNbIeBUb9HH0QCYIl63Pt053N6vzFR9ogcvvuBLiR82gQW55Klb6SY0uPiAN2uNoyQBEI/ZawNJpKhiio3pY1CWtRb/dWzg2RG0cTgQRvWyn3mgbITV7SW++6ZVJEyYjqu4+pGnSJF8KwJhnHknT9t0Ahoiiug8J5+k02RtAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I/PDbpu2; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I/PDbpu2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761913192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QdTeBVN/ilJ1FssJEyKSoAQftpG+92VQsGr2mpeorCA=;
	b=I/PDbpu2Q5lrX28chT3ap81I+PnSUyIVnqUg6cme2gewMbc56R8C4aZxFNI+Sr3DbHCMD4
	MFoHcT1VmnmZ7YZJNdUbHgZgnNbIVgpgkSQNfx+Qdz4XM+cUZewiohfm56r2cBtDEC2JE+
	ucyC2ErFHw8pjSBQ6OiHhsKoHH/QAfc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform: Replace deprecated strcpy in platform_device_alloc
Date: Fri, 31 Oct 2025 13:18:58 +0100
Message-ID: <20251031121858.156686-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

First, use struct_size(), which provides additional compile-time checks
for structures with flexible array members (e.g., __must_be_array()), to
calculate the number of bytes to allocate for a new 'platform_object'.

Then, since we know the length of 'name' and that it is guaranteed to be
NUL-terminated, replace the deprecated strcpy() with a simple memcpy().

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/base/platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 09450349cf32..55ec4fb023e2 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/overflow.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -577,10 +578,11 @@ static void platform_device_release(struct device *dev)
 struct platform_device *platform_device_alloc(const char *name, int id)
 {
 	struct platform_object *pa;
+	size_t name_len = strlen(name);
 
-	pa = kzalloc(sizeof(*pa) + strlen(name) + 1, GFP_KERNEL);
+	pa = kzalloc(struct_size(pa, name, name_len + 1), GFP_KERNEL);
 	if (pa) {
-		strcpy(pa->name, name);
+		memcpy(pa->name, name, name_len + 1);
 		pa->pdev.name = pa->name;
 		pa->pdev.id = id;
 		device_initialize(&pa->pdev.dev);
-- 
2.51.1

