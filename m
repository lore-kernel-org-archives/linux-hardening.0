Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED512848B4
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798496; cv=none; b=Gpl48HF6u0cDWj9281q+8jmDIxni4J2gewGjYU+lPoKtKOch1Uoq30WXZqlgCUzQ9c+1Pe0rCrxEqbYD2vPDoK/4ZQEobWLhu+PwfuaYkUK7n9q6sejHLHKZtff1B7Oni72UzfZEKI7gK9CKeZMXpHrxaEf+thxFrczqts4Vtb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798496; c=relaxed/simple;
	bh=xJIw1bAGNCKENGyl7Smzyc8MsigWND1otejzP0Dgs0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hT6ZR7OHLG+0jrgM/eTZfR/YPZHEmDG3KJfOPLwOtEftgzSDeYRyTP7weiI+oSJANa6YJAm+rF+t5QP5fSkFgJaYqC7lbL+Ii2sfrntJcgZ7jPE1joDLVlfmX8+4rbNwdAW9Hl9L1zZVrMmNhRcp+2Tk11DpRC/Cx+N6qWhJn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Drz5Xxv/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Drz5Xxv/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45dde353b47so18525215e9.3
        for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798493; x=1758403293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3eQWTLa8qf+9saHeA5hbj7RQD5lII0deY9ii6lAlos=;
        b=Drz5Xxv/BnnMv3jLlTbBuSXPKfOokiDmndSmHCSTk8jIFRUD++SuYGrhzB7gwZ0AJ8
         s0g9uY8kHpoM6xTsR6K5etO/bueVFHMExpXkU4fuFCEcKlz9Uqi6aDP7JjotO+oBxn/a
         u/tb+b2a8I+z+COf8iKqlHjpo2vwe2Pt1e45WFtLR2WCpu7elYF+ZXlw+OXL/n30Dzkl
         4rNm1mDx1piXImQpVDqKfsFmoKsgDd1imIYnrdryUAG6+443U/WckibvYwqzCoPL5Wqd
         VM9NdQpGAlbxeyANVCboLvq2y1NPespdttxkJTvvvBygWCWolAROSIcd9L18TCnb/YWV
         aNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798493; x=1758403293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3eQWTLa8qf+9saHeA5hbj7RQD5lII0deY9ii6lAlos=;
        b=oLTJ7Z8R11UR9XcXTrxtzZEJGl9VWP96ocXf0uaKmNrRhUFWc2Zo7RcqU26q0eUVYA
         /xDFspPqnRVMY11UPv19u9ePGyG2Ga0SyhMm0SfF/4H5hjKRrwE+f9c9q+wKP6bMZrcW
         wLUu+TU7YaPhgWjwmi1+XizAthYeVrk7897CrOx6s6qrciug8Xzt9YTqgB5+WGJWJ21Y
         48X+4MSwjLZ/e/I/Chk11i/wLzgqbHVe6ls4XBATm9Xi+P/Fp4imM9Dhj0jr0zLRjDPo
         WadkZ35wOitV/zjJPReRcpwmF2qu588BPhXUsxjRsBS2bu9xmWOm+cwMt+q6bJ4QbpjQ
         yEqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDRTdHSizPXYvPju72CKINBMQIGq3OvtzV1L9pZqR63QwFYSE/80Ay83UxwaKC0VgUghbKbYYCNeg+kjGPqoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/3rZTC5nP3FwMto16vdbmcKljgfGIPrp2Vk8k5TxwRNO0stW
	OQ0tw20RsRgCkKH4lNvz10faHUq3yygfg+hSGCK7kMPaL2UsXQ99bX+v
X-Gm-Gg: ASbGncuudGN7PwPUxJbBLICDMKEfscsfL8nwN2QQ2xQMoWzKcWhNe7llZvE7AccT4x6
	ZJZPoq+RMh+2mjqPbNiElVOUmhOnC6t48M6AxCWRQm3ZiMbEsRwV2Kya35BRCD++Yz1RyfAWdJm
	WkfjZ8GGiCJTeNdZKM7HyaZfa7HF4b9TVREGcSDVx/XWfFngHr11T4k72LopkeKlzXrIgP82Mqc
	hHhu4+NLwee05yq80iHh57UWN2AMBDIpWzzT6qDMa5AVTEQy86Hwy5p7qfQhjJ+XAb/CcRuMKIo
	lBsUrmDVk0Fxe2Ain4Univk9YOKpHhJwZpkfmyJkkNFkj1Hz6m47XPINxYX7jKBIfwlGVp3prGc
	0Z7B2EpXZhpKcVHtqXeWgwZCLRp1VoMOHodCS3c6OOEbbPXQcjwoo
X-Google-Smtp-Source: AGHT+IHr8CiMYGUEeTiKYHRRsxQhLO6JbPn2EeOKGS5jqS2eJuGZcBJj8fDG+9B8XtOlMfD63jhKQA==
X-Received: by 2002:a05:6000:250f:b0:3da:936b:95cf with SMTP id ffacd0b85a97d-3e7657a93b4mr7806706f8f.28.1757798492558;
        Sat, 13 Sep 2025 14:21:32 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd6absm11576842f8f.34.2025.09.13.14.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:21:31 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:21:06 +0200
Subject: [PATCH RESEND 4/9] arm64: dts: marvell: pxa1908: Add PWMs
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-dts-v1-4-8120cdc969b8@dujemihanovic.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=6njTuJu0UcIU1bHrsjDWk5PZ/WvBeIzNhePT57xOd78=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlHH/j/9Wlu0tA/HS04WXhf9ekl35iYE3dVPO9++9LNc
 NlCRpaKjlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZjIgxOMDEs7c44qKm/1nBH6
 4K9KyWyzKecW3JK8+My2/cC297a8Z18x/BXezh6Wsd3N7UmozX/JKU4zAhUM+Qoyj+vnp7ZzeUs
 sZAAA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

The SoC has 4 onboard PWMs. Add a node for each of them.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi b/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
index cf2b9109688ce560eec8a1397251ead68d78a239..61498fd75d1dcaf0d068943c1ac14d3e5a7ca9ae 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
@@ -195,6 +195,38 @@ gpio@100 {
 				};
 			};
 
+			pwm0: pwm@1a000 {
+				compatible = "marvell,pxa250-pwm";
+				reg = <0x1a000 0x10>;
+				clocks = <&apbc PXA1908_CLK_PWM0>;
+				#pwm-cells = <1>;
+				status = "disabled";
+			};
+
+			pwm1: pwm@1a400 {
+				compatible = "marvell,pxa250-pwm";
+				reg = <0x1a400 0x10>;
+				clocks = <&apbc PXA1908_CLK_PWM1>;
+				#pwm-cells = <1>;
+				status = "disabled";
+			};
+
+			pwm2: pwm@1a800 {
+				compatible = "marvell,pxa250-pwm";
+				reg = <0x1a800 0x10>;
+				clocks = <&apbc PXA1908_CLK_PWM2>;
+				#pwm-cells = <1>;
+				status = "disabled";
+			};
+
+			pwm3: pwm@1ac00 {
+				compatible = "marvell,pxa250-pwm";
+				reg = <0x1ac00 0x10>;
+				clocks = <&apbc PXA1908_CLK_PWM3>;
+				#pwm-cells = <1>;
+				status = "disabled";
+			};
+
 			pmx: pinmux@1e000 {
 				compatible = "marvell,pxa1908-padconf", "pinconf-single";
 				reg = <0x1e000 0x330>;

-- 
2.51.0

