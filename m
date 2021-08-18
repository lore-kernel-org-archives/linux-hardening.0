Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67052C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 09:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445156108E
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 09:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhHRJ5r (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhHRJ5p (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 05:57:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C51C061764
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 02:57:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn28so2236614edb.6
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rn4A30qTQOxkstQYw62Y3prioOpHXXbJvzGKouAI1jo=;
        b=HxuZ7amf0x5rDg8Pv2sDkTar7KFdTSrkayed1hQb/rSNUcLT73vKapTE8H9oodlrl+
         XrKtbghyhAs5x9vzvwVUrXrR09KztnaG2Yh4SVOy5u7XPIz8jTtUtcddn80S6gYaezG8
         v4/iegN2atmH28uNfVXvvavIu21o+9JE6gq04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Rn4A30qTQOxkstQYw62Y3prioOpHXXbJvzGKouAI1jo=;
        b=K4ftPWYuH5SNgEJ4f7tdjph3WYArPOHbm1Na/EVwDh9vqV24rOM7tGpkNQOt8+rG0c
         yaSRCvQzEAg6pn4wBbSfBnwezG8a+pfnrP1JP57V4d7Vm6hQVx1M8Ow9R/MnwHDZCHvI
         6wGayFsU+BCavEKdtdrXq9Wtq8wFMZPmUNvX2BUsPnuvLtvaS29OpIWNxS2VJ95sftFF
         cTTIVuQnN1sJOkq81POzzl6KhowBhiWHsw7YkToXccBMaTGfiTKydqnydta8A027oDjp
         mr9H1D6AV9dseQp+q7jK8GkI6GnkASxR0NSDItTR66Hv6uHEFP2evhZYbfNtJ9qzqHOi
         kDbQ==
X-Gm-Message-State: AOAM533Pz8LO9kOyD9TrMKzMauWiNqqRCjmXydrubQjTGIk6XTV9hGwk
        WWFwz3H3yZmE4O1C4quotO68Hw==
X-Google-Smtp-Source: ABdhPJwYW1o49qUAQxejWY4Sn7eDQRTvw9cFiL03omJ6m7BCOJhQgKMgxhygSTQ/CZCejqpBO/2g4w==
X-Received: by 2002:a05:6402:29a:: with SMTP id l26mr9269082edv.347.1629280629996;
        Wed, 18 Aug 2021 02:57:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q21sm1789736eji.59.2021.08.18.02.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 02:57:09 -0700 (PDT)
Date:   Wed, 18 Aug 2021 11:57:07 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Jason Ekstrand <jason@jlekstrand.net>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Use designated initializers for init/exit table
Message-ID: <YRzZcwR0O9Fv8asJ@phenom.ffwll.local>
Mail-Followup-To: Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Jason Ekstrand <jason@jlekstrand.net>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210817233357.2379455-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817233357.2379455-1-keescook@chromium.org>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 17, 2021 at 04:33:57PM -0700, Kees Cook wrote:
> The kernel builds with -Werror=designated-init, and __designated_init
> is used by CONFIG_GCC_PLUGIN_RANDSTRUCT for automatically selected (all
> function pointer) structures. Include the field names in the init/exit
> table. Avoids warnings like:
> 
> drivers/gpu/drm/i915/i915_module.c:59:4: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
> 
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Fixes: a04ea6ae7c67 ("drm/i915: Use a table for i915_init/exit (v2)")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to drm-intel-gt-next, should show up in linux-next/next merge
window eventually (that branch isn't in linux-next for reasons).
-Daniel

> ---
>  drivers/gpu/drm/i915/i915_module.c | 37 +++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_module.c b/drivers/gpu/drm/i915/i915_module.c
> index c578ea8f56a0..d8b4482c69d0 100644
> --- a/drivers/gpu/drm/i915/i915_module.c
> +++ b/drivers/gpu/drm/i915/i915_module.c
> @@ -47,19 +47,30 @@ static const struct {
>     int (*init)(void);
>     void (*exit)(void);
>  } init_funcs[] = {
> -	{ i915_check_nomodeset, NULL },
> -	{ i915_active_module_init, i915_active_module_exit },
> -	{ i915_buddy_module_init, i915_buddy_module_exit },
> -	{ i915_context_module_init, i915_context_module_exit },
> -	{ i915_gem_context_module_init, i915_gem_context_module_exit },
> -	{ i915_objects_module_init, i915_objects_module_exit },
> -	{ i915_request_module_init, i915_request_module_exit },
> -	{ i915_scheduler_module_init, i915_scheduler_module_exit },
> -	{ i915_vma_module_init, i915_vma_module_exit },
> -	{ i915_mock_selftests, NULL },
> -	{ i915_pmu_init, i915_pmu_exit },
> -	{ i915_register_pci_driver, i915_unregister_pci_driver },
> -	{ i915_perf_sysctl_register, i915_perf_sysctl_unregister },
> +	{ .init = i915_check_nomodeset },
> +	{ .init = i915_active_module_init,
> +	  .exit = i915_active_module_exit },
> +	{ .init = i915_buddy_module_init,
> +	  .exit = i915_buddy_module_exit },
> +	{ .init = i915_context_module_init,
> +	  .exit = i915_context_module_exit },
> +	{ .init = i915_gem_context_module_init,
> +	  .exit = i915_gem_context_module_exit },
> +	{ .init = i915_objects_module_init,
> +	  .exit = i915_objects_module_exit },
> +	{ .init = i915_request_module_init,
> +	  .exit = i915_request_module_exit },
> +	{ .init = i915_scheduler_module_init,
> +	  .exit = i915_scheduler_module_exit },
> +	{ .init = i915_vma_module_init,
> +	  .exit = i915_vma_module_exit },
> +	{ .init = i915_mock_selftests },
> +	{ .init = i915_pmu_init,
> +	  .exit = i915_pmu_exit },
> +	{ .init = i915_register_pci_driver,
> +	  .exit = i915_unregister_pci_driver },
> +	{ .init = i915_perf_sysctl_register,
> +	  .exit = i915_perf_sysctl_unregister },
>  };
>  static int init_progress;
>  
> -- 
> 2.30.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
