Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7AF429822
	for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380964; cv=none; b=ZaCthyCcpwdz5eKP9RRenkpw6ZFie6l9TKDx6QHkfQNwWWX56LMrcfK+uOMIy4Rz3PMdJtjIZNQ4qZSDDSOQM8UVQ3J8vlYfmSsYhNINmUnungPozFEwvtHBmS+C1k4cQKurem3DogV+M9GFFXcZv3JEhHnea5myPmz1tkc+juo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380964; c=relaxed/simple;
	bh=RWuj8qnf3rFbnhiUgB4rT985qfCrivQ22YvDzPsKCWo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cEOz3SN6Yng8RRydOgIjAP5mBfg55W2W76R6pp3LvnGob3YWv6BCjcSqYWmWCr3FHUIUkbuipAAKWCY2AxD7O+mtB0wbe5gQ8koGLS/9XtJZGYIm9jOxPU+NVC7zHcPdKxHHPhMRPUs/eDXZnWdDVaAUf1GEB74wZ/CbL8+u8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fje3fzWU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fje3fzWU"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495635a85d2so18792105e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380961; x=1786985761; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=13b3qYKMb3EC+1kg3FPioAIArReTTwfbQhljZ1qVL6Y=;
        b=fje3fzWU5nJN4VsCug2NZN01UoT0kOzlYC6EhzRBAXaJvHsQusCAx795TtB5kJkova
         x1gCkGk/0qw/7UPZNnKWk5kFvFjy+gYs5WOIyKryJZOIZeOIuoGnIQ1DwnIUEqx4MzON
         YtZcoY6Knop5W5bJPyYIxfsnxSMO9zzPV2WHYbly6YEUctsGLfq5HD/OtFBKNUzrmX1z
         e/CFIfF0JMRaH0mI7BR5GI7yWQFwhK/mD/Zgmtgqzt5RoXEGC7HUkDGplUKVdzXY8FGv
         PlG71VSRI7tC9yYSEVnv18hqauF6sQEETxdAm7JuN6RRkOkDaUbIEKdguYpgqSLviKWY
         mqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380961; x=1786985761;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=13b3qYKMb3EC+1kg3FPioAIArReTTwfbQhljZ1qVL6Y=;
        b=YHbiUum+fm8O9Xyxmsf6YiCuLnU34tsyEcflrh/4OuX7kEuGm4M8ZoBx+NonkZLjfO
         08xBnIeG8Oi68v17O2lIH/CzlXguo54OdPQ66KyuciPPhLb++KWy8uQcQc/7+Yodsnol
         w/6HWfdtH4h9x+shIoq0iVLudQniAvEG8xpu2rHY8Sz6GeDTZphnk7E6krQwVd+Jm5ud
         nW+mC/8gERintGOCosfBiYsaGTAUuGIXIygIvm5fCsBpe3E2oaHnyU4DOJbT2+7JpkRM
         odOTCQcCsf8khAtAES+x5HWVDVBK1SX1vU/Tw3u3Sb0ZDm5XZSXphkr74i8AQSdKl1RZ
         +wpg==
X-Forwarded-Encrypted: i=1; AHgh+RoI0sTknHUxi3Den2RwLolB9+qOzewjd/CiB5JS6pGCq7OZEotColKh2pfQwf53KqtoBzYIAupgaOt3sD8Py5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu1HVp6j31hfCzJgswPvhPDPkUMotGjvzJlpJwc6rFQ9sRJo6d
	H+ttcb0r+hZJURSsuCGDbBCPG0q6rmq6S1Gqfvld617nO4Fr6Ky8R62G
X-Gm-Gg: AR+sD11ujCi/V6wr8GPS1/ItNgu1mTvcCH+HbdnxirLTanAv8xVYPrb2gTrIY4wot0g
	BA1tBTRYFYVM8zzRUchS1OriZJIJFNTnAEWpC/z1d1NSz0Q3HPht2fYIbv+yAIKJU96iVsx8+Gw
	1nK8Cu5JWJnlB56ICiE2u5bnjDk3nv0eG+x+Xpzs4dlYKG/Vol3GGrNTq9f8meYJI9CISuykzYZ
	TdOTebLuTIYgsx83LmImwCyvhgcUstaKQ4gw+S4yIUrfn2HWJ6Fx7Xstyt1uaTGMX+hyYXMkbRh
	fivheWvSRJkcEUJxODImDSx9KZVOFXbJUJ2A+DHXtXBjqp+spFm8pNKBSZ9xNJKAjBw3dMqgKQa
	uG7WgtGM4pP4NB7a3ckBMxtbvfBPGpIH8dl8L01x96bBqcpmgGu1lHas30ngxjcNRzD5225drU7
	J60buu8KNrhOneWbTI4hg0ufA5K3LuZudLalsW+YtOztPaOWDaaCObVpu1Eqa91pjwEaxGkuOLt
	jpj5fA+cEvak7P+1jyjNC8gf8vxHuqgGZg=
X-Received: by 2002:a05:600c:3ba6:b0:499:48be:3189 with SMTP id 5b1f17b1804b1-4994e6c065fmr548621365e9.0.1786380961346;
        Mon, 10 Aug 2026 09:56:01 -0700 (PDT)
Received: from [127.0.1.1] (83.31.73.193.ipv4.supernova.orange.pl. [83.31.73.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm238472635e9.2.2026.08.10.09.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:56:00 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Subject: [PATCH 0/7] arm64: dts: qcom: Add 3 new devices
Date: Mon, 10 Aug 2026 18:55:33 +0200
Message-Id: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDWZWpS4ilhUOxiLkk6JRNxds
 XyL/y8QikwCbXFBpIOF15ChywLcbMNEin02VFgZbDSqQGdSm01uJlHGeuM1Yl1bhJxskUY+v13
 X/5Z9WMil9wH3/QAvQcMjcAAAAA==
X-Change-ID: 20260810-next-patches-6ad6d10077a0
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

Introduce support for 3 new devices:
- Motorola Moto One based on MSM8953
- LeEco Le2 based on MSM8976
- Xiaomi Redmi 9T based on SM6115

Device trees besides enabling most of supported hardware also wires power to
subsystems like MDSS even if those are not enabled to lower maintenance burden
on out of tree forks.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
Adam Skladowski (7):
      dt-bindings: vendor-prefixes: Add LeEco
      dt-bindings: arm: qcom: Document Motorola Moto One
      arm64: dts: qcom: Add Motorola One
      dt-bindings: arm: qcom: Document LeEco Le2
      arm64: dts: qcom: Add LeEco Le2
      dt-bindings: arm: qcom: Document Xiaomi Redmi 9T
      arm64: dts: qcom: Add Xiaomi Redmi 9T

 Documentation/devicetree/bindings/arm/qcom.yaml    |   3 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/qcom/Makefile                  |   3 +
 arch/arm64/boot/dts/qcom/msm8953-motorola-deen.dts | 443 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8976-leeco-s2.dts      | 444 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm6115-xiaomi-lemon.dts   | 440 ++++++++++++++++++++
 6 files changed, 1335 insertions(+)
---
base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
change-id: 20260810-next-patches-6ad6d10077a0

Best regards,
--  
Adam Skladowski <a39.skl@gmail.com>

