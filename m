Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3992400961
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218979; cv=none; b=InR993XIHnSn5MPqgvbdi6/ftgCUrGLR2oSdWFZzff5YoFFy+UrPJy0UxedD9XLrrW+21PgIrGo/9HE0DC5LBlGgGF/e3c7nMm52yQeptRJEIe04QxVR9Cjud7PT6l27WRhaGe2VhFGTIzE/hRjdCbFzt+O+UU0Dw5sFcUnCPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218979; c=relaxed/simple;
	bh=240qChyaHcgAIrUoo9v0o8NSZCJsliQZCuzI/589blE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bauX+XgQ9LG/fOemUfvKe/DTjXB7K5dj9Ty3J7ovwL5r/SOs5Ch/49kc0TcSXTtVYM6NKESRy5AO0SGmV5oBaCANsXOOkItf+XmoYqT79Smjv3ttxxplFjDcGG1tV4U0MvYgSPZZdHMnR52Jmqg0QT2VqiDi+5dgvUElLBg2Gbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1BnZDy/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1BnZDy/"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47362928f65so1936980f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 02:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787218964; x=1787823764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=neXALKgIPT0rUNWxa1mqzXGbgJQcvVkrR3q/lkeSSa8=;
        b=F1BnZDy/m6QsJN21F+BsPLH5g2sdxl9F/dRomTXbK7efUQikhc7OQpFvYHRcMQspBr
         mZkHd3ibHRzVnQ0/pwAOj3b1byJoOakKoJZ4Ze1hAAEkTzZrC/l7PXxZrmfTnuhU0jvG
         DM+0KpPfzqtekh1UrxZgNXk0IY945yn8LrMQNmtMoJVsSw6dvRlXy89fjS4muV2fU2PK
         BhGh2wDG38/6j+NTjmDla8J3Z2mVDkdlxt25pJv5y64XB5R3lifMcg4N8bDMt6bZoGsA
         a34/7MmFv8SDJWMEnx0aGVCCFRhUFrF+SvBRk9pQEiR0TcxvTcRaAxcUkDv/ilrQ7k17
         LJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787218964; x=1787823764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=neXALKgIPT0rUNWxa1mqzXGbgJQcvVkrR3q/lkeSSa8=;
        b=putdHrHRnPzN6PEYThQzPNeiZze+qqazQfd71lvZ7rqnbK1lA4FpvSLKqI3ln9McuA
         VBVh5NMuDUf0dJSdqwhYFSr1tvdtL9xOZu7okhFJHzuivLD0wjkz3tPqLprUtJFx1CJ6
         OtCwe3LuXDmLv5sweMyoZWnZ462l1YN8p6xPPYAOpl6Q57lMhyzL2xFbfLc1AiVPztMO
         5x0wc670Yyxl5U3tepPlNHrl110eRc9hjVZC+QCWIizawQqNLv3rjqy9KEO+Tf0exJF9
         Y96zfu5TlYpDLUzZpMqWgQCdZSDTtppJQ3tb0v0v+2irhR9Q/qofS8RlZQ8ZIg2hYtJ9
         B5JQ==
X-Forwarded-Encrypted: i=1; AHgh+RodijrUEFEOEIetFEc2qzOo+6/AKrb78W1iybR7XyMOhwsuWBTKEuMih8hId85aqP9kMADHab/wbx25FCQchaA=@vger.kernel.org
X-Gm-Message-State: AFuF++mEwGAxIF+SjShjjPSB0RxCtgmLN5A3c4DC3sX3PcrFCWulAvtJ
	zGk3rJDu5JfMndoaKYsRC5U44LqzBTx2Ho3IEUBMMV+jgoXVtP2Bcj6y
X-Gm-Gg: AR+sD10cZjKwGJ+hmDcXOgVdIXjxD1bjs/Jn7f/KJrdvcjp7W7RxYwmphV5z0Y27jCw
	8g0bYKJnqUGhm7VEdy8u22aPdABmw1Kqih14BB4Fb2r6xqD1/s1AMoJitJ8Ke9/X//bC1cKPqJl
	aUwoMz43Qc+siwYhSRZytbSLuLba4yQeQFzUy1h7wMuE0hGaNV+D/E2UZK315Cfl8/1u/tMxJl3
	NBWeoyVPMn/txlKfq2YAiRBiAzq2MgyKJXWlDzP+tWmXVcVQ4bVtZP5hUxtGoQQb6lciU8hCtRD
	wi3Dn6HZWevOISvIWwLNRum0e8w48zBS55mGjxQ7g0vsOZKPCl6BYQwZvBwFwcGOnkKTtIeL1uc
	RGzLhw0y5DL7CS03AL+Zq9hROUS7sgGdOaT90KgNNzdwsDGMbcQYYUNR8Sgdg+TiHFO9+Osh7eb
	vqMm2vrZSoPxflqK7qFqHPE54SM2xrUV+WOT7PVRhL6h1b8gyc56Xh06elRtxWCUG1qfNNp6Y9P
	L1gLtRKyB5l/om5CCOJntLL
X-Received: by 2002:a05:6000:715:b0:481:57f7:6015 with SMTP id ffacd0b85a97d-482b1e96130mr22568820f8f.6.1787218964416;
        Thu, 20 Aug 2026 02:42:44 -0700 (PDT)
Received: from [127.0.1.1] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b144173csm11788090f8f.6.2026.08.20.02.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:42:44 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Thu, 20 Aug 2026 11:42:27 +0200
Subject: [PATCH v2 4/7] dt-bindings: arm: qcom: Document LeEco Le2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-next-patches-v2-4-7130d68183d9@gmail.com>
References: <20260820-next-patches-v2-0-7130d68183d9@gmail.com>
In-Reply-To: <20260820-next-patches-v2-0-7130d68183d9@gmail.com>
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

