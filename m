Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6221FC25B7F
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Aug 2023 20:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346118AbjHPUiM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Aug 2023 16:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346192AbjHPUiE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Aug 2023 16:38:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094611BE6
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 13:38:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68874269df4so1472451b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692218282; x=1692823082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJIlP+1/qA6fcDc2Mru+2eZCt7jBZOXqJQckio1X6xc=;
        b=IQAAyoMIMRMlYm4RH2Fzi0XDoBtqTCbmQjx89YHvHuV4+MfX7axqYeLaL+9hO0U0Ue
         v1EkYDflL9QccT+IKePO0WZ/Hqy7WO3phw96Xo2MEp8AqDkuie8yKmXorIiCu+WuNbb3
         H6g0i7Udm+oGcKdpmnwMLhRnccBHsLiaQvkI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692218282; x=1692823082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJIlP+1/qA6fcDc2Mru+2eZCt7jBZOXqJQckio1X6xc=;
        b=DM3XzTok1wYj3T+AubF9X4Ah2PI0204TCRBKjTNnHi0cMAXQ1VWe6aQrPKC/ih/0CS
         wuCqAOZg8e40lar5ZK9YJd2Ub6Q5ctP+nQX7UbGcwGXbp7+fNZ3VocKX3jh1DIpC/pmq
         1ESkeM1N0RGYr63QulaYu9cxTatT98QjrljnOVgYc3ERQfe+3KiWw5vs+iz2qsWt+/KC
         kz3pYl0sCMEbQ8oo2dBvvOUIQWLI8hHeEaSz7gqJxqUI9NemG3j/SkmtUm4Lo0p1SBzx
         ocsZaxbOPSCyFBui8eI+L7e743P3h9Lcwjx+PHp/F5gHfgjBEZgtEOGc2Mq/dmStfGqZ
         kNLg==
X-Gm-Message-State: AOJu0Yxxvd+XjJrCtMtvzaNfuEtHB29RuQhbECm8QU7VYPQEQelzLym9
        +TgR0V3EUgbKyNq8P+4X7ZYKZA==
X-Google-Smtp-Source: AGHT+IGD+Plh3BsUd0TQTpVgaXEavYIMr8Q2oQgh+U/utLjGSkkg77n0HL7nHAFnesuGqd5CBWellg==
X-Received: by 2002:a05:6a00:3a03:b0:679:bc89:e5b with SMTP id fj3-20020a056a003a0300b00679bc890e5bmr2845336pfb.19.1692218282505;
        Wed, 16 Aug 2023 13:38:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 24-20020aa79218000000b00682d79199e7sm11427546pfo.200.2023.08.16.13.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:38:01 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:38:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, Steven Zou <steven.zou@intel.com>
Subject: Re: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Message-ID: <202308161337.975C93F163@keescook>
References: <20230816140623.452869-1-przemyslaw.kitszel@intel.com>
 <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 16, 2023 at 10:06:17AM -0400, Przemek Kitszel wrote:
> Add DEFINE_FLEX() macro for on-stack allocations of structs with
> flexible array member.
> 
> Expose __struct_size() macro outside of fortify-string.h, as it could be
> used to read size of structs allocated by DEFINE_FLEX().
> Move __member_size() alongside it.
> -Kees
> 
> Using underlying array for on-stack storage lets us to declare
> known-at-compile-time structures without kzalloc().
> 
> Actual usage for ice driver is in following patches of the series.
> 
> Missing __has_builtin() workaround is moved up to serve also assembly
> compilation with m68k-linux-gcc, see [1].
> Error was (note the .S file extension):
> In file included from ../include/linux/linkage.h:5,
>                  from ../arch/m68k/fpsp040/skeleton.S:40:
> ../include/linux/compiler_types.h:331:5: warning: "__has_builtin" is not defined, evaluates to 0 [-Wundef]
>   331 | #if __has_builtin(__builtin_dynamic_object_size)
>       |     ^~~~~~~~~~~~~
> ../include/linux/compiler_types.h:331:18: error: missing binary operator before token "("
>   331 | #if __has_builtin(__builtin_dynamic_object_size)
>       |                  ^

Looks good to me! Thanks for working on this. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
