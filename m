Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44448EB64D8
	for <linux-hardening@archiver.kernel.org>; Sun, 18 Jun 2023 11:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjFRLo4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 18 Jun 2023 07:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjFRLow (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 18 Jun 2023 07:44:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DED10D4
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jun 2023 04:44:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98862e7e3e6so94375166b.0
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jun 2023 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687088689; x=1689680689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhL8KtwaYHcT7IR66TG7VubSU1MX9CLuOzM0f221Puo=;
        b=GW0IYfNFLemT3JyZkg+GYmqSqwWKFgg6ihpkp56SCYQ5LPz544JAWaiptb9Xgb4EgM
         X6Gpm9nRX0vUDWGll7cZm6rIn+h+XNKTPIeufTfPacnEjjjZVr0XmcxW6YEgI5lK8Aug
         2+9GHLfBEaH09EWvQZwWDH900+7fLaLCDBa4Cht40oDDe4kPstbvfEzNSpzX55fEYMr9
         2b63INeMw24d80LyXmVXzSPzx7ZnR+0Y54RuqGVemqmvstqOIlYOIufLqH4F0mqdu0Md
         Hfa5HjFsmG8DXxU9eYfxo0QQ8Bm55kXv0KskSzHu/vRFxNe4Wntm0oiCQlU2vC5pmDxL
         833Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687088689; x=1689680689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhL8KtwaYHcT7IR66TG7VubSU1MX9CLuOzM0f221Puo=;
        b=JRrwmko0jpX/UkwZInzTvtg3OQeewNLZH+b+uef5ao4UKJsZ7yUGd5mvbftE2Ol5kP
         I9lw61nKxcvmS7zGzAuRmVPOBu8195UhuS9VahLUPDWDKetD1DqUQVOrrqUn2zs/qIzi
         aUtqXHSUkVaSq8gw7L1S3g9PbOVcecpi0WeFlTrfc5lMMre0cVMqbeG4kD10ixmtNHK9
         RFRfXgoCg2GVT2r+5fow6y5Ij7LW0wDurGF9IaA5K3QhyQPgiWxAb4MKssjkMhRPqrpa
         77CFfo7fPIumnnt/WX61vygco8nrAfZtfDPQTs522pn2tH/py0jmTmWJJ8+VLdB/YVXh
         0qkQ==
X-Gm-Message-State: AC+VfDwD0UC32QEaMeDa4Zoh34K4PEZ5KCRVEJ/zwrLQdIkstE9Xonii
        5ITcv3yzfn3vGssX04XSnLvNRQ==
X-Google-Smtp-Source: ACHHUZ5OT0jWVs00PZn5ksvk+MMG3/2lSYbe9YqHXEkgKh30EIWsOl/maNhkNafs0ECtpnsYlwY17Q==
X-Received: by 2002:a17:906:da83:b0:982:ab8d:1e08 with SMTP id xh3-20020a170906da8300b00982ab8d1e08mr7149008ejb.59.1687088689498;
        Sun, 18 Jun 2023 04:44:49 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709060dc400b0096f937b0d3esm13183854eji.3.2023.06.18.04.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 04:44:49 -0700 (PDT)
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
Subject: [PATCH 2/7] arm64: dts: qcom: sm8450-hdk: correct FSA4480 port
Date:   Sun, 18 Jun 2023 13:44:37 +0200
Message-Id: <20230618114442.140185-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
References: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

FSA4480 has only one port according to bindings:

  sm8450-hdk.dtb: typec-mux@42: 'port' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index d7975b3cf064..e5cbea92e07a 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -518,16 +518,9 @@ typec-mux@42 {
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

