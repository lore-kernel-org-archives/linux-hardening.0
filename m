Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969FCC76196
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Apr 2023 15:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbjDFP0E (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 Apr 2023 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239322AbjDFPZ6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 Apr 2023 11:25:58 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA6186B4
        for <linux-hardening@vger.kernel.org>; Thu,  6 Apr 2023 08:25:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k37so51352045lfv.0
        for <linux-hardening@vger.kernel.org>; Thu, 06 Apr 2023 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680794751;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QseBQLy8TtMrmO07Qs/JRVxTi2zIfcjTE6wwfQJ+AhM=;
        b=DnNXfWd03uXqT0o2IsSiDvfsHJiYlA/365R+ayRxxIV6l+U9IWpcDXCX7qcpw/xbvx
         eIL0RJdbEqn3YeXZRYEUQSmacRyfUuz+YcZ7LQsoJ42pe68TwkvJRMVA+7qHBId8H6wf
         MhvrjEZ9Got9ZmovLyQPNtxuV8BPkeubWyKGCoBYxKotzw5Anz3jnTOP26sHm1KbP4hz
         mUahIOKmZipHhy3HCDzryDvBHO6fH+lLc/pjHgQ4/DJagcw9GoA6Pn/prrBjKE5NErZd
         GGworHAIST7yXoXK4Vcra4W1LfXM/R/Sv9Mh/QFf95TfIavtyF+xXmxRx5ZpKnaqHP5G
         MaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680794751;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QseBQLy8TtMrmO07Qs/JRVxTi2zIfcjTE6wwfQJ+AhM=;
        b=7gBMHt+1RlYHLSg13wkzP/Yj//yVUMlzbBwTcmtanVlPAWfWY4/dJuxm3n6FpKskMi
         Qt6X8j1oOBEy7Ugc7skkJx6Uh3KIRxWJKJ5eC+bYUmiJQiYb3Gc9rq7AaFlnhcYPVMmN
         dDa85qSITRYVR6mBsvtNjiUGhzKgQkxKp0j4YJRbvriozABaZIWudKQ/BHSXtcTUVXOB
         675AcxDOZpJw5qslLp1hIXfRJDTbJSGFqb4DZzDb685p7lAoboydt6gCgkkzxyL34sJK
         lKO14BWP4qif5xFqa9/Ob2Zhg/tqRxjKXxfYbRBFzTH+lnSAUpOEJgRLtz6iwMgOrv6K
         s3ow==
X-Gm-Message-State: AAQBX9cy8o/NNQQ9RoRopv009ef60mjkauZqkXjjmpW+pqnlalrVVVuC
        OGujT4AhCcFj7rNBokJw6ot9yQ==
X-Google-Smtp-Source: AKy350YvcZx8qx/o+0RM0P+WGhn7PuM0G03nngoVhulexm2Tfn3ofwiyNavcDmIM7yeWSHcGxVwCng==
X-Received: by 2002:a19:ee18:0:b0:4db:3882:8f42 with SMTP id g24-20020a19ee18000000b004db38828f42mr2096473lfb.45.1680794751693;
        Thu, 06 Apr 2023 08:25:51 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id h4-20020a197004000000b004cc9042c9cfsm300103lfc.158.2023.04.06.08.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:25:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/4] Tab P11 features
Date:   Thu, 06 Apr 2023 17:25:49 +0200
Message-Id: <20230406-topic-lenovo_features-v1-0-c73a5180e48e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH3kLmQC/4WNQQqDMBAAvyI5NyXRVqUn/1GkrMmqCyGRjYYW8
 e9N/UCPMzDMLiIyYRSPYheMiSIFn0FfCmFm8BNKsplFqcpK3VQt17CQkQ59SOE1IqwbY5S2US3
 etQFoUOR2gIhyYPBmzrXfnMtyYRzpfc6efeaZ4hr4c76T/tl/m6SlktZWurJQtm1Td448cLgGn
 kR/HMcXt8UFm9AAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680794750; l=808;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=iHNEEA5Iv3dwjVQpoEQKxZ3jdgKnaMmyVgtYumaQYfI=;
 b=aN84IwOztKIO+Uo88gKhk7ikVnRwdJy746haXkCpvYhR0dylOkpkika1yziuUvQOQ2AC4fmjGxBa
 pxA/Xex1CIKFSUoRiDxbXfIgn4aOyCR100xlKLsJ5WXsgYVTNLgH
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This short series brings a couple of "nice" features to the Tab P11:
- Wi-Fi
- remoteprocs (+RMTFS)
- ramoops

No external dependencies.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (4):
      arm64: dts: qcom: sm6115-j606f: Add ramoops node
      arm64: dts: qcom: sm6115: Add RMTFS
      arm64: dts: qcom: sm6115p-j606f: Enable remoteprocs
      arm64: dts: qcom: sm6115p-j606f: Enable ATH10K WiFi

 arch/arm64/boot/dts/qcom/sm6115.dtsi              | 10 +++++++
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 34 +++++++++++++++++++++++
 2 files changed, 44 insertions(+)
---
base-commit: e134c93f788fb93fd6a3ec3af9af850a2048c7e6
change-id: 20230406-topic-lenovo_features-d708e51caa7e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

