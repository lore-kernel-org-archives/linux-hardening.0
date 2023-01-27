Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D16C61DA4
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Jan 2023 19:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjA0TTD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Jan 2023 14:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjA0TS4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Jan 2023 14:18:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D77B7D289
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 11:18:35 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so5688640pjl.0
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 11:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrpVKqMmu6aS8nYMVOqBou02mxi1hvJKXYbLMwv8NQs=;
        b=gpFq7sLNE6mtb8IXlsZj7CCQRrpRWeNX0DaVfrF+tfxo9TmGeMLBn+/gnfOMUf9f03
         kgwSxVzTICgFikTbtgUWpuNyQft8c8V/oKrK4TQ3eLWiN6R+PKS/rBGLc5GeDDP9ipoj
         eQhp2NlMF4R8DBNAY1vd+ghK2hq5P4QC8sK34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrpVKqMmu6aS8nYMVOqBou02mxi1hvJKXYbLMwv8NQs=;
        b=vE84B/TSgE64T7qjXIdwyt9QsKGlrJlhy92vwfgEW7o5WWisiAdP8daosezjkCjcCa
         dBT1jUuvz018zdUsJVeIM67sgCVf2dHGbMfg6IqIoj6lvsiE1yuokIb1XncPfQM4gs61
         lCR3iX4CoYFjRxbjKgxd0urGmkfn8dlA2RdNoyxiF8xps4UE0c25oF+waJnKWnEncj9s
         GU1G9K+smx3C2EsyuC6o7PP+iFwNU4K10/NCxZPb56CV12gWP8ZwKmQY0VLepU+XbUUA
         3KNPJgM7zDDytro4I+VV42DfF06+DLWMt5YWBJ39u9xJ5FXEV6WHK9rh6RLyr66oasSz
         KmHA==
X-Gm-Message-State: AO0yUKVAGTE8B9+m11rrOuu7nhuAVpXwDZOZdZZaVFOW4ttzYNpOw2R+
        J3X24p64ALjnq/sVxFhEeA3WLw==
X-Google-Smtp-Source: AK7set9hsln9I1KJbS/pzMIo0pAzaGsMtCQ40nv8FkEkxL0KJF+vuhYW0O7+D6uWuvitFfC8bRPHhg==
X-Received: by 2002:a17:90b:1646:b0:22b:e79f:fff with SMTP id il6-20020a17090b164600b0022be79f0fffmr16835308pjb.15.1674847115070;
        Fri, 27 Jan 2023 11:18:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p5-20020a17090a748500b0020aacde1964sm5320872pjk.32.2023.01.27.11.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:18:34 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:18:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: ramoops: Inherit reserve memory
 property
Message-ID: <202301271118.A223F4E88B@keescook>
References: <1674835252-31954-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674835252-31954-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 27, 2023 at 09:30:51PM +0530, Mukesh Ojha wrote:
> The reserved memory region for ramoops is assumed to be at a
> fixed and known location when read from the devicetree. This
> is not desirable in an environment where it is preferred the
> region to be dynamically allocated at runtime, as opposed to
> being fixed at compile time.
> 
> So, update the ramoops binding by inheriting some reserve memory
> property to allocate the ramoops region dynamically.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v4:
>  - Addressed comment made by Krzysztof on ramoops node name.

Thanks! Krzysztof, if this looks good to you, I can carry it in the
pstore tree.

-Kees

> 
> Changes in v3:
>  - Fixed yaml error and updated commit text as per comment.
> 
> Change in v2:
>   - Added this patch as per changes going to be done in patch 3/3
> 
>  .../bindings/reserved-memory/ramoops.yaml          | 34 ++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> index 0391871..8741626 100644
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
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        reserved-memory {
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges;
> +
> +            ramoops_region: ramoops {
> +                compatible = "ramoops";
> +                alloc-ranges = <0x00000000 0xffffffff>;
> +                size = <0x0 0x10000>;       /* 64kB */
> +                console-size = <0x8000>;    /* 32kB */
> +                record-size = <0x400>;      /*  1kB */
> +                ecc-size = <16>;
> +            };
> +        };
> +    };
> -- 
> 2.7.4
> 

-- 
Kees Cook
