Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358F27442
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777589009; cv=none; b=e7L0kR+k2yDFtwiEg7uMV2m7f/3ARN0WbFlI1v8oekkZvlnT7vlAwKsiMSVveO8KkABP26yXilgs+6aGKp2ab4RSt57KIerTX+l7sPva/fG/d7FpwzbPs7MOoxMFipr1v2804hDvKrRpEhQ/9/IMjqG05P1Y1DCzHkQuuRnQAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777589009; c=relaxed/simple;
	bh=h4bUXydaGYb5msBkanLLxkTCv1bN3AZGvRH3q8dXQX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+0tcvggVBzeqFXtY5gwuXeoAKJhkA7fttpgFokyNWrWB0ueegPdrtqlw2MUoW0GQ5EOG95IosO6lIN3gNyXujBe05KOlMUwQtM0Er1CgzLmcN7w3Hr1nW72K3UTZzYokF2F2f4K1vbQlCqGqM18Wsa+BPZ6H3vi591aFxAm5qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHqjT6t9; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHqjT6t9"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e614fdb42so11348201cf.3
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777589007; x=1778193807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpto9+Ej84DfwIPoSsQI6Rk7NM+GmRUDZZqbBkQ1LtE=;
        b=VHqjT6t9Z3LHYL6SmnAz6CTB5SPj79BzK9T26RHJUklky/lr9cvjPls/CncDz3D0Nh
         YD5wQVTgVMuwWXOWgD+MKMTd7NeY4HoIjJU+aIISarWhddVZRnd+VHGmhwI1kGYOXCak
         cg0DG4ZeM2z/Dxw4myTw/0OsDp0uDlahLKoV/TgtEOnp1Pv2PPugjYg0ZctuRodlK83s
         R8zvTK2EPtWMck2DTt3YTXLSEGG97OscQj4WNGR7OMSi5C7HzNWNP4cIMAdBvJTuCloA
         rJjkPCAUELDur2EtZ5dbKCeEBWfWa3sunfgdhatkqSzN5GVX9v4d2G5YQ2Z0Kxm9atc8
         TUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777589007; x=1778193807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpto9+Ej84DfwIPoSsQI6Rk7NM+GmRUDZZqbBkQ1LtE=;
        b=s1A4tIQhcbjN7MCM/OlvY71RrH2QrIQXNetXsujCP8x8TDo9LqGTsu6Hk9tLHH8iCb
         c0PbVci22UZdfc8hcfJjel5J/EQ8OfuWqrn0eNjSk+ICuEOw/NvHakeGHVxQrEecQK0n
         U2ReoVExbcPxxTJG51UxFL6C5NF/UGC9tZLdp256hAzOyMlM02AyBTjGj9AG1zACrZPg
         jX1H7t/rdpLdicpum0j+zQUuMJFdNYaxxjRw9E1JstRQtuV3HTiG/ch1mffn/L8Q1oAm
         MA+KomcE2g/H93fr3PBOzMYWYaHTadvjk/lnB+D/m1RVweDD5c0tGjYqd9wbOqU0esHG
         FrkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dGMNwqI7CHYWdN2CiKvnAcrl6N/MQpFQlPFvwhMxWz0fVH72xLiq31zmSJPqZZ+Js7ezNZYO/db+6fd/cuaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFi2dZ4DMbv6WlNWPXtwPQdDQ679Hv/bBofJN2M/Qp0/Lu0L36
	DZXAUuekEUUSTvoZsYTpWNbj4AWDSJpQb9mBlPJvV2jMf9zQKpFVGmu3
