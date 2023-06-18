Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E65AEB64DA
	for <linux-hardening@archiver.kernel.org>; Sun, 18 Jun 2023 11:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjFRLo6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 18 Jun 2023 07:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjFRLoy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 18 Jun 2023 07:44:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB75E5E
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jun 2023 04:44:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-987341238aeso245822666b.3
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jun 2023 04:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687088691; x=1689680691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFYdBV55OCJJ86vmgEdrgI7fkJKCaJKaUvm1YLpC5XM=;
        b=AXs8s0Txd65E96lhJH01MhCi/5B3SZNfeivXk1cCjqAEVXQ8mSYfMMgg4IYXFc4Ucr
         MfVHqhh9bSOnSfTEUWU7G1+LZDwVvWMiWQBMxhP62TEWkhMSXYYQbzd0jpYv/oaeOsk7
         teVCaLCM28hmUWYEGfLfMUFLpU7cXPok4rDnWDhLUYMI0aLOmecc5Q1X6BR0oWIG+KMt
         vm2fEFpUsMGpkurXhGoUeofgMxSi7T7RsBj30Ssds8w6Px5wLMEA28eZKHsGy6x8f8PQ
         9RXa4WT00u1k73Hhoeov+HfUU3ijUv4MfPRhCKxGxHJFfzyWPesfdOtxE1JJwJ4Dc1tt
         uPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687088691; x=1689680691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFYdBV55OCJJ86vmgEdrgI7fkJKCaJKaUvm1YLpC5XM=;
        b=YAXaU1ghnB4xpYUleFWEOd337QQlVf3ofZZBV8cqcSxTfjVE2dW+lxcppfAh0UhybQ
         bomBIH8tl57UcKMKc7sffOcVVtJ8umGhnDA0y6J9a84UY5Fe0ljncAksK2gyvxZM4MUt
         /xHsVswNG5Ddq/k6o0PFp2m4kydJP8Icvzpd/ZK9PXmWMVjFjGZLTPw4ZvWA5LEULfwZ
         OH3zvYjB9eL7EmGSbUjbuczG6iZ+2BoGUxDr8yjgctlUEiumYC0HbLyZcTF+st+ZNBFy
         udplkzhqh9eodeAY+I1U/cfleqXgb4iEq2yX7ULcA7f0CGMA7cyJfY2vPRPZ5/ztbU7Y
         Xiwg==
X-Gm-Message-State: AC+VfDwUh+ygEobljwGbT4NlBTAgt7iFaYZDlM1rdtv0+eJq4EhcziRa
        +RoHcy2YmkKbB0J++aLQDuiRJQ==
X-Google-Smtp-Source: ACHHUZ5IpqumNQukF2F7hqtI2Dig8Z/BMspkoqR/66ebZy6jV1N8mgHx09PKGakv6xuXFgycqfLGBA==
X-Received: by 2002:a17:907:8748:b0:974:1c91:a751 with SMTP id qo8-20020a170907874800b009741c91a751mr5873867ejc.29.1687088691444;
        Sun, 18 Jun 2023 04:44:51 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709060dc400b0096f937b0d3esm13183854eji.3.2023.06.18.04.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 04:44:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/7] arm64: dts: qcom: sm6125-pdx201: correct ramoops pmsg-size
Date:   Sun, 18 Jun 2023 13:44:38 +0200
Message-Id: <20230618114442.140185-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
References: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There is no 'msg-size' property in ramoops, so assume intention was for
'pmsg-size':

  sm6125-sony-xperia-seine-pdx201.dtb: ramoops@ffc00000: Unevaluated properties are not allowed ('msg-size' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 2b4840446cb0..9e44ac229619 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -79,7 +79,7 @@ pstore_mem: ramoops@ffc00000 {
 			reg = <0x0 0xffc40000 0x0 0xc0000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 		};
 
 		cmdline_mem: memory@ffd00000 {
-- 
2.34.1

