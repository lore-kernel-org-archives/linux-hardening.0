Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC012EAD1C
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365412; cv=none; b=l9RRYFrGV8jsKrnRDiNqvakh3l1i2zszosadoPyyn5i8q3mL6AxcXo3p/PmQWILumGQp8Eu9gsWuc8yCQ74fVhv9Sz6phtSe4zgaKhiyGuWcBSKkrr8wQ9TneZWQQZiHwBNsC7B67ifIqPLZMXic+HXZ2ASgaIBV2UwLaPBFVj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365412; c=relaxed/simple;
	bh=yDgqovov3P+BgQJIgQIcPJeeBOVhAaLQJOWmJvGhnm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXg+fAdZYPzvCjwAWnckgbCXwa2vYTW4v7epOoUg/J8llCDAMLlzRZnDTlroZPO7NSiuYzbTnvt1LIOTCjqGzBMtfr0rX3cRJkNXPCpxoVHK0S8/cyjxpz4UehkmXGayrUtRIgzme1QDs3adow6j8xtCZkD9xocG0eKg4IKw5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jwFZiSQV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwFZiSQV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d6ade159so6665755e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365407; x=1753970207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la6fP9HkJphfM0jMf+9F231C5ZYtMe+0kHUA15eBYp8=;
        b=jwFZiSQVJYWsamCDFeiyWQiJ3l/lmU7kS3tELReNf7RPsOKXGDXYGlWUMofbznWnLw
         8ZnZ1porHZcgssDi+CbL/Nm4MVmuNi2l0vKRD7VTDAoimUJoblalg2o+NqLFQgq6YvSJ
         phfuCAjdAtTiLT/9XNloAnkBqNCM0xkC6j+phLm04TSGt8Fq+yFcCh3Uy5EFmcCdnOR6
         cPIKZdFJos5wrXSPtaaeGbXhStNFIWhGew6+hUqzuDMNoMCgOyv7hMD+aIFhRM1QbNaw
         T0mAS/mSYMrXQf/WBLp34BXnb39XN4U3ImwgOQAqkZ2UQWp5Exo2pQmuK5X9xRzfG5Jt
         WZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365407; x=1753970207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=la6fP9HkJphfM0jMf+9F231C5ZYtMe+0kHUA15eBYp8=;
        b=fNf5vnaFX9/iUktFik1qtvfNuS64rWV1u3Vq3eo+qRdXvGx3ftzl0VBTuV4/5SR6AQ
         kN2N3LZxhFgsCaahLn9Mcl51Rl3c2w3YU63djY1FpTzskowfL53wI13/4XL3XBlRGD1d
         568h0+kffM6uX3qfqlCDimgccYFe4l7GrJh193kx+PH+aiZIQor63tmkAO72igI8D9Dp
         8cjO+a4AQDWSiFc13fEa17MvN4l2/tF6TsvVjQkqkge3lVqrrX42MbTVTQ0nDLDZM+pf
         GK5fP1w0m4SANgcRubfKoLp6zOXO5RUQzE4oKLfWFibIr/CucNmt1PhbOk9P7EM9+IJd
         LR2w==
X-Forwarded-Encrypted: i=1; AJvYcCVXlnI+Y09+nIFuegTciBoaKZaVinhE3qRNHtnqELESWkAurXI05vzjpJxChjawVXecH/5vsiwB84sqUPg6eH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv5ifSQn4PviCHLYvDHDH0TwedJlgHJdSE36q9hDSuWkgND02w
	cI49184mu3TjS7doSo5L0QJhXXGjr7fxSiIZBaVSXLJXjrJxwqO3/I99kHq+/fK7YjI=
X-Gm-Gg: ASbGncuZztt4Phg7VEAZ7GTgKrgtzopXIrBu0O7nkNKrJlvm0Qy777JMSG2HExKHWTK
	Yic64Wm6JeaUVR/Mko10z8qQpaO3TbkVpnq+CUew450LvsYhE7JravYXaU/MMutnYHBWndyvAlw
	HVyvWRcaVpLzJxQE2VPicq02cfRdLgrIpBapvjMrly24IeBmmi2brRJ5Mvp8EjgvKVdXEgqybVA
	ZPp9YvFKcJix2NUK+H4pIkiPLll4AWnTVTwXC2uTfpWuxk9CNqKt+mCTMBr3u2dRrxBpk+k1hgE
	Fym/nvTBicjkAgCC/vvk7XUt8I+q4aG6bSAatCXeiPXkIe2EWBxgwPwl0Rn55HoPnkcmCt91Mw1
	qMKUE7UH+pjyjKcbEgaZM6Ug/xpsyqj8y+X+x55GAKO/p/HGt7INaYpDwgnNT0kdcbQhtVHK+VA
	/1eWiz7cFiYhnc
X-Google-Smtp-Source: AGHT+IHN52iDsRUI3MC45fB2NHZ78a+PI04sVz+MJmf9Pj70BNaVdCA6rPCjq4NJ6xqIYAMwjrcKOA==
X-Received: by 2002:a05:600c:4693:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45868cff3ddmr60788825e9.20.1753365406597;
        Thu, 24 Jul 2025 06:56:46 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:46 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 27/29] kallsyms: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:10 +0300
Message-ID: <20250724135512.518487-28-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - kallsysms_num_syms
 - kallsyms_relative_base
 - kallsysms_offsets
 - kallsysms_names
 - kallsyms_token_table
 - kallsyms_token_index
 - kallsyms_markers
 - kallsyms_seqs_of_names

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/kallsyms.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 1e7635864124..442dc13d00cf 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -31,9 +31,19 @@
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
 #include <linux/btf_ids.h>
+#include <linux/kmemdump.h>
 
 #include "kallsyms_internal.h"
 
+KMEMDUMP_VAR_CORE(kallsyms_num_syms, sizeof(kallsyms_num_syms));
+KMEMDUMP_VAR_CORE(kallsyms_relative_base, sizeof(kallsyms_relative_base));
+KMEMDUMP_VAR_CORE(kallsyms_offsets, sizeof(&kallsyms_offsets));
+KMEMDUMP_VAR_CORE(kallsyms_names, sizeof(&kallsyms_names));
+KMEMDUMP_VAR_CORE(kallsyms_token_table, sizeof(&kallsyms_token_table));
+KMEMDUMP_VAR_CORE(kallsyms_token_index, sizeof(&kallsyms_token_index));
+KMEMDUMP_VAR_CORE(kallsyms_markers, sizeof(&kallsyms_markers));
+KMEMDUMP_VAR_CORE(kallsyms_seqs_of_names, sizeof(&kallsyms_seqs_of_names));
+
 /*
  * Expand a compressed symbol data into the resulting uncompressed string,
  * if uncompressed string is too long (>= maxlen), it will be truncated,
-- 
2.43.0

