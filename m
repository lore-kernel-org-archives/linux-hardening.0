Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FF3C4167B
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Dec 2022 22:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLNWsd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Dec 2022 17:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLNWsc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Dec 2022 17:48:32 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4761327DFC
        for <linux-hardening@vger.kernel.org>; Wed, 14 Dec 2022 14:48:31 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so822805pjr.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Dec 2022 14:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iMEJ8qWvU17qF8Iw6KkCvqlY5TEaxk9MDPpeFJN2leo=;
        b=aXfHEhtI9R9soKDZaToBP0eHoF2wK2L4yt464De59nc6HszERIRBsqLpZZ+DFxc96F
         ErGuCCGWsqQeO+Y1l54z466jTHAlyVTnV523ltKdLyfd0Iho/DTDTk578EVfOjG7+STh
         xQf2eoCCBBhAtR68zaS7SgJiOTnl2XhSwFrvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMEJ8qWvU17qF8Iw6KkCvqlY5TEaxk9MDPpeFJN2leo=;
        b=w61pnxufRIJXq++FQOEcwueejEhSNRsV3HFlk6u3XCJuvvrW3P6IrAxDWCm90x/zZw
         X4hGKGfGciiWTHmFm7sln1j7X9qDNnV3bK2GDWS7+Yo9Qh0/fQ7c9QOCW/Ly47aVgrqv
         JTMjnoJnc9ctBmdbWo4ek3xL+NYBpLTAf7uqxJCiHhi1HEa/yvQMCg1i0WtcyyM/YNeU
         Ni6Bj7owBHYOqYUE+RBkWMMEyscZx8EDvlsxj6CZ9wjE3bQ+lAPAo8z/SuBrbUGv4E5v
         4Tgkkr/3kXX9xSDXGM49wrni8iWu7g0Njt8lcL8lF9ZHK6hlCxEw24wZ+Bs1KmLpR6EJ
         AXWQ==
X-Gm-Message-State: ANoB5pnD0cnJ8F5nik0w3Q3sbwaJX4AWUGXlp4K1WFAH9OIqHWC/fEIu
        Hl/3+IgxYj7tv88aOkbbfOVNuQ==
X-Google-Smtp-Source: AA0mqf7qKN79UVZEaW0Ls76RahKulLM3pvcDvRzXwGVbF7i+MXNF8rKr0K5wWQE/acWibVQATBg9tQ==
X-Received: by 2002:a05:6a20:429a:b0:af:89c2:ad01 with SMTP id o26-20020a056a20429a00b000af89c2ad01mr1690943pzj.40.1671058110782;
        Wed, 14 Dec 2022 14:48:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902680800b00172f6726d8esm2327431plk.277.2022.12.14.14.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:48:29 -0800 (PST)
Date:   Wed, 14 Dec 2022 14:48:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Dan Li <ashimida@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] lkdtm: Add CFI_BACKWARD to test ROP mitigations
Message-ID: <202212141448.03552F3@keescook>
References: <20220416001103.1524653-1-keescook@chromium.org>
 <CAEUSe78kDPxQmQqCWW-_9LCgJDFhAeMoVBFnX9QLx18Z4uT4VQ@mail.gmail.com>
 <202212072221.A9FCC905CF@keescook>
 <ba52dac5-2ce7-a567-41af-841b857abbed@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba52dac5-2ce7-a567-41af-841b857abbed@arm.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Dec 09, 2022 at 05:34:41PM +0000, Kristina Martsenko wrote:
> Subject: [PATCH] lkdtm: cfi: Make PAC test work with GCC 7 and 8
> 
> The CFI test uses the branch-protection=none compiler attribute to
> disable PAC return address protection on a function. While newer GCC
> versions support this attribute, older versions (GCC 7 and 8) instead
> supported the sign-return-address=none attribute, leading to a build
> failure when the test is built with older compilers. Fix it by checking
> which attribute is supported and using the correct one.
> 
> Fixes: 2e53b877dc12 ("lkdtm: Add CFI_BACKWARD to test ROP mitigations")
> Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Link: https://lore.kernel.org/all/CAEUSe78kDPxQmQqCWW-_9LCgJDFhAeMoVBFnX9QLx18Z4uT4VQ@mail.gmail.com/

Thanks! Added to my tree.

> ---
>  drivers/misc/lkdtm/cfi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
> index 5245cf6013c9..d4bb8e31a2fe 100644
> --- a/drivers/misc/lkdtm/cfi.c
> +++ b/drivers/misc/lkdtm/cfi.c
> @@ -54,7 +54,11 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
>  # ifdef CONFIG_ARM64_BTI_KERNEL
>  #  define __no_pac             "branch-protection=bti"
>  # else
> -#  define __no_pac             "branch-protection=none"
> +#  ifdef CONFIG_CC_HAS_BRANCH_PROT_PAC_RET
> +#   define __no_pac             "branch-protection=none"
> +#  else
> +#   define __no_pac             "sign-return-address=none"
> +#  endif
>  # endif
>  # define __no_ret_protection   __noscs __attribute__((__target__(__no_pac)))
>  #else
> 

-- 
Kees Cook
