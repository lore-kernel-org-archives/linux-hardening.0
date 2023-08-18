Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32327C77B7A
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 15:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378121AbjHRPX5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Aug 2023 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378094AbjHRPXw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Aug 2023 11:23:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96DA3C31
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 08:23:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ff93a7f230so1197850e87.1
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692372229; x=1692977029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJQqDdGPVUJfoRvKnSM80n8RczWSHnCto7QTsJZiqtk=;
        b=C8uQDGLm7z++sx4Hg3NyuOfpIVB4wpbI+ED7CNVawWP0Wx7CZ/W3uMMt0+81hGbcjf
         SwqTa0A7HafS0UIaX52ysPqC26xwzt8rhw9RlxqPzD4VxYhikOahtQ+AusgK0XW32Uh+
         HP3HzoNyuTKC7dMM+bTs0rbpYmon1d4h1/YqsMC1/pdkSOTW+1jSoBUm81Uouqc/gelh
         rfZv3p5i5nHtr01kYLtpeFu0bG5ni4XZllMvwYvOCUIJiRx3IT9KKSpCOBGbpBF+YgmE
         CdWny4e3CTLa9eJR0dln9VUpjrMUkKJEIHkQL1KXigeqBsWPi05xgP6OZ4QssjdrVzaY
         k82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372229; x=1692977029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJQqDdGPVUJfoRvKnSM80n8RczWSHnCto7QTsJZiqtk=;
        b=ECq+y0Q/uQHcdnKoEC7SH6RCBhjMz/vYqzPcrvSrd0vS8MDdfduMECgoGCwQLSP9mS
         BJbM56YhcKY4W5cbRQpg6Wzh4O6qKOXd6bpJ0DOgANWJNU/aL6DGl3lzBZPlv6gnCP9N
         7f7lgWgYvwQpDfLAearrWi+BtDsBif/Y6MbaYfojakkcYwGdk2RBiK4wZNlqAxoBvVML
         AI5KcPR7KyQohjgJnx1hKLqbKl9T9DSwFIGtWOZUQgD+jTv9UighAcCdpaDnoAcFLO7r
         JIOTtD8P3BcBG6rUISjutb+ijjTMkR17WH3mm1Ol+bCObr3LRUFcQyR4VzVkdgVvy548
         jpCQ==
X-Gm-Message-State: AOJu0Ywp0gCGEYsZZ2LWToIHlmbool7boL2z+vX3tk+5E6G63i44Po++
        BlAza1lKBcqyK7eEBXy1g/X4UQ==
X-Google-Smtp-Source: AGHT+IG/mI9Nx9tmlh0+qzTSHFdmpOBxSp41fxQHkMQkMitajAbKXFDtQrjdgsIPZDldqTcGTH9MzA==
X-Received: by 2002:a05:6512:159e:b0:4fe:8ba8:1a8b with SMTP id bp30-20020a056512159e00b004fe8ba81a8bmr1248198lfb.7.1692372229014;
        Fri, 18 Aug 2023 08:23:49 -0700 (PDT)
Received: from [192.168.1.101] (abxh52.neoplus.adsl.tpnet.pl. [83.9.1.52])
        by smtp.gmail.com with ESMTPSA id y2-20020ac24202000000b004fe4d122a66sm383715lfh.187.2023.08.18.08.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:23:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 18 Aug 2023 17:23:24 +0200
Subject: [PATCH 1/5] dt-bindings: qcom: Add Sony Xperia 10 V
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-topic-10v-v1-1-dbb6464223c6@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692372226; l=1130;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=w7EHpX3DR/QuWoxAiVHalOk3V0ZK5fAKJ3KAsW4H5mY=;
 b=lHLWdy5rSa9EJVMoNNo2AhDQGBBQupAMkbkz0AwJi3IxNrlw87hCpZ1yD7tXa9v94pNyJMihx
 ftzTNs+0vyIAfqE4y6NmuKzDsXwtk/jvIoFJG4pxkE9R61XO0N8wDru
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The SM6375-based Xperia 10 V is veeery similar to the previous year 10 IV,
sharing a common base motherboard design.

The software configuration however is somewhat different, which requires
us to allow using qcom,msm/board-id on sm6375. Sad.

Document the device.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index adbfaea32343..766d7e1c9db3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -941,6 +941,7 @@ properties:
       - items:
           - enum:
               - sony,pdx225
+              - sony,pdx235
           - const: qcom,sm6375
 
       - items:
@@ -1086,6 +1087,7 @@ allOf:
               - qcom,sm6115
               - qcom,sm6125
               - qcom,sm6350
+              - qcom,sm6375
               - qcom,sm7225
               - qcom,sm8150
               - qcom,sm8250

-- 
2.41.0