X-Gm-Gg: AeBDietYOnbctR88diuBwSS8TlJ0+PbEjywp687aYhCVqSKHTvc5o/UfNjZ0Yy/VWBW
	1xaNsNB0/09ulMfz9yA2DH/C4ZPIx5f0xeZT00AXqNr3FXSvf8EQMnuIpsPbv7Ri6MpR5LM8MOe
	1ezRE3agS47rdBw3Js7zdBscdob4LNyt0/YCcgh7SQKYAT/nfI4Cl7Bxg91RKB3B+irS5FMiQbu
	nngCV8oYY9dVXcolvMbVg7kcH6eB3fKG3Mz+m4mrpnIRXl9MCrRljZ1tNwtYeXrOzIfU6Bz+IMm
	MTWyFu44tV7LyIuRMALNf816zfdyMLJHjPnhaoOBtYE8lclPuF2hZFPtX2s7fbB9g20MUaLux1p
	UTEzsMxFd3YKJxTWJP/Wa/15IlV1Z6ti2ZkWKiYdoy+0RkIMYgQy6fbDx8yBMPrGMEK48LMyT7n
	mNhmKlzBHcey7x4P10bU2bV96rW64fms+UaSntcf8FkYBOZ3e8r+FoKL8rje7wuxyKb4SvPc3LD
	/t3E1+nbrGKVVuDAFqEnKMwl+MYLyrgPsRngxwUKY/3dw==
X-Received: by 2002:ac8:5e52:0:b0:50f:c36a:381a with SMTP id d75a77b69052e-5103e97ae32mr7037151cf.55.1777589007135;
        Thu, 30 Apr 2026 15:43:27 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103e5cc890sm3307341cf.30.2026.04.30.15.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 15:43:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "David E. Box" <david.e.box@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] platform/x86/intel/vsec: allocate res with intel_vsec_dev
Date: Thu, 30 Apr 2026 15:43:07 -0700
Message-ID: <20260430224307.109311-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations. Avoids having to
free separately.

Add __counted_by for extra runtime analysis.

Move counting variable assignment to after allocations as is already
done by kzalloc_flex for GCC 15 and above.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/platform/x86/intel/vsec.c      | 14 ++++----------
 drivers/platform/x86/intel/vsec_tpmi.c | 13 ++++---------
 include/linux/intel_vsec.h             |  6 +++---
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 7d5dbc1c1d05..9ef0f043bbee 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -112,7 +112,6 @@ static void intel_vsec_dev_release(struct device *dev)
 	ida_free(intel_vsec_dev->ida, intel_vsec_dev->auxdev.id);
 
 	kfree(intel_vsec_dev->acpi_disc);
-	kfree(intel_vsec_dev->resource);
 	kfree(intel_vsec_dev);
 }
 
