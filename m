Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2326C39E
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777588021; cv=none; b=PRrEJ+cpV+oAp8J9wIdx5HaMlYznFPhR03JRMA0LjCe601fcl1AC5VflNBpD1RFY/ADErOTkUAoTLVQBh7qcXg6z1+V6i1k0KhcI+m0rbYNl+Z/gpEv5DeDrlQtxQ/v/x16mlKh97ZN3EW+OHiK21DQ3bAKfI8Zqrzpjpd1Rfvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777588021; c=relaxed/simple;
	bh=ULeoxKQtLtCquSMfQ9rjtCWnF700YKRLKcUJfKtZVCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwiLvRIyV5jKK50zu4h5lfd7BxuvNtFzp+Ep77DmvKnyk2ecc76c7a+CugppDpRSYZ5wXBlHgxSstfqtKTYqr3xSZs5lk8dukq2x6X/EoLWPCT/EbW03KcNMWd5I50EmIyoPvLrzCQr8E+l/vqELE4rGxgBclGoXk0oaMuU6YGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6cv/gxB; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6cv/gxB"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8eb5ad01402so154061385a.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 15:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777588018; x=1778192818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6sXoJIaz8w7Ayo4b0fhJWmMwXN9FnP2SkuIaK37X1jQ=;
        b=e6cv/gxByAaTOLbsFtIWgHECatNW+mMOUgTlAgWf8WdGtl0rnPInSYQw7SbH5Fpeki
         HZtRNTq1FKymhLLYGWAbZQlaXja+v3mwSoXMs0Qd0xQHZ2MpV1F4AQn+9+dwf5cam3fW
         npub9j4vyTHiOGuqaWH570HHAYyfhWOtgJp8CCAHcfyRBuejGEEPnCr91KS/iGG4mYqa
         ycY/rg+4sCWqWbaflUVuRvbQ7C1+9klDX82E0yQU6OY6uI09eCeaERMDKl6KEpwML1gA
         nDTASrUIhl70b+IcjLGHXGjXC0KBHdCJ9hj21PGCG0SY4Vcg7TOX8ratd8Evbk7x67w0
         fGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777588018; x=1778192818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sXoJIaz8w7Ayo4b0fhJWmMwXN9FnP2SkuIaK37X1jQ=;
        b=bIv3Bzu8cCztnnXRk6m4cR5fquKXCf4UT+mZEryB1ZQ6v6VMb5MsIHZfk/JemPAOdt
         ei/7qCb97N/Pm1Komxjs4ElgKiq+I/uIJuQ8MJes+W5yfh3df9z6q73QLZ/VKoLOD3hi
         7ETFwHpOPCA9w6dT3DTJVyCG7qXdWwih8q3CJ83xqNM6XzI+1mPTHbL4IgY6+KNSRLRH
         KAIpZoTlb5Qzh03QfQUXnXJuHiniZhlKmP1N3IMC8vxorKAH1bwvjCPFkweKdWD0vQfr
         0E5nu9dw6LSU+HnVUtjpcrAHnokVYKJl82XpMx6HVJ1halLw+/M3h3Le8SEU/qNkL71y
         tr4g==
X-Forwarded-Encrypted: i=1; AFNElJ/l+/rg+46kklrx5WeX7Yuug9N2mB46dCn02JT3L9MHL1h7KiGzRMvq/HfiZ7QXhk9c0rxItOGn/WV+GorIryo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcoip2HlgtmKBG9QaNuA+/6ivfGIcV2F7BzdDQlKA3RzpBrPmr
	KNAzlQ9bC4Ur7bcLdHdmqvE2I9ksURTjzrZZcwqDaZwXVV7Gv1Quv5r+
