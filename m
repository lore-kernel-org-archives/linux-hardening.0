Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9463B1A4
	for <linux-hardening@vger.kernel.org>; Mon, 12 Feb 2024 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743430; cv=none; b=c9UIrIcvUUAdu/EQ/Fnpshv/j2rs1vdWteHE0Ka9f/6AWdusWzfpAMq0I+aGNiTo9zrh/QilcEQQBWkalQG4pStZR8io7TlRX2Nna9FeV5fZ6ONj/Xj6Sek1T+WeaE8WMT9LjqyMB52ML6rjnISYwnKwDZH+ayqtVUgT8fSqTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743430; c=relaxed/simple;
	bh=kq5j5a44u0i4ZLViq4Vc2kh0Xc0OOLzaeXziNYe3I+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1gMNS0xjwcdipsMxGRSkTUCIcCgG1qNTMUM1Kvig9GA3PgicDgDBLYGeH7ixmXiOwsSTDGjOjWg7PSlbu6rQvcubRN1loRshjykazFkQbukmP287rWzz7x/xwGmVghPivJfxaRI9uD3wKCGHHtSXwy1nXsiw1E3lcCLX2BRj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rksX0ZRb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rksX0ZRb"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3c00c98d32so360942966b.3
        for <linux-hardening@vger.kernel.org>; Mon, 12 Feb 2024 05:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707743427; x=1708348227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWYcyGNfIFLRPx4pt/22DjIYJEdjPhLiYl159GLEbQg=;
        b=rksX0ZRbjvJ6S5QkVfUAR6yHmdm3TNZ4AUS3wlXA//Lh3RjQ0QNmX4wG8kEfooIr4O
         TubAwqxXuge0dAtYlCsvq6XH0NA8cBLleri3VCxcFfUSrmQpYAabeUnGOwe+8Rm4XPnt
         TPiBUC9YPVOPVRtlWupP5blM7bcEEedrplsuL1jPJYbMhwBQXbkQCqtcDYqzBWkkm/cS
         O9JiL6SegHrLMd66IioR0wd/8jPfZ2a0bIq90xq6OrNlIqcCypg7eza/nIik7J+DiU98
         J7QXP5uZgOQOgqYQd6wZfsTHHdRMZ/tEud7g+KP4pmM9vpbr4ZK3yveUm3OZM2aAAjZS
         tAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743427; x=1708348227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWYcyGNfIFLRPx4pt/22DjIYJEdjPhLiYl159GLEbQg=;
        b=D9YFz0OSVXwlpbSm6elqlFKpiCMXseA9Q08GxHez0h4SNLUkc17Wcr1rxnXYEe9L7M
         7W2CtQE0P5Q9ck4XDFxCzEPnDOf7ksSjTWXQ+aaMR10nnDwQ206kLabnV6GRYtZKoGkU
         ghMTtq1FSHynrJtl5PgEQvahaMYIRLDClFiCGKnGZuQypGWLgDh2ptoGOsV23PBqqW6t
         YO7T9PGhv2Cj7gwEXgqYExxwRAZG/st4r/Lv0Q1ttJO8x5sCRu9VZjbQB45RkA8FP3fO
         iH0DjDJZdTVXLqrrgpcsDJIuHiWCgjWeDYGhyHv4zu65gHhzEPdIJCuToaUGC/H/S8Zp
         5LIA==
X-Gm-Message-State: AOJu0YwlBbe/EdPy+bG84+ooCikzSuBnpt5sNexliHOcb+m6rRCljfKB
	HEHTboPrYTRtsyR5P8oy/+EvYGofegOmYcRKHprriAY4h1Q8obcYm33o4sKZrwA=
X-Google-Smtp-Source: AGHT+IGFBRNSSJxs1RXogQPC+HmdRuTXUKjjSrq5nznzwQO4T+zFDp77bIblvfKfXm6kEnZ2FAD41Q==
X-Received: by 2002:a17:906:29c2:b0:a3c:770:1752 with SMTP id y2-20020a17090629c200b00a3c07701752mr4218831eje.68.1707743426912;
        Mon, 12 Feb 2024 05:10:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXuCyaQr/W8a+C1M0E7AVq54SBy2u41vHYdbqFfYBYFbzSAeUsaZGW5YroQozvht5zf/so9htC64gtRC7DKItXZfNf0IHOaR8Jn1DQaW2BL8ogkhCi9c/6BKYjEEDGdMbOSX2g9W8DNOxhDn9L7fSOl7fGY4ZE1gXoTjnAJSZs3DEXpIzx5OyMeBidrJwHu9cieHTa8zRfKUI0bJwCod59Y3GeW+vloREbNWN1HXWVnapH6X3a14N9eiBxyCgxu7VYzCJpvyaMZA5LdX5eMJtHWittgwUG0cL/k6HjbssktBzpt+0y8Pc/q4Durxbk4KXmwFZZLRhz8URFyz7vsphYPdeZt9D7HZaV3JjwWRNGf1gFdsjMrrqLPwsjt4XAK7v0dc4MBwaCPhR3yenyXnXTj/oE+wLio9+4JVMUs/YLxuCklZSNmHkANv35Dx30khK6Yx81FRZyouEwZq5byA8MvbarzQWI66Q5ppPY3weaLP6/r2kxvvHMbln90lIuFV++x4OV8h9lExFhKQzNCDLVEwIcxbeQEX10VqiZGVGARWKGQJ8riAjg4KwSIgSI+9STX/TrXlbLNv3KoIBmSHsblQsqU7zK2TpgU7u3rYbnRBxrG6MnvAWLeTB32HCHF3GwT9f9k2AxWHPrV6fc9n4gdt/USEUkN30clb2/G72dJV7zkEI8OvI4HkmpNCLm08Gtxi900nHobW3DAt0FV7VUdn9fhgMvaA3NEJwRW66pNQx68zZI+L+mkIwak0K9YQFt3WWeEB0QXf8aiCSNlzK7YXm7bv2lYMADU7yDiBQrG2EytArx+k6h94tHGa6isATPbiRMzDy+4I7pFrEkTVnAMqLNq
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id gz9-20020a170906f2c900b00a3515b35be4sm193052ejb.104.2024.02.12.05.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 05:10:26 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 12 Feb 2024 14:10:12 +0100
Subject: [PATCH 4/7] arm64: dts: qcom: sm8550: Mark APPS SMMU as
 dma-coherent
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-topic-1v-v1-4-fda0db38e29b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707743413; l=787;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kq5j5a44u0i4ZLViq4Vc2kh0Xc0OOLzaeXziNYe3I+w=;
 b=4KH+YyPNIYKyi1m0IBMqd9biATcIsevmXT8PvZFoSkc51AMiOSoCBGOHDuTdwZFHd4B9pthVR
 6L3X0T8uOeUAwa1aXYa1+fwU//8FX/p328x8Ieq5xfqSZC1Ge94bOb9
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Like on earlier flagship Qualcomm SoCs, the SMMU is dma-coherent.
Mark it as such.

Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d696ec6c6850..868d48b85555 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3934,6 +3934,7 @@ apps_smmu: iommu@15000000 {
 				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 		};
 
 		intc: interrupt-controller@17100000 {

-- 
2.43.1

