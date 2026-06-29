Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C857637D13D
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782703546; cv=none; b=KS/xV+nDnDs6E5vD7nG7NXZCpcQ6x6Xy7Lw7LgyAlxHZK1NGAiCUWnIG+W0/lBwdXEoTvFq+gu4erLPkmOL8LxUQuNO8jeCXwZEDkoFH49XwtpIRtBTd/JePVReYdeJs9wzKBdpYo484D70mMC5ncM2z/JJrvIEknGuHVktEhNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782703546; c=relaxed/simple;
	bh=sI235h7NpFG/djNSPowZLUqWUmqwyCKk8vSphw/WAWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvMQprqlA/1E+Ft/v/wWbE/+CFS9yDCslK7zcH0FCRK/obkr34ZHH3IkBf3P8Nxagn86MneF2c6ypHhSxGsf7Q1KjldgWZm3gOBLZ2n1vfAaSNuoLbYA9v1N8l62AjCJcHMBWaaTpC3QNXE6KdEZx+J3JbWTSwOo6iFKdIcEO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dpa/wsrf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dpa/wsrf"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-847921eed4aso37437b3a.3
        for <linux-hardening@vger.kernel.org>; Sun, 28 Jun 2026 20:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782703543; x=1783308343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TyaonlxlnRA1aHNz8FZIRpD/+0hZdshlSVPR6i+Frcs=;
        b=Dpa/wsrf74G1iCqVst8sqMLODNH8A+VzJywCrClHac8QgbFW+R75VYnxqIee+TVKU2
         dwhSdewmEQbLX9O64v1fPnJktHSogsukQC50NelFozd9xZRJ/7DSRQXH9xfuGZdnbTEL
         AsdNyFqJchck5VsQ2UldwetybZ7kA5lbbxarHjfWDNF51WVUYWk2eldSqcqM3lVKC3IQ
         2E1W0o4dV0KNWZOLp4Ryc4ztaDtsJHodMrtD4eeZy46iDmR6y/kamfCscjOLpTZNlLDJ
         +TY4Y+srnt5FyCGUlsGvJxGKCnRQ3l4R0iMnjvRX9zWoWGCsii09UayJd8KFiWsDm/lf
         NM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782703543; x=1783308343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyaonlxlnRA1aHNz8FZIRpD/+0hZdshlSVPR6i+Frcs=;
        b=VXq+WPYl8HBYVdykz30F+dulc8qNfHyybpU8v/G7qRjNOLCjja62zRmB70jEXpqfKI
         jJ/KyaDA7mrW5kk1Wv3nhjuDpCqD4taxLgshXFn+behaC33ixA1f/E3Ux+ZijPig2Axg
         peTYxhaaGLy4njz09GsnPbHNG9sxL5iO8zFUgLa8Q/cizs6vqN5fWeTi1c/ehzAm4g5T
         nppnvnQtf/OGPz10D1F5k59TT9QJq+zCQZA3bdlvET44eoQzKQeSTRxBC2dss39aaGsg
         GbTE7JzzB5YL0pBGV01U9MYVsY+4hgFdHvnKZBZzBvX9G2I2kmIIjKQh822iwxt1dTrB
         JImA==
X-Forwarded-Encrypted: i=1; AFNElJ+69pcjxkUOvm4dza4sNYSGtian/pkoNzRdf3/i7u+giHwZ+Jg9MR3HljlioWiqcQydXB+Zi8rV+VMdpw/7hok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxi39dhBReHc0/KnF76eA4WUZBK2mLZUCWfHx+L+WUXowa3a+X
	Jl6gLlASTfALTPDAEUQ4AHxFUHxrE1qyoRYNTxULaULU8dJcjVpLXt0x
X-Gm-Gg: AfdE7cmV4cqBNZ76gSWu8k551lWmeh2LBVwNJ5/fECpdyu1+reO2TI0y8kcSVAheRVN
	rJzcLMgWAinVzYNRkcjc9JUWET8878vKwajcGxJcWqMCf3bk11aECgrmdQX/sAC7dJ4mh6KYLuF
	bHiHq5hR6JNunC0L23nazphQjKH0xLv9ZLlCMeJ/+016qQrMM2RR7WalpHNxfKQ75Xb2FOwb1vf
	Q1ecAAOHRlyDuiDvJnXfmJtl9Ws5p9sC32VUcBB/DIuoMiapaaIa8qn61aN1mPmzBcuYipz6fdH
	a2/uBCy7E0w3wKy2NYavdYPfyzIj+MQvD3QpgplqrtLWq/8OXW0RTllBmj3EdSAHs1B69aMrOOz
	dH3RVBvpHpHR3Pt21BlW+rIRZwvwghFbolI8z4jh4iTEcFxViXeay4KwEYPMIKc+76jRWTurS73
	Dwog0KeU9ETSTXyTAItEsuGlb44T0/yK5mD7jk1xYNj5gbUs6JmX13Ju8455UjEwh3BfvoXIrsP
	P38lOJZuq7HAfLmzzQi
X-Received: by 2002:a05:6a00:4c19:b0:845:cd69:bd34 with SMTP id d2e1a72fcca58-845cd69bf6fmr9304863b3a.28.1782703543034;
        Sun, 28 Jun 2026 20:25:43 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-846c7f659ddsm1921771b3a.32.2026.06.28.20.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 20:25:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG SOC CLOCK DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv3 0/3] clk: samsung: use kzalloc_flex
Date: Sun, 28 Jun 2026 20:25:37 -0700
Message-ID: <20260629032540.2331559-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch three structs to flexible array members to combine allocations.

v3: move rd_num
v2: fix compilation and reword descriptions

Rosen Penev (3):
  clk: samsung: use kzalloc_flex
  clk: samsung: cpu: use kzalloc_flex
  clk: samsung: pll: use kzalloc_flex

 drivers/clk/samsung/clk-cpu.c | 34 +++++++++------------
 drivers/clk/samsung/clk-pll.c | 56 ++++++++++++++++-------------------
 drivers/clk/samsung/clk.c     | 11 +++----
 drivers/clk/samsung/clk.h     |  4 +--
 4 files changed, 48 insertions(+), 57 deletions(-)

--
2.54.0

