Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E081B28C5AB
	for <linux-hardening@vger.kernel.org>; Tue, 10 Jun 2025 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552119; cv=none; b=VMY2wjlwHvV6Ces4xZ1FhYW+/iaWphuNRX2zZ2x+yE2fe5GAYdWk+H9Y7g1nAMQPIn14hmp52P1sEbVw3JnPtG+fDnaRHYfV+MaJ/oYhNfKPHuq+RfNvQvZhDn5077TET3P5Qhh5lkkqwhB4cE2l9GXaxTY5qQszXQlUyWk7MAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552119; c=relaxed/simple;
	bh=HrubCorwEI4QzVE/jzPQeSmrMn2QE2G/08itsfpnLpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOYQRu9mtPnEUVa2JEuTzeQR+e2e8C3hFHsqrkjxLZwiicrXqdXOUf4iNa4menriNPFT5NEcnl+DHX5eIm3Q0Y6m5DgXDDq51dnEY/5jHsEsNtcWiYxQOEBSEoSrZL4aNK8WZsmDjDSBHXLMUjpF4rTni8vjti/Qw6axB7FxjeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eZjAL4LM; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eZjAL4LM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749552114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rEgV8+jcHG8DYIUGohYSskDCUEUrKKBIFZXspFzbGyU=;
	b=eZjAL4LMXs5XY5pP0nCn1K//1kwYiqhXDNFRKcOLNmTKxhVLJkgeAWDwMVDvQmMEgzSx8S
	/GhKEdKpKEsx0fHSwZonkrZTUIXhRuBI9LI3coOFYXEpuO7y83J53BGW+j9BLQ8yu5fWdC
	Miv76Au4XAj/ldFz52sOugUd/Ifeb/A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Rosin <peda@axentia.se>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RESEND] mux: Convert mux_control_ops to a flex array member in mux_chip
Date: Tue, 10 Jun 2025 12:40:59 +0200
Message-ID: <20250610104106.1948-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Convert mux_control_ops to a flexible array member at the end of the
mux_chip struct and add the __counted_by() compiler attribute to
improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Use struct_size() to calculate the number of bytes to allocate for a new
mux chip and to remove the following Coccinelle/coccicheck warning:

  WARNING: Use struct_size

Use size_add() to safely add any extra bytes.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/83
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/mux/core.c         | 7 +++----
 include/linux/mux/driver.h | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 02be4ba37257..a3840fe0995f 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -98,13 +98,12 @@ struct mux_chip *mux_chip_alloc(struct device *dev,
 	if (WARN_ON(!dev || !controllers))
 		return ERR_PTR(-EINVAL);
 
-	mux_chip = kzalloc(sizeof(*mux_chip) +
-			   controllers * sizeof(*mux_chip->mux) +
-			   sizeof_priv, GFP_KERNEL);
+	mux_chip = kzalloc(size_add(struct_size(mux_chip, mux, controllers),
+				    sizeof_priv),
+			   GFP_KERNEL);
 	if (!mux_chip)
 		return ERR_PTR(-ENOMEM);
 
-	mux_chip->mux = (struct mux_control *)(mux_chip + 1);
 	mux_chip->dev.class = &mux_class;
 	mux_chip->dev.type = &mux_type;
 	mux_chip->dev.parent = dev;
diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
index 18824064f8c0..e58e59354e23 100644
--- a/include/linux/mux/driver.h
+++ b/include/linux/mux/driver.h
@@ -56,18 +56,18 @@ struct mux_control {
 /**
  * struct mux_chip -	Represents a chip holding mux controllers.
  * @controllers:	Number of mux controllers handled by the chip.
- * @mux:		Array of mux controllers that are handled.
  * @dev:		Device structure.
  * @id:			Used to identify the device internally.
  * @ops:		Mux controller operations.
+ * @mux:		Array of mux controllers that are handled.
  */
 struct mux_chip {
 	unsigned int controllers;
-	struct mux_control *mux;
 	struct device dev;
 	int id;
 
 	const struct mux_control_ops *ops;
+	struct mux_control mux[] __counted_by(controllers);
 };
 
 #define to_mux_chip(x) container_of((x), struct mux_chip, dev)
-- 
2.49.0

