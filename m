Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A151AEB64DB
	for <linux-hardening@archiver.kernel.org>; Sun, 18 Jun 2023 11:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjFRLox (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 18 Jun 2023 07:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjFRLov (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 18 Jun 2023 07:44:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5084E77
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jun 2023 04:44:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-987accb4349so208007366b.0
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jun 2023 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687088687; x=1689680687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E2l62kT3eiLEXqJg8CxMuWY141wzPG/hn4e3QVCnoRo=;
        b=whUyseXZjMZhBSfuawXlWU0LfE0rSHAdHQOKBNAIR+CrxT7m1V70RciIGp+YM6yHAO
         6HBjvZg59OnFQ4FTYrhHWz5++OfJmZjh/N1fMrMG1FYn+jIlnvSs16EKkW38KUlxWgio
         twb0wyP77TH8tW4/r30MLeOnFhuNQ9SbU2FJOTXg8m34sdv0HKH3NlW9bzL0L8rea+5X
         7+SfIZjHdAkxwP9JjrWJeeUFZvoQhXWdST7kMH8kfsm8/k77iwPEhnpRzgTCMT+zKXOY
         cPycoOoQ4QcAEbwMvox/Y1BPmrDkEgwXjUsIdQ+5Rs1r5HRxRTVYJ+6mzBdG0kstlCtA
         ytVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687088687; x=1689680687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2l62kT3eiLEXqJg8CxMuWY141wzPG/hn4e3QVCnoRo=;
        b=SZk4qlH4l5Z9EQefiUGZFsDPO5Z1k2XaWlys5eneap0o4TEWl8G2L/BFrg3rs4CoLE
         6s6WAlNB7EykzD5PG8n0JAeVjVsBO4pTLUioqIMkt0i24nd2alu+d6fRZ5uMThKtZCrf
         1lGzh+pZjKwjHs2+bPiWvLjMwcVTB1xaDxXu8Cn2Z+v7iy5VDZ/VrQWB7kMETaQI8F+A
         04BHQT+GdS989hnyngPgZaZ1cxCO0QNAMZPDl0C/Rc+ocazl/XOaRv2bgAkDDRv1Sehv
         dC+Ddh9XdUAyTsvKo6Yidk7psg2M0+EvsVX604TTWD0nLGqn9yrQasRmllo0W2r6U+v3
         rAGg==
X-Gm-Message-State: AC+VfDxzUN89cNMMgVk1b6DmnA5OPIS6wJqQQBnoAjnKiZ9VI4nbhz9i
        mlOKIsYw3t5pp8oHvodmDvTlJA==
X-Google-Smtp-Source: ACHHUZ7OkwHwZ354uyf5KpKgxVBy17PLodEGLL3XG9b4tYp1rBqRcUayxXIOn5EkFUKTc1VIZ7I1Gw==
X-Received: by 2002:a17:907:7e91:b0:973:cb21:8479 with SMTP id qb17-20020a1709077e9100b00973cb218479mr7048460ejc.70.1687088687234;
        Sun, 18 Jun 2023 04:44:47 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709060dc400b0096f937b0d3esm13183854eji.3.2023.06.18.04.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 04:44:46 -0700 (PDT)
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
Subject: [PATCH 1/7] arm64: dts: qcom: sm8350-hdk: correct FSA4480 port
Date:   Sun, 18 Jun 2023 13:44:36 +0200
Message-Id: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

FSA4480 has only one port according to bindings:

  sm8350-hdk.dtb: typec-mux@42: 'port' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index b182f4cf06cc..95a2a42ccb9e 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -349,16 +349,9 @@ typec-mux@42 {
 		mode-switch;
 		orientation-switch;
 
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				fsa4480_sbu_mux: endpoint {
-					remote-endpoint = <&pmic_glink_sbu>;
-				};
+		port {
+			fsa4480_sbu_mux: endpoint {
+				remote-endpoint = <&pmic_glink_sbu>;
 			};
 		};
 	};
-- 
2.34.1

