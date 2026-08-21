Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A33347798C
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312206; cv=none; b=UmQjb1x8a2geunV3i/IQ9JVDXf3nzJehcGQ2hHFf+ZDMyCsDWwTX5VJbAEii/lkUCDc9QO3JVjNAISyPyppjlypwAgOUfHi6wMRtFb4SDSG2pqdUUxTFOEpzYcPYzfkyTXw5VSt5rQf+k76so4pTVEa8PInpsRNmB3ZJTgwwdDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312206; c=relaxed/simple;
	bh=AT2nCkqaStkGDkKbRaEEc0Gp/jVkJLnUYFN+MYdaXSU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LJXhAYBOaoPh6K/t21icSJkDJ/MVwXHcrnczdxeZuA5IqH7V/IfkdNdPuknrvyIoL+J1j8hGTMXnPh38Q9abizpEUpxjmD+hHnuUYXqaF17qlV3KJyya9hZtDZsxyiD7vhTkQpHqKuT0ruDZTXPKOabJAKWa3m9hgt9+G28XC4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z75x8hF6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z75x8hF6"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so1889160a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 04:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787312203; x=1787917003; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FEEs/Ed8HmMYsgK4w7JBeJkb9cZhktOgtlxlFJ0RzVQ=;
        b=Z75x8hF6Enf8XvfIYmANNrqp2KrJwy0hcWOd06kIzzVKyuXhjflj1zP2AuDqphW9eQ
         Z38oa2X6wBXEZu3XxDw0Sm7sa2KNqe2gX3xlAHE+AhaarksBNAKY38nlS9U0uQnpsjdD
         9Gyhhieb5Xz/mD/IoE1V7xUkKIn++nlspAwV1ZmF2uxJgL0gBNbNMO8m0EgtC8KjD0Lj
         izr5sA3P3DlA6vvOZIUg04caEbHL5UQi4NZxIHQYwJBH/8ZkU6bWl0ee0TmhMl+StGqS
         1w/iEVi+BsDkuBevdl/PfGddz5wCBNSV9QmCI6jvTKc1pFyLeFtp1WbJs/BFHts3Y0/a
         r4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312203; x=1787917003;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FEEs/Ed8HmMYsgK4w7JBeJkb9cZhktOgtlxlFJ0RzVQ=;
        b=H84eCaPudagCnnF8Sc8ybKOGAMuk/7mLTVwXgAJcfkyUrMQSfySBZkoNGPw3m73cl4
         agE2qJi6HkoYtXZZZkgdeX+qIVzHzm2EtzG6QY5POCx9TEjEAOh4egFTHjXNZNui0ym4
         gTO/FzwLUENLoDKGD5i7ZwAJXvlhsvDjuZ6Drb8BZvNEeIlP96oZ92wHsZsbIrs7yn4n
         VMCt4Hv4hZCYwZUgksxYBFRVzgWMQUTYEetDkz1x9iVJsZam/u5y4LExPTzrXM9ELGHZ
         QQ8pq22znOooiiyrVPDzGcx/AXfzPR2rDpXrVOzcch83kL4Fw3XrThjBY6MHMJYBlgg0
         RB0w==
X-Forwarded-Encrypted: i=1; AHgh+Roxhh4XwKkTGU4SRAF9C/baDrd685Y7h6FLV9/ckhKqdUn9g69Kjzo4V4MpzzRiBYmWEMB4UZQ/JngPV4XsGGE=@vger.kernel.org
X-Gm-Message-State: AFuF++nRoJpW6U2yNmTSzBv8rlXSR0DFVslXFAdgIfimX97PzmyXVNjy
	C8D45U8OzueAOk9SfyAyoBD385QTh1dp+tyn+LBxs6ys8Mhoa/g6Gd21
X-Gm-Gg: AR+sD12m2Tlg9VX47TFLmOKRedSq+MT0vfLE5YYo+xYq7GBbYaRTVDilvpwUvUgi0aJ
	w8dACbqVhUE+P2JI0BTK4PQW+Ct3oKMWkKEJezXwD3WfC6uvwYj8qTHqhSjgkyclzA6FHmxQkSO
	z0bjhnjzVVidITW/B7D1lpfUtkiaJR5VJgxjhmVvbDfXn13/2E95MNoSELQZMI53J1E8jJ5Jvz2
	ixeUl4L8M8D415JScMaeW4Q98znuF8oaPi2Fqa6bLIaFqIthI/uOeHwblwqG5tWdBN0MJNYVN0E
	c2/BRlBvDAiciuvSYgImJi5XMfgjghWqG3Jw2DgbIYx2lf7scCxtAtjrIX/tE/XLRpIS9z9aUHc
	RHo0QYK+Xfm9L7t8T9njwGLj6ripzc9oOlYPi1b8R6ZL05Fcaa6wXqve/8aWIdP7RWWKWrH3EcZ
	tEOnRA6io09G5LGaI0osq2D8GsanHrwe9uslMrY8A67neB+JcBWhlb7oDmCIySFdIvCWTPjGfB4
	Ob5Vy9pay/32k65eYi4G0wJ
X-Received: by 2002:a05:6402:4494:b0:698:b6c8:70db with SMTP id 4fb4d7f45d1cf-6a42f196f83mr6180263a12.8.1787312203110;
        Fri, 21 Aug 2026 04:36:43 -0700 (PDT)
Received: from [127.0.1.1] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c3491sm6204661a12.10.2026.08.21.04.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:36:41 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Subject: [PATCH v3 0/7] arm64: dts: qcom: Add 3 new devices
Date: Fri, 21 Aug 2026 13:36:27 +0200
Message-Id: <20260821-next-patches-v3-0-cd64bcef6e21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw7CIBQFf6VhLeYCCbSu/A/jAuHaYuwjgKSm6
 b8LddOYuJzkzJyFBPQOAzlVC/GYXHDjkEEcKmI6PbRInc1MOHAJNQM64BzppKPpMFCprbQMQCk
 NJCuTx7ubt9zl+uXwuj3QxNIoi86FOPr39pdY2f1JJ0aBqkYr1VglmRLnttfueTRjT0o68Z3Mf
 2VeZCbAyprVwjZ7eV3XD6GXbMT3AAAA
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
 arch/arm64/boot/dts/qcom/msm8976-leeco-s2.dts      | 441 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm6115-xiaomi-lemon.dts   | 497 +++++++++++++++++++++
 6 files changed, 1386 insertions(+)
---
base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
change-id: 20260810-next-patches-6ad6d10077a0

Best regards,
--  
Adam Skladowski <a39.skl@gmail.com>

