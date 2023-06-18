Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DBDEB64DC
	for <linux-hardening@archiver.kernel.org>; Sun, 18 Jun 2023 11:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjFRLpF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 18 Jun 2023 07:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjFRLpA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 18 Jun 2023 07:45:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F1310D3
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jun 2023 04:44:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-987a977f62aso122541866b.1
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jun 2023 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687088693; x=1689680693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSL47gn1L1/6NYCgMBALhWT3v+BPAsJvm/qvmecO3gg=;
        b=QhC1QYjJNQsPuuiB8j4j956d80LOgk7C0p7Sr3KjTnDiAftCdaKBcVYOHxzuCP0fSO
         0wbZnJVQBAeKUppqrDCZCiwdogs5c47a8zkJ3OqQ4AbfLE88Ovl9FhePpy13QhmthCDd
         RCNNvGO72opz/clsxizJTuv03ayUmM+No6H8ZhHp3dX1lVOx1x7v3sk4CVEWrn0sA/tx
         xv8r4qXE5KXYqo8sfc77Jq1cgo49Qq3FB4GpuQFc9yMITKkhEk13BlLypUA/CkoehGUB
         +E92OBsPyCMmGS+C20mL4V2qhiHZ4SMqiPwBQ9rq3YdEVfN0VpLe6I4TTDBUInxyk/rS
         W86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687088693; x=1689680693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSL47gn1L1/6NYCgMBALhWT3v+BPAsJvm/qvmecO3gg=;
        b=fkMeauOciINY6DdDYKjFZmClEnxJ3K0H5Fhcu/EDyXp3Iide50yPqg/C05BfQEpDW4
         e+F2VRvCDypD7AZge5wuEGEEgJbxspkKXbnkJYCe3QjZ0JNzWF03XX5xHdYhpO/kMIA8
         2SSdEfQcKxFBC0GwR+qRU5jYbuLNy6NHPaXM18zjp41sjbHlJMBB2DbDO7mwxr726UTg
         oBorUfAGML+fP51U+EhocmX3w1lO2w6zN3FldR2w13HjbtBoqVQmbhm5EzcpBRIGrwAC
         Yzyrkuy5/iNORbTqaS/MN5WLTZW4owxDSl6//Phe5ry4gJletb3CbvFEnXCINSDMdebf
         he/A==
X-Gm-Message-State: AC+VfDykhqkqaihVWpOtqUi3ZyN800PfcEQrGO3pLdv/vlnTX0SK2WjZ
        QoBemoZwEADAgjDe+7eUwN6DTw==
X-Google-Smtp-Source: ACHHUZ6WKKXMpAExOdY4Zmhg6hUi7ZqfeA6VLYdFNA1+NxUIUoJNrgqOA+AKMQqEYWhRjpi01mc5kw==
X-Received: by 2002:a17:907:3fa1:b0:94f:6218:191f with SMTP id hr33-20020a1709073fa100b0094f6218191fmr5996848ejc.52.1687088693349;
        Sun, 18 Jun 2023 04:44:53 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709060dc400b0096f937b0d3esm13183854eji.3.2023.06.18.04.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 04:44:52 -0700 (PDT)
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
Subject: [PATCH 4/7] arm64: dts: qcom: sm6125-sprout: correct ramoops pmsg-size
Date:   Sun, 18 Jun 2023 13:44:39 +0200
Message-Id: <20230618114442.140185-4-krzysztof.kozlowski@linaro.org>
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

  sm6125-xiaomi-laurel-sprout.dtb: ramoops@ffc00000: Unevaluated properties are not allowed ('msg-size' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
index a7f4aeae9c1a..7c58d1299a60 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
@@ -52,7 +52,7 @@ pstore_mem: ramoops@ffc00000 {
 			reg = <0x0 0xffc40000 0x0 0xc0000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 		};
 
 		cmdline_mem: memory@ffd00000 {
-- 
2.34.1

