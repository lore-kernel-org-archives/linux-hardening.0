Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0CB48BD54
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312212; cv=none; b=SW/J5/tQmHti8+A+xpWHLdRiuZBBbHiOqpuVRBULcclJiRFhfAMnw2uhlT9HbHw3jalRvIJ+KmveEi+qH0NZ3Ya16ljU7XHXwXJatvrESaHe79GX22HqqCr+NM3ACllmVnspuUlaxqE4/sJJmxOr0cOXIH6M5PbviFmVaYqM510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312212; c=relaxed/simple;
	bh=240qChyaHcgAIrUoo9v0o8NSZCJsliQZCuzI/589blE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5WWIStU5prjX5Js8GerLKjA5dnyin+zK37dQSBpcsT1nmJPuvL+MZGURqdXXuu63VvBH6FoJ6CRwcTieebgOXKOlHGFReDhrk+lRxq+cHwKhehyASnPUXLIXOPhvj1QQM5M8Zog6lb0bPZEahJPs1lu3n5gvugmu84RyL7RH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPKYVMWq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPKYVMWq"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso1649145a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787312209; x=1787917009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=neXALKgIPT0rUNWxa1mqzXGbgJQcvVkrR3q/lkeSSa8=;
        b=HPKYVMWqdrlpxRM4N4RNK6ltl5JL9UdDQ5hOqltqiGSeQ3HknGVYcQPX+fPaK1tWqs
         U/rCJu+RWn/L4fOdNnAR7Z1/qqB+uHYg+WV+ju/I5kN5rGlVRw/xosHPKkRehth+Oqj4
         1IKubAhmh2FZpPk4p4cBbfrG1Xccf8csw12j25nF+8depk8X0mDQ2Jd9EM9mzOfRr5EG
         1qqdRw/XVGYaoEXMoyZT7daePyGbT9P0NRj0s7B42S92MWow7VfnaGMJzvNxbRvYwrYz
         rJgOgRA6Nm+YaAW97dXZE6aTxB3fkDRRXOZDeLnKDMZcGhGbj+lduAaCHn/r/GvId8iX
         NXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312209; x=1787917009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=neXALKgIPT0rUNWxa1mqzXGbgJQcvVkrR3q/lkeSSa8=;
        b=pzOYXhsCTX+/EPrbUaaAb7s0dhhg2APyC9qZZ5RxFPKzfk/wUf1xVAHDoi6DQBvbyK
         ylgaKXxS7XjnDMzKJIHSAsU51xTcjSxJeh3E6OBJisOTm/9PbZlDocNiBW65O3kYYZQt
         gXecBuA9favMbXdRPRkY/WHr3kn4VWMdiOOFX9e0SdcDrNy6mkv+/+T1Pngipqb4CSs5
         PyzHlBxST5GQcAlvzra45SOSEpsq3ZNq2t5NgqDOmnNJqB8STRYNRib/QDEIGS0pKT0y
         6VHeTY5em3dfIWtqLF9qanm4gyD2GYKitqWn+RH4ilqQytsmCRdt11A2kO2uzT58bFWR
         6TXA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7xwlZ+rprFsANMVCgzPmi03ctdb3pBEr0yp+NHHpE/JUkzOGI5H+brUMB0i1DWn3u7d3sEuXNetEXf3b680M=@vger.kernel.org
X-Gm-Message-State: AFuF++m5nKVrRq3Qji2ZGCEtSzblCt12E4cw69gyE/Gv71B+yevwHYY6
	tE1riPCmvA/7XC2OxW1RBBWbCyTeF86RIuAmjvFhmRUqjDKp2k0/AcT9
X-Gm-Gg: AR+sD11FI7aSvcqq2IX9auDLu7LGam8NKzjIPECQAsPeZ2hKWV5pjdtynOhK0V94WBx
	4TKWri8jijMWmHXH7YC8QVX+Ug7ObIKc/vaC7kGgn6cQ8WicmCFSRrA6i3G0X/LkBw5Muo/bJF4
	Dn05XGlB3pNj/wlb1v0hOosw2guwpo3ZOPWG6+6/GsHDJ9y4t1un0NhiUTb1qdRf+gS4YCXkCx7
	wHQ3GrbLEceJc4Mf12z00RvcTNf+qp8zPRK1KuS2rzpFBjH0yY5Knj8rk2IA2cjm2OGVDHJVWxB
	wt6hyfSzoflWjwUxd68Hht2uzcdsiAB6KgTGyMY2mKAlN0ZusUVbQ7TS/OztrkWEseOvBJupWyK
	iLUigu1+pv+vpRsiyrBUChP23J+U6hmIOEqWKF4+xIXybcnE2flN/V14fWt09zvLdiuv2JJRBlO
	0D4XXvHsC+0vkEfNcdK0PvWPOM4OrJrrcCd9OXglv2mRi0Z3bRocQd30Yd+RHR30KQpf1EXJKt4
	BOaq7UccHFwhnH2Hv9NTyx0
X-Received: by 2002:a05:6402:458d:b0:6a3:87b7:b5a9 with SMTP id 4fb4d7f45d1cf-6a42f1f9d6cmr6197996a12.12.1787312208743;
        Fri, 21 Aug 2026 04:36:48 -0700 (PDT)
Received: from [127.0.1.1] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c3491sm6204661a12.10.2026.08.21.04.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:36:48 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Fri, 21 Aug 2026 13:36:31 +0200
Subject: [PATCH v3 4/7] dt-bindings: arm: qcom: Document LeEco Le2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-next-patches-v3-4-cd64bcef6e21@gmail.com>
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

Add compatible for LeEco Le2 codename s2 based on Snapdragon 652 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 289a3de1d24b..68542f76df30 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -348,6 +348,7 @@ properties:
 
       - items:
           - enum:
+              - leeco,s2
               - longcheer,l9360
           - const: qcom,msm8976
 

-- 
2.55.0

