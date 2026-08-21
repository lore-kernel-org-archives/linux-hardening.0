Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0A470126
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315240; cv=none; b=r4E9TtzSvn4vuULpeKID6/H+xrUfpdJHq/tJq3lNahGNAzynK9fIUvxoRDSJhyzwCymUr/fctZprKDGKtoMPsnzyn92qX6jE0cZ3VrAzngUebct2/FUyVsj8b7kXaGhiunxM9jhZADoTEox648tAv6ADVhGTfoSz7zcKEuuW6Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315240; c=relaxed/simple;
	bh=240qChyaHcgAIrUoo9v0o8NSZCJsliQZCuzI/589blE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DWXah9FZ9IrTnpFIO9ir5qX9KsOVgpW2ejxEQ8CamUReZcJniPgR0eAJAK00My8OX9rcFX08Zvy9zEWna3/kE3S6u+bQ7H01xCd4P05rhcp0tVhcDcwdEyg7G071RBhD5ZZpB29KvzCJIg+WF0DUGjz52RJbJyLq2juG/lyxobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH/9Tvh3; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH/9Tvh3"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so1944681a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315233; x=1787920033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=neXALKgIPT0rUNWxa1mqzXGbgJQcvVkrR3q/lkeSSa8=;
        b=XH/9Tvh3RWq8sKp5i+CXjg9SrCLI94lPXmaccvma2tqxjlMegRtSo3m/C96kzQ2SPZ
         V3Qs6EsR6zbj4v1OfNq0ZaUB3KFKjITxYzqX5z3KrZeuSh9lEmy0lnVRYGpm1JSvcyWV
         G2qmLWVRHCJDsID7iRbgAMMdZ55kgyjvy6XkhHSNxCwQEemw6PusaJr4gj6XUlmg9Jh0
         Aek1N/0A3itkQt1TOvMihV/x+ZqgLzA7IGCh3/BlvtNNW5wfhT7cwdaKhg9luHIqveJT
         LoCxeehDUiaYOYaTvxNiaiHSbqfDslFDDdajRjV8NInZpRluGiB58Rg53YXTENr/ItBa
         Eb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315233; x=1787920033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=neXALKgIPT0rUNWxa1mqzXGbgJQcvVkrR3q/lkeSSa8=;
        b=VHuF1RZ6ti0VvEJuTubNnt+2jsoxO51yTCvuaVRV+6bCtu7tabZHRzgyyEhCpGf2GY
         SdEG0LAatuZsLclUPMuvNAsofXpwTvjdtCX1CCPP8osjINcQRmF53FkyomKHGwl9ZDB3
         XqR5eaDGtj2t8khKlY0ixNT0wDAKoH5mebV2XkGTGLM1up601TCq63ilir+uUfgUuQ3q
         p0WWpbG+1rG7VY40PhRAMJHfmtgSO+E6dpfgDEDldglfR5VlrZFhq3XfiDDf/QnwbUpd
         nB8aBZRiTJJW+sbco95IULcFy3/Wa/1IW8/vLpmm0DH3NPvipkUvPOm6TDS75XYQbmWf
         KSYw==
X-Forwarded-Encrypted: i=1; AHgh+RrXBlRyrp3eZT3Rs4hp7/TKKtsZuTpT90ZJk9XphI7kQNX02GjWRxJU/6RSF1QXsd7n38qDTWGF9/8y4anIIa8=@vger.kernel.org
X-Gm-Message-State: AFuF++ksTzREnmxVurqjPOSojYH3CwlP2Xf0HSPTK/6jp8Vw2tzGpmKn
	ADP8UyeZXKzdEtnTX7HbjVwjJXOTMdpoNdGOczV2dylkm/tJ3H9av0qw
X-Gm-Gg: AR+sD13iTFpYzGYzXZfZrOVscl/MMkOaCapPDKlNNcXieGsRq7sacp75F/94ssh1GbU
	f4GR3ftUM9EfIiKz6CIBbZmpCeNuaws8WwmJvns2EyTynruurfx3MUG0lBqsm6RjYpRgMAwQ/GT
	LwiFRMFv/EO3UhKKPdwcW+oy9H48poXLpLbsNCEnW9I3PjYDWg2/zKdNyTSBm6IOr8jmr9jQvp0
	M0HqyX1pDTCjiwiYJaxEzruCcDXxTnHcvSDd/ZP2BT9M90NJcoQNuzlMK18hOD5riFHhGPd4dL2
	oRnTqffQvHnZjQNgTKG4LtTlxdPhqof2feLE1Sq4NKj4fWI16x7oIwq3TSOnoHDW5QkW3l9PqUp
	8IOnFUaVOcFG1TfwgYiGQjEg43rlwxNwT+VMHaUIaa9AVI0t3PPYNfsmshYRI3v3I8fRka3vRiq
	CQX6KayDqa+4fGXnXG5i9azHWP6RApiRCM20s/cX4h79EnOwXj9E0J+3fUzGkTiKOOMrGaHV51o
	2zoit8RSUqd8XgSyiFvV3jPtk0=
X-Received: by 2002:a17:907:8dcf:b0:c20:2d38:e518 with SMTP id a640c23a62f3a-c246a3080c5mr730710566b.2.1787315232715;
        Fri, 21 Aug 2026 05:27:12 -0700 (PDT)
Received: from [127.0.1.1] (83.24.178.112.ipv4.supernova.orange.pl. [83.24.178.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c315dsm6220262a12.9.2026.08.21.05.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:27:12 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Fri, 21 Aug 2026 14:27:03 +0200
Subject: [PATCH v5 4/7] dt-bindings: arm: qcom: Document LeEco Le2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-next-patches-v5-4-ec81cee63e09@gmail.com>
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

