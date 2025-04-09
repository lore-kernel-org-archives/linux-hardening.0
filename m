Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D226B2C8
	for <linux-hardening@vger.kernel.org>; Wed,  9 Apr 2025 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209835; cv=none; b=MTLkwH/NKlGbc1rAKexhiewzDupACeEZXPOdUgI2nqfjhXqzdQbmPg2k641SvIM+TSitNcZZc2JJzs5GJWFU1pPgOvmhri3j+xnu87GlIOKzss+HMbuF8Up1u9FmN/eAWK225NhC91JsxViYmvX9MNzjnB0npDEK2anST7FFU/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209835; c=relaxed/simple;
	bh=0WHNQiXpJvbJn36AQLX85Aj3fyJzWdmCgnrQ+kDFAaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dj3sB5ufAGS5jjeJ9Bj3XuW8bfUM/rhBpf+HWO/JRhTEduIdR7/t6HXL6IEzfRjug9D+9bXoVyJ89aD/esELCxmnHKQRMFx63gDlZWZTITZETQr7qG7y76qd3h/XqG4s42Oe7Ua87vbiwgwQOZ7wsgd8IUSCMb85d2O08EtR0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZztA1yUq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZztA1yUq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744209832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K5vDEFdTDW9rK5SeS+wbVHo4HvuIgpuVG9l7fqiTse4=;
	b=ZztA1yUqKjSrmOn2KApwttL9T2UGrOVX3W9ab/KqZliKzLUshnOdSVgSnJPeriEWuYEw+j
	qTg8MziphnHXMfwUt5u3ElyZryGtr50NJc7eXrupxNoc2a0x2VirKoTKYUfoC9LngoCiud
	Gyk1wRV+jmh2J2+L95+kon57SJMgzns=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-i2pyDEzwMp26sAM6T3NXZg-1; Wed,
 09 Apr 2025 10:43:47 -0400
X-MC-Unique: i2pyDEzwMp26sAM6T3NXZg-1
X-Mimecast-MFC-AGG-ID: i2pyDEzwMp26sAM6T3NXZg_1744209825
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 157DF180AF56;
	Wed,  9 Apr 2025 14:43:45 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79BC818009BC;
	Wed,  9 Apr 2025 14:43:40 +0000 (UTC)
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
Subject: [PATCH v2 10/14] mfd: zl3073x: Add functions to work with register mailboxes
Date: Wed,  9 Apr 2025 16:42:46 +0200
Message-ID: <20250409144250.206590-11-ivecera@redhat.com>
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

Registers present in page 10 and higher are organized in so-called
register mailboxes. These mailboxes are used to read and write
configuration of particular object (dpll, output, reference & synth).

Each of these register pages contains mask register that is used by
the driver to indicate an index of requested object to work with and
also semaphore register to indicate what operation is requested.
The rest of registers in the particular register page are latch
registers that are filled by the firmware during read operation or by
the driver prior write operation.

For read operation the driver...
1) ... updates the mailbox mask register with index of particular object
2) ... sets the mailbox semaphore register read bit
3) ... waits for the semaphore register read bit to be cleared by FW
4) ... reads the configuration from latch registers

For write operation the driver...
1) ... writes the requested configuration to latch registers
2) ... sets the mailbox mask register for the DPLL to be updated
3) ... sets the mailbox semaphore register bit for the write operation
4) ... waits for the semaphore register bit to be cleared by FW

Add functions to read and write mailboxes for all supported object types.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/mfd/zl3073x-core.c  | 193 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/zl3073x.h |  12 +++
 2 files changed, 205 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 79cf2ddbca228..f606c51c90fdf 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -25,6 +25,47 @@ ZL3073X_REG16_DEF(revision,		0x0003);
 ZL3073X_REG16_DEF(fw_ver,		0x0005);
 ZL3073X_REG32_DEF(custom_config_ver,	0x0007);
 
+/*
+ * Register Map Page 10, Ref Mailbox
+ */
+ZL3073X_REG16_DEF(ref_mb_mask,			0x502);
+#define REF_MB_MASK				GENMASK(9, 0)
+
+ZL3073X_REG8_DEF(ref_mb_sem,			0x504);
+#define REF_MB_SEM_WR				BIT(0)
+#define REF_MB_SEM_RD				BIT(1)
+
+/*
+ * Register Map Page 12, DPLL Mailbox
+ */
+ZL3073X_REG16_DEF(dpll_mb_mask,			0x602);
+
+ZL3073X_REG8_DEF(dpll_mb_sem,			0x604);
+#define DPLL_MB_SEM_WR				BIT(0)
+#define DPLL_MB_SEM_RD				BIT(1)
+
+/*
+ * Register Map Page 13, Synth Mailbox
+ */
+ZL3073X_REG16_DEF(synth_mb_mask,		0x682);
+
+ZL3073X_REG8_DEF(synth_mb_sem,			0x684);
+#define SYNTH_MB_SEM_WR				BIT(0)
+#define SYNTH_MB_SEM_RD				BIT(1)
+
+ZL3073X_REG16_DEF(synth_freq_base,		0x686);
+ZL3073X_REG32_DEF(synth_freq_mult,		0x688);
+ZL3073X_REG16_DEF(synth_freq_m,			0x68c);
+ZL3073X_REG16_DEF(synth_freq_n,			0x68e);
+
+/*
+ * Register Map Page 14, Output Mailbox
+ */
+ZL3073X_REG16_DEF(output_mb_mask,		0x702);
+ZL3073X_REG8_DEF(output_mb_sem,			0x704);
+#define OUTPUT_MB_SEM_WR			BIT(0)
+#define OUTPUT_MB_SEM_RD			BIT(1)
+
 /*
  * Regmap ranges
  */
