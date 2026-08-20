Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5936401492
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218971; cv=none; b=BDBT6XrUmnsYjdmtWOm2MtZHcc6dJPP7zVlL+CbQHYGf3/6HZmFiUUIsgOhLvbg6DOOf+CeUhp7dNKovtysh8lhc03Fqz1G4AY2B17W3nNqZ0H3pTo1Kg/fdepPzf44t+7z7tSyJJAuBTUCzpoOk/1HOHv6HjtdNTXXLmufvDKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218971; c=relaxed/simple;
	bh=SLgt0+h14ZOfuzmTLwyNLNXs7RHbAk6hjl3WhGYDpWQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FnYtsiM0TxJ5PbL79jpmIHZ4LlpM3l2xgQMm65LVp6yZApN/OCJKnS9xhZrzJZdlOXSsPrBz2TFZO/8JxsU9ImPJBWLuCqLQKXAt212SDVOKXC1+ozc2SNsJn4oxKu3PJmMcsIH00psqQ7CmvywkygfAYvekPbiDcFnm6sbiG/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ki5EYMVz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki5EYMVz"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47de008b020so560030f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 02:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787218960; x=1787823760; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YzL2SO0oanEljmvoZAdumsTt6y7BipjLwI3m0jswq0M=;
        b=Ki5EYMVzCHWLazlYFIcaQLNvLDDw0B30mlaO61852TGR2lJmPBpa2zCty/UZIAOr+t
         n9BG8c8tnWslkKfW5EOB37taEUilNL/ZnQqiPeU2SVxtMQQwLYX151BZelMLVYHtMKc8
         BOhAsKPLeLUuiaE+au/I0p/oxLwDOvjPhoy9Dt5GWSxoYCbo0JZPHl8ptAyI83PqOaAD
         oz5vzwk6KC3Pbl/Tdgb0QNatUTtXgzCj+E42FuPw+Ik/5srgApCrtwPG+9szrLfEWo1f
         wfx3QDyPAfokjmMY9vvYVSnfJTWRixcuIz0lyu1NHyf6ExGiITMxDjgwMXwVUj021tEW
         fz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787218960; x=1787823760;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YzL2SO0oanEljmvoZAdumsTt6y7BipjLwI3m0jswq0M=;
        b=rr8bC/cPBH4sOl6FUHURObKRKq8pGQ2Pp6nusC7yEm3wGp2lZcrXwF0RrFUykqIOIn
         wrpMTFxtB2Lh/49A6k2nZ4TW7Anen+i+fppuMNyiLYQvIW3HjqXki93q2XFQgbBLM8mg
         lVPa90OlPh0x9a2ZFah+pBV0LhtvS80meXDFVO5sARNBBKGgUUFacyELF8ykJ6WwTzj2
         HAtRMP4mXWPPsG3IcFzsR+BvnfU6N/FmEHasY+11t0FReQDxzIJXiXXAWjEdMhM1qqic
         mkIjTQ95pqswE+axDBr/gN89Rjezw2d7SjL879UI5gp+syeft7zmp/nRsXpSSUarkTkY
         0m9g==
X-Forwarded-Encrypted: i=1; AHgh+RoPQOxcp/bYDGipOC6Qb63l91xSVv8KClx3PXj3KqPAjTMYduoeNpkwulMgUwPHq/b5ji4NWLuT35SxNS+FGcg=@vger.kernel.org
X-Gm-Message-State: AFuF++kTsZz/4p2CbTGZZmEyoR2dRPU6ORMrzrGmqmJtCGKMCTn3QLSx
	ib4AknzB0GHwGOqPAzYUNmGYdhHAVQ5+2TitZjMrvaQvLHs9PCWIc+Gz
