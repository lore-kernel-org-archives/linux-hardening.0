Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8F28A705
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348267; cv=none; b=i7C97iRdLKLA7JoH+rGMrsXJ15V4VgaHoXJ26iAEOHSdd21D0af1+G9vuzXLiXVMPQQ4GRE1YJhwZyK0JtCwKj5NM4rsaP2KWxh7rl2zz7+oF877JDzJr5dtCSgtKCCTkIUc1nxdUCVStZJRHEgS5xIPLXJxc5Pku3VF0h18dF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348267; c=relaxed/simple;
	bh=WeMxLxNxoM0fxbTOjXv8h6v0vRO1M3ClG/sDp6GeyAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qjys0RBRCU8k7k7khkRih4qh8b4BN6OeAq3T9P15SRWeYdVlbKV3G+F+QqbUs/hnSJehJrWH9bJxIlFvMu/bSfcH3kwGKZZglIIavbhPlhvjcnce2Xk6pIWVnB0ac/PrFkrpv6D2VsnCArGzvc3uSf9v/KzaxLU9QeT107RzC18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH1SV2OF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH1SV2OF"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235ef62066eso45515085ad.3
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348265; x=1752953065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rq1KJVn4h8bfSVddR8RDWbHZTl1lqWc4Gz9OU2mVmNU=;
        b=bH1SV2OFwb5/brIEhiGtVtBW9RVg31VnyPVcqWsteUvAtYi9YIeZmVrQguiP5qQdk+
         Ogtlp9P8MEvspHpOrVPliRTLvgXj5Vcxsf3ga7+ppQwQSVSZ46Os4WtfodQ8yuTCmGX4
         b16WC/cIulk+EJtmLfutslP1JDx3aU1prf8tX2PvGk1n5/t6JjNItXtNAw3bR6GJNzI5
         f043CUftvzqI0LWSx430ZTkUwuffaXYr02JfjyVZ1oUC94G4PbM+eFZqJlFW2rPRxmIC
         60y8y1f8RoTWLit7s1QnxbDSZ007MYVstZr2P17dHgkGr7JsNPBkZADsO+cuq5t6DNbF
         YOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348265; x=1752953065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rq1KJVn4h8bfSVddR8RDWbHZTl1lqWc4Gz9OU2mVmNU=;
        b=rG6gUa74ut9sFJavM3pO7QnW/qRqoL7ZlsHCQYEES6guepppYRknRPn3BVq5JLlQeG
         B1ASeNMNTv2BZVjWd5gOiY0rEy4qUQW/i72pNweenYFnByWO2dp7X688N0gBvpDfhyQL
         kkW0UYPq6r57WVIBR8mM+2KGVG5yi4JSVyUV13OBRHcurgqOcVlig+zwTdYADH51qeWL
         XW8Z8H6scAXiPWFWZKBlzM3UeZ+Ono+024rmvBXLtnpfHHxf+Qb+KV0g77l72v3yFroE
         4Zhk2Yaj/Y0Ra3Cn+z0R61sBLsbdaM4rEyi4xGQodpqP1TVC9WAzeBfvRx6ex+kBfVx/
         /5pg==
X-Gm-Message-State: AOJu0Yz/Dze8f0W1JbVwe//bYCRk1hC8ZbMtHsmyf4uR8XC5MU3xb0Z3
	8SqS46spoudlSD3QyY7/8T1NHcINsB+KyFXg6c2aXVRTGRhJc/OaTwSbJoodohw0
X-Gm-Gg: ASbGnctATX8HpfOFEYZ9pwbKSC5CtGlSgyXUYSKOi8b/ZJdrJe8u+EYbXFZfKAce9nH
	05smlC4v3QnZhhHI79zZWSm6Z59aizPRARdyMEJ/oi10fK/Bzn3jaGK9a8OJ9jwht4c/29Aa5Br
	Fe15DbmuBiR5vfyfElDdTQfn7vH1egkxtsi+ie+rt71/m/i86KBXLyGOIh/tXQ/XOSFru6HwhPE
	fJ29/13i/6yRfsKVr4cfSudDP7xZvOomo0vLITM4AghCh/2AjADSBRGrQWw9irIDTEw21Sfs7e2
	lbScmC5O21vp7GKeOfEF9Iv5c+uslYaFWC85cMCfH/R2TBtrksp59vSAjNZuIA9qJzV7v3JMVv2
	+qL9twzr1x1Yrt3QA8oeLDx39avht2uyZI9NOKPjD0NkB
X-Google-Smtp-Source: AGHT+IGBAIu1f4r0m1O+njfKoFHNuzCNxxiShF/oWKeb8EKrT4YW8ByKI5YtUk1ko859cETx8KFWDQ==
X-Received: by 2002:a17:903:24f:b0:236:363e:55d with SMTP id d9443c01a7336-23dede81d49mr112341935ad.28.1752348265309;
        Sat, 12 Jul 2025 12:24:25 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:24 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 14/17] makefile: add SafeFetch support to makefiles
Date: Sat, 12 Jul 2025 19:21:59 +0000
Message-Id: <20250712192202.707192-15-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
References: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Also update version string for differentiating testing kernels from
host kernels.
---
 Makefile             | 3 ++-
 mm/Makefile          | 1 +
 scripts/Makefile.lib | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7eea2a41c905..6a3bf5849270 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 6
 PATCHLEVEL = 16
 SUBLEVEL = 0
-EXTRAVERSION = -rc5
+EXTRAVERSION = -rc5-safefetch
 NAME = Baby Opossum Posse
 
 # *DOCUMENTATION*
@@ -1088,6 +1088,7 @@ include-$(CONFIG_KCOV)		+= scripts/Makefile.kcov
 include-$(CONFIG_RANDSTRUCT)	+= scripts/Makefile.randstruct
 include-$(CONFIG_AUTOFDO_CLANG)	+= scripts/Makefile.autofdo
 include-$(CONFIG_PROPELLER_CLANG)	+= scripts/Makefile.propeller
+include-$(CONFIG_SAFEFETCH)	+= scripts/Makefile.safefetch
 include-$(CONFIG_GCC_PLUGINS)	+= scripts/Makefile.gcc-plugins
 
 include $(addprefix $(srctree)/, $(include-y))
diff --git a/mm/Makefile b/mm/Makefile
index 1a7a11d4933d..36826aaea1c2 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_KFENCE) += kfence/
 obj-$(CONFIG_KMSAN)	+= kmsan/
+obj-$(CONFIG_SAFEFETCH)   += safefetch/
 obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_FAIL_PAGE_ALLOC) += fail_page_alloc.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1d581ba5df66..d227eed3c6ed 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -90,6 +90,10 @@ _rust_flags += $(if $(patsubst n%,, \
 	$(RUSTFLAGS_KCOV))
 endif
 
+ifeq ($(CONFIG_SAFEFETCH),y)
+_c_flags += $(CFLAGS_SAFEFETCH)
+endif
+
 #
 # Enable KCSAN flags except some files or directories we don't want to check
 # (depends on variables KCSAN_SANITIZE_obj.o, KCSAN_SANITIZE)
-- 
2.25.1

