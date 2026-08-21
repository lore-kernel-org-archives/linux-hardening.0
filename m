Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320942DF6E6
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787314750; cv=none; b=Nq4B585EJfDyfCFCvbvW6Z8Z99/NQsKxcU7HbuotIj72zmESvXBEtpYyQw9QEOgIjDBdRY0qS1ydqf0ppDz5Zek2fQUnTtwECmeQbbEIRG+qu7M4Iqe1mSsmnjRWPZwAO9hxCT/FMc92RxHWfdY/22VNFxjKOPYbPOQrcmSt76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787314750; c=relaxed/simple;
	bh=2w8PO/4Tgh25HFk6nyzACrDt8k5i353xABVv5znYk3k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UWVvVf6jQXjyBgxr2jx2t+9IODgDTJiPdlNf+Kteh38bCwAwlpZg0MccyfOXriRB9ZoGeU54jkdYW1Zi0IY/wL1oxWPamnJJS7t2mgpkwD6glcMpdy4NsRLVZwXnYET8uXqOYgYa9Z+bpV8z6BrPZepbSkyI7ciiKGFg/Qqk0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmMt7vyB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmMt7vyB"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a18e24ad25so1399731a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787314745; x=1787919545; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/b8hDyA3Tux1C6emr/gbpSDfkZ3HQcig3Nns7k266mU=;
        b=RmMt7vyBWvFmWxapVfxpb3bHrxMwp7ylmJ5OHSIMHcKLGKeVD8YrS+t/Ks+gyuTAX+
         yc1Z5L1BPg9LTKKLfK7OZbsOrt+JEd0e7dIDwOE2V40xtyj7gQtSOmAoSEmTdqKOzCXI
         zasw3FpBEFcKSLCvmy1gwKSjBC7i1jmYGkWTzWHdN26LA2P3vKRO2XLW/tPd1w6Kt0tt
         ty1lO1XV7JBBlzhzqGECVzp0MAzpwzkqWTVHl6tsv0yE7OWC+g+A569LRAeAp0WHaZQ6
         F17r8HXCIzDt/AfjI4d/2V6lgSK6kxunq5ky2ci6KVv2sb47TUzi2nntBOWRTBQRobqt
         gGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787314745; x=1787919545;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/b8hDyA3Tux1C6emr/gbpSDfkZ3HQcig3Nns7k266mU=;
        b=LZ0Rszb0GTURik98qCzTjmio513fz2dIjcIhDqZ3QnlEp2C52BSGJ/cshiT0FLPOEe
         fj5LsDpx1Z85a7lONbcBPnZQTNzhIP/vsbU2Wp3eNEVrskTejEFuQDVR63lPqc3L/5yg
         Bm50T2jN8aeXkVcHJL2SukQqxg4HNX32Rx6skawJmq54RfiwJKbbRjGQH1vNSp6uuDS+
         P83kg2JaoUY65sVgqzA01K7pOGVwEvYF2l5N5APBXUYP16OiWUxfVsFP0HvE14tcPDJf
         VVlix9JJkMZ/4jUKYs+oPp3+S3oAu3WPFzBxxeJVLKIo93b/UPOEeKtpSCteLoMy6XSp
         dJ/g==
X-Forwarded-Encrypted: i=1; AHgh+RpxRe5CFDtAMpAhEloxwh4SptCXBP37JbBfO0ryhYk3AgtnZlWz6UVXYCJisr6kO6YqCVjtsZUa4pwZUxaU+C0=@vger.kernel.org
X-Gm-Message-State: AFuF++n0a+81dvOxuZ4taQ5JUvNUMsheZTSyPK2s6+oJC3uks2rgy8wQ
	JR/PN/lJ8HvtM8rx2chrZ13UP6xbGX+jVzbOogMP7Er0shATs4WDlZpH
X-Gm-Gg: AR+sD13xhSzltDoCehjGx6UTnivHPOSCFHuz3l5u4n0eAEXtBKeVD/e6OBa0MUhQjRP
	SUw0Hj3k3dqaeLzsGNGwmWLcKEjYAQyqAHY9ZpoWzNbJpTe92bj70n3eygDRzOyvrjaTvVeATIK
	7CI3SN0GKQGFmsZetOqXVMAz8L1heslfqKAqeDQdREHpKMSylm35pXRFpa9vgRO55nnqlUwO6ox
	f/qgR/PnY8ALcRw4bHBlYpbA599sekBkQuRUHPDyPc4d3gRCTGVPc6Ae2DjOO3v63j5XzjHzK2Y
	JyQBilqGev9VtpVxINE09/amKtVoqAWCQ82/4eWaeDGYkDmYT6/2wVG4/+tajMpxnyemqTQXlsY
	ivFUZeEjQia8uH4//VOtzcgpn+D/XTsX2UtLmVHOaQtMU+smW2NYJRANyMNA3bjDikfJ/zRrNq2
	miKBMsc96mySUPPh2GWtsqaYO/AlBxNNLLG1XdfByJsq7H/SaUvPO5Kp1p1reULEGE8RQd3emFj
	IDyL2szw1dakvU/WjNJbkzEYdI=
X-Received: by 2002:a17:907:1907:b0:c21:3c4e:cb90 with SMTP id a640c23a62f3a-c2469f98c93mr602288766b.0.1787314745047;
        Fri, 21 Aug 2026 05:19:05 -0700 (PDT)
Received: from [127.0.1.1] (83.24.178.112.ipv4.supernova.orange.pl. [83.24.178.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589d9df9sm447823866b.1.2026.08.21.05.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:19:04 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Subject: [PATCH v4 0/7] arm64: dts: qcom: Add 3 new devices
Date: Fri, 21 Aug 2026 14:18:59 +0200
Message-Id: <20260821-next-patches-v4-0-7ab02c0d4eb9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQ6DIBCF4asY1qVhwIB21Xs0XSCMStOqEUtsj
 Hcv2I0x6fIl8/2zEI+jQ08u2UJGDM67vosjP2XEtLprkDobN+GMS1YAox3OEx30ZFr0VGorLTC
 mlGYkkmHE2s1b7nb/bf+uHmim1EgXrfNTP362fwHS3Z90AMqoKrVSpVUSlLg2L+2eZ9O/SEoHv
 sP8iHnCIJiVBRTClkcs9hgOWERsrMwrg7VEDnu8rusXaXdoPzQBAAA=
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
Changes in v4:
- Leeco Le 2 and Motorola One fixed-regulators aligned to schema
- Motorola One commit msg reworded to drop touchscreen
- Leeco Le 2 added lacking parent supply for rpm regulators
- Redmi 9T makefile placement fixed to be after other sm6115 device

- Link to v3: https://patch.msgid.link/20260821-next-patches-v3-0-cd64bcef6e21@gmail.com

Changes in v3:
- Motorola One Touchscreen was removed as it doesn't work
- Leeco Le 2 gpio-keys node name was fixed
- Leeco Le 2 volume down key via pm8950 resin was added
- Redmi 9T Reviewed-by tag was added
- Adressed more Sashiko-bot warnings

- Link to v2: https://patch.msgid.link/20260820-next-patches-v2-0-7130d68183d9@gmail.com

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
 arch/arm64/boot/dts/qcom/msm8953-motorola-deen.dts | 440 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8976-leeco-s2.dts      | 442 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm6115-xiaomi-lemon.dts   | 497 +++++++++++++++++++++
 6 files changed, 1387 insertions(+)
---
base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
change-id: 20260810-next-patches-6ad6d10077a0

Best regards,
--  
Adam Skladowski <a39.skl@gmail.com>

