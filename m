Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA012E4259
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365406; cv=none; b=TOFvqKj9i8IP2+f5MCWEwttzz2QNXojIFXEjZglj/Cr68m06hJJo+4CMvTAvGaOmKhsS7rL1YAaDKhf5eX+6orrHWeW3b6ON0i9gKo+S3YPHhd9+Hh9tFmxDC/yDgIzz1m40FB5fD9DVa+o3dq3C5hkC1fk4e2twm+O/FghJKes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365406; c=relaxed/simple;
	bh=wYMeidmYjvDlycPH4G07GZhntMp09MWX5qBkhRN0CfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HROaEWvT+pnd5hwvIZO3jkcEIsE9fcKnCnTX1QVi+/aDwBgyc7TGeiGRUeb7o6Vez5kfPSnk5Czrq6mOCdfPJhNHj80mU4BAXDtOX4V3sSn+W4BTPNIn5GdbdW+wX2xTQCAPAV+xIoMwOFEGl+NERYxal4Xg0BfglITOxO7OtyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TJGzWX/6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJGzWX/6"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso10995795e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365401; x=1753970201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieqGzTCdj4VITWiplNNA/VccLe5fuArNXR2nSJt3s9g=;
        b=TJGzWX/6v2x3LKFOGORhb25GV3SG3O5lJhLzN12s/kz3xZzSeCM2F/DPwP25r/rfjt
         tHSsxbljdsMdjhPrIByOBKv+U7WX0wlixs7UQeh/CpNrBitqyYW2s4gR8dLIRyOm9RTb
         X5gLNzW6X1Te9HXIZwJfvz9l61YLYNyHPE5jJHkr6haAkWG8sJitt9NfyZ7VW2oAURPh
         3aZKnmcEKHumzKpIpyRxJjLWney0vVSv2+GaknSiXmiCIuku4s+m1scu25JSQPYnO7qg
         AcwqG7YrjHPSLpIuX1y6I+spSSKnMA87XLj0W6wfJfgAlwNIYFEfR3n11iV/luMdlKDq
         7xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365401; x=1753970201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieqGzTCdj4VITWiplNNA/VccLe5fuArNXR2nSJt3s9g=;
        b=q75Fct65qHbfsNL5AKDUVgPBWxf5snKalVNmj1qp7XOkiYBBQr7iwsSwSv+52ArdfL
         k7defmc5pS5YNC/p3f43XpJWhMzJnfciAyHGSIK7InQfZdGhf5XxhL/s7fbmGn17ZmcF
         auz7Xqft3XvZthuk7Xw6XO82w0yRVF0WcELxhDwVjcfFhHlauBSMB2jbP9/biDQKJc8o
         IqnRodLY7ofETKSbKJD+Z3NXfQmO5MQxlAw62qlszKMC8/TKLOCT79yJIe+kyplWkH2U
         rQcttgLmH3/i3sk+7BoknDXgiLG4Ky/W6mSl/xrvpQGZqR+36uqB0gOKPkyE1l9W0Kd6
         rdhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5GSX1YNkR+UGu03kR5Ax1BygknI3wwr7gXzfVBIGi0Bh3FH19iQ6md6jge2HyaP+IKBVYoJF9406aC8xT+zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwORXvZQ7KT/tVvokRavCwqGPulEqoK1b1mNDfXS9aLkYidgU4L
	rkpRlllKN6mHZ0MZveFbDxNhO+DUSs5Rr+gB8OcpPYErVGEMT1ctqPMFw06+21RstV4=
X-Gm-Gg: ASbGncsrArHPErejws1TNP3GH4dGp5vgSze4ipJvVAl0xREoNK0py0SbNt94cUpknoZ
	hGStrq8iG1vWJ8Ag4s4ZknjVjxjtk56eqWy7ltuAGgE0bfFlvXautxSUfCVQlI5rFQuw+uV1o8P
	RBJgmqT7y03zbl9W8BCMAFO4oQxsX3xqwc26cqQe3EEMYh71mjNMGBLhJCaJQbE0eKd3E64tigh
	/ULhVTYGgRVS3H2znWHsyzsJlifv92p0UeYalvuwwvYq2r6F4LehoOBpOk6dQYsbgZoxnabQrz2
	ZHEMNvJ0OTy91MvWEAwMTnka0Y+JRq/sj/X5XDEtFfiUB5QjMg8YgXl8hPquLetWbLF2SAiuWL2
	NT+UmLVdoxdKP+oYBkrfgYbL1AqnUfzE1p/RdlPg6Erzl+PMeNHbeb+OGaEsWI9IRRGzvu+oRMs
	x4v6TCMpeBMBlj
X-Google-Smtp-Source: AGHT+IGXEHFsoY1KVpxzOAw5TwDBINg782dVci0CvVy56NLBcwsZCPP5/3Z/QT3qLnRYduHfxvJiyA==
X-Received: by 2002:a05:600c:c167:b0:456:1c44:441f with SMTP id 5b1f17b1804b1-45868d7266fmr61139855e9.31.1753365401169;
        Thu, 24 Jul 2025 06:56:41 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:40 -0700 (PDT)
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
Subject: [RFC][PATCH v2 21/29] kernel/configs: Register dynamic information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:04 +0300
Message-ID: <20250724135512.518487-22-eugen.hristev@linaro.org>
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

Register kernel_config_data information into kmemdump.
Debugging tools look for the start and end markers, so we need to capture
those as well into the region.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/configs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/configs.c b/kernel/configs.c
index a28c79c5f713..ec94b695f234 100644
--- a/kernel/configs.c
+++ b/kernel/configs.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
+#include <linux/kmemdump.h>
 
 /*
  * "IKCFG_ST" and "IKCFG_ED" are used to extract the config data from
@@ -64,6 +65,11 @@ static int __init ikconfig_init(void)
 
 	proc_set_size(entry, &kernel_config_data_end - &kernel_config_data);
 
+	/* Register 8 bytes before and after, to catch the marker too */
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_CONFIG,
+			     (void *)&kernel_config_data - 8,
+			     &kernel_config_data_end - &kernel_config_data + 16);
+
 	return 0;
 }
 
-- 
2.43.0

