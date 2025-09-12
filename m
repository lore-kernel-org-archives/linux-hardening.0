Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D176131AF1B
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689824; cv=none; b=DhFv8niZm8bZ7oxAIqqzxxss5Y6KgH+AhyvJaC1MeITTrZlDdlX6mFxLCj6jeeYR3SYGGhv6tDihycBkyeeU8IRqA0ly2D72EcdjU0mAotEt2+Z31ldtoQeLP3wcxnd5/ltaCHGDsERVHMzxJyg8UD4Fn4nR2ufyB3s9ZPQ426s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689824; c=relaxed/simple;
	bh=/usbRG/zhuVo2onQ1eYRDQP8zMO0U8orZCA2d2tBubg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2QN52cqIu8hA6huhT2sVV9qz5wkVibYXaBOnWQgbNMUADuVxmVfnvwHvXnB4IRI4HunkvRfDzoFnS2oJnNMD36/CpWq/4alkc6p6/Jzp6WuQaYYqvg76aIx8J6fLdacso6qpGzxD3rnd1fSPnyPDUhYp6eL1fTn6V51VzJIn1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hZtX4yKU; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZtX4yKU"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-723ad237d1eso18643217b3.1
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689822; x=1758294622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUEgobPFH+EGZPcli+Ra4q+x5D03Vw2x1oq0a5Xuvco=;
        b=hZtX4yKUixslg3orPC7dgg6QzgcZFnPP1c4XtPzua1ewuUUrE6D/+Sdy3sBERLkvBn
         qW0GUv5LdFADNFyDQkC3/hfuTZev2ayrWaSdC5yE+RdF1H4lpbWt7JJ49m6rEg0SjfXU
         Hn49Lyzf0VxIBmb13sGlXbaxQJVmDRC4fjWG5cLmw0MpAvAruAuxhvM3Uuu3Ttxj6RS0
         VuI8qIv27/54LSrmCnrGEbA/k96aqimDrNmpqX44P6NoaK8DTgWKahQ+pFwX/5eree6F
         Ql96e8q8Xlr72lIhvVPkkIBoSdQX6C1IJyXy4UQ/Vym8TFS5tlfjLqBuzwLf6nFyD7bg
         d7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689822; x=1758294622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUEgobPFH+EGZPcli+Ra4q+x5D03Vw2x1oq0a5Xuvco=;
        b=IbvDAnVtHRmuPTHCRSrgADIC1v2TCHZ5DJ9bJ1TZwu9dwTcbtqt47FOucuCZseDgn1
         ZmPnX3RrG0FECZXLGWz6J89BlKdTP31mxRXeLBalmV9klbkdmOKCQPr1GxTQ/wp6RgdL
         OV2eqWMTspjxWTH97xg3clQuDRwz6RRyqMYIeIENH1kviubZenFcthzknhWuq5GmlcHi
         vJME/uPXE+pXk/gyK69Z2CR8QI1P1Y0agFQaIg272+sBYV3WrQaBspvyJTsKY/1gP74A
         +GFN38NvbxpK4A8iO/MTr39gmEbc36GkSyQEJRddcriNLcGdOkrIYGcY5iqbwy9XplSs
         AnRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwC+/Ost1OcFY3B8TPbudh2IxAcEu8YFI+sTkZMn4wIrkmn9fHnZIbcHgnvJLdatAD1JWImots2dMi/95DEP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzV99ZvNia+69vlYtvU+EnY7CzJbNIChyfRnO3xH2rLEBvmpnV
	sCWQLgTcSttcmCRBkvmAUEaEODPII1YA8pC6lcmmem5pYxRwBpBhc66EZ/qTG8beuhk=
X-Gm-Gg: ASbGncuwsUWLeXEjtzwy+uDSz6Mut05/u6Cx0OEolFd4V6FcMdhOpjjjAxHrsBivVEG
	NP60BKczGmz5drSuzy7BCUUS+lLw12ERqwwI4vI50EZJML0nfp/sLD4+Bw9vqLj+JDmNy4NhMHm
	GZFTiLwZmwvVTSrnoAM72Z5YnEMHp9cYQiSCgORKP9K+rt4KsuZl/Wnc8DaIBc0Y08YkDH7fJmB
	7aF6apgHHIjZ7o627s1UffY3DTTRSeo8lTwhLr2adlm3+rXGOiw6qfhIqJCO08MdW51ZGouMUM0
	xHi3waG3dnlco8rfG6UnIpHCm7bN1ytbyqJYg8m8ZTMTUuQoOfcx8xtZu96UuKEi3h29TRcPyYj
	/dch1vE84RPZIdX4+988O8dEDwDkc+1L1RFrj9injP7ye
