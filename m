Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CC269819
	for <linux-hardening@vger.kernel.org>; Wed,  9 Apr 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209816; cv=none; b=uzyOqFJ4OgX+DA70hSVLoNhCjEOaxB6EgYpG2gAQd1KAeAnHUJLoixEb64zlodOpuJFkqrDuegIzmAckUQ6B5hOUVu6j4i12OdTugOeThXb64XmRYp7gQdm8+m0olv7674+M/PL4JjTI2mu6rs6BuogTM8v4grI3qBv4+0k6LDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209816; c=relaxed/simple;
	bh=DfAET7jhcBW6N8PdXpG1Kmkl/JoBkhmbtQRFfdL7RuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HD/uUMflrQuSGizfR1S31RMuaiOTz+akNmEri5PufX+ihEd85ga6zLcz/lxMQhawfQEb5rIJx0KqAQU+cjErHRtzCUOCVR+H6kXv1H16DWn+B3p5/Qz9EYbbj47wUCkIV9aReEqI6+/pKE7a3SWVcbs9jpPXZ5OlbZhN1AmdHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejkW3kE2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejkW3kE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744209813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QsqtwLh0/EsvyJRseyAyykMgGD9f8bdjnDSkTDZJdEA=;
	b=ejkW3kE2CUqsNntaGF92oBlEEB+YDcrKnIEkOCI2uZKNNCIZRIppjhv1s/EyTp8LHznI47
	kGOMxiPuxHDLKf8Z9Xi9jx9aqHsSEgXK0tyC+poDdvOUJf9ItaOD/hH8nKQRO1g7Ts3GtS
	0lNaTLA8C7x1lMvq6pmxQ0f5vZydvA4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-1z22zYYcM_eaO7uaGBbB5A-1; Wed,
 09 Apr 2025 10:43:28 -0400
X-MC-Unique: 1z22zYYcM_eaO7uaGBbB5A-1
X-Mimecast-MFC-AGG-ID: 1z22zYYcM_eaO7uaGBbB5A_1744209806
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A85D19560AB;
	Wed,  9 Apr 2025 14:43:26 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03BC01801747;
	Wed,  9 Apr 2025 14:43:21 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 06/14] mfd: zl3073x: Add macros for device registers access
Date: Wed,  9 Apr 2025 16:42:42 +0200
Message-ID: <20250409144250.206590-7-ivecera@redhat.com>
In-Reply-To: <20250409144250.206590-1-ivecera@redhat.com>
References: <20250409144250.206590-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add several macros to access device registers. These macros
defines a couple of static inline functions to ease an access
device registers. There are two types of registers, the 1st type
is a simple one that is defined by an address and size and the 2nd
type is indexed register that is defined by base address, type,
number of register instances and address stride between instances.

Examples:
__ZL3073X_REG_DEF(reg1, 0x1234, 4, u32);
__ZL3073X_REG_IDX_DEF(idx_reg2, 0x1234, 2, u16, 4, 0x10);

this defines the following functions:
int zl3073x_read_reg1(struct zl3073x_dev *dev, u32 *value);
int zl3073x_write_reg1(struct zl3073x_dev *dev, u32 value);
int zl3073x_read_idx_reg2(struct zl3073x_dev *dev, unsigned int idx,
                          u32 *value);
int zl3073x_write_idx_reg2(struct zl3073x_dev *dev, unsigned int idx,
                           u32 value);

There are also several shortcut macros to define registers with
certain bit widths: 8, 16, 32 and 48 bits.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 include/linux/mfd/zl3073x.h | 100 ++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 00dcc73aeeb34..405a66a7b3e78 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -3,6 +3,7 @@
 #ifndef __LINUX_MFD_ZL3073X_H
 #define __LINUX_MFD_ZL3073X_H
 
+#include <linux/bug.h>
 #include <linux/cleanup.h>
 #include <linux/mutex.h>
 
