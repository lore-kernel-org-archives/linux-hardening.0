Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFCE279DAF
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jun 2026 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781201335; cv=none; b=gzWj3t6jQwaS5ZVsMagFsDRcTw4lbdFWOEA3FC+EQLYZznpvcyqg1lu9iRa0CHqZgeecY5owhbcyeU6vkCufXQgPQXLGR65DDrIeNuWCoHN2ZC9bwJSum+a0M/eFnFxpZLb0I9T0ZGHrnz5OBK/15TSDAsB0fLla3hx7UBvkohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781201335; c=relaxed/simple;
	bh=pajLU4q8bCN5YoHUmk+hCyhoUL3rH3RIe6W8LPCHUfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrIAcHF7SGWyAd/YEvj/eHVQ7OEYTno4C3t/jlAkWnq1MnOvlgt4vJfXXKUzOdPcUl6yWHeWP93xJx3vCQCe+xw/qRsKSvNBYhLsF7UgK9JmXeZc/v96jKq9epm2y43DunsnnqrOC/nbz10ylxisjvPVZ/Bi1GEChRVOEAM4QaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8OvVRTP; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8OvVRTP"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36b900f350fso245338a91.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 Jun 2026 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781201334; x=1781806134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pajLU4q8bCN5YoHUmk+hCyhoUL3rH3RIe6W8LPCHUfg=;
        b=r8OvVRTPNbr4tVV/rZcu/rt5KYCj0JmIse2oRfn5eu4sLqmqMEYd99p02KyDDVJ5ny
         32NSZWylDOfXBajJS5v9pzmYaso3CjT1BsQZOIH+Ptd0Y4brDfaP7YJudgmHCmJStkaZ
         FfVcPv5s+6SBBUVzlSbf2gogavph3FYc5lanD/zuqwXFIj5zhWC02TYLp0DeynDqDdc0
         Swf7rPdlwjqjMuHManUtGymaamIvg3IOh3cS3nl+0da1OKG/9KLHA3M/McFWq/qgmtgh
         LF5pg8lVmRobGAJOyrL5nHG3FjsYpH1Z0ihlsDh+EFR6dl8a/usteWYhzx6ixPmcJLBE
         hm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781201334; x=1781806134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pajLU4q8bCN5YoHUmk+hCyhoUL3rH3RIe6W8LPCHUfg=;
        b=pNuLC+hpBWVXS072Mj+BFXd3GGTkDHB4FYgdWEXfpbpCMmf8nlWCptG1nUlV96lT8f
         I/6uUjEzfTiXJHaIEX8KrwWK4kubiFqcZEtHvYWv6sDQwUMbh72DmA/iUksAGFDRseuk
         L6Ir05TwIPLwteoNoknkp/+rQSKJngnJMAqRuczPfA4pish1E4XiyRSh2QQHSARkavjx
         Sh1ZjBSKXzVx85zre8f5MC38aEjksDAvlcuMSCIOwifCFkWJ/mu91h5RJAiEiZ9Rw3Oj
         wNY3DRfQVaxTktn9GECf77CtQSJyhjjrAQQoJIr/0uBCniapGPZ/KP+eHAwQ0De7JyA+
         1ZfA==
X-Forwarded-Encrypted: i=1; AFNElJ8/WH2NoAeUYqNL31VFP6zR8kJJiZAuzXszPOWtJqImbH39qeqmXMU74ogOq0hFq4vbbMu2SChdS5ZUjmCsJpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoZRZ+JYGo12lCIg5lj/h6O1bGX5vtMemM9lIeUt77DzrjORgF
	I2cgFUwhBC67UDeslI8Ic1D/kpXu7LfjtvzpETQgbhAVG4q3xX/egVLr
X-Gm-Gg: Acq92OHqbtSLGUjYe3zFEn0/eWqW8I5owg69fprUB4TwhjSoyTXySR9CBUO86X5bY2a
	zR6S0fOqH5/ipSO21xy12avXekvZxjEv7v2xZQBGCtHVArmELdb1jltvJuIkl3tz2148o9yv0kZ
	JZ+cjxgfRhyTxxT4cfUU07QaMDboDhCGK2XNDlE7KRyqDWbEKmFNlGOdBfPvUlI2g4B4BeaXy5e
	ovtoVD8/lFjq1E9qTREE6ba/wCFU77VMqbsnkCr2xMGW5gMozDbxLQnUG7paobzPG9U99vphENT
	E67WcHBmn0+B0j2touAr3xyEh2CPdDoQJZ/UOJTepH7QcDq/vmrMdRzOEX/5dqJvSeWEUrmKJ9N
	4+10J+dr8kgF82U5brhp98RJOGgfvG6DcXGcFBbejQ26jI7Ko+F+5DPLbGw16GDi+E7yQQIBZQu
	NVVWNC/R/tgpAeFvvl2NI8T3yvlFhVhG4nJedNuFuWstFhQ3MbiGPLTr8P
X-Received: by 2002:a17:90b:2dc8:b0:366:10f1:3d86 with SMTP id 98e67ed59e1d1-377aa799f69mr5239736a91.22.1781201334232;
        Thu, 11 Jun 2026 11:08:54 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.202.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37752d59ff8sm3256230a91.8.2026.06.11.11.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:08:53 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Thu, 11 Jun 2026 18:08:45 +0000
Message-ID: <20260611180845.6556-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
References: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Thanks Andrew. The __guarded_by annotation and context analysis integration look good, I wasn't aware of that infrastructure.
Thanks for applying the fix-up on top.

Thanks,
Karthikeyan
