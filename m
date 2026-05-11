Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A133B3A4F35
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504750; cv=none; b=GJJJkOLNxJ3cmhROR69s/JlXRylmRjCyjIu4MAJ1mjpMmBmw8La7bNVSIOLCgQcksJQf5Lb0hyCNrpV9fr847KI9oM/oZnzbO7hxRvE6/Gy/f0CK490zBuVgMr2CuNT6TgRoU/fEuhxdUIztnPspWKSLEZyjbDGhIyblm682aIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504750; c=relaxed/simple;
	bh=M1BdhDHhctGN+nSWoT6Iqnwlg54cLR1CkWBAIkv+Raw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=crzHF02avk2IPs2nYZ9uE1wK1xaIno+bLckc0bcPG3wu9Jlsh7H7fcC62aL4T6NNd+id6OJ4Ov8yDzYcsSSDrJ5Q4m9641W/EobAOSqlo8Q4h02tgnzt4AkWK2/Pyq95Zz/erNZaO2eMiEz3scbP1lHMwXZ0NUQIsXQXZYcy8Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpQea85O; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpQea85O"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-449de065cb3so3970330f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 06:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778504747; x=1779109547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wKE/HS8PVABSXW4fi+mYBFkGbkLBcHtj12GDUFSueN0=;
        b=XpQea85OGOdquBLdUMlWxfj7qK1431XGRCJSlau+XvO8qqVBwXbwtXeq0MDk1NIj8w
         XKKoukoP2mspV3+x+bluAFMZ8YMR310gTWR2dopfh9K/9M9bbstJvu2y2ErSop7Uq9U4
         ZHvRgI8SYyCGbFyHcY4fjM0QqlUHRwUlf2VQNDh/08SzpfVUzUbeZPWY+xc67dz6zUI7
         G+HioreAUkNLzRdZvEhuS+gNuj//ZTkWWXsMDhdF76Z6A5OSxIeOCq/dfkQ44W+8N6G7
         zxK4+d8NQKP3UU1zPQnrpj8oBywPy6OigvxYubeHsz19kBwy/Y0slDWMNXcTUp/UGKCF
         eNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778504747; x=1779109547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKE/HS8PVABSXW4fi+mYBFkGbkLBcHtj12GDUFSueN0=;
        b=O8oEhlu0kDVY14tgJcb/B1vjwOMi3Q9UT9FbTPjIhhx9WjQjIfcih5Dm6Msav6S54M
         gWrTh4jyIapkavym4E5wQM+et8hqM4xfNZwr1WTdjxxXQlAC9bJCUQiBqeYKIoj5vdPn
         bfKyD5KBMLb9WBlFjL5lNTWYkKNzUYyioDsdzghs7a+rObIDCnTp4NrjRa7nR+n9cXCe
         bGLCnXPYhwdP6eoVmDGPjhtLkuvzROMPEt0fQVPVXSHA3eAoVLIHcOpTfbAXMaT5Wwd/
         woofb+d1DyZOZT3H8xdYaLpuZNxq+2cAxABZeVrZgOmDNflSP0Y0Sc5zAUB8E9J8xH/S
         hSxg==
X-Forwarded-Encrypted: i=1; AFNElJ8ZBYRkJzgjS1iIMQO1jDosHdyEPQzFuU2+DJyuzOAWUwHOF7O+x8FLMcWfCRSREa55AWfDozl3m61uc3XFvSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRNpb2dJfE58LWBXOIKikogd/KWSFIoXIjDqBSHdwud/Vxt5O4
	QS9SiyS/AsVnU1UUaEmoJ0fT0TQddAKnZx90R1Ol4lccPaeh1tkxGkA=
X-Gm-Gg: Acq92OEsGTE7C/rA94PyH4UhkYTw2chYkOXDePnNGlfTow5FKyUWyMBhBG7VaJOMo+F
	XWZq06H0Vef0rssn5efavc422Cc41T2xhExqnTcf7Teo5KDbr7d2sw/WD8dduwOMwcvSR8rymcl
	CRhaJm6qH4YeTNlXdbWzOO4gfzKKnQoIGbdpdYTapxRdUyaD45NTMOBmpXT12z+bR2W+fGRIPGx
	nQPepMm2Xqw359iwM2fC0GWKL1ZMwNdK0wzLTVOI6P/7UY5f53qCdCYGiTpJV7OaDqLw7s9yi++
	qLmO/kQboExDHFvTr0XMB4KCf4IFzz3dbUIAVSYaHAYMMmDruiCPEKG6c0uD9K/DZWnzUjxYyi7
	zgNBLk/IjEMQO0gnq1Yg0Z9TRcz0RPyN0bKSE0ketAfWTjbKcauo9AhNFiZdNEyNEEJPrgn/flI
	rwp7Gcox0lB59u5tHQ5jJG2gPPj6ErlRH3EX/orEU1USp8tlP1Kk3elwJ6lg1i9fSyzStwWyZ9m
	9xVHRjl9EWN9/vvjK2lWWkeZiG2n+ePguQa07eD
X-Received: by 2002:a5d:5f42:0:b0:455:606a:b2d5 with SMTP id ffacd0b85a97d-455606ab327mr17802750f8f.3.1778504746668;
        Mon, 11 May 2026 06:05:46 -0700 (PDT)
Received: from hp-ubuntu.. ([105.71.16.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120f1f9sm25615647f8f.24.2026.05.11.06.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:05:46 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: quic_vgarodia@quicinc.com,
	quic_dikshita@quicinc.com
Cc: bryan.odonoghue@linaro.org,
	mchehab@kernel.org,
	gustavoars@kernel.org,
	kees@kernel.org,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH] media: venus: Annotate flex arrays with __counted_by()
Date: Mon, 11 May 2026 14:05:38 +0100
Message-ID: <20260511130538.33443-1-med08elkadiri@gmail.com>
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

