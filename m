Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB87303CAE
	for <linux-hardening@vger.kernel.org>; Sun,  7 Jun 2026 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780831181; cv=none; b=cknJbS1YmlNNlwy5QmbGgfVsdSXqNGHvJUyAVNXqERELSP56P9NWA7NjZnAAo5M3bOqyvGtTJvlhxudtCIZH/vasfNdKqmkMnfGFOzchLwa1D78TdiMF/1TxSfGqdCxN5pUiWYuAtU7/xUf6wmPIyfJ1n1HL0Ha5wrqYVY+WrYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780831181; c=relaxed/simple;
	bh=0uDYtqRBUzvLjwC3Lb+glSfRN5HCu+ot/eZzvgKdnq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgtT7g3l0es/xly3BNea7jG7c7++dL74SnT6h8qgbwa9T05PQshQgZ1/2wwPWj9O4WrmMO8+VFBLGmPFunKy9VEsrb3gpaRXIpZg0yN+2gaNZflsvqDTlM5MLiSeSTf1nA+EVb/2ZSGvlWhATMgBKvSAAv+14fxrQ6c1cAv+7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfwjCMVa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfwjCMVa"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49068493267so24251945e9.1
        for <linux-hardening@vger.kernel.org>; Sun, 07 Jun 2026 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780831179; x=1781435979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nrYQAlpfe/R8hKzBRpiJvT6OU8qSP87xKaeg9At/5s8=;
        b=BfwjCMVa5kQOBFZ/v5rs91TcX6t9R+J+RUXTI6y4v6M2e6nY2c19BviZ0hLBQABya5
         jy7N1orx4sQjjn4wAkIMJ8gJkGI2u7QnZiwJpNQAZOCFR95I+xN8rGw/fP+mTHLZUj/p
         44sswKTGeTHCkARHGPQMu6p6Izzz1LM1orHNpLHFt1HNJ83GampZthLmkv1003riHEmw
         aJPcdgWyEfhRdwLoDuyLYRiGx+v/Zt73O3ftGBMgfRHxr/1+YPbc1uO8DXifmQEZ7WTf
         jxsXmV1GsPWlKkBOAJWyv8e3VfY2ZfFTlFwUj9mZwH62YKAsbXyh2YuzJsn0ql0jyrDV
         Wwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780831179; x=1781435979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrYQAlpfe/R8hKzBRpiJvT6OU8qSP87xKaeg9At/5s8=;
        b=NYrpWowpEvzV1gdjdj2A28c7c3g6lpXIq31MYNDHtFWTZQOqlgSZciDjFMfXwBmnC9
         jik6mrcUwow2dCwCY/rYiPdrazUbgLJqZa7tnCjegMoUPm1TDVTpO9rvn9Y9+hNxMLcX
         6E7XUZSL8Iy22x+3GgPrBt6PWdvNI/yrh4ph6LtLmEn7WFiVXl1w8yv2XKAo4LB0O7Fk
         jEz+Q+xrEiSWVFRf52WK2aOnkYX6tzhRzdFbwx4eNDr/MQpQWY/C6PCTfsEjCujLWrAS
         k3bfVP8iYh+AMUKQb+D86lbAyV8uDxCqGu0BYm5Lw3nhbE1xnwMFZfxR3ZZ5bmIsqENY
         Rvjg==
X-Forwarded-Encrypted: i=1; AFNElJ+L8+TIo8OP2Zc1Lom7zpeq6J15cCF9XWHI3afXoS5gFk/kkLXpdv62TFfM5JiYgi5U27u5LVMrpYw9HelgH08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8gIAykC1dsos5BqjiAbph7xy4lMKS8dYwhZ4qHakh2AUSkGf
	DQPkqdKwzE+218eISM1oxJCCGPeGO1YK6WecD1y4+aRlrsHWeW50svoV7zKMj3oacw==
X-Gm-Gg: Acq92OFBwz14pVlM3ag/vAEvCDveHrdpBo4U++YjLCcBB8bSFxSIfdEjHCn/NhN4Ph5
	XYkf6mX8S3HfvCmuC1yzaAhjKxqkRIjuBIw4Lh3IJdk6wwDWMWTv7NzZOxfSRTvALvH47f6U8CH
	5ir13TMlgHiEU41kjeNot87ZwzcoOeW4F6W04/A63SXCwIBPszvZqJn9gV2ESRZMGnySDFmQmXK
	rFwNG6g98oIFB/Lcl0yZenYz7oztEPSX7aGjXt/LQtctiqA/j9R7TEDOGAvxaVIs36q3k2li/5z
	h0kmpCyOpCAG9+cxjrOMHJeMdjOZMq5c2jJys113A8WL4z7b9mJlrMdzOFlOM+jyV/sMwZeHOp3
	U6PCFQ902S+UWg7DuMgG7ag10LmtneARYVNnzxltMUIxY2jODc6qb1pVttg+uzXY8wp8CTbiMZy
	auGhNOXUbO3O4C2CIKjAtGiZO/e+dECFI1IszPHMooWLYrvUENVuZ0oEfXndoMkvRD1TiOY3qUZ
	oTBJ2TJPGjGWdd6CaH84mHQ4W5hbqvQPLkCdEc4qw==
X-Received: by 2002:a05:600c:818c:b0:490:6237:521d with SMTP id 5b1f17b1804b1-490c25b3ca5mr196207925e9.13.1780831178838;
        Sun, 07 Jun 2026 04:19:38 -0700 (PDT)
Received: from hp-ubuntu.. ([196.74.199.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918d7sm282234195e9.2.2026.06.07.04.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 04:19:38 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: quic_vgarodia@quicinc.com,
	quic_dikshita@quicinc.com,
	bryan.odonoghue@linaro.org,
	mchehab@kernel.org
Cc: kees@kernel.org,
	gustavoars@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH v2] media: venus: Annotate flex arrays with __counted_by()
Date: Sun,  7 Jun 2026 12:19:33 +0100
Message-ID: <20260607111933.6398-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __counted_by() annotations to flexible array members:

- hfi_capabilities::data, counted by num_capabilities
- hfi_profile_level_supported::profile_level, counted by profile_count
- hfi_resource_ocmem_requirement_info::requirements, counted by num_entries

This improves run-time bounds checking via CONFIG_UBSAN_BOUNDS and
compile-time object size resolution via __builtin_dynamic_object_size().

Assisted-by: Claude:claude-opus-4
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 drivers/media/platform/qcom/venus/hfi_helper.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index f44059f19505..e96d458c52fa 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -616,7 +616,7 @@ struct hfi_capability {
 
 struct hfi_capabilities {
 	u32 num_capabilities;
-	struct hfi_capability data[];
+	struct hfi_capability data[] __counted_by(num_capabilities);
 };
 
 #define HFI_DEBUG_MSG_LOW	0x01
@@ -802,7 +802,7 @@ struct hfi_profile_level {
 
 struct hfi_profile_level_supported {
 	u32 profile_count;
-	struct hfi_profile_level profile_level[];
+	struct hfi_profile_level profile_level[] __counted_by(profile_count);
 };
 
 struct hfi_quality_vs_speed {
@@ -1085,7 +1085,7 @@ struct hfi_resource_ocmem_requirement {
 
 struct hfi_resource_ocmem_requirement_info {
 	u32 num_entries;
-	struct hfi_resource_ocmem_requirement requirements[];
+	struct hfi_resource_ocmem_requirement requirements[] __counted_by(num_entries);
 };
 
 struct hfi_property_sys_image_version_info_type {
-- 
2.43.0

