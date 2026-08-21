Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA71471D02
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315244; cv=none; b=BDvZNO0Hi44NGfTTjC36EYyHjwEZltMIoiE5SMnhNhGnoQ56Umx/2+9Mlc3UWqeWYLWrEASVQpLz42dSqzjFGzyNlMCqQSdXugnD4AQUJLFKIscS9HKlTX73I7EtL6ELfEtMhaNxDC9dFyIhZ+pXetUWiFXXVzrVNbTT6bRSPFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315244; c=relaxed/simple;
	bh=aRikrKedr8rRD84dJqfsSjKHfSLi0ROhZlN789CUbJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WgVoyjzLKFKeWD0OGC6oHE4q2G0y+9Fi/K24xwgiGFSMx+0Q66X9hIaeYon+AEQNzh6Z0ISmStML8vHPgXP8fUXJiCnBzipytmuzNt0YgMv3PZYVKnMOsRt3otM5sMvo1E0hllbq+N9OcyshQ17CAd8svOXssf/0gAeeGQEDjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyHo3Q68; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyHo3Q68"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a36982a875so1610226a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315235; x=1787920035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/a/K4l60N8ZYR9C9kOGDnGGvsCsbHCt+W0MVudFPQc=;
        b=QyHo3Q68WhsfgHv6ExsGYFjMBTWH/225oSsPXZNSIGy6HP7JrgxcduIuJwOedH23p+
         U60gRWi1Q9odTZuBfADIApozwglG2DWaopqdiTS3XaRast+KKrg3cu4jwSzdRw/mMtpY
         HadWE/UWOFrLJj2O66pCPXqdR3/oqnvAZz0LAvcUyiHGorkXCaSLvKrHXfsDRvkqNW/E
         QT9YY+3WcYxHLa7IIZc96i8PHzdDwBlBd9JekxjncEC3WkLFLPrSgwY+gOQbdgHUMe1l
         zC0hn6ianheu2qN/BtLagNksR35loz6lbPdWZOHvG7mOKWdIcFMNPsNIcU5dhyV0TA/o
         HfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315235; x=1787920035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K/a/K4l60N8ZYR9C9kOGDnGGvsCsbHCt+W0MVudFPQc=;
        b=kbh5XfSy58fpCuWL7McfOlM+RsR5qrasbXNGmicGngerkjmmdZJHKWOMWlZm2zERZR
         n3xJvTPCNOgP3bs9ga5bOZ7Z3GNQiT1ZuYQI2prwyguToQVWzZmFZ5PN2/a3Bl7msqBW
         0z3QmWKaL4ZSvfarRbi5gJTduAQCGLzmfIpGvutj6Jy7TWhajkD/20ScX4INChdMoqOJ
         uGxZwsbBPOPCkWRPovvAFLwCcVOa/v9BBwUKfs6oWBpbvy8cG0bW41qtG2Hg95d3eV1S
         /zD0TXHYwZsYbqkBuHh7LSxJiaPMlVGaLzikoS87rI433UF98qPmTkPHBXPJXdi+HOcc
         TjOw==
X-Forwarded-Encrypted: i=1; AHgh+RqPp9BvjN533naUy3xXM2Mdbx4KlQTJOjxs7ZH3UC5KndNsKIBjMPUkRTDTvWaXZtxP/YcKV6ZmivSxHTKUdyQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nZDVhtbF17goJWydvbUC2eV5uRH778Ba/kCWeXolPdYwDKulm5
	LMRNT3pyGBn0gA/fshtSdRhKTJBucKWW2acUDqKcnKQsWX6wvuF07uEN
X-Gm-Gg: AR+sD13+7oirMFqbTI7NtSp7bPFO5QH8eA35wHykhHV2T6g7KIAh9vDagODBZonzvEn
	8cKIJ0x+PtZmDLrqUuNbn56e0F3ud+16OnQz2/jLfYJnX8se/OhxxwIfThEvJHxtDLgsfwFFToY
	sI8SCEOZitOM1ep05vwVQA7Sjldx64LOo4/p3yzKBtw8hJee21uuiKEexngWq2fwJERa4O/pk8c
	ZC4cViV4okjhSAZqXLWYVTCJGw/3ZMLNEX2D4QNDnBjLQfu7tGi0Fr4bc8A6YnYTXo7Cumkawy0
	mzTHWpOmNuHW2BzRnvP86jlzVVp5FtTHbj+6DoCEMEoDbBTUWwifz8MeAWLdQnI2oaQ/lturFFk
	Vcyd/+PieVbHv9e/pVtJv5q2GQDWbwJzmgST4zz+51W1317fduTbN/f4k0QKmMDTgbCXMrnhJSi
	7nZVOZAf+EgcjNeEXQj0eW/nsUvzDTYhNvGqs8dPyOXsfnDyz5AshNH9N85vvkg220CKD/v7hqh
	E4Kp/uvOEP2pc0eQSHNFrTjBBn0ZIrrXWsRhw==
X-Received: by 2002:a05:6402:249f:b0:6a3:ebe1:c2c2 with SMTP id 4fb4d7f45d1cf-6a42f14dfacmr7250121a12.2.1787315235036;
        Fri, 21 Aug 2026 05:27:15 -0700 (PDT)
Received: from [127.0.1.1] (83.24.178.112.ipv4.supernova.orange.pl. [83.24.178.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c315dsm6220262a12.9.2026.08.21.05.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:27:14 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Fri, 21 Aug 2026 14:27:05 +0200
Subject: [PATCH v5 6/7] dt-bindings: arm: qcom: Document Xiaomi Redmi 9T
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-next-patches-v5-6-ec81cee63e09@gmail.com>
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
 Adam Skladowski <a39.skl@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

Add compatible for Xiaomi Redmi 9T NFC codename lemon which is one
of variants of Xiaomi Citrus lineup based on Snapdragon 662 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 68542f76df30..5363efadd4ee 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1035,6 +1035,7 @@ properties:
       - items:
           - enum:
               - fxtec,pro1x
+              - xiaomi,lemon
           - const: qcom,sm6115
 
       - items:

-- 
2.55.0

