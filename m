Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B98353ED9
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777589609; cv=none; b=jKRGW6p0v0rcakcvOfdxCryH/hNvHKTCQMIM0sDbnp0BPO8/Z2YSwvq8BGuhpeIBOfPwYV2imNnsBn7jEMZBmSeLieki6G3uyuRtyfAO3643hyacMuJKNIZLALsMVj2uPSyT6D5eQl/2rYl9rMPQNHiCTL+rUnTdnOJCQJrVBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777589609; c=relaxed/simple;
	bh=skGTGrLVcifH8lHYXyJ1EySzxhgSJcO8bcxVlpJNh7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cw0tzXUt6qgwm+9l/3u9R+Z50eu5jxP9O85dBX2XUyp3hTsNzMTAwgrsPWTTd/VTCyZCeHi+oTJfTvmUUKRUbvq0m8IjObfN5LQ9x/YJYGXxGAmsfHoOspqOv2/iVtjWgaj0Gk47KKgigOFR+vh9XwLSiVBIF3a6xywKoasZBUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF44lAF2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF44lAF2"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82cf636dac8so710769b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 15:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777589608; x=1778194408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3sFxgw4Clv/Aqa9OTsN2Ya0IWvB3CZpXJ32lJDy2rEw=;
        b=NF44lAF2cAM6Tj/PSLsyHTnqn9ik/quFEGK3nLK/eRXubMHFXq1xjnG5hdDr1sLbLW
         LUu7FltY/8mO7N/pkgrN4yKksiTYyYZwRqBb50Ch5NJePbwtwXleH8RtApw9qKlbu9Np
         6Q5RIivI9n1vL0RYU6crLDeFkgoBv6eZzhopz3U2xA5g+fTe/XM7pvq5/RPIxukbX9cI
         p9ykMfR3wap64xSO3gq1Tl6SMNylQKCmx8awYJB5fI+UfoVqk4+LSvGmslCGleYP4WmF
         U/tvLuNjK+wv13vb0A+cvCoXfEKEb/bNjKagdItLHm2aMyPdlTuO0g+zu1GK3lWF/hnv
         iOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777589608; x=1778194408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sFxgw4Clv/Aqa9OTsN2Ya0IWvB3CZpXJ32lJDy2rEw=;
        b=ffAhJD88kKXtuTMUBMF6mm3piplXbKdrdkBbDkDFlhNNnnQRRjPHyqdqTVcROieFFv
         UV5wyP9FaP79IfV0+7f8DtsmQmGbgExTEzfNff/IJy6jDQg2oXGWySvS8Yv/oSYXwL9T
         MZ4eI1N4q4o1izFsw+KIae3w86JL6xv6cStQxsrasFXBFP3Oz8XchgcxQUhY9jm6kT16
         Cr06FAgo68l3TIPows0KNCBVvoPJVDrgxhdmprKiSCIl5t6lPF5+RDMJQ3tFQ8Me68Ey
         aPzMMdnqkdHhD9aIib3qmNFQqHRhuhr0dPqpsaZ6m5g8OUWDxW2b+mwMwcU3NJLyqREm
         7xHg==
X-Forwarded-Encrypted: i=1; AFNElJ9oWr/kNXBu4ls/UebeTMPgmHtRtQYgsvpKddFutlr7cEQlfVcSvLI+kpsbdnPmgSh8/YOjXUdo+++1ORIl2is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfs71ZgzECifUQWakte85/IGF8fgpo1CUCcj6JTPgkgK3GYENP
	U99kI3SQXgsrvwMge2vQKe+UQXe0gdMfeYbj1glc1BNyTUaI+jSiL2Ds
X-Gm-Gg: AeBDiet8zpCUbg4BrupTt1e4blhjxrjvN5L6fiNEhNQxnTOXS5BdopkGdAo+8cLPw/u
	n2AfBRTOLHjr7e9LflgeypucRihyFre7YZfVO5zNVcJtmZADT21DAd30m7ONGNr3tDUdKI72Kj6
	12Gp2gu7lApVv5ZIafRzig0LKhh1w/80vNUuQr/JV8NJK6psvf2LehB9Z01VpVgHrSo6xs6MYMF
	MEZA0G1Nspp/yZSirXLhRpxybpq+J/CdOTodlGCkR2qsFhwmELjY8xpGC8QuAd0t5ToxOhFx4f2
	rnDcc4OWdxrxnsOm4Z3q9sUat7T9oY7Tnri8O4CB3gB293Y5wfn0li5x+t0io8pR9FdLqICQ6dc
	byjqm2XWK8a/lENz9ZknJmPVkMS2cOy8fa5ucwn9a/YKHUD8MBY2SmuE8QS3DQB89MD1Fj9II0Q
	vhi+2vyssiCWeloWelbw0VY8VHznkhNtpJ4zRrPsGQdXS/QtxGO/xGcwf81BwPVr4SM51X2fU3p
	H7dS/6g6D252M29sRw5Fny5geC6dwPEzOvxBu+Bfrb54g==
X-Received: by 2002:a05:6a00:9a7:b0:82c:7876:a027 with SMTP id d2e1a72fcca58-834fdb4947fmr5496414b3a.18.1777589607741;
        Thu, 30 Apr 2026 15:53:27 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158322f6sm757564b3a.10.2026.04.30.15.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 15:53:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] platform/x86/intel/tpmi/plr: allocate die_info with plr
Date: Thu, 30 Apr 2026 15:53:09 -0700
Message-ID: <20260430225309.117557-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocations slightly.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/platform/x86/intel/plr_tpmi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/plr_tpmi.c b/drivers/platform/x86/intel/plr_tpmi.c
index 05727169f49c..2fd27e80bc1f 100644
--- a/drivers/platform/x86/intel/plr_tpmi.c
+++ b/drivers/platform/x86/intel/plr_tpmi.c
@@ -57,9 +57,9 @@ struct tpmi_plr_die {
 
 struct tpmi_plr {
 	struct dentry *dbgfs_dir;
-	struct tpmi_plr_die *die_info;
 	int num_dies;
 	struct auxiliary_device *auxdev;
+	struct tpmi_plr_die die_info[] __counted_by(num_dies);
 };
 
 static const char * const plr_coarse_reasons[] = {
@@ -278,15 +278,10 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
 	if (!num_resources)
 		return -EINVAL;
 
-	plr = devm_kzalloc(&auxdev->dev, sizeof(*plr), GFP_KERNEL);
+	plr = devm_kzalloc(&auxdev->dev, struct_size(plr, die_info, num_resources), GFP_KERNEL);
 	if (!plr)
 		return -ENOMEM;
 
-	plr->die_info = devm_kcalloc(&auxdev->dev, num_resources, sizeof(*plr->die_info),
-				     GFP_KERNEL);
-	if (!plr->die_info)
-		return -ENOMEM;
-
 	plr->num_dies = num_resources;
 	plr->dbgfs_dir = debugfs_create_dir("plr", dentry);
 	plr->auxdev = auxdev;
-- 
2.54.0

