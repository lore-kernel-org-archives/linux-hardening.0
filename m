Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886072185AB
	for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787477; cv=none; b=uKcN5brrwjYfQ0tPXU9cUp2TpzXEw2CmmDFYkfFP8zXW+DJ2hUoDktFPkOX6GCJ+8GBR6GyStTgi7zjDeAtyP8ByNH4pA/i2iEwynAPwdqNAOSe1TIITyUAbmzPFX5IH4f3zHXr7RIg+qBOtiMMQMO4EhrUiiNTj+y7/CtSY4DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787477; c=relaxed/simple;
	bh=qZuC7gqK3WcrD0D+coZGKMDI2mB55tzfLWIMdlAFyjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3HFe6KfNpHwezjrf2fjrTgRpD0CSluoxacYkyy19Y3sT1KdRe+1Tz4GIiotuo6enxCIfy4oeyhDMfNeCXy/ihBYb9e++UjEFjigM5lcDzPI5c3bANwO67I4wqFzqcOIcHWKZhs4FCldM51+MyGumzaFhSaoyMnwmPfCTk2ZfDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qf+kVBpn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qf+kVBpn"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4396424d173so39686145e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 02:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787472; x=1740392272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QifBQ/xg2RCUDrB4vfDq4gu1LJ6B/77pKMAfIESueUs=;
        b=qf+kVBpncy34FC7bO2z9mojDXe9X2yIqPsq6y76Q6r26W8QXO9H8rhGDTTuNDZbrbB
         /aaEvTV2uznjRgon9i0sGXZ2ttSgXWO/3XRKNVFY0UxqYgpIbC7SEqYFJwBbFmZ02yb/
         sTV/CyVcHAN1PlMfXQz6Hde2ieMhan2p428sE4LMGiudGAiFuI3/dz7XMMNxxHXsWpAL
         0kGu0XEKlUOm0bu19yNYc7RLyB3BToZsKVe2897M4uZm5q567NaxUGXlMh0hpyl60QQp
         XnA1VKUlitlYVluh8UHZV8CCpvpTjTNoFRcfL47xM8phYHgocNZpDMq/2JsAhzA9G64H
         QxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787472; x=1740392272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QifBQ/xg2RCUDrB4vfDq4gu1LJ6B/77pKMAfIESueUs=;
        b=QlGEom9Wj3Ol89KkpHb8uDvIlSoiippEYMkLuHqAciFXjs1mH9Cyu1najPQEZheCnN
         tIvT/4blgvuyDXzeNYg+UpzM4Er6Ki5BLtVrT/vM8Jija35ne/JbpXBCYPOBnuyUY/kF
         0uWVvlTDIFUQko8nXqR2tWDgroafOY7vjK0m8Hmiy4cUEidzJjwPESTVd4oA24XDAjXQ
         ap2FOiz+ipzqQ963xpZJKv229H/OCQMKL4VIVPMelSJE1ISR3X0jSbrz/00LCs0Vl432
         8R9so3jYyLZ18WmogMQABKRJw0mbEtWwnGRqB5qcgdvBlEacElD9ORybwQ4gE0O8aNnY
         D+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCV97RzCI2jn2AS56zZntSQRtmgSWjua0quaLXP9Q/zUK/KGBAh8s7J9zTlblhWQZl4V/eGl2snOfuQ9FBCnI68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze6Up4xaqrcZElHhqwrNjIKEZ0gDA3rE6W7p+JpfCocUkZ3Vko
	cV+sQdhp5Ut3QzKgcatd6HywtQJv2J3FAX6MLMJA9UzHstINHW0NbCrW4XVwiCU=
