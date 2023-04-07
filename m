Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6618EC77B6C
	for <linux-hardening@archiver.kernel.org>; Fri,  7 Apr 2023 19:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjDGTy7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Apr 2023 15:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjDGTyv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Apr 2023 15:54:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783C29EE0
        for <linux-hardening@vger.kernel.org>; Fri,  7 Apr 2023 12:54:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a23so84370lfk.4
        for <linux-hardening@vger.kernel.org>; Fri, 07 Apr 2023 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680897288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ik00/DWzOBDdpaDCzlragBZR2t7JS1DYLQEwoXiJp+k=;
        b=bMuJhqfHPpyn6QximJG/STPxFywOBESH03woaCLph8VyGfvK7QATR+kTRLm7E64BQY
         tBsiV0HeWFZrMYjgmtyoSqouLEWwMsTO03s1brNnWaRxWdDN95pY3hmH7EFOhxj2p61r
         3H6/nbA98vsZ3EcAHDGvEdMLbxHd7xRc/QC6/9cfP1jpLPgFlVyLNgfcVLwtRdtMUFfh
         ZlRwGpnJDtcb5oSvVlp1N29tnkeROai5vTiTeZoFZ2lWtEvspcYCkJ5JLA9LwTBNwdbw
         WWizPbLuO/Oouyz7RSne9BMT+pflTHannixNeuw5OLaf1/Ohni+BAeJPooWIqeRLZ+nL
         Y2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680897288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik00/DWzOBDdpaDCzlragBZR2t7JS1DYLQEwoXiJp+k=;
        b=EB/foovHzn1rp+AViXBf8QWvkzm0YKno5dbebeu9Q3KVqIhCAJow9/biVyN79rvG9r
         L+5Cgl1xiGKkJNoXX7IxI24O6ACmHy2Z4cP/uWywyRqkzpU9eSD9fqYh1DZNv4mBWnqp
         nBK74FNQHmzL+Bn2uOfLCbE/wE7fiPAlj79f92kKGEjxVFDDniqiZgZ2S1WtJ0c8Gy0C
         6qJmHrYpKW0PFY+8LptQE8xOA//twRM7QQYkUEgHLNaFnyy3aaHnch5N3KjjocgRSVIN
         ymSE+mEart76TRJHINhss9bKssbKKyeZUcvdThcWyiDUoQUqMuGUT4yKQBMESc4LE1Jj
         SE9g==
X-Gm-Message-State: AAQBX9d1yoBJudlrvLB0I/Kr5E9uTOGsOZosFSSIOIsP4X8zeZmObiAv
        M20jXKqHOZP5Uz4x0cu7HvqkRA==
X-Google-Smtp-Source: AKy350ZFGAHRePab4vDJ64ClvIMx7BmV1MG6ApHndhdLtWMr+IlbavCnOjN9BMqqKPM1kz30JeNmQA==
X-Received: by 2002:ac2:4838:0:b0:4dd:af29:92c1 with SMTP id 24-20020ac24838000000b004ddaf2992c1mr786647lft.44.1680897287743;
        Fri, 07 Apr 2023 12:54:47 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u5-20020ac248a5000000b004d856fe5121sm839981lfg.194.2023.04.07.12.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:54:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 21:54:41 +0200
Subject: [PATCH v2 1/4] arm64: dts: qcom: sm6115-j606f: Add ramoops node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-lenovo_features-v2-1-625d7cb4a944@linaro.org>
References: <20230406-topic-lenovo_features-v2-0-625d7cb4a944@linaro.org>
In-Reply-To: <20230406-topic-lenovo_features-v2-0-625d7cb4a944@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680897283; l=841;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=E/tv8jOaoTtifU3iJkgY+Xi2d+mKQ2GWGkNbT8cN8Ck=;
 b=ZZHXQ2cKIx+C02ak8/jM5lpthy0RYTcN2FKcZFAytNmq9sljyputmzIU+Df5yjE0Al55eYDdtUWv
 X+gR0JmdCdB65vFzgB82jYBFS/RGCg+6V/MW/6uQ58I66cEE1Uty
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add a ramoops node to enable retrieving crash logs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index 10c9d338446c..cd47fbc993ba 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -52,6 +52,17 @@ key-volume-up {
 			wakeup-source;
 		};
 	};
+
+	reserved-memory {
+		ramoops@ffc00000 {
+			compatible = "ramoops";
+			reg = <0x0 0xffc00000 0x0 0x100000>;
+			record-size = <0x1000>;
+			console-size = <0x40000>;
+			ftrace-size = <0x20000>;
+			ecc-size = <16>;
+		};
+	};
 };
 
 &dispcc {

-- 
2.40.0

