Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2765048A2CE
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312209; cv=none; b=WnZP08ej+VeZkAXRkVi4XhaaZqsGl+Wsjodhnwh1WgU/x5EVd51E2t04nFIIniTF+yZ8VorM70VTlmdB8KPMU/TylxjXid8NahPVKR1j0LcaItFWTECc5V3RvwB+od4SgiL0PXhQ5rMC22RrBmPpPw5rDEyMU2VrcxEkkDNbqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312209; c=relaxed/simple;
	bh=GtU3BwmWr5r04fdNMr2P/dLekVQQQO6qKHal+CTJ5SU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H25J08H57fajxeEGu047ltY17Ez3/fiwzrNGQDaf1r3P8xK7Wto0wGl7p14kExoz3oJkPl3OB1N09T67yISXz2SmESFbWpZJqkVRs/XHAa93JgIdjPBYDmdjDNxcyP4V9DhcuJnko/jxH08XdDFnVlaq5NpAeWe0Sgr4wtFtqSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cY1BR8Ow; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY1BR8Ow"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so1814081a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 04:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787312206; x=1787917006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fqnhzBAbwr00r53ZE/i4Zlj1u/RNPOU76CLxr9WNMu0=;
        b=cY1BR8OwL7JRO+eF0OsNMGYgpnT0+gX5pyB49TKjGotM+IcT43LYWnjSWVU2pYXBwl
         +Ykjo867/GzDLZT+L8bOjInFel1BjgH71NRZvBjs8dLXOIEoc5UFx6p+dJlo01wQDn/2
         3zb5ZWP0v6Lrgo+73hhvAaRe0Gnsjr0dzNv27mmRWvSL8xICuePf5DkmgczeHdRGZcPi
         YWOQfXzO8g/eWIMgeMdx8BAcNIDPLo5KMDh/BzAiiTnnFjfVPZ5ztV8FJzUA+aFhPrgD
         fd/Nsi68T85WrDndghAUFyEp0ggVWwbIzQbsxJtGCz2iziajM0H/QMUqnjC13QA32LaB
         QIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312206; x=1787917006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fqnhzBAbwr00r53ZE/i4Zlj1u/RNPOU76CLxr9WNMu0=;
        b=oJ/PZAl0jntgY4mOeRXFWR4kYQvo0srPS4uGTwlPrWNw/PvPzT9GAaim9KAkUvBV0/
         hQ5oX1oTsc7ysIov46epuz9TmW/W5UMenhlEYsxsUpmOS0oV2G9j8Y9ODzZ7zoofc3fn
         m0hQIE67swPvKeXxFZrmIw9SOhl2HIJIthvN71FrzjQ0yC/1Q6ReHKW5haLruAQWo4TY
         eLQhbxKX8Y1PGQMudXrWx100I+UR7JLYfpbOqN5wVyNQIinqWNPqoJOofJjB2dsWJBl3
         rYRtj4p7EzHIdzaE+Jny8LYSSjhxAPuy9xst2I+wwnQZEwuV/o4YgG17K77UTyvJZY7Z
         eyXQ==
X-Forwarded-Encrypted: i=1; AHgh+RrdXzxcjfWYQD0dDFGr0j4eHRUGNjOktwCj7pog44YFv+e+w0WTEpwNDy3UyT1nsfDltCJZ1dTQTZ6MSnwyTs8=@vger.kernel.org
X-Gm-Message-State: AFuF++nVFwawy3fAj3vvimOq+qzMBUrEEPgH9crRaaRw8PcQwvuQU+nr
	Uv1rcZk8iPQcoIgFoSjzT+4EYAs5jiLxwdOuXWqsfIWxrcr4i+td8h1s
X-Gm-Gg: AR+sD130e3kTxzUKB0taKCDGkdh+4t2EokI/6I5L3Nw3sBF7bjeRbiRyRGUdCF1Smd2
	ynsPZdGViQF9Y4QTjqLeaBeQMVkW7atpJQZ/Fcdv+qyjNGMPybD4+WkQ7zDqj040xXOvfeuAwkK
	OB4L4aCqM/rjE7Qu/A9YVCXwkn8gZcF1VjsD98XXrmcOMfnF707Hg3wC4/oNvtWYsnX2hqMAHKN
	IkJ1m9Sh6koEy2S2iy0X9LW7AAKsqz+PpLt36K3eokzaiNLkx1cxJINCZoubOsGBlTLqW4eG6DO
	9SKTLmqauetMUxWiPGX3PF7R/IfYK5pcemb71+VT5iIyi6SUGwM7ro/vFLQGZbz4n6ibIxhyifT
	fXR5cLj9+c1akLUz3VJPHGFpzgHzZKq1IxdCKOEn7Jal4xPFI/wngMEPpu/3Baf2c9DkMUskEkN
	3dUq80LT9Fwj60quin+tt+f2b67TTKr3IvCXvy2h78p/gkT/VCJIO7zk2MRyAvGoZ+19Og8wQ0Q
	k7iTvnpYemDYhFrohqO9Isr8trFNbXIbGo=
X-Received: by 2002:a05:6402:3818:b0:6a4:cc9:c8f0 with SMTP id 4fb4d7f45d1cf-6a42f16302bmr6103267a12.1.1787312206351;
        Fri, 21 Aug 2026 04:36:46 -0700 (PDT)
Received: from [127.0.1.1] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c3491sm6204661a12.10.2026.08.21.04.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:36:45 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Fri, 21 Aug 2026 13:36:29 +0200
Subject: [PATCH v3 2/7] dt-bindings: arm: qcom: Document Motorola Moto One
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-next-patches-v3-2-cd64bcef6e21@gmail.com>
References: <20260821-next-patches-v3-0-cd64bcef6e21@gmail.com>
In-Reply-To: <20260821-next-patches-v3-0-cd64bcef6e21@gmail.com>
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

Add compatible for Motorola Moto One(deen) based on Snapdragon 625 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index ff8a35df7862..289a3de1d24b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -292,6 +292,7 @@ properties:
       - items:
           - enum:
               - flipkart,rimob
+              - motorola,deen
               - motorola,potter
               - xiaomi,daisy
               - xiaomi,mido

-- 
2.55.0

