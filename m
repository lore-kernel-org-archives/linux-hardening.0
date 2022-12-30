Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346AFC4167B
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Dec 2022 13:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiL3NkN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 30 Dec 2022 08:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiL3NkM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 30 Dec 2022 08:40:12 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B207A1A833
        for <linux-hardening@vger.kernel.org>; Fri, 30 Dec 2022 05:40:10 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bf43so31777517lfb.6
        for <linux-hardening@vger.kernel.org>; Fri, 30 Dec 2022 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=COQ7nJLT/LPh8CfMtU8IzopkfbfZ6Re6+gjvXdfJY9k=;
        b=eyfc2zq24VH+uVh0cQ7WRnfLOCO5muX2UeqlxBViIZvyyGxCTBLAdsocBeZZSCY+VX
         SvVnK7WmTJIT8v4PbaELhCEBefHiMfMxcfcLdUtpyFNLz422OTf5kF4rdM+n8ImhCnGq
         krWNCKiTGPtRPXjbFmrC9tv8sHWjRtb9EZRPs3msdrQIYpUJFCRUhEZEPrLA6S6xKocA
         3+lY/OzAahsdFd6UUSvhuNCaXHVwAC8M0tKo1sHA+/k/kbR5WjfTCkIUMmvN1eNJnjgp
         bse8XJZjcZm+iPok+JWE8qGvlNIXho1nbnuJAmZcXKwgNlvZQdWcsr382RTfWXxLvwdI
         woUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COQ7nJLT/LPh8CfMtU8IzopkfbfZ6Re6+gjvXdfJY9k=;
        b=zBA2Y6Q9dbwdIiRAlbOJqGTwhu4OjeYikSlCKs9o+G7wkU5hWr7CmabH5Z3KIOlIob
         yWSF0WXjrHXukm3B21RapLT+vi5QrkbdbiZGYsyaHA8kTfTzV6Eujs1o97lnLobvZp/S
         bPUCGjGSJwRfNITwGfZrrqiCOk24XL5FePRv0qKlEbzfPliZVjB80UX6xOs7W8zSJybD
         qk5cMZgzeET5YA2R5q7YS1sXXawTRlOQJZjzHK8QaQbLc8FiWRMrIO8hiWfQ/xoVJvsK
         XDDZzoMQMqdJl6zDk3ZvEhtJuhjWljgjnMj5wwO5aBshJA3kmxbCXlZl3dnpwUkss9Bj
         /XbQ==
X-Gm-Message-State: AFqh2kpc2lis4qPGYQPKOXeyfYwRvqnBWWX3suLG6uBWhLuA5w+XT86N
        PUmavZDMA4SMXkhL3bDvIdaDCA==
X-Google-Smtp-Source: AMrXdXt+Et0C1G26SzTRvliMsPJdy4lASQUO2Oc2BKEYF/iPA/2cHa1Qi0rLjIu1YklbRPv/FE4wlw==
X-Received: by 2002:a05:6512:1522:b0:4a4:68b7:e74b with SMTP id bq34-20020a056512152200b004a468b7e74bmr9319323lfb.53.1672407609090;
        Fri, 30 Dec 2022 05:40:09 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q30-20020a19431e000000b004b373f61a60sm3462359lfa.96.2022.12.30.05.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 05:40:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: qcom: add missing space before {
Date:   Fri, 30 Dec 2022 14:40:05 +0100
Message-Id: <20221230134006.48111-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add missingh whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts | 2 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 6 +++---
 arch/arm/boot/dts/qcom-mdm9615.dtsi                | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
index bf2fb0f70fe4..c57c27cd8a20 100644
--- a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
@@ -22,7 +22,7 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
-		ramoops@88d00000{
+		ramoops@88d00000 {
 			compatible = "ramoops";
 			reg = <0x88d00000 0x100000>;
 			record-size = <0x00020000>;
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 1f40a3dd5748..e045edeb5736 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1101,7 +1101,7 @@ sdcc3: mmc@12180000 {
 			dma-names = "tx", "rx";
 		};
 
-		sdcc3bam: dma-controller@12182000{
+		sdcc3bam: dma-controller@12182000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12182000 0x8000>;
 			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
@@ -1129,7 +1129,7 @@ sdcc4: mmc@121c0000 {
 			pinctrl-0 = <&sdc4_gpios>;
 		};
 
-		sdcc4bam: dma-controller@121c2000{
+		sdcc4bam: dma-controller@121c2000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x121c2000 0x8000>;
 			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
@@ -1158,7 +1158,7 @@ sdcc1: mmc@12400000 {
 			dma-names = "tx", "rx";
 		};
 
-		sdcc1bam: dma-controller@12402000{
+		sdcc1bam: dma-controller@12402000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12402000 0x8000>;
 			interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index 536bd7b50762..8e9ea61a1e48 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -294,7 +294,7 @@ pmicgpio: gpio@150 {
 			};
 		};
 
-		sdcc1bam: dma-controller@12182000{
+		sdcc1bam: dma-controller@12182000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12182000 0x8000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
@@ -304,7 +304,7 @@ sdcc1bam: dma-controller@12182000{
 			qcom,ee = <0>;
 		};
 
-		sdcc2bam: dma-controller@12142000{
+		sdcc2bam: dma-controller@12142000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12142000 0x8000>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

