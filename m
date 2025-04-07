Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B0218AC8
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046949; cv=none; b=Jy3+zPyCOvtyLiVBS0pLsKFy6E8sjo75a0NGP8gPs2EjoISTslHIUP3bC+f9BbyYU2BUW8/fQWY4+4+NQWG662b4OgLZXymRVP/ypgJHiAtJZs4+dz1ItCH8NBiWBKXrq0BR5voQz5wMvauxVsokLADQ3rnh6RWwO2CzPjZqmFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046949; c=relaxed/simple;
	bh=0wCVLf2kJcHvkMdyauZo7zlisXxqfF6avpneNWZUZrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxz/FbPrqrk7JOfcuEUqi17cfjwHkOTAcdyW2/HvjLkf2ADT+B3fCyFIMVpUHmcy2VINIOTmCm45EldUqEYjS9sZ3gBt9989WTNfCMcDlxjn/r8HEmUBveer1jwQzm3/MTPZR0R13v2e5GOcZBlyueYVPbVt0sFqg/6VceecKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfoCk7ss; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfoCk7ss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744046946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0fBe2C1irn6omk1B6zTSlR0v1B01FIR0IrpHCwK7Uw=;
	b=EfoCk7ss2AVJmhsSopZlC3HwRhpIe6O6Om69RwuIpg3h4cUjWBXbhtwde7u3td08URMdvb
	zqRqjYZUyA4i9y78EDHJXxHmt7WE9N83rtdE79dCRiWmCq6sfA4bKUYITO9Uq/BQHDegzM
	63uK0urWk75Hd/ArtDbiNwzVfgCrpmM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-VGIaxfc_Ni6Rk6NM9QXflw-1; Mon,
 07 Apr 2025 13:29:05 -0400
X-MC-Unique: VGIaxfc_Ni6Rk6NM9QXflw-1
X-Mimecast-MFC-AGG-ID: VGIaxfc_Ni6Rk6NM9QXflw_1744046943
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D342F1801A07;
	Mon,  7 Apr 2025 17:29:02 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02A43180B488;
	Mon,  7 Apr 2025 17:28:56 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 03/28] mfd: zl3073x: Add register access helpers
Date: Mon,  7 Apr 2025 19:28:30 +0200
Message-ID: <20250407172836.1009461-4-ivecera@redhat.com>
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add helpers zl3073x_{read,write}_reg() to access device registers.
These functions have to be called with device lock that can be taken
by zl3073x_{lock,unlock}() or a caller can use defined guard.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/mfd/zl3073x-core.c  | 88 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/zl3073x.h | 32 ++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 71454f683eab0..39d4c8608a740 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/module.h>
+#include <linux/unaligned.h>
 #include <net/devlink.h>
 #include "zl3073x.h"
 
@@ -45,6 +46,93 @@ const struct regmap_config *zl3073x_get_regmap_config(void)
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_get_regmap_config, "ZL3073X");
 
+/**
+ * zl3073x_read_reg - Read value from device register
+ * @zldev: device structure pointer
+ * @reg: register to be read
+ * @len: number of bytes to read
+ * @value: pointer to place to store value read from the register
+ *
+ * Caller has to hold the device lock that can be obtained
+ * by zl3073x_lock().
+ *
+ * Returns 0 in case of success or negative value otherwise
+ */
+int zl3073x_read_reg(struct zl3073x_dev *zldev, unsigned int reg,
+		     unsigned int len, void *value)
+{
+	u8 buf[6];
+	int rc;
+
+	lockdep_assert_held(&zldev->lock);
+
+	rc = regmap_bulk_read(zldev->regmap, reg, buf, len);
+	if (rc)
+		return rc;
+
+	switch (len) {
+	case 1:
+		*(u8 *)value = buf[0];
+		break;
+	case 2:
+		*(u16 *)value = get_unaligned_be16(buf);
+		break;
+	case 4:
+		*(u32 *)value = get_unaligned_be32(buf);
+		break;
+	case 6:
+		*(u64 *)value = get_unaligned_be48(buf);
+		break;
+	default:
+		WARN(true, "Unsupported register size: %u\n", len);
+		break;
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(zl3073x_read_reg);
+
+/**
+ * zl3073x_write_reg - Write value to device register
+ * @zldev: device structure pointer
+ * @reg: register to be written
+ * @len: number of bytes to write
+ * @value: pointer to value to write to the register
+ *
+ * Caller has to hold the device lock that can be obtained
+ * by zl3073x_lock().
+ *
+ * Returns 0 in case of success or negative value otherwise
+ */
+int zl3073x_write_reg(struct zl3073x_dev *zldev, unsigned int reg,
+		      unsigned int len, const void *value)
+{
+	u8 buf[6];
+
+	lockdep_assert_held(&zldev->lock);
+
+	switch (len) {
+	case 1:
+		buf[0] = *(u8 *)value;
+		break;
+	case 2:
+		put_unaligned_be16(*(u16 *)value, buf);
+		break;
+	case 4:
+		put_unaligned_be32(*(u32 *)value, buf);
+		break;
+	case 6:
+		put_unaligned_be48(*(u64 *)value, buf);
+		break;
+	default:
+		WARN(true, "Unsupported register size: %u\n", len);
+		break;
+	}
+
+	return regmap_bulk_write(zldev->regmap, reg, buf, len);
+}
+EXPORT_SYMBOL_GPL(zl3073x_write_reg);
+
 static const struct devlink_ops zl3073x_devlink_ops = {
 };
 
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 7b80c3059b5f3..0156f9044d79d 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -12,4 +12,36 @@ struct zl3073x_dev {
 	struct mutex		lock;
 };
 
+/**
+ * zl3073x_lock - Lock the device
+ * @zldev: device structure pointer
+ *
+ * Caller has to take this lock when it needs to access device registers.
+ */
+static inline void zl3073x_lock(struct zl3073x_dev *zldev)
+{
+	mutex_lock(&zldev->lock);
+}
+
+/**
+ * zl3073x_unlock - Unlock the device
+ * @zldev: device structure pointer
+ *
+ * Caller unlocks the device when it does not need to access device
+ * registers anymore.
+ */
+static inline void zl3073x_unlock(struct zl3073x_dev *zldev)
+{
+	mutex_unlock(&zldev->lock);
+}
+
+DEFINE_GUARD(zl3073x, struct zl3073x_dev *, zl3073x_lock(_T),
+	     zl3073x_unlock(_T));
+
+int zl3073x_read_reg(struct zl3073x_dev *zldev, unsigned int reg,
+		     unsigned int len, void *value);
+
+int zl3073x_write_reg(struct zl3073x_dev *zldev, unsigned int reg,
+		      unsigned int len, const void *value);
+
 #endif /* __LINUX_MFD_ZL3073X_H */
-- 
2.48.1

