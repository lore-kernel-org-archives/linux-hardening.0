Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3146C678D7
	for <linux-hardening@archiver.kernel.org>; Fri, 13 Jan 2023 12:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbjAMMMR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 Jan 2023 07:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbjAMMLe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 Jan 2023 07:11:34 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A597CDD3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 04:05:03 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id u19so51771103ejm.8
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 04:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vXHybJ2mJD6aa8TvSwEacdirC05VvD7/mmGN0WSC+vw=;
        b=QvjvtNTf6/c/WYoFYhk46x+H2YhZBKQBg620l4RhwiX74ErRSQSNzqunYHdo4GaKj7
         W18ixbG6yEniU4KsVAiBHHWba/xKipCDS2GL/0FEB7BLhPHMD0FgirXaNwkkkiRwoJ3t
         kpi+qkgjwZ6o7WcgMdN9fHoLspRM0kaL9VbY5aiTAIOnFNAw+A8R3lXW70zejxUNCFZR
         L6icKZ2GdzNdmwI9Y2mP9R5sAuD5xw0ZdAnmxJlkH480HWdLCxrkz7lZtdnCEYx14qbe
         f/6IwD25mR6BcVWDnvXjB49k//bl/vS1wc/qQ6Hwy6xPrVPDbL9fX4WiySKva6mERgf0
         16cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXHybJ2mJD6aa8TvSwEacdirC05VvD7/mmGN0WSC+vw=;
        b=ZHsdx6gPAW9j285EnVaf/c9pJrgNL/UdZAN/lgN/4DnleOW4pFhV0gNOur3SLoyJEk
         DP8udD7GFZkoFinaSnP/ZWE2pag8SRQi3TnHDHTlkFIKrir9tuA5OZ96HUL+RCIvuXFb
         SeJ9MzyYps+sHOtpp8SllAhkHv/to/0Gp/wsbD8dJ7UbZ6ZIb+i30daPooc2cy+WxvLu
         JJolEYnJxeGvSsYAIAk+QuoYsJnvrlj3FMecvgV6hWR1H0gGUFaYVN+f6EEPTlyENP+1
         zM66gCW8CPcdiYaH26zYEwU0xf84jpvc822KxzqFZbMgOjvz9MLw+sbhbD5LffXzSjrn
         sR7A==
X-Gm-Message-State: AFqh2kooIUOSz4lVycFLyke0SM2BTE+icHh+NXKBFOMYMOBbnrKx/sEQ
        8Dy9zOttCB8tSRTJQr7LTXAhcg==
X-Google-Smtp-Source: AMrXdXt/AzW14h8l94Wqnw6m53vrD1GcILvRAidaUWScS+ZS45P5oisNr9+yWakUYg6jOlAzSZU3OA==
X-Received: by 2002:a17:906:abc6:b0:7ad:d835:e822 with SMTP id kq6-20020a170906abc600b007add835e822mr71763506ejb.42.1673611501624;
        Fri, 13 Jan 2023 04:05:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id og5-20020a1709071dc500b0084d420503a3sm6715352ejc.178.2023.01.13.04.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 04:05:01 -0800 (PST)
Message-ID: <7cb96551-094c-1a68-cc3f-31e4e2e94518@linaro.org>
Date:   Fri, 13 Jan 2023 13:04:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/3] dt-bindings: reserved-memory: ramoops: Update the
 binding
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, keescook@chromium.org,
        gpiccoli@igalia.com, corbet@lwn.net, tony.luck@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1673611126-13803-1-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1673611126-13803-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Subject: drop second/last, redundant "binding". The "dt-bindings" prefix
is already stating that these are bindings.

Your subject says nothing. Everything is "update".

On 13/01/2023 12:58, Mukesh Ojha wrote:
> Update the ramoops region binding document with details
> like region can also be reserved dynamically apart from
> reserving it statically.

So what exactly can be here reserved dynamically? And what does it mean
'dynamically'? By whom? How is this property of hardware (not OS)?

> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Change in v2:
>   - Added this patch as per changes going to be done in patch 3/3
> 
>  .../bindings/reserved-memory/ramoops.yaml          | 34 ++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> index 0391871..54e46e8 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> +++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> @@ -10,7 +10,8 @@ description: |
>    ramoops provides persistent RAM storage for oops and panics, so they can be
>    recovered after a reboot. This is a child-node of "/reserved-memory", and
>    is named "ramoops" after the backend, rather than "pstore" which is the
> -  subsystem.
> +  subsystem. This region can be reserved both statically or dynamically by
> +  using appropriate property in device tree.
>  
>    Parts of this storage may be set aside for other persistent log buffers, such
>    as kernel log messages, or for optional ECC error-correction data.  The total
> @@ -112,7 +113,13 @@ unevaluatedProperties: false
>  
>  required:
>    - compatible
> -  - reg
> +
> +oneOf:
> +  - required:
> +      - reg
> +
> +  - required:
> +      - size

There is no such property. You cannot require it.

>  
>  anyOf:
>    - required: [record-size]
> @@ -142,3 +149,26 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    / {
> +        compatible = "foo";
> +        model = "foo";
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        reserved-memory {
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges;
> +
> +            ramoops: ramoops_region {

Node names should be generic, no underscores in node names.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Any reason in naming it differently then existing one? You have there
example.

> +                compatible = "ramoops";
> +                alloc-ranges = <0x0 0x00000000 0xffffffff 0xffffffff>;
> +                size = <0x0 0x10000>;       /* 64kB */
> +                console-size = <0x8000>;    /* 32kB */
> +                record-size = <0x400>;      /*  1kB */
> +                ecc-size = <16>;
> +            };
> +        };
> +    };

Best regards,
Krzysztof

