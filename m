Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E32217679
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046970; cv=none; b=nZuUWTGpxMTZcfwvLBGP34zFug3tUDBJg2rDRHl2ZZIC2BTy7mj+CrPd9wWU+8qVdkQ12wplC0YuotEiB4weT+7yPi70G3BgQVkdnTDnHEtxPG5ES/+Pc6l7oUYS1yJ1NrgTBTHDzFLORYoH2NBu0RPaYjX1BfTynk4LWMwuCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046970; c=relaxed/simple;
	bh=FNVfDjiAs80CxSrgw2joIxTPr3R1fwS+JdUgXRyMHws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjWqNl1IClgLAoKuXtd4GcYuTPUqHqbq1EK8QGVvYC/Lf+URrHVBaPLUaDYcKRIhk8gzu8IpQYIH68tl1rS6zzkNgdX9hwoeQV3ycVgzuu2GjOl3indNLLNyjbrbt5kLZfcgKiOSOn9/iHExZ3sv4ac47FQNXLzihqRR3eEnW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gT02RBSN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gT02RBSN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744046968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuEW/SGI3isu0yVFd6QA70OIZUfyWajvSLe1fJC9qPY=;
	b=gT02RBSN/npL/8v5d+NYNIGFLY9IfNDCCD/t5XNqGa87qlYIbrDu3WK/P/E44RvdV+2pJ3
	dLN9e9SePpKSR1R001LzGRnPjGI4hzvecp8Z2PiLp3mkPk2bCw0f4AJ4uB7veIWegoWnfy
	TJIANcfOsBXbc8zd1w5uO93UR0YOztI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-ERpXse5eN2usobjcXKM-7g-1; Mon,
 07 Apr 2025 13:29:24 -0400
X-MC-Unique: ERpXse5eN2usobjcXKM-7g-1
X-Mimecast-MFC-AGG-ID: ERpXse5eN2usobjcXKM-7g_1744046962
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 372AE1955DC6;
	Mon,  7 Apr 2025 17:29:22 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A49DE1828AA4;
	Mon,  7 Apr 2025 17:29:16 +0000 (UTC)
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
Subject: [PATCH 06/28] mfd: zl3073x: Implement devlink device info
Date: Mon,  7 Apr 2025 19:28:33 +0200
Message-ID: <20250407172836.1009461-7-ivecera@redhat.com>
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

Provide ASIC ID, ASIC revision, firmware version and optionally
custom config version through devlink device info.

Sample output:
 # devlink dev
 i2c/1-0070
 # devlink dev info
 i2c/1-0070:
   driver zl3073x-i2c
   versions:
       fixed:
         asic.id 1E94
         asic.rev 300
         fw 7006

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/mfd/zl3073x-core.c | 73 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index b3091b00cffa8..33e76666e5694 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -142,7 +142,80 @@ int zl3073x_write_reg(struct zl3073x_dev *zldev, unsigned int reg,
 }
 EXPORT_SYMBOL_GPL(zl3073x_write_reg);
 
+/**
+ * zl3073x_devlink_info_get - Devlink device info callback
+ * @devlink: devlink structure pointer
+ * @req: devlink request pointer to store information
+ * @extack: netlink extack pointer to report errors
+ *
+ * Returns 0 in case of success or negative value otherwise
+ */
+static int zl3073x_devlink_info_get(struct devlink *devlink,
+				    struct devlink_info_req *req,
+				    struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dev *zldev = devlink_priv(devlink);
+	u16 id, revision, fw_ver;
+	char buf[16];
+	u32 cfg_ver;
+	int rc;
+
+	guard(zl3073x)(zldev);
+
+	rc = zl3073x_read_id(zldev, &id);
+	if (rc)
+		return rc;
+
+	snprintf(buf, sizeof(buf), "%X", id);
+	rc = devlink_info_version_fixed_put(req,
+					DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
+					buf);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_revision(zldev, &revision);
+	if (rc)
+		return rc;
+
+	snprintf(buf, sizeof(buf), "%X", revision);
+	rc = devlink_info_version_fixed_put(req,
+					DEVLINK_INFO_VERSION_GENERIC_ASIC_REV,
+					buf);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_fw_ver(zldev, &fw_ver);
+	if (rc)
+		return rc;
+
+	snprintf(buf, sizeof(buf), "%u", fw_ver);
+	rc = devlink_info_version_fixed_put(req,
+					    DEVLINK_INFO_VERSION_GENERIC_FW,
+					    buf);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_custom_config_ver(zldev, &cfg_ver);
+	if (rc)
+		return rc;
+
+	/* No custom config version */
+	if (cfg_ver == U32_MAX)
+		return rc;
+
+	snprintf(buf, sizeof(buf), "%lu.%lu.%lu.%lu",
+		 FIELD_GET(GENMASK(31, 24), cfg_ver),
+		 FIELD_GET(GENMASK(23, 16), cfg_ver),
+		 FIELD_GET(GENMASK(15, 8), cfg_ver),
+		 FIELD_GET(GENMASK(7, 0), cfg_ver));
+
+	rc = devlink_info_version_running_put(req, "cfg.custom_ver", buf);
+
+	return rc;
+}
+
 static const struct devlink_ops zl3073x_devlink_ops = {
+	.info_get = zl3073x_devlink_info_get,
 };
 
 static void zl3073x_devlink_free(void *ptr)
-- 
2.48.1