X-Google-Smtp-Source: AGHT+IFfoHeq2qxhWL+Mgo2uL4H24h0IQUACTuuF5mx/FkiDr6oqL6RZMT2GVhdQdeu/Vgit1i7NzQ==
X-Received: by 2002:a05:690c:94:b0:71f:e154:7aa2 with SMTP id 00721157ae682-73064c04bdemr29570617b3.25.1757689821531;
        Fri, 12 Sep 2025 08:10:21 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:21 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 06/16] kmemdump: Introduce qcom-minidump backend driver
Date: Fri, 12 Sep 2025 18:08:45 +0300
Message-ID: <20250912150855.2901211-7-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm Minidump is a backend driver for kmemdump.
Regions are being registered into the shared memory on Qualcomm platforms
and into the table of contents.
Further, the firmware can read the table of contents and dump the memory
accordingly.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 MAINTAINERS                 |   5 +
 mm/kmemdump/Kconfig.debug   |  12 ++
 mm/kmemdump/Makefile        |   1 +
 mm/kmemdump/qcom_minidump.c | 353 ++++++++++++++++++++++++++++++++++++
 4 files changed, 371 insertions(+)
 create mode 100644 mm/kmemdump/qcom_minidump.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fc8cd34cf190..8234acb24cbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13818,6 +13818,11 @@ F:	include/linux/kmemdump.h
 F:	mm/kmemdump/kmemdump.c
 F:	mm/kmemdump/kmemdump_coreimage.c
 
+KMEMDUMP QCOM MINIDUMP BACKEND DRIVER
+M:	Eugen Hristev <eugen.hristev@linaro.org>
+S:	Maintained
+F:	mm/kmemdump/qcom_minidump.c
+
 KMEMLEAK
 M:	Catalin Marinas <catalin.marinas@arm.com>
 S:	Maintained
diff --git a/mm/kmemdump/Kconfig.debug b/mm/kmemdump/Kconfig.debug
index f62bde50a81b..91cec45bc3ca 100644
--- a/mm/kmemdump/Kconfig.debug
+++ b/mm/kmemdump/Kconfig.debug
@@ -26,3 +26,15 @@ config KMEMDUMP_COREIMAGE
 	  for debug tools are being registered.
 	  The coredump file can then be loaded into GDB or crash  tool and
 	  further inspected.
+
+config KMEMDUMP_QCOM_MINIDUMP_BACKEND
+	tristate "Qualcomm Minidump kmemdump backend driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on KMEMDUMP
+	help
+	  Say y here to enable the Qualcomm Minidump kmemdump backend
+	  driver.
+	  With this backend, the registered regions are being linked
+	  into the minidump table of contents. Further on, the firmware
+	  will be able to read the table of contents and extract the
+	  memory regions on case-by-case basis.
diff --git a/mm/kmemdump/Makefile b/mm/kmemdump/Makefile
index eed67f15a8d0..6ec3871203ef 100644
--- a/mm/kmemdump/Makefile
+++ b/mm/kmemdump/Makefile
@@ -2,3 +2,4 @@
 
 obj-y += kmemdump.o
 obj-$(CONFIG_KMEMDUMP_COREIMAGE) += kmemdump_coreimage.o
