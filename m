Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D62750F6
	for <linux-hardening@vger.kernel.org>; Tue, 23 Sep 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621156; cv=none; b=HObbabf6Y/EQ8d+259LeSKlx1PcwxAxIOTi0OEhAWmckiFBg4Z5Ex+1NYTkmIZ5hQiYaa1kv4v4nwatiBMQz6aFNfnQgvoJ4h2a/rVVtmpZYytE0UFb6JWjf9Ljx9gNi2wxx6YX5Ou63C52x2uYTxPpQqU9M9vtfrWQ1hc57noQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621156; c=relaxed/simple;
	bh=0BnOPQDELNokGZZYmpRQ1cd8xaZrosaBnpt3/XVY0Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OPGaoKnxluL9Ms/eRgpsyWEwAUX64wdTOdD7n9eLd21cZfEoImcl2GSUarEQNBJaq+RwnAvF7ZcZZrDQcmcac5lv9UvpmarJSUMDlh/LogFaD1WsS1PqlouJLoZFfu42CyaRsspDnNtHc1iqapj1RGn+/VgQb5uKOVUX625Y95U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNIQYjoF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNIQYjoF"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46cbdf513d7so22346135e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 23 Sep 2025 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758621153; x=1759225953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LY0Z8Ik+ok4lx1moFpVF9A6wNG/8oeWUYiVAkRks1lI=;
        b=gNIQYjoFKSf8E9eM/ivy9Vxl0llSXIQfUtr+3IVKU/htxQZyJILrCaJoCF5jiXNoOW
         29SCLo6R5NK6YxhZYsj0iTKPIUXMlpYLMPojFqRSfHbpoGA6h2apoQ/hZ33c8L2WWTRr
         5ctAnSIW7KthhtCUe9DsHHGPITcGd+Gvm+CfSjL3+1yh+wWA7wF9wB0uyOXUNS4j26Jj
         QXfBE6DflSFY2mWlOLEEmmBs6HERGdZaX+tMKB28Pk4LyDcNAfTdTjfVD0inojmuz7KA
         HN2Oq4oPbqnP14Y5l/RHRo9asGKF1OYN0j34JlEmlMSGawyZ5wqNqcbyp0llHyPmQ8n4
         BdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621153; x=1759225953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LY0Z8Ik+ok4lx1moFpVF9A6wNG/8oeWUYiVAkRks1lI=;
        b=aH0jDLgbGgxvuxONoIpo2P+AQxG310xlAcjDLkMwcuqvH6Qs4ikXQWK9OWMaCg6RKS
         2EeEsX06ZxYYnuVSHfCQZ4vo+Sce2VA75BAGJn4uw+X99exkL7jQKSV2WvXmmhSysu1c
         6k4bfclEsw+KtyPqEqTsDbordC6dAaf31GUOq2aevq9O8lbH4Su2JEiahzJHp8f8rANG
         4NUmdfgBDCkvV65teuxpkjEKtyzbIoaQiW3a5bnOykvz+6kChdqiTDW5S6JYOZ79Spsz
         sfwjg+AJ37xgWgpBrLeGMfDtukp4PqVxrSrRK2k6Az7C7CQT80/6WMLuHMl+bYkcy1bT
         u5fQ==
X-Gm-Message-State: AOJu0YwYM0mpUXCD+ZQJ8BceHOX+9pit6z28YdzidtY8DSSmZotE2WDB
	VDPtRCaiMjjN/rFYqsWdyAYpSlIRhaA3NzOeZSeWiHBwg0Qkfgac5CNm
X-Gm-Gg: ASbGnct8r9MJK7PkAW0xPWg/y0NkJgwqOokyvfTBL2d0b6Sy7YNtT4jEwH1Wz5Wbz9G
	p1dH0q9ondWZ20Xo0SiSPOwJcM2lDxFzqnBdJQfLVFYkaUIuhUBVL84LrIk4YnLmr69gtoqK6tY
	dy1Y9x+z+Kwma8D629i6h8m2ATxh72bRObgQWECeGxRdT6gEQzc56VyvzzqgLHXATorp5/UFYMI
	uMo+Krdn+VKLr+FxtoR0hSeYAmiR/Uc+gIFk0aUi3Q3qa3nEWP89yHZ94oUoFlFtHjLHdlhAXBb
	VbSl4j7KuW3+Ki1Z3Cs9tBd+p0+nbpj+c2KP+1ryN3sAJVVgZgLQumTzWoQPScBhfisCJe4Cbwt
	jndjx9RvxQ5aYlYTQlsyDMNbf7iGG69tF2cSImdtX5m1ufqoazJJB7vbpXQ==
X-Google-Smtp-Source: AGHT+IFsjWmH1yjZS2/W9w+zjAbYKelnR5zFxdIn1q1xM5jD5x8f4Cm37BnIW0kg5YVrR17ICbU27Q==
X-Received: by 2002:a05:600c:1907:b0:46e:1fb7:a1b3 with SMTP id 5b1f17b1804b1-46e1fb7ab54mr16883045e9.23.1758621153090;
        Tue, 23 Sep 2025 02:52:33 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:a5d1:59f5:ca88:d11c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46d3ab09b27sm86882985e9.21.2025.09.23.02.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:52:32 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] lib/string_choices: Add str_assert_deassert() helper
Date: Tue, 23 Sep 2025 10:52:29 +0100
Message-ID: <20250923095229.2149740-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add str_assert_deassert() helper to return "assert" or "deassert"
string literal depending on the boolean argument. Also add the
inversed variant str_deassert_assert().

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,
Note checkpatch complians about adding a new line before the macro
definition. But this is the existing style in this file. So keeping
it as is.
Cheers, Prabhakar
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index a27c87c954ae..ee84087d4b26 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -17,6 +17,12 @@
 
 #include <linux/types.h>
 
+static inline const char *str_assert_deassert(bool v)
+{
+	return v ? "assert" : "deassert";
+}
+#define str_deassert_assert(v)		str_assert_deassert(!(v))
+
 static inline const char *str_enable_disable(bool v)
 {
 	return v ? "enable" : "disable";
-- 
2.51.0

