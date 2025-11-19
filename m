Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A550366576
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567137; cv=none; b=cjCbQUMdcc114l04JiStcRqzx7aabfRqRITaKGWMLvAA6QwlpKNG5/VfOgIKMpZsY6DJERV0BYfIpu9tak3OPK8m/R3DzzAJ+EnuZz80F+ADd5ypp3YdtELCFsEjZe/rJu4+se1WQSMS5QPVIa8qVA/PGKjSJLo1uNNMm6dNu3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567137; c=relaxed/simple;
	bh=E0xWWAAtZ+sb1tFoy69j+X8UfYdpBq6LQ0ZttxzoUlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+9utiFdO9oVORq7vvCjO//Dhm48Zuv4v+O+yWSj/t8U9aQSx902NBAE4WN5Qp/yTiuZuhumdKTKezy/TAPIkH3uhNJmXcWFbQUXRALMC106bFQ6ndktnALplEKhKThjpCTObJV7Y1huod7GLRmTkyUc+SYTi4pjQJj46mqCnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bFLOD1dQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFLOD1dQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477770019e4so71951235e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567131; x=1764171931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93DS/ScHi6FgD35ajGLpv/dHTyNaaklJOjylE6wX7jU=;
        b=bFLOD1dQC0Q4Eym89MV7724Zm5/qYdVd2/MyrMm0XvxbrzU2lDJ7f3Hv1VBREo0swI
         VNOqEN4cIlEgl+4RG3ftwarzTx6ULTRfRqQECW4NCGOea5bakUcUwadftn+o9l5qcuQr
         GqOhGsYig2eyjmviFGaWge0Ow+AucMs/GddQ7Kvm24vYmAkB9N2JvTJG65NJ/KsZPbV2
         WLjgsvnPwFwpu+sLHn5AI3lW/12WVyHGZzzBopJ60S7mOvi8gmM7wjOlCW9IqzOHKDLp
         paCwK/zQhMrhsuME+ta7z/kdBso55S8pQQVjvaunWcA3poAn3wdp0V295gegBTryfFZD
         wv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567131; x=1764171931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=93DS/ScHi6FgD35ajGLpv/dHTyNaaklJOjylE6wX7jU=;
        b=NDH1H5UpgaxaJ2lkKT5Hy3wey1D7ZJ3eJsB8p+En94Z772RhWDh0e47YPaFP1t4sdy
         bYwXFqz3cZkNam5/auoHhoygzLN511uyXF6D90UeI+AmNgTjtm8XumF9FEIR4gQXBCid
         FWCxJRqoALbiTUAVIS6kNduz6gEQU/93GbLTR4u2EGUk93KQQSw9DbYkXryaNNqfvAAA
         6pMN+UsMyaLUVnl6kS2gxQS6bKQlbvf9R7ETRBs6OQLLWZ4uPtlYjpau+HPzerCM7hbm
         MB6SSiVIOh4W58rf8LnyJ8jU6i+axcGA6+IR+a5j7Iu55wFab3Po0E5de1Mb8guB7a+Y
         V8MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYpntoJqPVIMdSV3NB9zB2rIH7V+1viV+MFD6Qi5GEmwqrYLjW+2Wfcpfi50VkBCrmArn/pHDRzpDpq0iBY9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/X/v792Q4epXHKlYi/UHaiHmXw7EFbEmZfGk7oXiKs0w2Kc3b
	Y1obyk0RvpFY5+C5IUpQUXBzJXufYBt0LlPchUHkF42tKmXMEZ8B/QiNdHQzlrNYt5k=
X-Gm-Gg: ASbGncvnlm1nDQBmyRtZCVpmVp4L7MraqIE/Dta9h2HFBj9VskXvQSP+eSpKz/az/IF
	V5dh+tV+4zsY5gmyXF5sNAqQ+wQbxezS2A6C+PWFcUC9dkfoSckHD5S4EnPg/txJT9b3vVUBiZl
	siycSinHuZCEeNi8QdNFkwiSr/qyCGGekbc3Aco+0sOKFYht7/EX11/A70QuARoeQnljivT/WYN
	yjcsCXNmnpXRUsx6TKCgdVzekCaHOTdTv1ruI28Jjo/2kC/BPZyCo89yT+KaIYePbTEmta997fb
	aFI1JmIexeLE+xwEVapmFCXnKkjVRK6o/DwkOdDY5USRoxgsyYSKdxscxCyzranJcjcAyosSXpF
	E7g9INUA31XTWSFJL1zYjhY1RCvqjxEG43tT09ZlqH3BQqSG3/IlzPuBoHB5M7Txonh7eLTKYJP
	o6d5qHEofsGP85nDe2mXLZ96fwnFh1yRvwwUNYIGqH
X-Google-Smtp-Source: AGHT+IFTd+L8MIsFVmd5+4R/tV4nej4oyMMzTvyobs7oRMR9eeDnvkZRxA29k7Ua9rj2plkllb3d8g==
X-Received: by 2002:a05:600c:c48f:b0:477:7b16:5f80 with SMTP id 5b1f17b1804b1-4778fe49c0bmr204044185e9.10.1763567130586;
        Wed, 19 Nov 2025 07:45:30 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:30 -0800 (PST)
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
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 08/26] mm/page_alloc: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:09 +0200
Message-ID: <20251119154427.1033475-9-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into inspection table:
 - node_states

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 600d9e981c23..323521489907 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,6 +55,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <linux/meminspect.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -207,6 +208,7 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 #endif	/* NUMA */
 };
 EXPORT_SYMBOL(node_states);
+MEMINSPECT_SIMPLE_ENTRY(node_states);
 
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 
-- 
2.43.0