X-Gm-Gg: ASbGncs2Qlo1O8vC26JDspW06nN4NIjdBiSuS7Sxdlvs20JAH/NAKavBJV/U81EPfon
	WY87vWdZqdRLNubcMHNg6y5d1xRfgwzRAdYNEjW4iOTmA3u+VdKdU5d0XiuOlNIad6UOK45AxvV
	nuo7L0T0+K4uoe3r4nDjq2KtH6OkA0cChoaGbiyY9E+D9fhrqqoES9zXWwiSlyNdkUSRq3djA5J
	tI7CPQQid2EE3peoRP3xrVyilhIpBRKrRnZlgORxi3xOV+/uM4NOJeosR3ZtHU6svcT8HI/7ECq
	Njnfsfe47DdLGJ2JTabnNsax
X-Google-Smtp-Source: AGHT+IHXaznwSyo3YbfYL/R4+3M72WRvyCNEfigOhBxj8g1XzyEDxhWvwflhOeb8uHLrPz5EryyeQA==
X-Received: by 2002:a5d:5f4a:0:b0:38f:4244:68cb with SMTP id ffacd0b85a97d-38f42446bfbmr3184326f8f.12.1739787471737;
        Mon, 17 Feb 2025 02:17:51 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm308583266b.174.2025.02.17.02.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:17:51 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	quic_mojha@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH 04/10] qcom: smem: add pstore smem backend
Date: Mon, 17 Feb 2025 12:17:00 +0200
Message-ID: <20250217101706.2104498-5-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217101706.2104498-1-eugen.hristev@linaro.org>
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for pstore smem backend in the qcom smem driver.
This backend resorts to minidump regions behind the scenes.

Co-developed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 drivers/soc/qcom/Kconfig       |   9 +
 drivers/soc/qcom/Makefile      |   6 +-
 drivers/soc/qcom/smem_md.c     | 306 +++++++++++++++++++++++++++++++++
 drivers/soc/qcom/smem_pstore.c | 112 ++++++++++++
 include/linux/soc/qcom/smem.h  |  43 +++++
 5 files changed, 474 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/qcom/smem_md.c
 create mode 100644 drivers/soc/qcom/smem_pstore.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 58e63cf0036b..e1c71f713c05 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -180,6 +180,15 @@ config QCOM_SMEM
 	  The driver provides an interface to items in a heap shared among all
 	  processors in a Qualcomm platform.
 
+config QCOM_SMEM_PSTORE
+	bool "Qualcomm Shared Memory(SMEM) Pstore backend"
+	depends on QCOM_SMEM
+	select PSTORE
+	select PSTORE_SMEM
+	help
+	  Say y here to enable the shared memory driver to register itself
+	  as a pstore backend.
+
 config QCOM_SMD_RPM
 	tristate "Qualcomm Resource Power Manager (RPM) over SMD"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index acbca2ab5cc2..304b031ed70e 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -23,8 +23,10 @@ obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
 qcom_rpmh-y			+= rpmh-rsc.o
 qcom_rpmh-y			+= rpmh.o
 obj-$(CONFIG_QCOM_SMD_RPM)	+= rpm-proc.o smd-rpm.o