X-Gm-Gg: AeBDiev2TrfaZx2+xIFvYhPIlAPFUxDQSHa14mKHxbegByXB+SFYZnEvJFGzUpR3LE4
	Q6Af4WOdCc+H0eM7ihGO29uqjJFuMlQ6Q5ITm+lHw9mPGlDVYxieLzSVuLzHwF0gwFzUumway+o
	ZS4c731GGDT4XOHe5SgpFu5GeFGhlKNZAVRYy7ThAe/DrhsmQsqdO9lquBliwfTF3pmolumsuGE
	SOcVMozj3Al+tSF+On58xhMi7QcGYTvadrjvrHeKbNPtJ/O0NnMcX39N+v8zJ+UzF4wDdCi9StH
	z5OPukqUOYvW2h/nehj+3mIYefsc3BoKliLNubX0XQqfYMOlyvplkS/ax/Ry76UpbZYTUacN6zf
	gTLI20Dhc3pszKfyI+W89y9eZrESzrIQCa2P7JMfvr64axFxpVmvVa3o6sw+/BftJguiruC7cgf
	klMi3+7zP6f9R/dH86uqnWzQf/w6jRPKp+/pIEZ8wwLi7xA0HUMeGYmAAxu+eex21RMaYwvVVgC
	zZLejxjuxXf5HSkrB2TZMxp2blNBANMLAbs0R44GCViDg==
X-Received: by 2002:a05:620a:4804:b0:8eb:f3c7:223f with SMTP id af79cd13be357-8fa88847b70mr724161485a.40.1777588018468;
        Thu, 30 Apr 2026 15:26:58 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fbf0c69d24sm46443085a.13.2026.04.30.15.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 15:26:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] platform/x86/intel/tpmi: allocate tpmi_features with tpmi_info
Date: Thu, 30 Apr 2026 15:26:39 -0700
Message-ID: <20260430222639.95622-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Combine allocations with a flexible array member to simplify the whole
thing.

Add __counted_by for extra runtime analysis. Move assignment of counting
variable to after allocation as this is already done by kzalloc_flex and
will be done by its devm variant when introduced for GCC 15 and above.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/platform/x86/intel/vsec_tpmi.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec_tpmi.c b/drivers/platform/x86/intel/vsec_tpmi.c
index 7fc6ff8d1040..79c0cbea2dee 100644
--- a/drivers/platform/x86/intel/vsec_tpmi.c
+++ b/drivers/platform/x86/intel/vsec_tpmi.c
@@ -113,13 +113,13 @@ struct intel_tpmi_pm_feature {
  * Stores the information for all TPMI devices enumerated from a single PCI device.
  */
 struct intel_tpmi_info {
-	struct intel_tpmi_pm_feature *tpmi_features;
 	struct intel_vsec_device *vsec_dev;
 	int feature_count;
 	u64 pfs_start;
 	struct oobmsm_plat_info plat_info;
 	void __iomem *tpmi_control_mem;
 	struct dentry *dbgfs_dir;
+	struct intel_tpmi_pm_feature tpmi_features[] __counted_by(feature_count);
 };
 
 /**
@@ -751,20 +751,16 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 	u64 pfs_start = 0;
 	int ret, i;
 
-	tpmi_info = devm_kzalloc(&auxdev->dev, sizeof(*tpmi_info), GFP_KERNEL);
+	tpmi_info = devm_kzalloc(&auxdev->dev,
+				 struct_size(tpmi_info, tpmi_features, vsec_dev->num_resources),
+				 GFP_KERNEL);
 	if (!tpmi_info)
 		return -ENOMEM;
 
-	tpmi_info->vsec_dev = vsec_dev;
 	tpmi_info->feature_count = vsec_dev->num_resources;
+	tpmi_info->vsec_dev = vsec_dev;
 	tpmi_info->plat_info.bus_number = pci_dev->bus->number;
 
-	tpmi_info->tpmi_features = devm_kcalloc(&auxdev->dev, vsec_dev->num_resources,
-						sizeof(*tpmi_info->tpmi_features),
-						GFP_KERNEL);
-	if (!tpmi_info->tpmi_features)
-		return -ENOMEM;
-
 	for (i = 0; i < vsec_dev->num_resources; i++) {
 		struct intel_tpmi_pm_feature *pfs;
 		struct resource *res;
-- 
2.54.0

