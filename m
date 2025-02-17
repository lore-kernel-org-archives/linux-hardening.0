Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B07218EA8
	for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787481; cv=none; b=D0tSli0vwmgN9QP7Brv6DWnZT4WG/ILT8QFvM/KMfqXPpXfCqlbKJbiG9Smw9E8tMjNPC9dEzjVV3Q6E2b5IKuH2jitrxNyCb13pPUlDSaYrHgyf8DImhBhARZGumvLe+sMDV6MDjELq/3vop3UN4FcUgvDN9BKZxGqVicwzk7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787481; c=relaxed/simple;
	bh=6JLAQiXiBCTaZy1rpRUfOhG9JvPaEfv2VkDTKVoBVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5hK1NJva8+fE/nh0qL8hkgE9ANz0akllf+EoavBBloD9SgRQkSElmM/boDaZPreX9g6cRvRzRzUgVZAkqrVFcjJV1anyyoDO+ApLe9gULdFiPhyZqIV8RTtwkJF+z9qxDI+6bbzPd8zAFyV7kLi8LTa3QOKLZYWM1pmcIF8/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sCKS6Tup; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCKS6Tup"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb8e405640so160943866b.0
        for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 02:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787478; x=1740392278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Td102jvjcyxJvAztEsXWW/VUH0CMT8UhqkeVVK6uLU=;
        b=sCKS6Tuprl/dYZRp9WH3Ijo33jFNfIf/A37scAt5+zGyFA1t+uzX6VWzy2Up4AaaEP
         rIvRcQHGHZUbwSR5zhg8CbBGfkP8xJVOgV+XG1iaPVUnt7bdlbMIbxu+7E6hkJL95owb
         4jakP3fTtCzUU08ui5gj3dUUZZlN8wqCS5xLsI68ZmyXObdD7fTiC/hzaqC5Pv835ARc
         x8umw/067y4wYYJOzbupwclrgqd2DynTVu1X/79YPj9TaEfcK1DI+qPy5it45oOXHoZD
         mQtENqCGQBZA4XZq0gV7F4UhlOqLU8UzNB+97CT4YxhBJyvf6M6TYMK+6+1uqR+Cauag
         9xjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787478; x=1740392278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Td102jvjcyxJvAztEsXWW/VUH0CMT8UhqkeVVK6uLU=;
        b=A2BYNYN8OUI3Bfe7bhUKhmtzsEDmWLv/gAN1b+9dUOECwHYmbW8H40o0CkVRcBPF1E
         fhP1KPNTacqVV3n8ILUlCAqvzwiWDPU1jPhgw+KW0SABsuP0Z7UAmYoKTb89+48WvysX
         V22+YVFPdYtt6T7jw+ABSyPyZc2wU3vjDiZoCIovPmHegCRTLx+RS+GbCcDFUijWRi3v
         GuzaOiqEFJOEdE51D73yVCeRSo9HrwNu9O/EAMcI9RxfQI4gDV3XxRjnlAk5wUjBGAn9
         fhstLW6Rcxi7xK7DNzzxUtPBzTlWHI96n8s9+xusRjUXiEf9tfXh0ixgv1S+Jchh6VDt
         ajdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuLs7VGEGzDBSKI/vb7nMR+bovK+hnrtkJVbmPPL4q/T1mEdIWxWrBY7HD8GicQUFFmzDD78YMdIDo1lhir90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTf1oba/P3YE4XefQ/MmHnihnep9wIgNqOTJs5irpm/p5567G3
	u6btIHv7UJY11AUro02aQiVRjVX6MaUnVMkmy9Ll50/7A3EWbNVH25VISvGOxY4=
X-Gm-Gg: ASbGncvRxQaC8BjFwLis9e/CHD9hhG4Qse1YOKo0cebPG+zuYJRC1VR3c5s++piZzWF
	2Wdmf4GRzkF8imuQaq+FpRfJC5IHRQIvx/U1ejF8JeyXzxZowXZ/DKFcb90sPXaeO0okZRpjrOT
	LNJmcCksA5Q/F6n5fbHCONmgf/inFYTmsrFWsEWiCnquUiyKxzq5aaDq4A459tspesl/CBxm6El
	bdj2wZ+HFTr04xYOEVt9ViiZ+Q9dUBTZaTAaZrP3IJ5Cjr0LcsaAyA1eThO6kKLssgugP6OLuKi
	/jYwbjp3YbXOJtgKR1/goZjP
X-Google-Smtp-Source: AGHT+IHY65P+Xz4TNjemyphPqqQ9+ru/mohlrB5vFIKJf/R1MNkDOblIAzwWX9YVxAvz0IWpeGk+4w==
X-Received: by 2002:a17:907:7752:b0:aa6:79fa:b47d with SMTP id a640c23a62f3a-abb7091cedcmr752835166b.1.1739787478322;
        Mon, 17 Feb 2025 02:17:58 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm308583266b.174.2025.02.17.02.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:17:57 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	quic_mojha@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH 08/10] pstore: register kmsg into directly mapped zones if available
Date: Mon, 17 Feb 2025 12:17:04 +0200
Message-ID: <20250217101706.2104498-9-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217101706.2104498-1-eugen.hristev@linaro.org>
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If dmapped zones are available, register the log buffer into one zone.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 fs/pstore/platform.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 32448d9dd316..9a5c1d6d5031 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -452,11 +452,22 @@ static void pstore_register_kmsg(void)
 	kmsg_dump_register(&pstore_dumper);
 }
 
+static int pstore_register_kmsg_dmapped(void)
+{
+	return pstore_register_core_area("dmesg", log_buf_addr_get(),
+					 log_buf_len_get());
+}
+
 static void pstore_unregister_kmsg(void)
 {
 	kmsg_dump_unregister(&pstore_dumper);
 }
 
+static int pstore_unregister_kmsg_dmapped(void)
+{
+	return pstore_unregister_core_area("dmesg", log_buf_addr_get(),
+					   log_buf_len_get());
+}
 #ifdef CONFIG_PSTORE_CONSOLE
 static void pstore_console_write(struct console *con, const char *s, unsigned c)
 {
@@ -582,6 +593,9 @@ int pstore_register(struct pstore_info *psi)
 		pstore_dumper.max_reason = psinfo->max_reason;
 		pstore_register_kmsg();
 	}
+	if (psi->flags & PSTORE_FLAGS_DMAPPED)
+		if (pstore_register_kmsg_dmapped())
+			pr_warn("Registering kmsg as dmapped failed.\n");
 	if (psi->flags & PSTORE_FLAGS_CONSOLE)
 		pstore_register_console();
 	if (psi->flags & PSTORE_FLAGS_FTRACE)
@@ -628,6 +642,8 @@ void pstore_unregister(struct pstore_info *psi)
 		pstore_unregister_console();
 	if (psi->flags & PSTORE_FLAGS_DMESG)
 		pstore_unregister_kmsg();
+	if (psi->flags & PSTORE_FLAGS_DMAPPED)
+		pstore_unregister_kmsg_dmapped();
 
 	/* Stop timer and make sure all work has finished. */
 	del_timer_sync(&pstore_timer);
-- 
2.43.0

