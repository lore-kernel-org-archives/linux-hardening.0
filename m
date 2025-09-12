Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E332F759
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689875; cv=none; b=WSZJNF8N7tWStVUzQM23QIilYFzyjCd4AblziHEHGTpeiXAwOI50OjiZeyzqvdgPiSHxb+V5ZjBAMfPhMIuUN6HurlEAUBCThBUvTnjb1FTVZrJ3R74qWIluNuYCLCjr+1Ve69V075lBI5T0ZgXT25wx/QkfZMuXC4WY8pb3lZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689875; c=relaxed/simple;
	bh=SaxLNwPjG7byVt6l+p6cg0if9w4/pkHze4tv4MutSeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twafjJyjDnUnAF3JFdP3zCLiCxo8enuDIVVA8olCU+PNiC9GQSbmkXqhX6S+pp3Ll+fxBPfyNJhx3th1GbeCvJ2k+YaMecEHpHg0dPQhi+gUzum5wnpMdaMSMtvZ5jCy3Q8cQcv2Yzr/0eQbCSRHfUSU/WJLa4AKChpMwcXWvRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VjAiS8Xg; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjAiS8Xg"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d71bcab6fso18134677b3.0
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 08:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689873; x=1758294673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNs2h9oqVJ2U55pyNU2xzrbkzs9MTq1sjEL+cOU6gkc=;
        b=VjAiS8XgtXdzKrUmMwBmLiNbs2EgyM6GmNxbpZai9EZhieVl9fu/1Lp4nbNLwhvzQP
         8wpPed/SEK5/wi4s35QCMhrNkKEf10JMs8CtILbmBESRW3ZP/etDBFt96wyMychc1chG
         LcNRs6mLqth8+U9L6omrCfSmW8im4VbBEmJ6MMRLry8tpYVlbhRWTxEq7LPyjHELgiw5
         QRzsqRBxeqV3e8otKZ9yXyOD3u8wAynvR1NKs5e84W5emwdpMIGepeUzlrRa/PmIBtR1
         ExuSg/Tt3vScbYc6rEbzRSa8Mh4Me1W17/K4p7HAaaILzo0WrdPPG/tKMKEF6/rhqLCx
         SX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689873; x=1758294673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNs2h9oqVJ2U55pyNU2xzrbkzs9MTq1sjEL+cOU6gkc=;
        b=ecmNZ4nRdrKWw/cDOLQ6/YrybfWoVf+3zpJ/sP4qrWyBjnxuB/EQLQPOIqpDh3iRn9
         TEz+4ViyHPAOvwqkvsi+mw9uQD4rI5jnmVq/8TmFSVp8fJb2uJvFBNJBpZQaWfntOwBs
         1QJdBFZccokGiifPj5/zlCC34sk+uGYkymCqhIB34apnJBVM2rkBiHaYHSxA5IodJkb9
         oq82uCWceFCsUXOby0oJvycMoUblHQpbP2ktLImApvgFA7dVH3wAYRzkRXFAw/ZuA+jv
         PDe+69QxX2SywsYMDYSZ0+0fdxtke5hL2ZWMRAuioPiIMlhO6vHcoamxqbHdhh+2dOQm
         sKMg==
X-Forwarded-Encrypted: i=1; AJvYcCVBhVDXM7LS4NlbadPQ27UqPSo/NnDXinZrwSJI4LHgukUJG8E+S3Yovox2XaYarupUdLofP8bNmlrMTE3DQXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPr/ZzZnFdKI8+su7BuZAeAyYekLP54vT0t0L+Eep3OInGUhvR
	UW1eQk19tCXNTQXSmc6BCCtTyC0zMA1rT6dmw9K6pfGoitmzOT7c4mxJeVLjHSZDXCw=
X-Gm-Gg: ASbGncs9VPNL7LEPw1ZPhiPfDZUnfJRWDrHksU5gpX36WH4KQojhR0NyoW9dkB4ImLa
	FZl+YWwnDjgYhW2x2lXy613VgfzkzVOoIc9p313xgplvYiuGjMfN/oqDHaaeUHQridxv8vQ17hf
	y+auzYkfT6hxu5wumTb5FDLL41tchuferHqZdYZpoVIxWlndxL667xe7znI5q7ajO/sI8Au6FKs
	AzpWS//AlRdWMl1/nJ9A5mIVL6N2m5Fa5f+GAJa+bTjcUThNaZl0sX2XqOU9FmVK6hUP3V99rGS
	OgWx85nUURXaCwScKUfNMMWroLuUssv9Z8vZeaYkjgougVntLh+omxtwUxl0kVOW8alQ5AkA64l
	Gbs7rmirA+x8Pa/S1i+VGl5U5dFZFa/vyoQ==
X-Google-Smtp-Source: AGHT+IEpiP8vlE6JAkelU9ryV0aqgK+NNUoCmR9E9pT/XsbUls6aw+6SDhLPMx2e7d1wIx+kCxhExw==
X-Received: by 2002:a05:690c:4a0a:b0:71c:1754:2696 with SMTP id 00721157ae682-730659ba7ecmr33141997b3.36.1757689872581;
        Fri, 12 Sep 2025 08:11:12 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:11:12 -0700 (PDT)
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
Subject: [RFC][PATCH v3 16/16] dt-bindings: Add Google Kinfo
Date: Fri, 12 Sep 2025 18:08:55 +0300
Message-ID: <20250912150855.2901211-17-eugen.hristev@linaro.org>
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

Add documentation for Google Kinfo kmemdump backend driver.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 .../bindings/misc/google,kinfo.yaml           | 36 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/google,kinfo.yaml

diff --git a/Documentation/devicetree/bindings/misc/google,kinfo.yaml b/Documentation/devicetree/bindings/misc/google,kinfo.yaml
new file mode 100644
index 000000000000..b1e4fac43586
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/google,kinfo.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/google,kinfo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Pixel Kinfo debug driver
+
+maintainers:
+  - Eugen Hristev <eugen.hristev@linaro.org>
+
+description:
+  The Google Pixel Kinfo debug driver uses a supplied reserved memory area
+  to save debugging information on the running kernel.
+
+properties:
+  compatible:
+    items:
+      - const: google,kinfo
+
+  memory-region:
+    maxItems: 1
+    description: Reference to the reserved-memory for the data
+
+required:
+  - compatible
+  - memory-region
+
+additionalProperties: true
+
+examples:
+  - |
+    debug-kinfo {
+        compatible = "google,debug-kinfo";
+        memory-region = <&debug_kinfo_reserved>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 65d9e5db46a9..6a846c51db04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13821,6 +13821,7 @@ F:	mm/kmemdump/kmemdump_coreimage.c
 KMEMDUMP KINFO BACKEND DRIVER
 M:	Eugen Hristev <eugen.hristev@linaro.org>
 S:	Maintained
+F:	Documentation/devicetree/bindings/misc/google,kinfo.yaml
 F:	mm/kmemdump/kinfo.c
 
 KMEMDUMP QCOM MINIDUMP BACKEND DRIVER
-- 
2.43.0