@@ -225,7 +224,6 @@ int intel_vsec_add_aux(struct device *parent,
 	ret = xa_alloc(&auxdev_array, &intel_vsec_dev->id, intel_vsec_dev,
 		       PMT_XA_LIMIT, GFP_KERNEL);
 	if (ret < 0) {
-		kfree(intel_vsec_dev->resource);
 		kfree(intel_vsec_dev);
 		return ret;
 	}
@@ -233,7 +231,6 @@ int intel_vsec_add_aux(struct device *parent,
 	id = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
 	if (id < 0) {
 		xa_erase(&auxdev_array, intel_vsec_dev->id);
-		kfree(intel_vsec_dev->resource);
 		kfree(intel_vsec_dev);
 		return id;
 	}
@@ -282,7 +279,7 @@ static int intel_vsec_add_dev(struct device *dev, struct intel_vsec_header *head
 			      unsigned long cap_id, u64 base_addr)
 {
 	struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
-	struct resource __free(kfree) *res = NULL;
+	struct resource *res;
 	struct resource *tmp;
 	struct device *parent;
 	unsigned long quirks = info->quirks;
@@ -306,13 +303,12 @@ static int intel_vsec_add_dev(struct device *dev, struct intel_vsec_header *head
 		return -EINVAL;
 	}
 
-	intel_vsec_dev = kzalloc_obj(*intel_vsec_dev);
+	intel_vsec_dev = kzalloc_flex(*intel_vsec_dev, resource, header->num_entries);
 	if (!intel_vsec_dev)
 		return -ENOMEM;
 
-	res = kzalloc_objs(*res, header->num_entries);
-	if (!res)
-		return -ENOMEM;
+	intel_vsec_dev->num_resources = header->num_entries;
+	res = intel_vsec_dev->resource;
 
 	if (quirks & VSEC_QUIRK_TABLE_SHIFT)
 		header->offset >>= TABLE_OFFSET_SHIFT;
@@ -342,8 +338,6 @@ static int intel_vsec_add_dev(struct device *dev, struct intel_vsec_header *head
 	}
 
 	intel_vsec_dev->dev = dev;
-	intel_vsec_dev->resource = no_free_ptr(res);
-	intel_vsec_dev->num_resources = header->num_entries;
 	intel_vsec_dev->quirks = info->quirks;
 	intel_vsec_dev->base_addr = info->base_addr;
 	intel_vsec_dev->priv_data = info->priv_data;
diff --git a/drivers/platform/x86/intel/vsec_tpmi.c b/drivers/platform/x86/intel/vsec_tpmi.c
index 79c0cbea2dee..908f3377b05a 100644
--- a/drivers/platform/x86/intel/vsec_tpmi.c
+++ b/drivers/platform/x86/intel/vsec_tpmi.c
@@ -626,15 +626,12 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
 	if (!name)
 		return -EOPNOTSUPP;
 
-	res = kzalloc_objs(*res, pfs->pfs_header.num_entries);
-	if (!res)
+	feature_vsec_dev = kzalloc_flex(*feature_vsec_dev, resource, pfs->pfs_header.num_entries);
+	if (!feature_vsec_dev)
 		return -ENOMEM;
 
-	feature_vsec_dev = kzalloc_obj(*feature_vsec_dev);
-	if (!feature_vsec_dev) {
-		kfree(res);
-		return -ENOMEM;
-	}
+	feature_vsec_dev->num_resources = pfs->pfs_header.num_entries;
+	res = feature_vsec_dev->resource;
 
 	snprintf(feature_id_name, sizeof(feature_id_name), "tpmi-%s", name);
 
@@ -647,8 +644,6 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
 	}
 
 	feature_vsec_dev->dev = vsec_dev->dev;
-	feature_vsec_dev->resource = res;
-	feature_vsec_dev->num_resources = pfs->pfs_header.num_entries;
 	feature_vsec_dev->priv_data = &tpmi_info->plat_info;
 	feature_vsec_dev->priv_data_size = sizeof(tpmi_info->plat_info);
 	feature_vsec_dev->ida = &intel_vsec_tpmi_ida;
diff --git a/include/linux/intel_vsec.h b/include/linux/intel_vsec.h
index 1fe5665a9d02..07ea563f524e 100644
--- a/include/linux/intel_vsec.h
+++ b/include/linux/intel_vsec.h
@@ -135,8 +135,6 @@ struct intel_vsec_platform_info {
  * struct intel_vsec_device - Auxbus specific device information
  * @auxdev:        auxbus device struct for auxbus access
  * @dev:           struct device associated with the device
- * @resource:      PCI discovery resources (BAR windows), one per discovery
- *                 instance. Valid only when @src == INTEL_VSEC_DISC_PCI
  * @acpi_disc:     ACPI discovery tables, each entry is two QWORDs
  *                 in little-endian format as defined by the PMT ACPI spec.
  *                 Valid only when @src == INTEL_VSEC_DISC_ACPI.
@@ -149,11 +147,12 @@ struct intel_vsec_platform_info {
  * @quirks:        specified quirks
  * @base_addr:     base address of entries (if specified)
  * @cap_id:        the enumerated id of the vsec feature
+ * @resource:      PCI discovery resources (BAR windows), one per discovery
+ *                 instance. Valid only when @src == INTEL_VSEC_DISC_PCI
  */
 struct intel_vsec_device {
 	struct auxiliary_device auxdev;
 	struct device *dev;
-	struct resource *resource;
 	u32 (*acpi_disc)[4];
 	enum intel_vsec_disc_source src;
 	struct ida *ida;
@@ -164,6 +163,7 @@ struct intel_vsec_device {
 	unsigned long quirks;
 	u64 base_addr;
 	unsigned long cap_id;
+	struct resource resource[] __counted_by(num_resources);
 };
 
 /**
-- 
2.54.0

