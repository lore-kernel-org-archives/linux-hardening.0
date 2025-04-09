Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB96267706
	for <linux-hardening@vger.kernel.org>; Wed,  9 Apr 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209830; cv=none; b=MkXoUr4+3hZyCr1+mq3fpI+Xy7l4qaZJ9muldPYRS0c+Hwkqm5PRYxl6MQW16x9i4PpmMpPipHm+LZLMULoU+5tUprsvsLJXe20trbmDyUTKlsRuPzL6JzO06N0cogDGB1UX4gqwDaQmBfGQmGXdTV5mtaDOb3f7ZazLzfSqTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209830; c=relaxed/simple;
	bh=kgahAoL7ufblEvh9NqzG2XBDZNk38WB3OQl8IMfIKjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvnK55PV/EAaKPxSEZxI2Z972gbGHcOJd+Ib1UY62rLBUKcwUNyJQEdhHzUdRURWbCdGWAPwvr82DM6gYViSzaAfzbyQ80/hrshtqsSHJzgcYLOBnsGZ/j2wE3oy9sTOpvAmV2z/kxD9aVcNICKqpowNi2gyM71+cTZX1oazNUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRkLIBNr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRkLIBNr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744209827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7A4cgFEm6Ivq2NqhzzDl0sq/beq24e487WzX2/qjds=;
	b=PRkLIBNry3B7FzbHCh/WhoIM+adLBI7B08KpJ4JCleODvmvKDEvkwZ1yFSZ0fqAc+Ng32x
	wVrSJKNrPmr20Q+HCnQNCBUmkJ+PCKVh4DWeO4ciJWxx9eXwlXwpEhWyfs5DazOMgY2Q9P
	gq79a9Uf2sThsDEMKHlTnux0vgeTL9M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139--c1N5hsYM7mK2Mg-LwBvSA-1; Wed,
 09 Apr 2025 10:43:42 -0400
X-MC-Unique: -c1N5hsYM7mK2Mg-LwBvSA-1
X-Mimecast-MFC-AGG-ID: -c1N5hsYM7mK2Mg-LwBvSA_1744209820
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 112C31956053;
	Wed,  9 Apr 2025 14:43:40 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DAD0A1801747;
	Wed,  9 Apr 2025 14:43:35 +0000 (UTC)
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
Subject: [PATCH v2 09/14] mfd: zl3073x: Add macro to wait for register value bits to be cleared
Date: Wed,  9 Apr 2025 16:42:45 +0200
Message-ID: <20250409144250.206590-10-ivecera@redhat.com>
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

Sometimes in communication with the device is necessary to set
certain bit(s) in certain register and then the driver has to
wait until these bits are cleared by the device.

Add the macro for this functionality, it will be used by later
commits.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v1->v2:
* fixed macro documentation
---
 include/linux/mfd/zl3073x.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 405a66a7b3e78..7ccb796f7b9aa 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -5,6 +5,8 @@
 
 #include <linux/bug.h>
 #include <linux/cleanup.h>
+#include <linux/errno.h>
+#include <linux/iopoll.h>
 #include <linux/mutex.h>
 
 struct device;
@@ -153,4 +155,34 @@ int zl3073x_write_##_name(struct zl3073x_dev *zldev, unsigned int idx,	\
 #define ZL3073X_REG48_IDX_DEF(_name, _addr, _num, _stride)		\
 	__ZL3073X_REG_IDX_DEF(_name, _addr, 6, u64, _num, _stride)
 
+#define READ_SLEEP_US	10
+#define READ_TIMEOUT_US	2000000
+
+/**
+ * zl3073x_wait_clear_bits - wait for specific bits to be cleared
+ * @_zldev: pointer to zl3073x device
+ * @_reg: register name
+ * @_bits: bits that should be cleared
+ * @_index: optional index for indexed register
+ *
+ * The macro waits up to @READ_TIMEOUT_US microseconds for @_bits in @_reg
+ * to be cleared.
+ *
+ * Return:
+ * -ETIMEDOUT: if timeout occurred
+ *         <0: for other errors occurred during communication
+ *          0: success
+ */
+#define zl3073x_wait_clear_bits(_zldev, _reg, _bits, _index...)		\
+({									\
+	zl3073x_##_reg##_t __val;					\
+	int __rc;							\
+	if (read_poll_timeout(zl3073x_read_##_reg, __rc,		\
+			      __rc || !((_bits) & __val),		\
+			      READ_SLEEP_US, READ_TIMEOUT_US, false,	\
+			      _zldev, ##_index, &__val))		\
+		__rc = -ETIMEDOUT;					\
+	__rc;								\
+})
+
 #endif /* __LINUX_MFD_ZL3073X_H */
-- 
2.48.1

