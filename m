Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC292E06DC
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365389; cv=none; b=mqX7tIp5s5d/zyyI0kB1sGoURvcWDeEkYKTSGulhkkBwxrRwY3mDmN8m9ZEruj8cpvcPy3KbJdP5kmjnmJM7KzAhJ/ycxPafJYkmB8oLuizDiTDgsv//uzd7viyY3GhKpcKWKfep0cBUyHeO/Gn1fEj60Ed76dbDNB0syCvU5rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365389; c=relaxed/simple;
	bh=I45+7S3jIU0dNMjyY0XWrWua5DCAvAPB8OAPs7f8VDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZarstr3a1Nu5W19HIHSZN7FXNAb9r2sOpAgf1w1RswTHUqbRCCVP99f17TGlx5DRtxR8Kba+MyUu/1pQHYCLkwL2YZXVzMh/QLgKWnYS/qJWkT/Oa9nyY7fizkXeexj1JnaxhWYb3MeXuQF21clK0zG2tjgyFKj7co4jRQNhys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NnjTYfIk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NnjTYfIk"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-455b002833bso4613075e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365385; x=1753970185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6vaDGqz93WFfpGOQ4UOrak1EBQhkmEoatVxlVsxTPs=;
        b=NnjTYfIkoofWBpyRAUQVrPINFMHx6ciLZrAV3551c/s6Bj1eu732dX5Sw4jJritVva
         fnALdGP4ixmhlSo2YP+i2J5UVqKiq4Z/HvlNvym7QH1ERjo6JRMClZDHb2+uCVkKv6qA
         SSgQ/q3VMTU/BUyiKphTinzhE987stIVuRh59Nv/roytHJcP8ZDeI5/sX1+TRYO94HbO
         zkCevDJTtJIdsndC2GstqBIpVfeDvKB35SSg28H7MZ0nxa7MNiJzIka4YGQvxums+hZA
         uLxS0NOrEzL1WroNaPvAzx7yd1q0ilyUzo8DK6if+U60oMf010Icukd9OPspDyfp1CPG
         Zp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365385; x=1753970185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6vaDGqz93WFfpGOQ4UOrak1EBQhkmEoatVxlVsxTPs=;
        b=ae5XVgPI4HaJ/9P6rVL8Hmn6RLVnhoY0sk3jEHYw3U23VZH2YX6zL9PrtLw6fyrV8i
         XeVpqoZaZ1M/L/X1kMY6BbydCbhrDgfSq00TaVkLyWltUkJrencHnYW7zpdTggKFm08K
         lHJ/QIwKjNEphBnJHIriL5ZP0Fc+6wPrDfiWgEGEf5NmYEftAskcT0tSGsnToe1HpAXz
         16WqVwcGtKcIXFuWnoZgoJPsT0PKVHJ+gFxbyjEWJbRVa7OidAJFVtYKmy9TxpSd+NTW
         v7xDpkA16Jk504MB+WL8c64U0654OJXgfSl6nS6krop3Ad2LtMLa4genqGX8LgqDWAi3
         +T+g==
X-Forwarded-Encrypted: i=1; AJvYcCVsvKqo8k2/EEdM/ozuKljYWqK9Ec56+2+bK8J58H0/csQTMn0isSA8Tx5rLsl/zwSnAVcYdGRmg7xVZxjMYhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3xuVzfECNQoheMDJtP+v6P6GLK3MqQ+FblWqCaOxZNptQoUVo
	CuiWGlUFt3HvR6NsdWUNoIMhEFkT/Y2yfP1kr6DrrrbJc9MxyXRMDwzg3Sb+0pCVuBU=
X-Gm-Gg: ASbGncsuwamoHBGnFU02/wRZ9qkr+9Pkxx6Om2ZjAw8ZWaf2DNSjKWe6kjtq3Mwl33s
	+5PX+w7YN1Nnm6xGJMEzM/oXZVV/FHHsJYqZKXnU3Z/WunGgcmwUEEsaJSNO1oyOPGMLFEBqvKE
	1NFU0ccRl/E7LAqCc5pAUatmoIqJiTGypyrk0ZNwS7HPFaa8amsR9PA3YkoZXojS0b1Asopr2XI
	261DMMqqsn0hdX7jjgdJhVfEk6cDaW8UvLtZHNxV9W6P4gW7p8z3nJORuSq2a8RwIwucQFcGe+p
	MTKXcpCia7Gbq3Qv6/eyiWV8rrlqpzoh4kckPtddqUsQ3V4qbU7UBaCLPgmHW2IBIvE4zCxHXKp
	XnGsEzEeeLsLzRDGvpW1U2AqBMCWpNfwbes/zB0Yw5C+yzGddtHbFz7PnCEy1YGrMs76X80jlBO
	omv/DZ+2MIbPYP
X-Google-Smtp-Source: AGHT+IHYnD8d7A8aBh+5tnrqY0LYzarTFZbBZJYJd44Ilh6yiLc/UVbK9j+FmYRR9VqOWZQpLWbc7Q==
X-Received: by 2002:a05:600c:500d:b0:441:a715:664a with SMTP id 5b1f17b1804b1-45868d3289cmr52540145e9.20.1753365385393;
        Thu, 24 Jul 2025 06:56:25 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:25 -0700 (PDT)
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
Subject: [RFC][PATCH v2 04/29] Documentation: kmemdump: add section for coreimage ELF
Date: Thu, 24 Jul 2025 16:54:47 +0300
Message-ID: <20250724135512.518487-5-eugen.hristev@linaro.org>
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

Add section describing the utility of coreimage ELF generation for
kmemdump.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 Documentation/debug/kmemdump.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/debug/kmemdump.rst b/Documentation/debug/kmemdump.rst
index 3301abcaed7e..9c2c23911242 100644
--- a/Documentation/debug/kmemdump.rst
+++ b/Documentation/debug/kmemdump.rst
@@ -17,6 +17,12 @@ kmemdump allows a backend to be connected, this backend interfaces a
 specific hardware that can debug or dump the memory registered into
 kmemdump.
 
+kmemdump can also prepare specific regions of the kernel that can be
+put together to form a minimal core image file. To achieve this, the first
+region is an ELF header with program headers for each region, and specific
+ELF NOTE section with vmcoreinfo. To enable this feature, use
+`CONFIG_KMEMDUMP_COREIMAGE`.
+
 kmemdump Internals
 =============
 
-- 
2.43.0

