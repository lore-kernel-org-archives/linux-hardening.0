Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A9CC63797
	for <linux-hardening@archiver.kernel.org>; Wed, 11 Jan 2023 05:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbjAKFT2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 11 Jan 2023 00:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjAKFSR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F46A13F16;
        Tue, 10 Jan 2023 21:10:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEC4461A36;
        Wed, 11 Jan 2023 05:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC24C433D2;
        Wed, 11 Jan 2023 05:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413807;
        bh=zn4sMWKd4ppOBnkwcQB+YD8fGX/U6+5IIXElTQ1tRrk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aXHOFZAfMR2xgLvKs3dBMFcIfSGS/+IpQO9KMIwaR2e7Y1K5tgKxdojdmk5x/YZ3p
         AM0alXpv80SejF/u11CdQdkQ4xa3PXlyjPxKYaz4f4ajIWpJTrUacJTiCFQvepkUVN
         XWsSGTD//nTnZSrmrwf6GMOdNIa0AekLCsEdKVZcrBngu8xXLpXapgsZ6feQPZRCZQ
         G1uQOF085lf2vz2xV4BUOqwMkXezfssqcxr2kpK91g+a7qoAlF2b2rMclDg8/lCf71
         yyl9GxXC5/YqvP7mUGQAqSD2t3fvBZOwvW92NCAqr8N7zZZ0UOxFmoKGwotGWh1c+J
         Uj9FPUN0m8Kfg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        agross@kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: (subset) [PATCH v2 1/2] ARM: dts: qcom: add missing space before {
Date:   Tue, 10 Jan 2023 23:09:32 -0600
Message-Id: <167341377733.2246479.14435445788072934578.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221230140133.57885-1-krzysztof.kozlowski@linaro.org>
References: <20221230140133.57885-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 30 Dec 2022 15:01:32 +0100, Krzysztof Kozlowski wrote:
> Add missing whitespace between node name/label and opening {.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: add missing space before {
      commit: 66b14154e278807811d67de9fb0d5cc76638d07b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
