Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BA39FCD7
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315240; cv=none; b=FFjK0VH0KtarZ3dufyum0NKVaQgQ24/qFO6IieIbOA+lb3Gm8qFOp9Fdgqir+7u6GXJVS4BD5fSotLjwg8Y7Ugc8WRWqSMmZ68uxqi4dTTOBrrPCOjMNLp5SBcxmGTvvuGGMuNmBF8L+lu+009i2lVW7FgbandKOmYq1td8sZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315240; c=relaxed/simple;
	bh=GtU3BwmWr5r04fdNMr2P/dLekVQQQO6qKHal+CTJ5SU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtwHFHK0YeBHSHMfgLGUHFeO6KBdthIuj4IjxkJ4LRSvfvcvGXajP/7w4rvKuSrJl+QPLJHfbSpd2kNYTZQzEFFnTgyKuV1FG1QF71c3sn2WKB0L5oNvVswKWhmDyhXBSTGRmlen1+mVicqaaLoC30npI1iHnr9gPopf+cWUaos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh44Q8F/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh44Q8F/"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so1627046a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315230; x=1787920030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fqnhzBAbwr00r53ZE/i4Zlj1u/RNPOU76CLxr9WNMu0=;
        b=Gh44Q8F/aGr9Z+qNKKT5qVgGD7vofHTsL0luUcJEQxfd0SxSbnmPd/9uD7XtjOEfor
         2cP44z+/tdmRsGP7Mi45z8ii/F5Nbd3WkzBuIpY9UkuZ6lFmQUxCEQfeF8jF2mq52xqO
         MGrHFWTSX78Tj5Tq3jSJAItDVdA9RjAfvb6O0rxm3wPrQgNAt+JluWHq88zs6BhJ4/pw
         4yhXxt9Zirm025L0OvNJaTUGJ+9mpIU0eZjWjzPA41fcs7f8AvtNP8tVzjg3hYiaBmR9
         7092eNoDT9MDxQIKeOMT2IdnQKO1Jb1vKh71lvJSHnLbQ+RYsAJtILquZd3XV1LkpXx8
         vw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315230; x=1787920030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fqnhzBAbwr00r53ZE/i4Zlj1u/RNPOU76CLxr9WNMu0=;
        b=GQTrmYHCf+OCPalin9xi5IqkIkPpwRRXR+WzuRlDFHymtAdavFY/m415gcomqd2X4O
         ADjTlVRkcu3sybItA63y7n7z7aWC3DlUIVY/hS0/bgBhgkFy2tpiTmqzbG1Wo0HgOO4L
         a2E+t1EeQ/Rkl5F68e8AJ8mCNIzkPmS0oNOfZaIOSyyFCphMkl4+QxujK739eBUJgvjE
         +4QE8jfEOdcAhQbeaOblBIsRuvPJumPCVZmJWL71KwbH0V+ssSfvp37X8X/EBXO0wR9i
         IYzfAkMVo4PO0jqYkuR16uUiq5jqty7YdVp1oOWbfmAzXdASVeabV0z76qsAYT/91HCr
         KrNg==
X-Forwarded-Encrypted: i=1; AHgh+RqhJ8+mmxFkMlTGO5WswNfTdG932UVsDuvqjJQmohlPX1VnrQD4OCxTorXy8Z8gKLAr6XnrVz3wt6fXBdf9enQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lk0I3FgmMC7kRZD9VuMAMhKL5EyXXlDHrcqoGf8ywd2hIJcVcu
	a2B7eVxPdLq86OkN5yBJ1t8heqnECMFQYWmCc2kcG79eRyhlxZE3OPbM
X-Gm-Gg: AR+sD10TypVjWxyr90dzLVa2crcKp8W8yF4jItFWaxFq4S34rJj1h9V9sUalZs8C+Sp
	Lza343zs2sOwzUfl9HJ68xavkjWkx9yRd62uP/CGBg2psEfoHC6PcNgd2YDcsavedxWPkZDFYbk
	kiswJkshSUhXbt/CShFcxohtUR+o4pMhZ2Nb1LMcumx6gFY5zX5e0PLn4IRwJRyBVW380Ay6e9N
	8r6FFgzEwmk3wdBdeTBX/ZBpr2eXcn8Ki3I6C7VnFLHmWBfoTvWylm5DACU88sXjh7OQzo9kciv
	9MJmnsv6+k1u+HQLZPx2BeyBtuQGqWGU6sMWlnTro/47u6cSnu1/+DefxacDmxKzc8Jmosm0q80
	rdKDZNR22uBWAVRPZBH5mJE5QV2mVGJiiTM8FO8++mOdLbC2km4j1YSlXb50fYeomWcKCjsmcNg
	cexCZZshYBRrpeJiPoXvhNcEY2MnVnHd5oeYkNi7zLRn7vCSHB0OTHb2pjxmVCfLSlLdxrP4kpZ
	geplO5www6ZtY73t961OyumiTIJbmfP/8x21Q==
X-Received: by 2002:a05:6402:5042:b0:6a3:eb58:dcfb with SMTP id 4fb4d7f45d1cf-6a42f1ddad2mr6350361a12.10.1787315230209;
        Fri, 21 Aug 2026 05:27:10 -0700 (PDT)
Received: from [127.0.1.1] (83.24.178.112.ipv4.supernova.orange.pl. [83.24.178.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c315dsm6220262a12.9.2026.08.21.05.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:27:09 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Fri, 21 Aug 2026 14:27:01 +0200
Subject: [PATCH v5 2/7] dt-bindings: arm: qcom: Document Motorola Moto One
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-next-patches-v5-2-ec81cee63e09@gmail.com>
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

