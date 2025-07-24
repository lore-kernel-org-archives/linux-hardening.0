Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FF2EACE0
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365411; cv=none; b=ONRH3baBVEdQtJ5hCXrjVkKllaLJpq6aXXUypqDVSwc6vLMHsc2cYkPtdpAF+CvxwSdoXlceYTCPb/+aABQjUSmDm72FrXe+D0WOUMzaqxc4ZD7KKmED2mPu/dW8Uq7Zk02sTYNs1pdFIw4NJpSiJ5ekY233/66PfrwY2zXOK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365411; c=relaxed/simple;
	bh=wEuXEElSEoeDjBLwM+2PEoqxG10Mf5YuozE9z8W97nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2I5aUU4ohHaUaKbtGwCmZ24GzEa+nQzdPXd0CW7WLwb2IKceMye04RhC2UfZwvA1ZcsXW28EoBkUOQ6oJJAci1ZSqdm7TkHBnG745oqtpSKCXm+ZId0zNqsF0KGyxQLPJyA4XPIxTpOCfdagSk2WNb3LYFjxhlQNbKph6cjn0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N0iRzo/H; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0iRzo/H"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-455b00339c8so6847615e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365406; x=1753970206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrjIGy29vhQmG8TWG3X2445EHE3hkTtQk53xAku5ZzY=;
        b=N0iRzo/HSw4GpGt17bXx6b6/O6ZuRBfug9PwLPcIbNX++v94NlSmli3aFPaEPK7H5r
         iaY+TKWGEB5SfGBTAh7kaxb3R4rulLXH1c/u705kGj2fk5OEnziJZSORD+5Su9Df9h77
         SLXNpM5LJtstYeKvG/AH0aSMHepM9tbTUo5eL/B4hyAAksFCeDY9CAq9DFQlQEHRxTmV
         frlisfgdDdcs9lsDMmzS2iHl0vq2a6XGezRMSPMqVjbHSEIx3xFWhpPwCvrtRI10jRXY
         fC4BJZt4VUx3H60OGMoh0qoSCptGcgPQlwoEEPuFQKolRFeRV/gh7d0hfkHSSyOK/4y6
         sl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365406; x=1753970206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrjIGy29vhQmG8TWG3X2445EHE3hkTtQk53xAku5ZzY=;
        b=TkfSsMzbrnBK0J12LIyJJPvyl0ag2yeq8OMxrQ2rSD27v0Fe4P3XFGgTuz+sQtl7nS
         pCrcWxvkRp5TwoTZKj0sJwMS34I7zmcKvmpFI6U/5pNQjdlZTWNag43YijwRSOtGrGvN
         I02Wgu2AUIouNeyHy7px4NhK7+TddynNQYha6ni+szaHkR1TLEt7r1f9/fqnQYqeLnQd
         queFunTK3QTbMBS4aUSOkq3DMMkOPvecD1loQSuKUQ1lfUidF7tw1JWSakc8rF/l3bGU
         SgT8sqp2z6CbWb1KiVUg85kriolT8gI7e71hacaJhuNjiCwcBRv/JwMTnD4+t+l5TZBe
         0LzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdvadYqZP9gkwUyN3XjcYpWmjF/wkrcSfBQIJknV15D+OdXCLSda68g0un11waupbZFJLhY2J7DawDLuFT98Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUznHKrDzllasMLPRg83Fr9AN3aJ8YUVDAfgU5glatM/ERd3Gm
	XTdGYtLzpGmn31f+4eooUDvK8BVB+ksMV9Ly08ZwQWpLVnehwukDBI34puP6AQY0/rA=
X-Gm-Gg: ASbGncsysBSyOqMMQiYPmHYo7H2UclHoeXU7TDMKyCIa6+4lFOqKWtPWXvS4wyZg3eK
	VYvds3etDZy9Acrx0wXphFRzvlM/4yC/dNvcRD6zYTeywFr0vF07b2JnjIXARiJiZdAT9CGmnqu
	Ujr0pV6PEXB0k7l0+ujrc4Cmq+G3KvPo1M5T/BqpnaJuZte3kBMJudsdxujkU1fYzoCznMo6weL
	nmVAP7oz86L7zGrAlZDfxZ4sxWlFvxO6zBUBEHpYH3OhjiEkgH4I4yUqjcUpartGaYOiqQKg92o
	fMIw4uHyX521u4gi4mlHG8eRYDK84BqXy4untWROWs4xfjxUdeUPyTnKGWItodfFFTGdMA9xprG
	P8CPnZUthqf2SQ7yxi0MOOxZhPjerPhHOxbMGQWLuf9rIhkitMYcP6ClT4EBW7PuktN+40IR0VN
	bfVmfAUnD8YdFa
X-Google-Smtp-Source: AGHT+IEVcqWnuyhtVrHKBupbieg0QvSQq5CXC89YW4ucbe/Xkxqrak9r8AlJ1/jdx+SIbeQvU+walA==
X-Received: by 2002:a05:600c:8b70:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-45868d2c4cfmr54619365e9.20.1753365405757;
        Thu, 24 Jul 2025 06:56:45 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:45 -0700 (PDT)
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
Subject: [RFC][PATCH v2 26/29] init/version: Annotate init uts name separately into Kmemdump
Date: Thu, 24 Jul 2025 16:55:09 +0300
Message-ID: <20250724135512.518487-27-eugen.hristev@linaro.org>
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

Some specific firmware is looking for the init uts name region.
In consequence this has to be registered as a dedicated region into
kmemdump.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 init/version.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/init/version.c b/init/version.c
index f5910c027948..364e7768da68 100644
--- a/init/version.c
+++ b/init/version.c
@@ -53,6 +53,8 @@ const char linux_banner[] __weak;
 #include "version-timestamp.c"
 
 KMEMDUMP_VAR_CORE(init_uts_ns, sizeof(init_uts_ns));
+KMEMDUMP_VAR_CORE_NAMED(init_uts_ns_name, init_uts_ns.name,
+			sizeof(init_uts_ns.name));
 KMEMDUMP_VAR_CORE(linux_banner, sizeof(linux_banner));
 
 EXPORT_SYMBOL_GPL(init_uts_ns);
-- 
2.43.0

