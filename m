Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F94B471436
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315233; cv=none; b=AwXnEiM6cpAbkD0jJVygco4EPuW5WKxeTRwhIS6sbjqVpN2nzL8BOEMrCq+G42126rp18KeF7zd7AqoZVhBsjDlK8ssU15earXi7GPBgFUWY72g6xpy56dIx5scgjnmmdU5qqL8WEbd4Nw8kfjMUROqiu3N5Jn7EQmLDwHxSlxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315233; c=relaxed/simple;
	bh=lvXJIYHg+Za7wwIfyKwrdptP8jCEhBX03Cv8tnpa48U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gzlQSS+10YhUQzeNsN6GLww+33Rl719ABNTlDjTY7YXw+H4taXV1CZowFqscDByoSeSJ94/kQIBR84FPhbDty2PdVjsBwRHF/ImogKSaxn2o29u24MmY9SpNJVjoUz6CQodfy5CG9XIsnT8fIvHncMHgcT/Vxvm34BsMiXrwP68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyHkRCcC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyHkRCcC"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so1898392a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315227; x=1787920027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pna/XzfqXxr5JhHe4C9RpqDZzth/Iq1szA4HTr9J/M4=;
        b=iyHkRCcCael8ukhCEkpReKwomUTJYsOYZyNYjUguFh3GPp92yFDWuFBJP7pocirwEZ
         HkEbA7qnnG0dbN9lpyfN02h8eCY6iW3BpPwgoNDqrmoeEfPqTb30UnYcQRfbt0YSZ79Y
         PzOjU0e8gYeLuRT8rrgw+c5i7FULxSbUkJv10rFEAcPnSukQHhLjHPd0QCISUKwpHVFN
         dPIOo/Z+0iyMUSeTRRm4dVModRv+TPxF/+IB7NGlZNbtSkNhD3cUzL/7bNnqBxJgIApQ
         OmZehncGz82pUoXosiyd5XEdgyN5UBBIxdZUmM0IjPQLE/X8sDCsyFTSupFWRajaWuTu
         JNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315228; x=1787920028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pna/XzfqXxr5JhHe4C9RpqDZzth/Iq1szA4HTr9J/M4=;
        b=bjVjO3LKqH0dXZgl/+ggopff1gHqLTEgJEkTN2NzIjz4H7DU+mtgb0lg9rT0LznDaI
         3NknmPKtAfKYf1GPdgvbvtTG/FZk8GXtq4ligMJcnkgiJp8e1KFniMWvjQTnTQabZRV2
         BuXU4aZRgGNSsLJQAwNePN38o/s/Hj4VD5VjjBlJSf8PWQnnssBfOxXRuvN8pDgK62C3
         4ZYeUTIzv5OoKwVPy34ZziWes7xZ2cEtUylmOmVtnH80H6Pw0cHVZN6RJ5APdTjWuPnV
         YHyjixvm8z9ppwSTCqm/De+EwZ5K6vpfHv6k6WTt4Lh1Q2yNAHDK39iEZ61fjXdVR7gQ
         YkZg==
X-Forwarded-Encrypted: i=1; AHgh+RrxjCzdB+IyaQACfPGBDC7jRJQd3nOOi8YuTmt5HqDmT/5FXXFgaeBYFfcYS2Q60Wr2QjbyN+J3fK/G6kpe/NI=@vger.kernel.org
X-Gm-Message-State: AFuF++n4zYYpsg10fivyhQVxuuhuk1chz5btZN7i2CBIwo/E+X/sxj5T
	BqOhtBNaFWGJrgW64Ahkmyc3rli6rp+k5dkXFVecDON1QNRTvOAbPfjc
X-Gm-Gg: AR+sD11oxi1rzyqZNr1L0qT93XBvloiMgXnTHpIedgiEMzGVHRH2aA5FMM++fX7vgDM
	GeUkNMK2wkMxECzlvrktX/XWvaKAJt2I0C3Uz09A9ALaojZWyy7nL5zzz2O5eQPnoC7io0OR7su
	B5IHpfFzoUoIsEz7OD0Z3xCbpqpTAFd0Tsspls55pafHfFW3OtbjTLCyAgi4y6t+4Es8w0t23b3
	Ly6QgFZrHVTc4yqplHY6MQsBzdwnV2faXHHCLuekzWNV4BUpivHzWEJ4WGIrVfIpjncxR5YwNDH
	ET4/t8gE/wL4UzgRE2HJ9OFR9M++TcnkV2GnmmZCeL/NPSZwv73qR4F3GL6WfEbGEdv0KZKI9l4
	Oj64nnXAbjUh166zWI4wFT64geZ+Nul3IHf5jviEJye4sqnVfi0/hhHVMWsM99CnuQgXOrkuITU
	zUAfpYXlPZSh57d+TJC84NKTUiClJmN4/2eXG80CezzJhRn0NUXatJ75h1nKS5QD5QftDE0Jzjb
	oYTEKhRrCYFUx1+D6JjtCbkI0s=
X-Received: by 2002:a05:6402:249c:b0:6a3:71fd:4083 with SMTP id 4fb4d7f45d1cf-6a42f1e930dmr562762a12.9.1787315227582;
        Fri, 21 Aug 2026 05:27:07 -0700 (PDT)
Received: from [127.0.1.1] (83.24.178.112.ipv4.supernova.orange.pl. [83.24.178.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c315dsm6220262a12.9.2026.08.21.05.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:27:07 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Fri, 21 Aug 2026 14:27:00 +0200
Subject: [PATCH v5 1/7] dt-bindings: vendor-prefixes: Add LeEco
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-next-patches-v5-1-ec81cee63e09@gmail.com>
References: <20260821-next-patches-v5-0-ec81cee63e09@gmail.com>
In-Reply-To: <20260821-next-patches-v5-0-ec81cee63e09@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Adam Skladowski <a39.skl@gmail.com>
X-Mailer: b4 0.15.2

Add vendor prefix for now dead ecosystem company LeEco

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 136681412501..dd0762d3334b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -947,6 +947,8 @@ patternProperties:
     description: Shenzen LC Technology Co., Ltd.
   "^leadtek,.*":
     description: Shenzhen Leadtek Technology Co., Ltd.
+  "^leeco,.*":
+    description: Leshi Holding Beijing.
   "^leez,.*":
     description: Leez
   "^lego,.*":

-- 
2.55.0