-obj-$(CONFIG_QCOM_SMEM) +=	smem.o
-obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
+obj-$(CONFIG_QCOM_SMEM) += qcom_smem.o
+qcom_smem-y += smem.o
+qcom_smem-$(CONFIG_QCOM_SMEM_PSTORE) += smem_pstore.o smem_md.o
+obj-$(CONFIG_QCOM_SMEM_STATE)	+= smem_state.o
 CFLAGS_smp2p.o := -I$(src)
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
diff --git a/drivers/soc/qcom/smem_md.c b/drivers/soc/qcom/smem_md.c
new file mode 100644
index 000000000000..2b665ecc5695
--- /dev/null
+++ b/drivers/soc/qcom/smem_md.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/hwspinlock.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/devcoredump.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
+#include <linux/dma-mapping.h>
+#include <linux/pstore_smem.h>
+#include <linux/pstore_zone.h>
+#include <linux/pstore.h>
+
+#define MAX_NUM_ENTRIES	  201
+#define MAX_STRTBL_SIZE	  (MAX_NUM_ENTRIES * MAX_REGION_NAME_LENGTH)
+
+#define MAX_NUM_OF_SS           10
+#define MAX_REGION_NAME_LENGTH  16
+#define SBL_MINIDUMP_SMEM_ID	602
+#define MINIDUMP_REGION_VALID	   ('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
+#define MINIDUMP_SS_ENCR_DONE	   ('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
+#define MINIDUMP_SS_ENABLED	   ('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
+#define MINIDUMP_REGION_INVALID	   ('I' << 24 | 'N' << 16 | 'V' << 8 | 'A' << 0)
+#define MINIDUMP_REGION_INIT	   ('I' << 24 | 'N' << 16 | 'I' << 8 | 'T' << 0)
+#define MINIDUMP_REGION_NOINIT	   0
+
+#define MINIDUMP_SS_ENCR_REQ	   (0 << 24 | 'Y' << 16 | 'E' << 8 | 'S' << 0)
+#define MINIDUMP_SS_ENCR_NOTREQ	   (0 << 24 | 0 << 16 | 'N' << 8 | 'R' << 0)
+#define MINIDUMP_SS_ENCR_START	   ('S' << 24 | 'T' << 16 | 'R' << 8 | 'T' << 0)
+
+#define MINIDUMP_APSS_DESC	   0
+
+/**
+ * struct minidump - Minidump driver data information
+ * @apss_data: APSS driver data
+ * @md_lock: Lock to protect access to APSS minidump table
+ */
+struct minidump {
+	struct device		*dev;
+	struct minidump_ss_data	*apss_data;
+	struct mutex		md_lock;
+};
+
+/**
+ * struct minidump_region - Minidump region
+ * @name		: Name of the region to be dumped
+ * @seq_num:		: Use to differentiate regions with same name.
+ * @valid		: This entry to be dumped (if set to 1)
+ * @address		: Physical address of region to be dumped
+ * @size		: Size of the region
+ */
+struct minidump_region {
+	char	name[MAX_REGION_NAME_LENGTH];
+	__le32	seq_num;
+	__le32	valid;
+	__le64	address;
+	__le64	size;
+};
+
+/**
+ * struct minidump_subsystem - Subsystem's SMEM Table of content
+ * @status : Subsystem toc init status
+ * @enabled : if set to 1, this region would be copied during coredump
+ * @encryption_status: Encryption status for this subsystem
+ * @encryption_required : Decides to encrypt the subsystem regions or not
+ * @region_count : Number of regions added in this subsystem toc
+ * @regions_baseptr : regions base pointer of the subsystem
+ */
+struct minidump_subsystem {
+	__le32	status;
+	__le32	enabled;
+	__le32	encryption_status;
+	__le32	encryption_required;
+	__le32	region_count;
+	__le64	regions_baseptr;
+};
+
+/**
+ * struct minidump_global_toc - Global Table of Content
+ * @status : Global Minidump init status
+ * @md_revision : Minidump revision
+ * @enabled : Minidump enable status
+ * @subsystems : Array of subsystems toc
+ */
+struct minidump_global_toc {
+	__le32				status;
+	__le32				md_revision;
+	__le32				enabled;
+	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
+};
+/**
+ * struct minidump_ss_data - Minidump subsystem private data
+ * @md_ss_toc: Application Subsystem TOC pointer
+ * @md_regions: Application Subsystem region base pointer
+ */
+struct minidump_ss_data {
+	struct minidump_subsystem *md_ss_toc;
+	struct minidump_region	  *md_regions;
+};
+
+static struct minidump *md;
+
+static void qcom_md_add_region(const struct qcom_minidump_region *region)
+{
+	struct minidump_subsystem *mdss_toc = md->apss_data->md_ss_toc;
+	struct minidump_region *mdr;
+	unsigned int region_cnt;
+
+	region_cnt = le32_to_cpu(mdss_toc->region_count);
+	mdr = &md->apss_data->md_regions[region_cnt];
+	strscpy(mdr->name, region->name, sizeof(mdr->name));
+	mdr->address = cpu_to_le64(region->phys_addr);
+	mdr->size = cpu_to_le64(region->size);
+	mdr->valid = cpu_to_le32(MINIDUMP_REGION_VALID);
+	region_cnt++;
+	mdss_toc->region_count = cpu_to_le32(region_cnt);
+}
+
+static int qcom_md_get_region_index(struct minidump_ss_data *mdss_data,
+				    const struct qcom_minidump_region *region)
+{
+	struct minidump_subsystem *mdss_toc = mdss_data->md_ss_toc;
+	struct minidump_region *mdr;
+	unsigned int i;
+	unsigned int count;
+
+	count = le32_to_cpu(mdss_toc->region_count);
+	for (i = 0; i < count; i++) {
+		mdr = &mdss_data->md_regions[i];
+		if (!strcmp(mdr->name, region->name))
+			return i;
+	}
+
+	return -ENOENT;
+}
+
+static int qcom_md_region_unregister(const struct qcom_minidump_region *region)
+{
+	struct minidump_ss_data *mdss_data = md->apss_data;
+	struct minidump_subsystem *mdss_toc = mdss_data->md_ss_toc;
+	struct minidump_region *mdr;
+	unsigned int region_cnt;
+	unsigned int idx;
+	int ret;
+
+	ret = qcom_md_get_region_index(mdss_data, region);
+	if (ret < 0) {
+		dev_err(md->dev, "%s region is not present\n", region->name);
+		return ret;
+	}
+
+	idx = ret;
+	mdr = &mdss_data->md_regions[0];
+	region_cnt = le32_to_cpu(mdss_toc->region_count);
+	/*
+	 * Left shift all the regions exist after this removed region
+	 * index by 1 to fill the gap and zero out the last region
+	 * present at the end.
+	 */
+	memmove(&mdr[idx], &mdr[idx + 1], (region_cnt - idx - 1) * sizeof(*mdr));
+	memset(&mdr[region_cnt - 1], 0, sizeof(*mdr));
+	region_cnt--;
+	mdss_toc->region_count = cpu_to_le32(region_cnt);
+
+	return 0;
+}
+
+static int qcom_md_region_register(const struct qcom_minidump_region *region)
+{
+	struct minidump_ss_data *mdss_data = md->apss_data;
+	struct minidump_subsystem *mdss_toc = mdss_data->md_ss_toc;
+	unsigned int num_region;
+	int ret;
+
+	ret = qcom_md_get_region_index(mdss_data, region);
+	if (ret >= 0) {
+		dev_info(md->dev, "%s region is already registered\n", region->name);
+		return -EEXIST;
+	}
+
+	/* Check if there is a room for a new entry */
+	num_region = le32_to_cpu(mdss_toc->region_count);
+	if (num_region >= MAX_NUM_ENTRIES) {
+		dev_err(md->dev, "maximum region limit %u reached\n", num_region);
+		return -ENOSPC;
+	}
+
+	qcom_md_add_region(region);
+
+	return 0;
+}
+
+static bool qcom_minidump_valid_region(const struct qcom_minidump_region *region)
+{
+	return region &&
+		strnlen(region->name, MINIDUMP_MAX_NAME_LENGTH) < MINIDUMP_MAX_NAME_LENGTH &&
+			region->virt_addr &&
+			region->size &&
+			IS_ALIGNED(region->size, 4);
+}
+
+/**
+ * qcom_minidump_region_register() - Register region in APSS Minidump table.
+ * @region: minidump region.
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+int qcom_minidump_region_register(const struct qcom_minidump_region *region)
+{
+	int ret;
+
+	if (!qcom_minidump_valid_region(region))
+		return -EINVAL;
+
+	mutex_lock(&md->md_lock);
+	ret = qcom_md_region_register(region);
+
+	mutex_unlock(&md->md_lock);
+	return ret;
+}
+
+/**
+ * qcom_minidump_region_unregister() - Unregister region from APSS Minidump table.
+ * @region: minidump region.
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+int qcom_minidump_region_unregister(const struct qcom_minidump_region *region)
+{
+	int ret;
+
+	if (!qcom_minidump_valid_region(region))
+		return -EINVAL;
+
+	mutex_lock(&md->md_lock);
+	ret = qcom_md_region_unregister(region);
+
+	mutex_unlock(&md->md_lock);
+	return ret;
+}
+
+
+static int qcom_apss_md_table_init(struct minidump_subsystem *mdss_toc)
+{
+	struct minidump_ss_data *mdss_data;
+
+	mdss_data = devm_kzalloc(md->dev, sizeof(*mdss_data), GFP_KERNEL);
+	if (!mdss_data)
+		return -ENOMEM;
+
+	mdss_data->md_ss_toc = mdss_toc;
+	mdss_data->md_regions = devm_kcalloc(md->dev, MAX_NUM_ENTRIES,
+					     sizeof(*mdss_data->md_regions),
+					     GFP_KERNEL);
+	if (!mdss_data->md_regions)
+		return -ENOMEM;
+
+	mdss_toc = mdss_data->md_ss_toc;
+	mdss_toc->regions_baseptr = cpu_to_le64(virt_to_phys(mdss_data->md_regions));
+	mdss_toc->enabled = cpu_to_le32(MINIDUMP_SS_ENABLED);
+	mdss_toc->status = cpu_to_le32(1);
+	mdss_toc->region_count = cpu_to_le32(0);
+
+	/* Tell bootloader not to encrypt the regions of this subsystem */
+	mdss_toc->encryption_status = cpu_to_le32(MINIDUMP_SS_ENCR_DONE);
+	mdss_toc->encryption_required = cpu_to_le32(MINIDUMP_SS_ENCR_NOTREQ);
+
+	md->apss_data = mdss_data;
+
+	return 0;
+}
+
+int qcom_smem_md_init(struct device *dev)
+{
+	struct minidump_global_toc *mdgtoc;
+	size_t size;
+	int ret;
+
+	md = devm_kzalloc(dev, sizeof(*md), GFP_KERNEL);
+
+	md->dev = dev;
+
+	mdgtoc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, &size);
+	if (IS_ERR(mdgtoc)) {
+		ret = PTR_ERR(mdgtoc);
+		dev_err(md->dev, "Couldn't find minidump smem item %d\n", ret);
+	}
+
+	if (size < sizeof(*mdgtoc) || !mdgtoc->status) {
+		ret = -EINVAL;
+		dev_err(md->dev, "minidump table is not initialized %d\n", ret);
+	}
+
+	mutex_init(&md->md_lock);
+
+	ret = qcom_apss_md_table_init(&mdgtoc->subsystems[MINIDUMP_APSS_DESC]);
+	if (ret)
+		dev_err(md->dev, "apss minidump initialization failed %d\n", ret);
+	return ret;
+}
diff --git a/drivers/soc/qcom/smem_pstore.c b/drivers/soc/qcom/smem_pstore.c
new file mode 100644
index 000000000000..a322a320e435
--- /dev/null
+++ b/drivers/soc/qcom/smem_pstore.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/hwspinlock.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/devcoredump.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
+#include <linux/dma-mapping.h>
+#include <linux/pstore_smem.h>
+#include <linux/pstore_zone.h>
+#include <linux/pstore.h>
+
+static LIST_HEAD(apss_md_rlist);
+struct md_region_list {
+	struct qcom_minidump_region md_region;
+	struct list_head list;
+};
+
+static struct qcom_smem_pstore_context {
+	struct pstore_device_info dev;
+} oops_ctx;
+
+static int register_smem_region(const char *name, int id, void *vaddr,
+				   phys_addr_t paddr, size_t size)
+{
+	struct qcom_minidump_region *md_region;
+	int ret;
+
+	struct md_region_list *mdr_list =
+		kzalloc(sizeof(*mdr_list), GFP_KERNEL);
+	if (!mdr_list)
+		return -ENOMEM;
+	md_region = &mdr_list->md_region;
+
+	scnprintf(md_region->name, sizeof(md_region->name), "K%d%.8s", id, name);
+	md_region->virt_addr = vaddr;
+	md_region->phys_addr = paddr;
+	md_region->size = size;
+	ret = qcom_minidump_region_register(md_region);
+	if (ret < 0) {
+		pr_err("failed to register region in minidump: err: %d\n", ret);
+		return ret;
+	}
+
+	list_add(&mdr_list->list, &apss_md_rlist);
+	return 0;
+}
+
+static int unregister_smem_region(void *vaddr,
+					phys_addr_t paddr, size_t size)
+{
+	int ret = -ENOENT;
+	struct md_region_list *mdr_list;
+	struct md_region_list *tmp;
+
+	list_for_each_entry_safe(mdr_list, tmp, &apss_md_rlist, list) {
+		struct qcom_minidump_region *region;
+
+		region = &mdr_list->md_region;
+		if (region->virt_addr == vaddr) {
+			ret = qcom_minidump_region_unregister(region);
+			list_del(&mdr_list->list);
+			goto unregister_smem_region_exit;
+		}
+	}
+
+unregister_smem_region_exit:
+	pr_err("failed to unregister region in minidump: err: %d\n", ret);
+
+	return ret;
+}
+
+static int qcom_smem_register_dmr(char *name, int id, void *area, size_t size)
+{
+	return register_smem_region(name, id, area, virt_to_phys(area), size);
+}
+
+static int qcom_smem_unregister_dmr(void *area, size_t size)
+{
+	return unregister_smem_region(area, virt_to_phys(area), size);
+}
+
+int qcom_register_pstore_smem(struct device *dev)
+{
+	int ret;
+
+	struct qcom_smem_pstore_context *ctx = &oops_ctx;
+
+	ctx->dev.flags = PSTORE_FLAGS_DMAPPED;
+	ctx->dev.zone.register_dmr = qcom_smem_register_dmr;
+	ctx->dev.zone.unregister_dmr = qcom_smem_unregister_dmr;
+	ctx->dev.zone.dmapped_cnt = 2;
+
+	ret = register_pstore_smem_device(&ctx->dev);
+	if (ret)
+		dev_warn(dev, "Could not register pstore smem device.");
+
+	return 0;
+}
+
+void qcom_unregister_pstore_smem(void)
+{
+	struct qcom_smem_pstore_context *ctx = &oops_ctx;
+
+	unregister_pstore_smem_device(&ctx->dev);
+}
diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
index f946e3beca21..376822f13a4f 100644
--- a/include/linux/soc/qcom/smem.h
+++ b/include/linux/soc/qcom/smem.h
@@ -17,4 +17,47 @@ int qcom_smem_get_feature_code(u32 *code);
 
 int qcom_smem_bust_hwspin_lock_by_host(unsigned int host);
 
