Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F8BC7EE2A
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 15:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378113AbjHRPX7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Aug 2023 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378119AbjHRPXz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Aug 2023 11:23:55 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CB43C31
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 08:23:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ff9121fd29so1502333e87.3
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 08:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692372232; x=1692977032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKuNDT3ozn5yu4XZDwLRBbbhrL0YjdwUNB++YlEavBU=;
        b=vaHynN3rl1OCp5jP73OUEMGqdiKZOdTcj5FzUPeYMNX5aMd1794XPQFmgUzRbiZnxl
         XvLAp+px+aR4h/q6mbrMtXXR92AbOrezTmVN/bzAUy34uM/1Uix3r0+bivnSfefofOnZ
         7KZ3xX/GNM7RmgaRElVrPHbD/Dfin5zet5DyEjx0lnUHEj1pIMpKwI+zblfaGhjFTvVp
         djp8Hfdb7qI01QebxHvlMILlwX8BmNxwsyOQXSWcJa0E/0yXii1a1aUjvsC5BMdCIW+c
         cGzdKYk1JgVoTB2kn03Wbiks6/UCy2EVsTPKz17wSs142VjrviF+sLPdBjyH18rZbetU
         ag9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372232; x=1692977032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKuNDT3ozn5yu4XZDwLRBbbhrL0YjdwUNB++YlEavBU=;
        b=S9Q3ANtKp2+JMvVUtWWXQopBTB6RDlILp2T8HZ9Zu+mO39mGYyuU4VHj4qZ08q7ddq
         lJpXJCZyIak1VchltdK2TGNVTQqNrxKWtKhyKVwE0HQnY7Fp08fdnqWdxoqicBA1Qypi
         jjW3G5p2XY8Nd2U/SeCuap48iNpPyJ71XMYB0D30Cj9o7i970xKU8QmYvoUl7rVa4XYg
         gvsuSbtobTCK7RnvZ/OyNvDi5W5Q2XApJNZKBjMcV+IiqS4vkxIPHbTzTQNNBAtNrI9B
         qDTBvbKOGwgc5gR9nGNk/gIDNsv1+vfW10sPq/d/JQwz4s30wkX4N8/eRqh0VZfYzc3I
         Nerw==
X-Gm-Message-State: AOJu0YxcWjY7mglrwsNdpUeGkMmdaj1AKebCy9g8cgOawcVF/5L+a0Sj
        fS5Yd547DImvxQyDYaHHc+cVAw==
X-Google-Smtp-Source: AGHT+IHjAGZdIBGvR96SvrKqgepbLo4FofyQopD/9llMZUKYV2cPMfdq+9VMOfu4VD4SleJwXtOacQ==
X-Received: by 2002:a05:6512:2309:b0:4f8:5635:2cd8 with SMTP id o9-20020a056512230900b004f856352cd8mr2727252lfu.32.1692372231991;
        Fri, 18 Aug 2023 08:23:51 -0700 (PDT)
Received: from [192.168.1.101] (abxh52.neoplus.adsl.tpnet.pl. [83.9.1.52])
        by smtp.gmail.com with ESMTPSA id y2-20020ac24202000000b004fe4d122a66sm383715lfh.187.2023.08.18.08.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:23:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 18 Aug 2023 17:23:26 +0200
Subject: [PATCH 3/5] arm64: dts: qcom: sm6375: Hook up I2C7 GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-topic-10v-v1-3-dbb6464223c6@linaro.org>
References: <20230818-topic-10v-v1-0-dbb6464223c6@linaro.org>
In-Reply-To: <20230818-topic-10v-v1-0-dbb6464223c6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-hardening@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692372226; l=1311;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7pwAxQ89b609N+91Ei3/CUuL4YiJwIEnELBA4MpGvCI=;
 b=7wn65upp5DABUi+sBI8DHVsh9zu7rABI4hUp+7QKuPdyWzePy3XyRoaheS4lThoxcmmbMRVMe
 VnZDV+pn2f/DeBrx1hMhqUCRmJKPjYrp0uBV5JPx4EiJbqTVziy34xn
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

It's required to mux the GPIOs to a correct function to make sure
the I2C host can communicate with the devices on the other end.

Ensure that happens.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 4364b144eb93..b79908d969c7 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -875,6 +875,13 @@ qup_i2c2_default: qup-i2c2-default-state {
 				bias-pull-up;
 			};
 
+			qup_i2c7_default: qup-i2c7-default-state {
+				pins = "gpio27", "gpio28";
+				function = "qup11_f1";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
 			qup_i2c8_default: qup-i2c8-default-state {
 				pins = "gpio19", "gpio20";
 				/* TLMM, GCC and vendor DT all have different indices.. */
@@ -1220,6 +1227,8 @@ i2c7: i2c@4c84000 {
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				interrupts = <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&qup_i2c7_default>;
+				pinctrl-names = "default";
 				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";

-- 
2.41.0

