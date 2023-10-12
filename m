Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29246116
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 04:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJ1Pz6J7"
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28B790;
	Wed, 11 Oct 2023 21:50:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a645e54806so82143966b.0;
        Wed, 11 Oct 2023 21:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697086255; x=1697691055; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSjZDUjjPOz4QqV7E0UZLHS9zrizXOtrbmGqfrqmqCI=;
        b=eJ1Pz6J7H8qQO31WvJYQSvt4ui401mMgjSEmgtcetAfPwDyXx/FVoQabxHRAkcPsT0
         /AUbWuP3uQTD3cabFiyVNldNiPHfo7lSivmfD9pTpLfcmcfiCj5xC380XK4fZuUpZ6Uu
         zZBc3696Lg/BuQhNYWwFhmRUMawZ3b/g2oQwjVoyJv5iFsf/83PayyvS/RNn7CvP67CD
         qCJX5qSJko4KSTzPjEcuq7msYzI+tV3TzSqPbkwkyHba2mojpf+AYuLloOOiFrbCH8eM
         yMo2iXliZfN4kdjcENJoX/R0w7HPjDlhaJurznXui0scpmj6DC5khhvDzLLaPrc9SxyU
         PMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697086255; x=1697691055;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSjZDUjjPOz4QqV7E0UZLHS9zrizXOtrbmGqfrqmqCI=;
        b=cYF0wf7Ol+U/mFswR8jD53lrMFFzNTCt7bbQGy5iGc8WHaV6dSwy6C59vUANMbZrIr
         jJJYQJjq5ahUnnEyD1JZKbPL4m86YQYm53RONeVRbo5Q4Fbba5Kl1BxbccI2drL9ksHF
         K0Ia6CwLxofKe7FnVaoK9bI7B20P06OlsI85UMAcIebL4TelxBSkomwC6Pz9x6cSPO2v
         Rbim0k+YnYk8sAhEj425kjJkhX/SQmyUYBmtyCO4t9Xv7sX7twKssl86w5AV8e6eOomm
         WnImcEHYk+c1p4xoWXHtOXJ7KpIFso9/XHT6MoBu/YlK+3hvE6AkNB3puoi/HP68NV2r
         rtYg==
X-Gm-Message-State: AOJu0YxPiPIAbu9iGZVClmMx2yVN0epkk3fen+rkFxKR7W4FE9aySCWX
	Ovlb/QxBg39h5EZDNpCA5RU=
X-Google-Smtp-Source: AGHT+IFJU5Xjs5SYCirYwBHBkaBd6589j3RzlYuxc/TtMyuhUiNB3IoWlaEQrYaPTu0/d3k7JkPpdQ==
X-Received: by 2002:a17:906:2d2:b0:9ad:8ef8:a7e8 with SMTP id 18-20020a17090602d200b009ad8ef8a7e8mr20459122ejk.25.1697086254881;
        Wed, 11 Oct 2023 21:50:54 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:78dc:282:cf18:8032])
        by smtp.gmail.com with ESMTPSA id w19-20020a170906481300b009b9720a85e5sm10573362ejq.38.2023.10.11.21.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 21:50:54 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <jroedel@suse.de>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] hardening: x86: drop reference to removed config AMD_IOMMU_V2
Date: Thu, 12 Oct 2023 06:50:40 +0200
Message-Id: <20231012045040.22088-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>

Commit 5a0b11a180a9 ("iommu/amd: Remove iommu_v2 module") removes the
config AMD_IOMMU_V2.

Remove the reference to this config in the x86 architecture-specific
hardening config fragment as well.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Joerg, please pick this patch on top of the commit above. Thanks.

 arch/x86/configs/hardening.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/configs/hardening.config b/arch/x86/configs/hardening.config
index 19bb0c7a7669..7b497f3b7bc3 100644
--- a/arch/x86/configs/hardening.config
+++ b/arch/x86/configs/hardening.config
@@ -9,7 +9,6 @@ CONFIG_INTEL_IOMMU=y
 CONFIG_INTEL_IOMMU_DEFAULT_ON=y
 CONFIG_INTEL_IOMMU_SVM=y
 CONFIG_AMD_IOMMU=y
-CONFIG_AMD_IOMMU_V2=y
 
 # Enable CET Shadow Stack for userspace.
 CONFIG_X86_USER_SHADOW_STACK=y
-- 
2.17.1

