Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A528750B
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798505; cv=none; b=hqiPgNpoQjN1kfDxEQffrQLOgShHVfx7dE8kFN9QiE1LNKW6ouN4iN0Br2V+ZQT08DiCAeOMMjggAKd6fHtYMQUiBK037h7Ou78tdqm76ya3nKgDC23CxuP5F6pA1J2q1J468ThSk32psvDFxaI2kMYxzvvNaC2qs9KCL0Tvyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798505; c=relaxed/simple;
	bh=bN2NtU1jMjlIDsytJCAkaK3wY9kweoygfyCb0yYoCOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DeUSJZApxVRTiBm2Xp9CI/RBhI8JzDX3FGBjJFqB70L8XUVP47z2OPlCqAPjhJMJIX0JGMtlR5Fo7LrwPT/TBpkdg2wLRCoMa29nNELcph79b5bCnpChdQ8LlTGJZ8IJCXhB7hssxlmFc8qSruiO6b4p0s2Jmlvz7XF98Zr6eyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv7Ro6Bk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv7Ro6Bk"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dec026c78so29361945e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 14:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798502; x=1758403302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGIDvsaWCo8xv8p7HWlgtVj86XAI/5q9CVA6cYOpa5o=;
        b=Tv7Ro6BkwypAfhuJGLmcSeKbCifraTZKELC3sfmuEXSxxpkIUZRay8vMcA0+jV4tSU
         8PYAcJPnyhyv5Bvc+I1Y3jSn7zJ7Tw1D1+/y2H9YqvWfII+t03MOhAhqCIqIAQbBCRUN
         Cw0LJBmGlxXI6owlce/TSKK47caDYfq1IpmHnJGUsA9ZioqdWyVHoPMEM81xucXgAM07
         LlJ+dtSfrglG+QKr2drMFPrVMd7uzgTHytAmVbxOwEdzb88CXBYn0g6KfVi4Zzorih7L
         JUtIYtrdSSlAllqoS2YSOItyf21a5QbBFQJjNac6uVB2jz0ITmb6k92eJ51z/9VLMHXj
         3I6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798502; x=1758403302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGIDvsaWCo8xv8p7HWlgtVj86XAI/5q9CVA6cYOpa5o=;
        b=d1rfi+Agi1tCFuK/BrO9FFSLyhJV3kvfsK0TpVRN4QbcnHpslWajy9YXgMCVpIsNKh
         2pqipvFxk2xMnYdkd0zWmrDJxiHg3jxl8s9/Z0INhiU8ORJarNVHnF0yxrNqMIzUFbsW
         9AWzOghsmbE8/QT1SoeIdsUdNVngirp8LmIUlOjSXivhSUW750mD6qC/kba2ZKDWvMQQ
         kiyZxaRW5HIIu5666QMpJx9VdrN9DUaqtwtDxApBPu3ZZxCP1w2622CjK2jhD+h5RLy5
         oXfHCrQ2djCWNNgdh9FgovjMz/NLaXz/+CWXimkrWc9Ogf2CwNCBrpjluRQSJiFrp2d8
         SvbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkAd/SOA2PlLaepTBFf5tmFRL7WNMgzarFtUWPzQTfgTqmj6ZRzsI7QTd99wmSVim5ly6U82P/DTcRA2iJj24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3W3logTyxJQobMeG8RvqeD2S9YhtPOw7c3RwJWjN28WwW8rNO
	M57MxNvR8a2di5xTctf7tpSPcCq/xzBN50msqP75hKnYTcenpNoTnv0K
X-Gm-Gg: ASbGnctWh7Z64bTtjF+Bq9CPWZlZjHW9DQirk/ISnxwKQTGqXlmflAOKUzUbjcPxnCd
	T71rupiYuiSwdbCj/Y6X5lXonfnscCDoAgFsRxFmcgB7J3XTH2p7i2WCSFFc5KUe9zB2AvXwQk8
	VBOlJmvcfsqdLYXqVq9D6xtT+eHgAScqsPR+PnmaGDYgRkAu6bSvKDmiGXQoV262Hr+zOKOAEfV
	6fOnjlgykOLTFSCL2YujQsbW9y9wCr+dWnqoQuDfZ4Dht/nf9GPZbvVCIfrjhboGu7CpCf8Q0h5
	EW8MyDZMMOYaQI7Ndxf1nICxoSi40qxCFLlJfYpO4ertGUZK4qJ1A/hCsmd+MkCIXXHORCgtum0
	YFZrKYTptufze9zX1fc8Ck5wdVnoNIrK1/hj08yhfWg==
X-Google-Smtp-Source: AGHT+IFmY5THLm9dS6Ltyl84/gJeP6O7MDMN8wq3OBTV4vsimxgGIeh5PeYusAs8d7qMKStK/tRNLg==
X-Received: by 2002:a05:6000:616:b0:3e7:41ac:45f8 with SMTP id ffacd0b85a97d-3e765a227fdmr6279358f8f.55.1757798502238;
        Sat, 13 Sep 2025 14:21:42 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd6absm11576842f8f.34.2025.09.13.14.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:21:41 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:21:10 +0200
Subject: [PATCH RESEND 8/9] arm64: dts: marvell: samsung,coreprimevelte:
 Fill in memory node
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-dts-v1-8-8120cdc969b8@dujemihanovic.xyz>
References: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
In-Reply-To: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=nM2aOAL4Rd5X1oThp5ECWAxcNFIMgGN60dxwZOl4zsk=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlHH/jHnzbvid+8/4WqqeD2tsaqOVVzrW4dMC58tePCo
 R7OvtSNHaUsDGJcDLJiiiy5/x2v8X4W2bo9e5kBzBxWJpAhDFycAjARFgZGhusB+x2XswWu8b3z
 53X0TMVnDvZdygG+SlOKT/IdFw/uiGBkmLWy9mLEXqMDpzo+7rnl8nit1aT0YN05gZ/uzJ9mF2/
 LwgwA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

The board is known to have 1 GiB of DRAM with the first 16 MiB unusable.
Instead of relying on the bootloader to fill in the memory node, do it
ourselves.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 .../boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
index 13a726d86e65ad836166325e0958a6ec3e6d022e..b3741389e2ae056714ff4235b972bc72b5560455 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
@@ -30,13 +30,22 @@ fb0: framebuffer@17177000 {
 		};
 	};
 
-	/* Bootloader fills this in */
 	memory@0 {
 		device_type = "memory";
-		reg = <0 0 0 0>;
+		reg = <0 0 0 0x40000000>;
 	};
 
 	reserved-memory {
+		/*
+		 * Reserved by the vendor bootloader as a "secure region".
+		 *
+		 * TODO: See if the responsible stage of the bootloader can be
+		 * replaced
+		 */
+		secure-region@0 {
+			reg = <0 0 0 0x1000000>;
+		};
+
 		framebuffer@17000000 {
 			reg = <0 0x17000000 0 0x1800000>;
 			no-map;

-- 
2.51.0

