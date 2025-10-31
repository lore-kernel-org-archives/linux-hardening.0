Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7AA2F0699
	for <linux-hardening@vger.kernel.org>; Fri, 31 Oct 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918962; cv=none; b=AqRGCWT8QniJNU8FWH4nfMbwk+Jb6Q5wBX1G+/Lg3QYEFjgG1Fl771ovzniKRwOCdrPZgFW+ccizArWprHCm20lEaiblcHlCXAu+UdkviAjj3qoX5FLBLHGo7VJg9oxfgQaZRiSbVIA97IoaStLjlSK+QF5NSdGJ9+pYpXC/7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918962; c=relaxed/simple;
	bh=rv1lakdnapd6shhm6W5A6hAx9wRV9T1vgsYATRaDRWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMMVD+ZuwR6HbfaTnDfDLo/k5d0vYD545dLN6jqbj0Y7T9YnBs4Nvaad09CrFQX7mVyrSXeOYoUzpUR8yfGOioHvh+lRXBpJMAq9PdPHytbbWgikRhExPDMRafE5/rjBdJtVr5gGgQm+sm4jJTWAjm910c22M+dvMDkRNgYCPQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ngo7cMjc; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngo7cMjc"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781206cce18so2675774b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 31 Oct 2025 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761918960; x=1762523760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rXy44YBpbFQ7ccTa0IVPqx57mQ389VTun+ngC3PqvuM=;
        b=Ngo7cMjcJTEvXJfB6Y+GPqQvaCcm4ZJwuykkefHlNxqrTBIDjA26jR4JlXE16EhoPm
         6mTCMQkvtK/1N5hmxSIMbrStNI3DF0VpLmg7S+97H822TuxIpvwJplJqjIKamaT7Oak0
         EAoAcG4e0JyCxdBHJHfSa9phYGy5ALd6KUhG54mkBkASxwrEURmzfSkmixapwiN1/inN
         yEiGPlkYyyr+keJqv0cu2DTPhdDzK0Ets0GgpLe9NbHu/7PQbNWNL/fXzO4oMdExi+R/
         p09tTz7bf+vdtszbE7I6387fWNys4K2YOZ32QAlJ8foTe4zVgkzephO6WhyrkPVYJoC3
         EWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761918960; x=1762523760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXy44YBpbFQ7ccTa0IVPqx57mQ389VTun+ngC3PqvuM=;
        b=EzFRKKf2do+07P994Bl5SnLT2Teb+/0kS7Yeh8XzDid+BRoUbFTKxUF+lexrl4qxfL
         0lw4hZnIS1A3CMYJdD5XWdk1BWh5ZUgFsVEghUDbvT04wfSx6JJd2Bw4kXc4dod7trfv
         XKLKkcNIRdzLrEmcwCVoQFRLdcF4fmL1YmHb37lK21dDtAFVyRfW+/YeXi52tT1jtsaj
         xOCLMh2ZD5MSwFOcUDHBxXw7H+J+LoZIuxkM84OKeKWmYZrMrKzHJUM57XmhvcotYKje
         nbmRaeGlTvcv3IU5GP+JS2ax4aogx7+9hkVWzHZ5aJpW5iW7/UFL8nLgbTdqqc5J023j
         hFmw==
X-Forwarded-Encrypted: i=1; AJvYcCXfg3Lb7Y3FdD6m6xAmqZ9EVTVZd3YprdLckYvyI2aVTFOns//mjZoT09WqBCibe0DcSHvKKgwN3+h9eq3/8iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZdLrI6cbNrkOoP1sryG96EfguLpfDv+jSXzwNo7eYo/Rkc3vu
	eUS3TNeEvnc0eYReJNadesdaUqLb2ewBw73hTTH/ZLMoaPsmwBb7Q+aO
X-Gm-Gg: ASbGncsmlPeeVfk4PvKx7ISWVMGCg8DT6onS7gAmfGOWC5F0Ju1tuwD9i0Ly/r6Q+p0
	/N1Gc1QalYKIzvBqVCcjYYmlXGMLc7nNR7IF4UgE+2iWpSY0yRCArIayNtof+kcaHYwFdxmQXOX
	99M8xHamQLBNKHEo+XtTb4DmXcW4ohBwcu6Xsg2ILFe9TNAlAn39W2kJgjPgxlvWMMPNWNyglUV
	VoepjraSWgqLGzA+Gop15v1ccdbVcQ8KP5kRnN0blzZRxi7ypS9p9FhtbW2lW5X2bSKhB3eZXTR
	GggFCOI+kCIutyj0MJ4C3sDhdD1O8E2QxpQzIGMpzTLqvbIv8GkQ88yP/jKRIzyE6ez4augH3R0
	kMN8UTgv1r8ufHKJgYXaOAY66WQkUbivKL+SVLgErRm6M06K7fABgBSnfMzyUz9ICXh+x++vX0/
	LYuhbAqzY=
X-Google-Smtp-Source: AGHT+IFa+KtYs1Qd2wH4XD0ttk5HSiq6KyawmAxwbjG3Kjo7lM6fGlhfsK3Z/0aCWFdV/RCWUZ3TRg==
X-Received: by 2002:a05:6a00:14ca:b0:7a6:9f96:966 with SMTP id d2e1a72fcca58-7a756473a05mr5078674b3a.4.1761918960283;
        Fri, 31 Oct 2025 06:56:00 -0700 (PDT)
Received: from archlinux ([103.189.130.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d72c5fsm2302271b3a.18.2025.10.31.06.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:55:59 -0700 (PDT)
From: Raihan Ahamed <raihan1999ahamed@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Raihan Ahamed <raihan1999ahamed@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: qcom: Add Lenovo P2
Date: Fri, 31 Oct 2025 19:21:20 +0530
Message-ID: <20251031135506.214025-1-raihan1999ahamed@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible for the MSM8953-based Lenovo P2

smartphone released in 2016

Signed-off-by: Raihan Ahamed <raihan1999ahamed@gmail.com>
---
version 4
- rebased on linux-next
- enabled accelerometer sensor
- enabled gpu and add gpu_zap_shader
- add homescreen and one-key-low-power gpio-keys
- enabled pinctrl for gpio-keys
- removed explicily added tag

version 3
- sorry for explicitly adding tags
linked-to v3: https://yhbt.net/lore/linux-devicetree/20240226195516.174737-1-raihan1999ahamed@gmail.com/

version 2
- document device compatible
linked-to v2: https://yhbt.net/lore/linux-devicetree/20240226094256.5736-1-raihan1999ahamed@gmail.com/

version 1
- add initial device tree support
linked-to v1: https://yhbt.net/lore/linux-devicetree/20240226055615.79195-1-raihan1999ahamed@gmail.com/

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d84bd3bca2010..cea9698fa4d8b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -200,6 +200,7 @@ properties:
       - items:
           - enum:
               - flipkart,rimob
+              - lenovo,kuntao
               - motorola,potter
               - xiaomi,daisy
               - xiaomi,mido
-- 
2.51.2