@@ -161,6 +202,158 @@ int zl3073x_write_reg(struct zl3073x_dev *zldev, unsigned int reg,
 }
 EXPORT_SYMBOL_GPL(zl3073x_write_reg);
 
+/**
+ * ZL3073X_MB_OP - perform an operation on mailbox of certain type
+ * @_zldev: pointer to device structure
+ * @_type: type of mailbox (dpll, ref or output)
+ * @_index: object index of given type
+ * @_op: operation to perform
+ *
+ * Performs the requested operation on mailbox of certain type and
+ * returns 0 in case of success or negative value otherwise.
+ */
+#define ZL3073X_MB_OP(_zldev, _type, _index, _op)			\
+({									\
+	struct zl3073x_dev *__zldev = (_zldev);				\
+	u16 __mask = BIT(_index);					\
+	u8 __op = (_op);						\
+	int __rc;							\
+	do {								\
+		/* Select requested index in mask register */		\
+		__rc = zl3073x_write_##_type##_mb_mask(__zldev, __mask);\
+		if (__rc)						\
+			break;						\
+		/* Select requested command */				\
+		__rc = zl3073x_write_##_type##_mb_sem(__zldev, __op);	\
+		if (__rc)						\
+			break;						\
+		/* Wait for the command to actually finish */		\
+		__rc = zl3073x_wait_clear_bits(__zldev, _type##_mb_sem,	\
+					       __op);			\
+	} while (0);							\
+	__rc;								\
+})
+
+/**
+ * zl3073x_mb_dpll_read - read given DPLL configuration to mailbox
+ * @zldev: pointer to device structure
+ * @index: DPLL index
+ *
+ * Reads configuration of given DPLL into DPLL mailbox.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index)
+{
+	return ZL3073X_MB_OP(zldev, dpll, index, DPLL_MB_SEM_RD);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_dpll_read);
+
+/**
+ * zl3073x_mb_dpll_write - write given DPLL configuration from mailbox
+ * @zldev: pointer to device structure
+ * @index: DPLL index
+ *
+ * Writes (commits) configuration of given DPLL from DPLL mailbox.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_dpll_write(struct zl3073x_dev *zldev, u8 index)
+{
+	return ZL3073X_MB_OP(zldev, dpll, index, DPLL_MB_SEM_WR);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_dpll_write);
+
+/**
+ * zl3073x_mb_output_read - read given output configuration to mailbox
+ * @zldev: pointer to device structure
+ * @index: output index
+ *
+ * Reads configuration of given output into output mailbox.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_output_read(struct zl3073x_dev *zldev, u8 index)
+{
+	return ZL3073X_MB_OP(zldev, output, index, OUTPUT_MB_SEM_RD);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_output_read);
+
+/**
+ * zl3073x_mb_output_write - write given output configuration from mailbox
+ * @zldev: pointer to device structure
+ * @index: DPLL index
+ *
+ * Writes (commits) configuration of given output from output mailbox.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_output_write(struct zl3073x_dev *zldev, u8 index)
+{
+	return ZL3073X_MB_OP(zldev, output, index, OUTPUT_MB_SEM_WR);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_output_write);
+
+/**
+ * zl3073x_mb_ref_read - read given reference configuration to mailbox
+ * @zldev: pointer to device structure
+ * @index: reference index
+ *
+ * Reads configuration of given reference into reference mailbox.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index)
+{
+	return ZL3073X_MB_OP(zldev, ref, index, REF_MB_SEM_RD);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_ref_read);
+
+/**
+ * zl3073x_mb_ref_write - write given reference configuration from mailbox
+ * @zldev: pointer to device structure
+ * @index: reference index
+ *
+ * Writes (commits) configuration of given reference from reference mailbox.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index)
+{
+	return ZL3073X_MB_OP(zldev, ref, index, REF_MB_SEM_WR);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_ref_write);
+
+/**
+ * zl3073x_mb_synth_read - read given synth configuration to mailbox
+ * @zldev: pointer to device structure
+ * @index: synth index
+ *
+ * Reads configuration of given synth into synth mailbox.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index)
+{
+	return ZL3073X_MB_OP(zldev, synth, index, SYNTH_MB_SEM_RD);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_synth_read);
+
+/**
+ * zl3073x_mb_synth_write - write given synth configuration from mailbox
+ * @zldev: pointer to device structure
+ * @index: synth index
+ *
+ * Writes (commits) configuration of given synth from reference mailbox.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index)
+{
+	return ZL3073X_MB_OP(zldev, synth, index, SYNTH_MB_SEM_WR);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_synth_write);
+
 /**
  * zl3073x_devlink_info_get - Devlink device info callback
  * @devlink: devlink structure pointer
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 7ccb796f7b9aa..cc80014ebb384 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -185,4 +185,16 @@ int zl3073x_write_##_name(struct zl3073x_dev *zldev, unsigned int idx,	\
 	__rc;								\
 })
 
+/*
+ * Mailbox operations
+ */
+int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_mb_dpll_write(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_mb_output_read(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_mb_output_write(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index);
+
 #endif /* __LINUX_MFD_ZL3073X_H */
-- 
2.48.1

