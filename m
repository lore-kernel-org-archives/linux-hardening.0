Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3E3EE49B2
	for <linux-hardening@archiver.kernel.org>; Sat, 19 Aug 2023 10:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHSKkT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 19 Aug 2023 06:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjHSKkN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 19 Aug 2023 06:40:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97219108E18
        for <linux-hardening@vger.kernel.org>; Sat, 19 Aug 2023 02:36:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c4923195dso214502966b.2
        for <linux-hardening@vger.kernel.org>; Sat, 19 Aug 2023 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692437767; x=1693042567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sXmf1PXc0L6m77MAsNB9+ZnrIQ5rFUeoN1zBa9T+k+s=;
        b=g6GSe3KRMg8aav5Zk4Awrlx453K6p9FvyV+iQj7OOS/hg4iEkUsHzgYcbMBRyEB3zK
         9bNlfV3z1yDmfmZ8X6jTiWet/yWsO2C8wMREFgCERMb6loF7v013mfPSgjsNbn37Qy4P
         eBQlktyuZPDwOcDxoaiIdxNKxoG+ZBlOIjrSAd+MfHJ3zlVesmXCC738wwJWJgcG4jR7
         gK3kNDQ9SXK2WSaiJ7LWkCgV/2QRXwN1MK1olqqBGzO+mLK6sNendkx20Lf4+ZBjMArr
         ffjcoeuIQEgC7Gz+C7JOu5oyGzqYsdF9a3iKEFomdy6nfm4MIyF5jOeicDZtEKI/WgXG
         lBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692437767; x=1693042567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXmf1PXc0L6m77MAsNB9+ZnrIQ5rFUeoN1zBa9T+k+s=;
        b=gPxhQo3Lty3957Yqb4sJ5RCKACLrURvIzHxvTM7PUJ3FiySg4939IkLf2Kxl9Pn+zy
         3cYkff87LJKh5TS7DC1+uJiRcn1LYT6PDgNtzRSkbvS3gWaPPDpsP8JTewjaXgKkPxak
         Cwe/8w7Zur3/YOHLb5dc6knoQ5eLoGYDCLV7ItcEczO6pqwwLpet4tot1eCoiFbGGUbu
         yRNSlCiOUqI5XysChZGy4C6WjGukocTYDt1TYNjajkKCvupfBnFRe7Z8F0dh4hNIVAll
         Q2AiNzxvGs2qYfrYU5c1fkdiZjvS9Lh9oViR4VBUoPkFhghqp5n8AT0r1t7xKcFJfAX0
         +JMQ==
X-Gm-Message-State: AOJu0YxCq0zMTgDn5RPbfHJ38Z6ozsUPLZZdFM9hHDH+GhRFLHCZ1Oa+
        GPYNmmmwL8yIkrnZ3IrNZSmeqQ==
X-Google-Smtp-Source: AGHT+IElIpQnP+n8uhTNiR6fC6b/X0C/ILO12LXuQRZE36J5I7WcRp68x93U9aJxY7JKru8QXXCG/A==
X-Received: by 2002:a17:906:3199:b0:993:6845:89d6 with SMTP id 25-20020a170906319900b00993684589d6mr1122648ejy.47.1692437767240;
        Sat, 19 Aug 2023 02:36:07 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906c00400b00992e94bcfabsm2390761ejz.167.2023.08.19.02.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 02:36:06 -0700 (PDT)
Message-ID: <13c6fd25-37c3-e2ac-3cf8-183aa1eb52d8@linaro.org>
Date:   Sat, 19 Aug 2023 11:36:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/5] dt-bindings: qcom: Add Sony Xperia 10 V
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230818-topic-10v-v1-0-dbb6464223c6@linaro.org>
 <20230818-topic-10v-v1-1-dbb6464223c6@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230818-topic-10v-v1-1-dbb6464223c6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 18/08/2023 17:23, Konrad Dybcio wrote:
> The SM6375-based Xperia 10 V is veeery similar to the previous year 10 IV,
> sharing a common base motherboard design.
> 
> The software configuration however is somewhat different, which requires
> us to allow using qcom,msm/board-id on sm6375. Sad.
> 
> Document the device.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