+#ifdef CONFIG_QCOM_SMEM_PSTORE
+int qcom_register_pstore_smem(struct device *dev);
+void qcom_unregister_pstore_smem(void);
+
+#define MINIDUMP_MAX_NAME_LENGTH	12
+
+/**
+ * struct qcom_minidump_region - Minidump region information
+ *
+ * @name:	Minidump region name
+ * @virt_addr:  Virtual address of the entry.
+ * @phys_addr:	Physical address of the entry to dump.
+ * @size:	Number of bytes to dump from @address location,
+ *		and it should be 4 byte aligned.
+ */
+struct qcom_minidump_region {
+	char		name[MINIDUMP_MAX_NAME_LENGTH];
+	void		*virt_addr;
+	phys_addr_t	phys_addr;
+	size_t		size;
+};
+
+int qcom_minidump_region_unregister(const struct qcom_minidump_region *region);
+int qcom_minidump_region_register(const struct qcom_minidump_region *region);
+
+int qcom_smem_md_init(struct device *dev);
+
+#else
+
+static inline int qcom_register_pstore_smem(struct device *dev)
+{
+	return 0;
+}
+
+static inline void qcom_unregister_pstore_smem(void)
+{
+}
+
+static inline int qcom_smem_md_init(struct device *dev)
+{
+	return 0;
+}
+#endif
 #endif
-- 
2.43.0