X-Gm-Gg: AR+sD12L0d0+vfergKZ7IF3v8hWMBIcKoxhDBbfqE4MN2cSsc6SHlwI6jqf74r/DHMj
	djil78N9qWbJE9rf1wASZpBnBLQG0n4mxZPCVDPLjikV5uwaFChM3OXyX516YKT5E0cFBA2OffR
	QiX81bcVLqHxfaKoP8fZ7/WswnbSCLZY7ryb4cCYiFAoIPpN3V3FUUFUZrchhmh/90FsIdEYPCB
	PZp0Kh40jmygyAgtr8vcqohB/4Oi8Fa96QhQFAFojh5TQcXDOhR4G0/gn4g/R1ZLF400gXbV7aX
	bkqL1e8Q2K93EFQwKaEi/NnVLptn5Gt8NLb5DcNmgbC3Sd3NEBFWArky9Qsh/UpevcRBB0N3lAm
	PvkQ+KftGpz47cU82dWn87/VZ6+Mz+iPcPfwgyXxCTP4t19f89lv8tVRRFb0czo2RwZhujNdBM8
	XZqbz+hL4fIZPmY70fUU3Qfp2gBa0izV7ZW0DIIgTiSEuV6CFWOZWErBSlPP3da9WaB192VNfu/
	JqAEZCf7ioE6lKZKl733qZL
X-Received: by 2002:a05:6000:230f:b0:481:562d:6fb1 with SMTP id ffacd0b85a97d-482b782c84fmr7644350f8f.6.1787218959842;
        Thu, 20 Aug 2026 02:42:39 -0700 (PDT)
Received: from [127.0.1.1] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b144173csm11788090f8f.6.2026.08.20.02.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:42:39 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Subject: [PATCH v2 0/7] arm64: dts: qcom: Add 3 new devices
Date: Thu, 20 Aug 2026 11:42:23 +0200
Message-Id: <20260820-next-patches-v2-0-7130d68183d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2pppTTriyv8wLGo7whh5pK0EQ
 /h3AdcuT3LuuTMkjsIJLsUMkUdJ0ncrmEMBvnFdzUrCymDQWDxrVB1PWQ0u+4aTsi7YoBGJHMI
 6GSI/ZNpzt+rH6X1/ss9bYzMaSbmPn/1v1Jv3Jz1qhYpKR1QGsppO17p18jr6voVqWZYviN89T
 boAAAA=
X-Change-ID: 20260810-next-patches-6ad6d10077a0
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

Introduce support for 3 new devices:
- Motorola Moto One based on MSM8953
- LeEco Le2 based on MSM8976
- Xiaomi Redmi 9T based on SM6115

Device trees besides enabling most of supported hardware also wires power to
subsystems like MDSS even if those are not enabled to lower maintenance burden
on out of tree forks.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
Changes in v2:
- Adressed Sashiko-bot warnings
- Added Krzysztof's Acks
- Dropped confusing link from first vendor-prefix patch
- Removed ramoops nodes from Motorola and Leeco patches(now handled via lk2nd)
- Motorola One USB-C connector and FUSB302 is now fully wired and enabled
- Motorola One Touchscreen has been disabled due to panel power dependency
- Motorola One debug memory regions were removed
- Motorola One regulator setup values were ajusted
- Motorola One NFC now have more specific compatible
- All devices now have described reserved GPIOs and trimmed unused ones
- Leeco Le2 added missing pinctrls for peripheral IRQs
- Leeco Le2 OTG is no longer enabled as phy dependency is not enabled(need rework)
- Redmi 9T USB-C connector now is fully wired including pmi632 setup
- Redmi 9T nodes are sorted now
- Various changes to styling to keep nodes within single dts consistent

- Link to v1: https://patch.msgid.link/20260810-next-patches-v1-0-79a779d76173@gmail.com

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Kees Cook <kees@kernel.org>
To: Tony Luck <tony.luck@intel.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

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
 arch/arm64/boot/dts/qcom/msm8953-motorola-deen.dts | 460 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8976-leeco-s2.dts      | 435 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm6115-xiaomi-lemon.dts   | 497 +++++++++++++++++++++
 6 files changed, 1400 insertions(+)
---
base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
change-id: 20260810-next-patches-6ad6d10077a0

Best regards,
--  
Adam Skladowski <a39.skl@gmail.com>

