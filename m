Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DBA3A8E6
	for <linux-hardening@vger.kernel.org>; Mon, 12 Feb 2024 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743425; cv=none; b=oaOfXG9cIGlUdNlTTY3VbFfIuhtBZNEiRlrWR3j5ACxTzG6hSrA3LPHkcX5iYLNt844/fiSPXkYYib35TRf0yBvlMNgdepORm/RnaR1HZE2eoA2AEkRCesdfcsncLFGuZzvoKXNbTXTmKeiKiEjDY5ilvo+VwNJJMzVbFNwdUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743425; c=relaxed/simple;
	bh=q26xy0RgLyg/jgOoRIiuTBV+Qq9VjOt9WLdRQMJTi4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwwmSxNkE0wE3hGhje9jQOeo1Ivh9MvWOps7dWbKLK0gnrRb6K4jkXR/RepXfgWyyy2Y2dtNGAQtBBYh0JsVpPlXNV/FliCX1ecOjxJso5asAoLUOjhbR0TkTcPxiTVk6Ln0+6QSDkbyl/3Z8YwiYVgBYLdXuU4WmA5qg6ZvVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E8YxRtrK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E8YxRtrK"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a389ea940f1so331706866b.3
        for <linux-hardening@vger.kernel.org>; Mon, 12 Feb 2024 05:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707743421; x=1708348221; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3YxY7MTjuSd/BMOvzsAl2Om+NYqMFmRsHTZC5B3VNs=;
        b=E8YxRtrKHu4GsVPk7dWujFuC7ucGyChgwrjA2QGhqrkisyCzfbX++KV732pbU9K1as
         Z2Culd8DEohFVWLQaDPgoDP1lFPH37UXwXHT2TUPctDDBRqb/uARSnLDmw9Hv0lTyhae
         5WgLDhjrv7XDhD5oNqTPQboqTA9jHMvL2BU0QpeyEqMu9k4er7oK15A/wp80AgnbD1DI
         mouiLWV0wkTN2yN7MSO7mAdm6aY0ZhylFyPlBQiCdlAA3PcE8cX/4qwmeojDx6f4jvRK
         MyOHNgoUQo8nhhir9gxzkszvOV7iyuIFqGnNzrmf8tkMRmJAVwTSiV1n0msIKn8EOlHD
         ntvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743421; x=1708348221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3YxY7MTjuSd/BMOvzsAl2Om+NYqMFmRsHTZC5B3VNs=;
        b=MUQ6NwvLYKwrDq54PwOstzbWUD8fS9ai1oHU0PM/5QwebouYf6BgdoswxmlPNiu4js
         61Yq91mXgp5D7FZH0QpOYgWPB6H36hXJEYdmJ/zxXW7eKPIn8z7PMWU4U6Qv8nm5UtQX
         NvswTsWjoAEOjXbsbW6uLqmMONSRhCMhWlyaFE1Aw+4MOGk7KIq+jo6wm4MvXFh7a0GH
         Md/Ej7lSKrDZkGY7OSccdWdID2MJn3Q2q8x8AycwF7ys338df0Whge4QcQQqeD+oyfXj
         qlelf/PjD3RPfHWXyFH6bpr8FnXAgGlZwmjjfcnQy1R+nbh9obFSmku7jpk29cgZC0Fs
         6vkA==
X-Gm-Message-State: AOJu0YwlSvdqeeETtbfhbJ3gq8Q35eK987EXGdUmc18gVA+m5JlCPtNf
	f1t9vCmuvkfqgmwxcawLa5SsjLwyytWTtLTL07/TkmWOh6EzXkEgB7+BYrRrDPQ=
X-Google-Smtp-Source: AGHT+IEs9wj1jsQKzm/kk4U3j9kxrPRagZuV0hgdDTKxJr6XhT94I8eZQ0Zsxis6PXUyOtgQmcgTDA==
X-Received: by 2002:a17:906:3552:b0:a3b:fe76:d666 with SMTP id s18-20020a170906355200b00a3bfe76d666mr4896870eja.0.1707743421644;
        Mon, 12 Feb 2024 05:10:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvH/ndhym9RY9fuwwtB05rpHM/ses9iieVGa45q7+ykdMChxwx6aPkrSYcNBkRQxhz2wm/QKCaTWe2cRrH6GI8GEuRcEEo96M/nhs0+KCOlfNUJOEpbTyPMnZxYN9aeCrtche9IVMzxenHzZQOmcMgiPLbPLUWSEdeaPkv+isL+lSSm8nl7A4UwKxvj/cuseHSWCLUWwAFk1HqfyY9PZqpnJNGOocr7HXf/E3oHUA1ZnWIQRWaRVamnwi+z/RO6wGsyksyarGyV083TyKNR7U8ZazwETqqws4S4Hlhro9F4DGCeG+n4NZdkpyEqCaGDB98ipXinJ2mXs2b1kpceSOEJyP9gs7CEAboF2FDVjNqn9YcQvqAAb+yPTV1TCj7GjBAy4lyyZ2TjIDx0k+Wkuuaco/2OWo/my8MYK/m2JFkNBqS3RLvOV7kE3QnGvam1J8SMYPrvTqPfGA8EFGmZzVQ4gcHrmFnoDUpJI800c3A+dAtFPFqLLczxCWM/hphB1PmqwKhC3Gq279Wlp4SFtstmRMJSVvVJXtNYnMIlSDF1C0WJbWdgowbB0YxdZQZvfgy7/IVbePQGn32mJ6Xo5bonvRQ8MGdneYbl0IKH3cWwmZ0QW4d+tN89VenVrDUxVOcaB0bEkumWC/ePu6jFAV32DAxO8EgCqGj3Qk2XhqMiKtAYm418AuHsiPFBD78K1RFhheBNNhjds9fqjoBS1kOWgaelb2k/Rnv2Mab1eh1P89UJlozwjN/Iuf3ZLUf6UtE+MAb9z6MOQjfS/PVXOgFhW/at2SDaTnc9i7GBkg0GAvXMS2/j3m1qvBYzCuulZqKFaakYdgFliFmvT6m4gPbxEfu
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id gz9-20020a170906f2c900b00a3515b35be4sm193052ejb.104.2024.02.12.05.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 05:10:21 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 12 Feb 2024 14:10:10 +0100
Subject: [PATCH 2/7] dt-bindings: arm: qcom: Add Xperia 1 V
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-topic-1v-v1-2-fda0db38e29b@linaro.org>
References: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
In-Reply-To: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
To: James Schulman <james.schulman@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>, 
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707743413; l=706;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=q26xy0RgLyg/jgOoRIiuTBV+Qq9VjOt9WLdRQMJTi4A=;
 b=KYsGSSNWcJwe5h/iFyeyuB0SBVNLU3N7Eo8waXvmIVKJb2YHFeJiNM4EU9aFNIkrtTVvM28tU
 CKrhnDmIQi2BSI+XWRZ67t5oEwPB5bMA2wPoetf9mZg1Ml+J6b/fBjF
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Document the SM8550 SONY Xperia 1 V (PDX234) board.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 2b993b4c51dc..fada660257ed 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1002,6 +1002,7 @@ properties:
               - qcom,sm8550-hdk
               - qcom,sm8550-mtp
               - qcom,sm8550-qrd
+              - sony,pdx234
           - const: qcom,sm8550
 
       - items:

-- 
2.43.1

