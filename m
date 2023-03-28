Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D54BC761A6
	for <linux-hardening@archiver.kernel.org>; Tue, 28 Mar 2023 06:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjC1GoI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 28 Mar 2023 02:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjC1Gnw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 28 Mar 2023 02:43:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF0130D2
        for <linux-hardening@vger.kernel.org>; Mon, 27 Mar 2023 23:43:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eh3so45278409edb.11
        for <linux-hardening@vger.kernel.org>; Mon, 27 Mar 2023 23:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679985829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmTvziNt2VFrSmXaXHn7cfTQldiBzclyda4PoCjJxWE=;
        b=DPaN2l40XfdN9xbWxJI9FLfIuX9bVwJgZdpiuAH2PKxv20nB7cEwX+D0+QXFsj+zH9
         +R1BNX9t/VB8qVFQX5HRW8ldTicErtXgvtiRUpE7zBGyldIZP5WMRiHTutasVJh/FI1k
         +U6SCuoWIjlfn9DFlpm45jzH5IpyHbU/g6/OEdC7WV2Qw19yaBwU6RI10CZzUfrWiCga
         qmeHp8d+OVI0OgV5MdMsDiXhHo6wAkVBSHzkWHaMdQmrA82iwZKi05gRY3EIoeZyuwZq
         pt+R/cAjakQZJ+U2JdSc4cGhXofPFgzr4dqJVbVgSWSdtyq2N2+9d7Vl4u5O7fAJxF/3
         ziyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679985829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmTvziNt2VFrSmXaXHn7cfTQldiBzclyda4PoCjJxWE=;
        b=HY7rGBp3SBuv7JdhFwdda2PmLLLOLnaMtZnPJKdsFRFTyrpYfsTBuueBEgnrjowap2
         jJlzqkJIa4RvUatS37vNCThmKcVs+F1M6DlPdZhCxas6Kr2cQ5gLiOzQ/Ye9ZL2oKOAs
         bZT47lHKVB9+SeZlkJRFn1kuIPel6HjDfntsSi3AjZA5EEqMblS40WJprQ9rD/F9Bsrb
         vhN1XoyouNHeoJfLJYOWLZmgCq8HWWZHtWEiWK0rG5o6oIRrOQhYibv+8dMYv/+aOF1P
         CRwFi+oolQ6cvgR8fdAORuOwuRrYo49YzoABkKJU4Z27SnOVufqFeFEwzzOYNNwsEbcy
         DihQ==
X-Gm-Message-State: AAQBX9c/Y+0w69RRv90ZhI6sBPjU2pN2b2Cj9+MyksjrMerroCd1oeLg
        s7KkeXDs7ylbZtg1/kboTiHzIw==
X-Google-Smtp-Source: AKy350ZHO7213F8SJfPOYH/2LqcuXOEigoE0IsXpMbVKyLHe8zZ/kqfEcihEQE/XDSC44GiNCdeFFg==
X-Received: by 2002:a17:906:b303:b0:933:48ce:73a5 with SMTP id n3-20020a170906b30300b0093348ce73a5mr14652999ejz.56.1679985829059;
        Mon, 27 Mar 2023 23:43:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id s30-20020a50ab1e000000b004c5d1a15bd5sm15404666edc.69.2023.03.27.23.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 23:43:48 -0700 (PDT)
Message-ID: <07700bca-a717-aeb1-2658-a1dbda00affa@linaro.org>
Date:   Tue, 28 Mar 2023 08:43:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: reserved-memory: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230327170122.4103518-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327170122.4103518-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 27/03/2023 19:01, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

