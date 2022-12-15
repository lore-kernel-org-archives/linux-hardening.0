Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8A0C4167B
	for <linux-hardening@archiver.kernel.org>; Thu, 15 Dec 2022 16:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLOQSz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 15 Dec 2022 11:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLOQSx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 15 Dec 2022 11:18:53 -0500
X-Greylist: delayed 318 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Dec 2022 08:18:52 PST
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7641A2EF78
        for <linux-hardening@vger.kernel.org>; Thu, 15 Dec 2022 08:18:52 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NXy8p68nHz1S5D0
        for <linux-hardening@vger.kernel.org>; Thu, 15 Dec 2022 11:18:50 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:from
        :references:to:content-language:subject:user-agent:mime-version
        :date:message-id; s=dkim; t=1671121130; x=1671985131; bh=KkVQrr7
        8sLYl1634PDnonKW+zcJGh/Ag3vGU/8LnAcM=; b=ayIrXl21FqBDZIfOuSLzK87
        8DLRqoJfe7r4BfDDDOIhg/Whfeu9GDmjKyZVn88SBbfyUP+rofofsat2B9i1cVgu
        QBwjIEoJ5ABjpGvj0Xv0B8Mr46oxjQFwo7wOuhSs//BlB7/TB+ld/hs4vTcyAGch
        SjPlxSK/WTcajI6tOtU1pd1GEkhX4Qc0BA72gdXkGfoXp7qAbe4FURxJYAU2G6FG
        PFJcroTkq7J92HNq+yT4EzC5pU8p9oANFRySKcxkXlpF3VCeW1JPUzPEnyVJMY2m
        +07H+1eTqubIt+BV7sVzHvEaFUNMUmNyddYAhAp07GL5VOJcdIG4HDgqwOSUAsg=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ygaKhzrcvpCE for <linux-hardening@vger.kernel.org>;
        Thu, 15 Dec 2022 11:18:50 -0500 (EST)
Received: from [192.168.4.25] (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NXy8j4Kg2z1S4t9;
        Thu, 15 Dec 2022 11:18:45 -0500 (EST)
Message-ID: <8e7c0b67-e8e8-4d54-080a-02065e09da5e@mint.lgbt>
Date:   Thu, 15 Dec 2022 13:18:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-laurel-sprout
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221215161258.355962-1-they@mint.lgbt>
 <20221215161258.355962-4-they@mint.lgbt>
From:   Lux Aliaga <they@mint.lgbt>
In-Reply-To: <20221215161258.355962-4-they@mint.lgbt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 15/12/2022 13:12, Lux Aliaga wrote:

> This commit implements support for the Xiaomi Mi A3
> (xiaomi-laurel-sprout). Here's a summary on what's working.
Noticed an issue with my commit message. After review I'll send a new 
version rewording it.

-- 
Lux Aliaga
https://nixgoat.me/

