Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DA1C0015E
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Jul 2023 17:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjG0REZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Jul 2023 13:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjG0REZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Jul 2023 13:04:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE526BC
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 10:04:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686efdeabaeso822465b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690477463; x=1691082263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZcV7GGyEaE3OLX7Vopz1HxO7d9e/1e1Zp3uwy/ULrg=;
        b=iiIuTxt6uVQ4wct3bOeLzxV0BWCxXhaJliBn5ZfltSH6DFUVlrmIUyoNpQaAXqRFnw
         NvaYTRxu/XHkUGDbjqCd292vQFYnzKTKzlkYd86pmVUYnH65j5ZTAu7Ap8zLqbfXo+XR
         gCOWjd9R/J2MURdh5WcB50gdoFqHaSMYXy0uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690477463; x=1691082263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZcV7GGyEaE3OLX7Vopz1HxO7d9e/1e1Zp3uwy/ULrg=;
        b=dFv1bJ8LycsambUObcU96GcP5USnMPhQA7Ao2N5IitU0V61qv9IhgeXArS0E5ZjDmy
         kcUiAyWMpjh220NjeT+h/EdK7WZarZNhlpbG7pp/rz1+P0j6V6I7YxUoJVazeoWmUl5o
         Gcplf48d1boqr98mNik1gLIzIbO6+2mB04yBTAO87kGcsm3uJBFlp2IwVEwVbpmWQz1/
         29qPiH+URl8CV7aWW5aoEUCLXwsLkwBOntp6/cpM/4/XiaQbGbKRBn7ObtbwMPEFQbpa
         WUf65HrM16PRWgk/KJlJXmUvM7A1JIwFJKsS0Rc0uNX6FLeDYRRfoFpFnesYXhy+27w4
         +YjQ==
X-Gm-Message-State: ABy/qLaXGKVTJBzTfU/eLzUUpFtK7aSkbFjyRler2gJg1Vd8STPfhnNl
        rOTUJ6xgDQTvCxaFMaqhlIwiejR2p/NZTDqBl1s=
X-Google-Smtp-Source: APBJJlGg0Pa5pJwOyLvYDxFwV9CR6OjZiGoVvSx+j7lgNrunXLpTzpEeoW/HbZLc5o28d/HAGWeCIg==
X-Received: by 2002:a05:6a00:190d:b0:66c:6766:7373 with SMTP id y13-20020a056a00190d00b0066c67667373mr6000736pfi.23.1690477463304;
        Thu, 27 Jul 2023 10:04:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c16-20020a62e810000000b006636c4f57a6sm1725855pfi.27.2023.07.27.10.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:04:22 -0700 (PDT)
Date:   Thu, 27 Jul 2023 10:04:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Replace strlcpy with strscpy
Message-ID: <202307271003.BCF5F3597@keescook>
References: <20230710030625.812707-1-azeemshaikh38@gmail.com>
 <169047317161.2400214.15246406234885315012.b4-ty@chromium.org>
 <87pm4dz6js.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm4dz6js.fsf@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jul 27, 2023 at 07:02:31PM +0300, Kalle Valo wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Mon, 10 Jul 2023 03:06:25 +0000, Azeem Shaikh wrote:
> >> strlcpy() reads the entire source buffer first.
> >> This read may exceed the destination size limit.
> >> This is both inefficient and can lead to linear read
> >> overflows if a source string is not NUL-terminated [1].
> >> In an effort to remove strlcpy() completely [2], replace
> >> strlcpy() here with strscpy().
> >> 
> >> [...]
> >
> > Applied, thanks!
> >
> > [1/1] wifi: mwifiex: Replace strlcpy with strscpy
> >       https://git.kernel.org/kees/c/5469fb73e96d
> 
> And the same question here, why are you taking wifi patches without
> acks? And this already fixed differently in wireless-next so our trees
> conflict now:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=caf9ead2c7d06fd7aa4cb48bd569ad61db9a0b4a

Thanks for pointing that out! I saw no feedback on Azeem's patch, so it
looked like it was being ignored.

For the patch you linked to -- it's okay to have lost the overflow
detection and warning?

Regardless, I will drop this from my tree.

-Kees

-- 
Kees Cook