@@ -53,4 +54,103 @@ int zl3073x_read_reg(struct zl3073x_dev *zldev, unsigned int reg,
 int zl3073x_write_reg(struct zl3073x_dev *zldev, unsigned int reg,
 		      unsigned int len, const void *value);
 
+/**
+ * __ZL3073X_REG_DEF - Define a device register helpers
+ * @_name: register name
+ * @_addr: register address
+ * @_len: size of register value in bytes
+ * @_type: type of register value
+ *
+ * The macro defines helper functions for particular device register
+ * to access it.
+ *
+ * Example:
+ * __ZL3073X_REG_DEF(sample_reg, 0x1234, 4, u32)
+ *
+ * generates static inline functions:
+ * int zl3073x_read_sample_reg(struct zl3073x_dev *dev, u32 *value);
+ * int zl3073x_write_sample_reg(struct zl3073x_dev *dev, u32 value);
+ *
+ * Note that these functions have to be called with the device lock
+ * taken.
+ */
+#define __ZL3073X_REG_DEF(_name, _addr, _len, _type)			\
+typedef _type zl3073x_##_name##_t;					\
+static inline __maybe_unused						\
+int zl3073x_read_##_name(struct zl3073x_dev *zldev, _type * value)	\
+{									\
+	return zl3073x_read_reg(zldev, _addr, _len, value);		\
+}									\
+static inline __maybe_unused						\
+int zl3073x_write_##_name(struct zl3073x_dev *zldev, _type value)	\
+{									\
+	return zl3073x_write_reg(zldev, _addr, _len, &value);		\
+}
+
+/**
+ * __ZL3073X_REG_IDX_DEF - Define an indexed device register helpers
+ * @_name: register name
+ * @_addr: register address
+ * @_len: size of register value in bytes
+ * @_type: type of register value
+ * @_num: number of register instances
+ * @_stride: address stride between instances
+ *
+ * The macro defines helper functions for particular indexed device
+ * register to access it.
+ *
+ * Example:
+ * __ZL3073X_REG_IDX_DEF(sample_reg, 0x1234, 2, u16, 4, 0x10)
+ *
+ * generates static inline functions:
+ * int zl3073x_read_sample_reg(struct zl3073x_dev *dev, unsigned int idx,
+ *			       u32 *value);
+ * int zl3073x_write_sample_reg(struct zl3073x_dev *dev, unsigned int idx,
+ *				u32 value);
+ *
+ * Note that these functions have to be called with the device lock
+ * taken.
+ */
+#define __ZL3073X_REG_IDX_DEF(_name, _addr, _len, _type, _num, _stride)	\
+typedef _type zl3073x_##_name##_t;					\
+static inline __maybe_unused						\
+int zl3073x_read_##_name(struct zl3073x_dev *zldev, unsigned int idx,	\
+			 _type * value)					\
+{									\
+	WARN_ON(idx >= (_num));						\
+	return zl3073x_read_reg(zldev, (_addr) + idx * (_stride), _len,	\
+				value);					\
+}									\
+static inline __maybe_unused						\
+int zl3073x_write_##_name(struct zl3073x_dev *zldev, unsigned int idx,	\
+			  _type value)					\
+{									\
+	WARN_ON(idx >= (_num));						\
+	return zl3073x_write_reg(zldev, (_addr) + idx * (_stride),	\
+				 _len, &value);				\
+}
+
+/*
+ * Add register definition shortcuts for 8, 16, 32 and 48 bits
+ */
+#define ZL3073X_REG8_DEF(_name, _addr)	__ZL3073X_REG_DEF(_name, _addr, 1, u8)
+#define ZL3073X_REG16_DEF(_name, _addr)	__ZL3073X_REG_DEF(_name, _addr, 2, u16)
+#define ZL3073X_REG32_DEF(_name, _addr)	__ZL3073X_REG_DEF(_name, _addr, 4, u32)
+#define ZL3073X_REG48_DEF(_name, _addr)	__ZL3073X_REG_DEF(_name, _addr, 6, u64)
+
+/*
+ * Add indexed register definition shortcuts for 8, 16, 32 and 48 bits
+ */
+#define ZL3073X_REG8_IDX_DEF(_name, _addr, _num, _stride)		\
+	__ZL3073X_REG_IDX_DEF(_name, _addr, 1, u8, _num, _stride)
+
+#define ZL3073X_REG16_IDX_DEF(_name, _addr, _num, _stride)		\
+	__ZL3073X_REG_IDX_DEF(_name, _addr, 2, u16, _num, _stride)
+
+#define ZL3073X_REG32_IDX_DEF(_name, _addr, _num, _stride)		\
+	__ZL3073X_REG_IDX_DEF(_name, _addr, 4, u32, _num, _stride)
+
+#define ZL3073X_REG48_IDX_DEF(_name, _addr, _num, _stride)		\
+	__ZL3073X_REG_IDX_DEF(_name, _addr, 6, u64, _num, _stride)
+
 #endif /* __LINUX_MFD_ZL3073X_H */
-- 
2.48.1

