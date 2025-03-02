Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB7F6F30C
	for <linux-hardening@vger.kernel.org>; Sun,  2 Mar 2025 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740956600; cv=none; b=NIiYu4U9G9f/INBObTgUwlBnfPyPEsWDOdLss5wAOhOWGihIeRvZEeIn60kIAlztnC/g4nvNIEZJRAvtQt4TeJlavEgFcwg/j6kbJ0KXrutWlXoS7OcI4WStHUL8BYsZw3HBrtiwmyuHHAxfLpVecgiEoHLJ5lDrgUX+SQSptKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740956600; c=relaxed/simple;
	bh=arFG12Yyu9BZtG4uWu4Apb7FX2TG1iTEcCqqDfZXUVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGwwBkxr+DbYjvtUm9FQwZpCWk5XBaqqC96Iug7wNLLV1mv/VYx/xZ5u2I8VIslBtWxZRp2PPU7IslxEgoGyxSP+15IY/qlYZ/b/FoE4SrZIvzP+OSgnPza7j38mrV8qQBiXWX5GpZv/RS5uDV6cXSahuwHyPD/Mtd98ID+Rom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J/lPjiuJ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J/lPjiuJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740956597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/oHcAJH8k19ImnwHTRjOmi9oEpJN71Gn5cUukOMpM5A=;
	b=J/lPjiuJfgPxSgs6X6siWydcPqBB7avPxqpi5TwQi/3Vqq5QfiB3rZ4tG9Htkak9YGRVRi
	ocP4kzXuTjuEdv1EXVrvMEsajVfrKkCrtwWanvArzBZCSbN8djjbmxBe0oQLh8GN+c0GAO
	MYFOIT+/dZ6pE1Hw65XEq12E9Qctww0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Rosin <peda@axentia.se>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RESEND PATCH] mux: Convert mux_control_ops to a flex array member in mux_chip
Date: Mon,  3 Mar 2025 00:02:22 +0100
Message-ID: <20250302230220.245739-3-thorsten.blum@linux.dev>
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

Compile-tested only.

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
2.48.1

