Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956E7C46467
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Dec 2022 04:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiL1EhM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Dec 2022 23:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiL1EhJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135FEBC83;
        Tue, 27 Dec 2022 20:37:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3AA761236;
        Wed, 28 Dec 2022 04:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13518C433EF;
        Wed, 28 Dec 2022 04:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202227;
        bh=0NEJIsSsSe6bGC55i0B6YrnD9Muybz+0yhe4GSyJ7AQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3Svbmklla26K/S8dkyCQh4KS3vFM6x+4t0QOKANXyxwQKgMq3mOagAoP7cTJ96Fb
         +CzDMqAb85ItjAsiclmLVHRdWDDauKCHYpGpWdgFa2nVhPKZuusF8r4E1rQeuKqBfj
         Yio23mc5HIrpEL7P/Vp+T+Xklq6GsBpH+1zZRHSWzA1n8+KkFBRmQMnUbpsWQgZL7s
         AIputisLWe7UwsERq0OaVer7/OOiT/wWfhvqzPTykYxRQ1zN9fMKZ+wMmTzxKvNd3M
         3V8dGpGKr/UBMocDPsB6Kx06imixDybD1wDeqHfhuBofmUaSs8cCdUsOBrmrp4d9O8
         vJccyppt3M3Tg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org
Cc:     gpiccoli@igalia.com, Tony Luck <tony.luck@intel.com>,
        keescook@chromium.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, luca.weiss@fairphone.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, patches@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6350: Fix up the ramoops node
Date:   Tue, 27 Dec 2022 22:36:41 -0600
Message-Id: <167220221234.833009.3159849283583093837.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221210102600.589028-1-konrad.dybcio@linaro.org>
References: <20221210102600.589028-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 10 Dec 2022 11:25:59 +0100, Konrad Dybcio wrote:
> Fix up the ramoops node to make it match bindings and style:
> 
> - remove "removed-dma-pool"
> - don't pad size to 8 hex digits
> - change cc-size to ecc-size so that it's used
> - increase ecc-size from to 16
> - remove the zeroed ftrace-size
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm6350: Fix up the ramoops node
      commit: 3b2ff50da499178cc418f4b319e279d1b52958ed

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
