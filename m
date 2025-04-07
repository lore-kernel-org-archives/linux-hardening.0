Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B79218EBD
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046977; cv=none; b=joKYRdVHk0B0IEJucQIv/yJdgZYs+dUgfusBBJuN2vxg57HCCZS+ljGrRJokVJ3XGacoxTIj1ScdwpGj0KJm6fo0mxF7xSHw6t3OuW03cAGC0v9J9kCXhna6xCp4CctUpGcyn6owq2VtN0PyHkLjBtuloxRLOiRgG6qu696MpwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046977; c=relaxed/simple;
	bh=YwQffT1aEOqjVu4z07Zs99qG9yuGlwLKY9+dxNhxdYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc17oCB7p9SZ3ncJJeVGJGj+mvFNqwhV+p8GCisMzBUB4/qoRm/W5RvSCyeW2QLoGCia+B5Lip0RjUxlda5MqQCBlmASJKgQDZyY2lYeSCX7gMo5LtKWCyZwaplXKtRUKBVns/V4wYtMhpS2N+2CNBV3alxur2MEmAEcsWBSKdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D08m+zu6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D08m+zu6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744046974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tuo2BZQlvc9qC7nHzNWOv25fLG9mfraZRBCulBhhTKU=;
	b=D08m+zu6sZUOMXqW4vM5vu30wWOK+YF5Tv2/s2sUUJeE4g0d/+QmfmsklM0np/KVyJALkH
	Jnk2WI9K8ju/tPPbhs8L9w4mDojIs3zdzeG+sAjP3vZVce/HtYj/mu5NoATuGq31weizME
	XMBh8E70cXgE/0ejXIvJ0khkSAhKa3w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-TTjZY9N5OYaat_BzfeyQrQ-1; Mon,
 07 Apr 2025 13:29:30 -0400
X-MC-Unique: TTjZY9N5OYaat_BzfeyQrQ-1
X-Mimecast-MFC-AGG-ID: TTjZY9N5OYaat_BzfeyQrQ_1744046968
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 780A91801A1A;
	Mon,  7 Apr 2025 17:29:28 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6684180A803;
	Mon,  7 Apr 2025 17:29:22 +0000 (UTC)
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
Subject: [PATCH 07/28] mfd: zl3073x: Add macro to wait for register value bits to be cleared
Date: Mon,  7 Apr 2025 19:28:34 +0200
Message-ID: <20250407172836.1009461-8-ivecera@redhat.com>
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

Sometimes in communication with the device is necessary to set
certain bit(s) in certain register and then the driver has to
wait until these bits are cleared by the device.

Add the macro for this functionality, it will be used by later
commits.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 include/linux/mfd/zl3073x.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 3524426f0e3ba..15dfb0d8bf3cb 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -143,4 +143,33 @@ int zl3073x_write_##_name(struct zl3073x_dev *zldev, unsigned int idx,	\
 #define ZL3073X_REG48_IDX_DEF(_name, _addr, _num, _stride)		\
 	__ZL3073X_REG_IDX_DEF(_name, _addr, 6, u64, _num, _stride)
 
+/**
+ * zl3073x_wait_clear_bits - wait for specific bits to be cleared
+ * _zldev: pointer to device structure
+ * _reg: register name
+ * _bits: bits that should be cleared
+ * _index: optional index for indexed register
+ *
+ * The macro waits up to @READ_TIMEOUT_US microseconds for @_bits in @_reg
+ * to be cleared.
+ *
+ * Returns:
+ * -ETIMEDOUT: if timeout occurred
+ *         <0: for other errors occurred during communication
+ *          0: success
+ */
+#define READ_SLEEP_US	10
+#define READ_TIMEOUT_US	2000000
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