+obj-$(CONFIG_KMEMDUMP_QCOM_MINIDUMP_BACKEND) += qcom_minidump.o
diff --git a/mm/kmemdump/qcom_minidump.c b/mm/kmemdump/qcom_minidump.c
new file mode 100644
index 000000000000..604a58240c20
--- /dev/null
+++ b/mm/kmemdump/qcom_minidump.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Minidump backend driver for Kmemdump
+ * Copyright (C) 2016,2024-2025 Linaro Ltd
+ * Copyright (C) 2015 Sony Mobile Communications Inc
+ * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/kmemdump.h>
+#include <linux/container_of.h>
+
+/*
+ * In some of the Old Qualcomm devices, boot firmware statically allocates 300
+ * as total number of supported region (including all co-processors) in
+ * minidump table out of which linux was using 201. In future, this limitation
+ * from boot firmware might get removed by allocating the region dynamically.
+ * So, keep it compatible with older devices, we can keep the current limit for
+ * Linux to 201.
+ */
+#define MAX_NUM_REGIONS		201
+
+#define MAX_NUM_SUBSYSTEMS	10
+#define MAX_REGION_NAME_LENGTH	16
+#define SBL_MINIDUMP_SMEM_ID	602
+#define MINIDUMP_REGION_VALID	('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
+#define MINIDUMP_SS_ENCR_DONE	('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
+#define MINIDUMP_SS_ENABLED	('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
+
+#define MINIDUMP_SS_ENCR_NOTREQ	(0 << 24 | 0 << 16 | 'N' << 8 | 'R' << 0)
+
+#define MINIDUMP_SUBSYSTEM_APSS	0
+
+const char *kmemdump_id_to_md_string[] = {
+	"",
+	"ELF",
+	"vmcoreinfo",
+	"config",
+	"memsect",
+	"totalram",
+	"cpu_possible",
+	"cpu_present",
+	"cpu_online",
+	"cpu_active",
+	"jiffies",
+	"linux_banner",
+	"nr_threads",
+	"nr_irqs",
+	"tainted_mask",
+	"taint_flags",
+	"mem_section",
+	"node_data",
+	"node_states",
+	"__per_cpu_offset",
+	"nr_swapfiles",
+	"init_uts_ns",
+	"printk_rb_static",
+	"printk_rb_dynamic",
+	"prb",
+	"prb_descs",
+	"prb_infos",
+	"prb_data",
+	"runqueues",
+	"high_memory",
+	"init_mm",
+	"init_mm_pgd",
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
+ * @revision : Minidump revision
+ * @enabled : Minidump enable status
+ * @subsystems : Array of subsystems toc
+ */
+struct minidump_global_toc {
+	__le32				status;
+	__le32				revision;
+	__le32				enabled;
+	struct minidump_subsystem	subsystems[MAX_NUM_SUBSYSTEMS];
+};
+
+#define MINIDUMP_MAX_NAME_LENGTH	12
+/**
+ * struct qcom_minidump_region - Minidump region information
+ *
+ * @name:	Minidump region name
+ * @virt_addr:  Virtual address of the entry.
+ * @phys_addr:	Physical address of the entry to dump.
+ * @size:	Number of bytes to dump from @address location,
+ *		and it should be 4 byte aligned.
+ * @id:		Region id.
+ */
+struct qcom_minidump_region {
+	char		name[MINIDUMP_MAX_NAME_LENGTH];
+	void		*virt_addr;
+	phys_addr_t	phys_addr;
+	size_t		size;
+	unsigned int	id;
+};
+
+/**
+ * struct minidump - Minidump driver data information
+ *
+ * @dev:	Minidump device struct.
+ * @toc:	Minidump table of contents subsystem.
+ * @regions:	Minidump regions array.
+ * @md_be:	Minidump backend.
+ */
+struct minidump {
+	struct device			*dev;
+	struct minidump_subsystem	*toc;
+	struct minidump_region		*regions;
+	struct kmemdump_backend		md_be;
+};
+
+static struct minidump *md;
+
+#define be_to_minidump(be) container_of(be, struct minidump, md_be)
+
+/**
+ * qcom_apss_md_table_init() - Initialize the minidump table
+ * @md: minidump data
+ * @mdss_toc: minidump subsystem table of contents
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+static int qcom_apss_md_table_init(struct minidump *md,
+				   struct minidump_subsystem *mdss_toc)
+{
+	md->toc = mdss_toc;
+	md->regions = devm_kcalloc(md->dev, MAX_NUM_REGIONS,
+				   sizeof(*md->regions), GFP_KERNEL);
+	if (!md->regions)
+		return -ENOMEM;
+
+	md->toc->regions_baseptr = cpu_to_le64(virt_to_phys(md->regions));
+	md->toc->enabled = cpu_to_le32(MINIDUMP_SS_ENABLED);
+	md->toc->status = cpu_to_le32(1);
+	md->toc->region_count = cpu_to_le32(0);
+
+	/* Tell bootloader not to encrypt the regions of this subsystem */
+	md->toc->encryption_status = cpu_to_le32(MINIDUMP_SS_ENCR_DONE);
+	md->toc->encryption_required = cpu_to_le32(MINIDUMP_SS_ENCR_NOTREQ);
+
+	return 0;
+}
+
+/**
+ * qcom_md_get_region_index() - Lookup minidump region by kmemdump id
+ * @md: minidump data
+ * @id: minidump region id
+ *
+ * Return: On success, it returns the internal region index, on failure,
+ *	returns	negative error value
+ */
+static int qcom_md_get_region_index(struct minidump *md, int id)
+{
+	unsigned int count = le32_to_cpu(md->toc->region_count);
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		if (md->regions[i].seq_num == id)
+			return i;
+
+	return -ENOENT;
+}
+
+/**
+ * register_md_region() - Register a new minidump region
+ * @be: kmemdump backend, this should be the minidump backend
+ * @id: unique id to identify the region
+ * @vaddr: virtual memory address of the region start
+ * @size: size of the region
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+static int register_md_region(const struct kmemdump_backend *be,
+			      enum kmemdump_uid id, void *vaddr, size_t size)
+{
+	struct minidump *md = be_to_minidump(be);
+	struct minidump_region *mdr;
+	unsigned int num_region, region_cnt;
+	const char *name = "unknown";
+
+	if (!vaddr || !size)
+		return -EINVAL;
+
+	if (id < ARRAY_SIZE(kmemdump_id_to_md_string))
+		name = kmemdump_id_to_md_string[id];
+
+	if (qcom_md_get_region_index(md, id) >= 0) {
+		dev_dbg(md->dev, "%s:%d region is already registered\n",
+			name, id);
+		return -EEXIST;
+	}
+
+	/* Check if there is a room for a new entry */
+	num_region = le32_to_cpu(md->toc->region_count);
+	if (num_region >= MAX_NUM_REGIONS) {
+		dev_err(md->dev, "maximum region limit %u reached\n",
+			num_region);
+		return -ENOSPC;
+	}
+
+	region_cnt = le32_to_cpu(md->toc->region_count);
+	mdr = &md->regions[region_cnt];
+	scnprintf(mdr->name, MAX_REGION_NAME_LENGTH, "K%.8s", name);
+	mdr->seq_num = id;
+	mdr->address = cpu_to_le64(__pa(vaddr));
+	mdr->size = cpu_to_le64(ALIGN(size, 4));
+	mdr->valid = cpu_to_le32(MINIDUMP_REGION_VALID);
+	region_cnt++;
+	md->toc->region_count = cpu_to_le32(region_cnt);
+
+	return 0;
+}
+
+/**
+ * unregister_md_region() - Unregister a previously registered minidump region
+ * @be: pointer to backend
+ * @id: unique id to identify the region
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+static int unregister_md_region(const struct kmemdump_backend *be,
+				unsigned int id)
+{
+	struct minidump *md = be_to_minidump(be);
+	struct minidump_region *mdr;
+	unsigned int region_cnt;
+	unsigned int idx;
+
+	idx = qcom_md_get_region_index(md, id);
+	if (idx < 0) {
+		dev_err(md->dev, "%d region is not present\n", id);
+		return idx;
+	}
+
+	mdr = &md->regions[0];
+	region_cnt = le32_to_cpu(md->toc->region_count);
+	/*
+	 * Left shift all the regions exist after this removed region
+	 * index by 1 to fill the gap and zero out the last region
+	 * present at the end.
+	 */
+	memmove(&mdr[idx], &mdr[idx + 1], (region_cnt - idx - 1) * sizeof(*mdr));
+	memset(&mdr[region_cnt - 1], 0, sizeof(*mdr));
+	region_cnt--;
+	md->toc->region_count = cpu_to_le32(region_cnt);
+
+	return 0;
+}
+
+static int qcom_md_probe(struct platform_device *pdev)
+{
+	struct minidump_global_toc *mdgtoc;
+	size_t size;
+	int ret;
+
+	md = kzalloc(sizeof(*md), GFP_KERNEL);
+	if (!md)
+		return -ENOMEM;
+
+	md->dev = &pdev->dev;
+
+	strscpy(md->md_be.name, "qcom_minidump");
+	md->md_be.register_region = register_md_region;
+	md->md_be.unregister_region = unregister_md_region;
+
+	mdgtoc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, &size);
+	if (IS_ERR(mdgtoc)) {
+		ret = PTR_ERR(mdgtoc);
+		dev_err(md->dev, "Couldn't find minidump smem item %d\n", ret);
+		goto qcom_md_probe_fail;
+	}
+
+	if (size < sizeof(*mdgtoc) || !mdgtoc->status) {
+		dev_err(md->dev, "minidump table is not initialized\n");
+		ret = -ENAVAIL;
+		goto qcom_md_probe_fail;
+	}
+
+	ret = qcom_apss_md_table_init(md, &mdgtoc->subsystems[MINIDUMP_SUBSYSTEM_APSS]);
+	if (ret)
+		goto qcom_md_probe_fail;
+
+	return kmemdump_register_backend(&md->md_be);
+
+qcom_md_probe_fail:
+	kfree(md);
+	return ret;
+}
+
+static void qcom_md_remove(struct platform_device *pdev)
+{
+	kfree(md);
+	kmemdump_unregister_backend(&md->md_be);
+}
+
+static struct platform_driver qcom_md_driver = {
+	.probe = qcom_md_probe,
+	.remove = qcom_md_remove,
+	.driver  = {
+		.name = "qcom-minidump",
+	},
+};
+
+module_platform_driver(qcom_md_driver);
+
+MODULE_AUTHOR("Eugen Hristev <eugen.hristev@linaro.org>");
+MODULE_AUTHOR("Mukesh Ojha <quic_mojha@quicinc.com>");
+MODULE_DESCRIPTION("Qualcomm kmemdump minidump backend driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

