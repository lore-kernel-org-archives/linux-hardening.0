Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17B120A5DE;
	Tue, 18 Mar 2025 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298945; cv=none; b=o3nlhGsQbofYtq3GnREgBSWT/LpYQDdKY2T606BprSWwUnO0ykZmQMN5Hgi7qq/rOBBXuWS5SYSgzEopxRcaSArFli+w+67CEBv1IGGVxDMlKxrAUzAPaizod7MWUPmwlHANheZleKc79IezZoMhVIriQarsrL9XjR+nfxj46Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298945; c=relaxed/simple;
	bh=JQ5utqpG6y1Ex545GbLiV+P0yO2TxTZwfB14ybeEbcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAJ414hPqgigEa6ccsi7LjI4sgX6B0//dLvecROLc9ArSl+L+LfgyJQf4lvIhQdolNsFvaWNDo3BJJ0autIYDHW6b7jlNb6Q+Qt1QfXWDi2RUzPYgou16r9I4+dLw8PXzgrbE5ETIuT9QvThmPQcMi42XCFqviOefAFYod2sXp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IePG8UoL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IePG8UoL"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fecba90cc3so7179934a91.2;
        Tue, 18 Mar 2025 04:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742298940; x=1742903740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cKyihIKo/pH3bvfSdmsukEMIsZJtwyOFl7m6Edus9Dg=;
        b=IePG8UoLfkpoKZSkB8rrOWOzwomipjKLklPudNdfJWXTRoPXrmHZbG0ASDx2COVNcW
         A/5lfZ2acwHMIeLBPRYBFzdABMiErIgjuyR2LPb96ltvZajdkiR5iF0Q5hxXYa6Jrdxd
         CTIFlcLkcVJThOX7cyXJy7e8EWhyRhSr8alncf9P/dWKtKRjKiRAx7X8JHvNQ7fF56uF
         tRUiSdea07c/teWepI6FxRpJlle1FKtxgpejKFR8W0NLgQo1HPwLpAN1XuBIpz6k3los
         fDQKbJ9f28O4wETdUQvO2YOE5HRMy2k1fmY0eA3n3G5Sk+f9uA8Z2szk+mweZu7dtQlP
         UgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742298940; x=1742903740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKyihIKo/pH3bvfSdmsukEMIsZJtwyOFl7m6Edus9Dg=;
        b=aV6AdxMOTRlist5WvQC+uPaLaoHrtMlxl/YFOBwd0XB3rD9kMrFrCixbQqLDQ+Dacw
         OZK+Re0Am0A/wXKuuC/4rnA6nd9aGeSElKtCb374HDzDYxTutz9BWF52K+XOTHHh2SSZ
         fYG+q0FpwaqurztMIDN9S3joMNvC1ahT4UH7HkZCn/QDf7OfK4gJPNxftJKslaQT1Bcz
         MT5EMpAhCrV/hgeYPDKsqOjQdrcT+BSkBq7A/SbMlGrtrPSQRDqeZ1UMY2D2Z2OgFE5p
         iqBKp0dAsx93WXNLDWrsI2RiFsUDmYzrOYY8ZDxRRUJhVT3w1+Ri1kMaiyyOMfYOi+9g
         WMUA==
X-Forwarded-Encrypted: i=1; AJvYcCU+EQzC7yFrY5CbymwcjQonbYYZNBas9YZKgBff9AaXmg7mWPKiWRRYNMlSjDg4WC3X+DX+lqo2Da4=@vger.kernel.org, AJvYcCWOGef1kp0ilGu+wH81ucBtURwUGuj8+g71ds1k56HLfKtyma5Tx2A36Ks5HIL3xXX5j6efSow7AKlvSoIm+UBk@vger.kernel.org
X-Gm-Message-State: AOJu0YxR27aUNtpVT8tDDG3eYbQaraukTC8iTU3OBmoQxVYejO9s54PN
	koH1SLzeWkzzDwy5kDl9uAKADacmLKilBRINboIq1dw/DMgoaaYDT8W1xPA=
X-Gm-Gg: ASbGncu3brPdSwzB0pWsixiZ/aUipZfuB9oMJVPyH+d1jet65lKOmX7WNN01Je3tzR5
	+89Ni9fjuLvgjYkPZi1mJgxVYtCobgvuBAP8ByUzINGf1j3uw7PfKD560mWwMzAVo0mYWqbw9M7
	ye4TpOMlhHOORkr6JAR7iTbcYFMCwyAsIusZOJPnh6Mqn8GBZFqy7m7/HBvZuXHTjFRWZ9F0ROY
	O6nEw2djARF9KeotAymHhTtMNFgAXK33pSBsEG1HS7jLCqyXfvTEei33255nNyW1KPps9mY7hfD
	WOxc4DDK59nHA7YNFfdyAdnidLIFEJMNc9Hy87snPs8=
X-Google-Smtp-Source: AGHT+IGHyw9jpFHb0aZNa7IBr5fLIyNMqKS2+tIQTNTWVJAr+zH6ZWKTwNlqMg6M1sYOe3HKq0hxDA==
X-Received: by 2002:a17:90b:1b47:b0:2ee:8ea0:6b9c with SMTP id 98e67ed59e1d1-301a5b14c80mr2967926a91.12.1742298939730;
        Tue, 18 Mar 2025 04:55:39 -0700 (PDT)
Received: from localhost ([222.151.198.97])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6ba6cbbsm91808155ad.117.2025.03.18.04.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 04:55:39 -0700 (PDT)
From: takumaw1990@gmail.com
To: linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Takuma Watanabe <takumaw1990@gmail.com>
Subject: [PATCH] mseal: Fix typo and style in documentation
Date: Tue, 18 Mar 2025 20:55:19 +0900
Message-ID: <20250318115521.11654-1-takumaw1990@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takuma Watanabe <takumaw1990@gmail.com>

Corrected a typo in the mseal documentation.

Signed-off-by: Takuma Watanabe <takumaw1990@gmail.com>
---
 Documentation/userspace-api/mseal.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..42f32b57e7e2 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -27,7 +27,7 @@ SYSCALL
 =======
 mseal syscall signature
 -----------------------
-   ``int mseal(void \* addr, size_t len, unsigned long flags)``
+   ``int mseal(void *addr, size_t len, unsigned long flags)``
 
    **addr**/**len**: virtual memory address range.
       The address range set by **addr**/**len** must meet:
-- 
2.43.0

