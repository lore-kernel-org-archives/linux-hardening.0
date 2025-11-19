Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175536C5AA
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567150; cv=none; b=CXwtm0cTNqE6Q2VVdqB0vfM0hPt97ttcBS5OlFqLv5v22Nl/HjDcass2l0R1pJCllXchVBW3fJJNcdtlwNBA6hgfnNySOYzjwnIStPPDfswlxloVP/tH2GfAdY3HFrJ+ImVeS3xEcsm3SBKRIwcPwIfG3G27xx3v5yh7R+dWi6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567150; c=relaxed/simple;
	bh=b7ZOQzNfYMyF79i/MOcMgt4XB6zny2khgQb+AuAIOw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBRrl/px4SLsK8Bd6g4AlYOD3SEFIvP5E0FeqyTmV10JTTyWJSfgWOPG5LFuGAfnXOtJTmJp4dL6vSdUAs0RGKcB6C9TijL8r243Mj/QAX0DmCeTHHH1T4ouD97eq7x4kdNsYvbcX1Zp7M49/R7a045+pVSOulZXhoDQpsBZsZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XeaDF8kX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XeaDF8kX"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42bb288c17bso2710891f8f.2
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567143; x=1764171943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVYkZ+YGVFmg/wGLFr+Mopllp1/vePaMucgqpmR/GFM=;
        b=XeaDF8kX7ZMHl7X8ve6YNTs6euc7cDzNwMF9/a96PZftfKYfkZ/jXE/thXL/LIiIaQ
         Q02MWmIB0O+JZ4GbrTxisOUMxALtAyHyz7jTCadkeqf2n22P1NIagu441f3tgFfM7QcK
         dPVYhDfsgeVsAh6mkKLn7q2BI2RpjPAWudhIFGd5mliSmMThEjsoxYZzUd8k5X7CyRsw
         sHUf1zcJWaopAFbyIAHxwLNqAwpL2GPHXcCGTngCCzojxG1y0pFkuHuu7f41aalfT3XU
         P6RMp8UgCgz+zFoKCmXIQRXYYotpvNuXYRt/Q/hWzlmcyHHgx4Vpn62xuszXtlAhNHlv
         FbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567143; x=1764171943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VVYkZ+YGVFmg/wGLFr+Mopllp1/vePaMucgqpmR/GFM=;
        b=VxQoQ9+uTVogYLSJno/bnjyk56BOrtBN7RghO4Bii3pIByLEqQ45pIuhTcNNe7yTQe
         kC1ntl35L5UqGs8RrA41TKMjcLHI+lIsa1BEsWSLf1Xry+gLbvZoxBLxAvK/ASAywSLt
         ZlB28mymfeCaDCFkmlhvvzS2gOzRsA/GNDHYF0MylnpIlFnWgQe1VEfWZFVPM0+CtM1t
         8scc+nrFdcBF49+kg+mTHQR+rpJMdtgqMBhAPu6UTUL34+4s0crGmoiDwip+4pzp2PWM
         Xp/80AgFE/Iq97nd5suh1WBYPf+XmSTdQgTUlYeckL7on4ucB9p8+QYZfklb/WXc6jdB
         rklQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAXAB0UdkiCYGllzd/OF0vwKwHeWBgWyrNMFNzUvpxnAdX8iIc0FxQciCRAA6Aco6slPuNN1iof/YscAHTMs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoRXtjV0zOEFA4kc/m3kIjbDdTZkHJJ0RE/eVzafAdAr4t3qWV
	RFJn8+7ds1cRI2YCYAwXphSn/5y7sGxP+iQ15j4qO+tWqP6N5gtiuXPw1dZRWytjD1A=
X-Gm-Gg: ASbGnctkGdwiTyFzYNbNHttFQDE4CbpVGcalJeB0vvSEqL62XzrBT3EmUgvaSt3OWFD
	+Y7vxUfiOIWDmNNZvFG4XiG+DsH1OVQsOng4oq1AkFTwKRRRKB9GrYyRxBHS5WwtagoEJvW46nl
	zHiyKUr2wo1HnNfWhcPHDVJA/8vGokR378INwhYWXvgQNP3T0BN0R3PBPOEI3mqdWOuMn0HFCKv
	50KQRw+YyhE9pIacaQ0AJy4zVgYsFxHVhVZTHE9iH9TjmHe9jrStdqgRJUQYAl0McAkyqxi3HkN
	LYS/3E363MoizwNVhw0BWpZyb83AMjx1zYAH8sFce6qk1rAxEC8StCVh03CZRLg+YOijGXA25pS
	oui2K5qyR4hexv9YzdWAdOTZ8gIHkcXjmsH+Y0cnxTNLN1uyTu63UWostgeqqU+G/x4+SPLeM4K
	i5ZYfjvrUMylMS6wjNstyBqWOvnuKoew==
X-Google-Smtp-Source: AGHT+IEZRkUZWC9WWo9OX6jj9I/ZWQe6urgV7WqPXknOd3CwNTmQvHOBkmKtLsoZT2TI4A/OTOkOYg==
X-Received: by 2002:a05:6000:200f:b0:42b:3806:2ba6 with SMTP id ffacd0b85a97d-42b593394b4mr21022814f8f.25.1763567142926;
        Wed, 19 Nov 2025 07:45:42 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:42 -0800 (PST)
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
Subject: [PATCH 15/26] kallsyms: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:16 +0200
Message-ID: <20251119154427.1033475-16-eugen.hristev@linaro.org>
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

Annotate vital static information into meminspect:
 - kallsysms_num_syms
 - kallsyms_relative_base
 - kallsysms_offsets
 - kallsysms_names
 - kallsyms_token_table
 - kallsyms_token_index
 - kallsyms_markers
 - kallsyms_seqs_of_names

Information on these variables is stored into inspection table.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/kallsyms.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 1e7635864124..06a77a09088a 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -31,9 +31,19 @@
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
 #include <linux/btf_ids.h>
+#include <linux/meminspect.h>
 
 #include "kallsyms_internal.h"
 
+MEMINSPECT_SIMPLE_ENTRY(kallsyms_num_syms);
+MEMINSPECT_SIMPLE_ENTRY(kallsyms_relative_base);
+MEMINSPECT_AREA_ENTRY(kallsyms_offsets, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_names, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_token_table, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_token_index, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_markers, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_seqs_of_names, sizeof(void *));
+
 /*
  * Expand a compressed symbol data into the resulting uncompressed string,
  * if uncompressed string is too long (>= maxlen), it will be truncated,
-- 
2.43.0

