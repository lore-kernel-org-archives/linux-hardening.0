Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873B5C433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 20:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiBCU6T (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 15:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiBCU6T (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 15:58:19 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A71DC061714
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 12:58:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id p12-20020a17090a2d8c00b001b833dec394so4233088pjd.0
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 12:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fNhWlMoL3ARvzgHV8VquO+9WZr0o6dFhXF/3pBpl+zY=;
        b=S7c3Eq3sx0VL1QSPwt15hZO3wCqBqUXIkHWHem/cKz3pGWyBEan/mKgiXfi1xp/29o
         kB7boL1DMiQRR4rPrg+knFLE3JaOD6isHkRRpKm1H7DKzX7+3Q2lhKYT0aP2xt9jyzQz
         PQlVEldzU7wLkMYLgSKnbnkzPrKk/TF1n93gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fNhWlMoL3ARvzgHV8VquO+9WZr0o6dFhXF/3pBpl+zY=;
        b=AUh4SC/UCKDI2XL4sk6AY+aql2prAVgTjMM2ivLo7TtOk0MS6YJ7L+PvlNZEArJ6CY
         HARiRFyh3APzZJgL8Y3IqF0iKsizBqm9j3DPU2j+ibUICgNPcL0Mn8HnOY66O0PWBURA
         EOUkBY9TLXghrMJsutp7GaUkCH5tIntCgcfJl+gNjixX2TkAcOCQtRcaiDgWwH/IIQy7
         RD1VUoHlp9ofRc9Nixi4k7I70ifPsDXHlKTsDGQvmdtTuo9rb2QLRPVdcuuyA/ZfwglD
         MhrJqYtqKqTZURx6rKaWLVPyeTEc5h8vVZw16Veh8gsWOG5brGOgMLXL64ECCv/IitX4
         E5ig==
X-Gm-Message-State: AOAM5320dSPn1MdK5cicf0y3Eh4sJXXJvSI+glfBCUYkNTkKsBaTIMNY
        87byG83eTtAeTHLXrblM3grhSQ==
X-Google-Smtp-Source: ABdhPJxHEJi5HsNKYYAMNJVOqu8P+bOMo5MPafa4O9reU/XE26kCwyLEA6TzZ8l+gs4hcb7ufp/WCw==
X-Received: by 2002:a17:90a:e38d:: with SMTP id b13mr15783752pjz.205.1643921898620;
        Thu, 03 Feb 2022 12:58:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4sm1162486pfv.166.2022.02.03.12.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:58:18 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:58:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     George Burgess IV <gbiv@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 1/4] Compiler Attributes: Add __pass_object_size for
 Clang
Message-ID: <202202031247.4F3AC598@keescook>
References: <20220203173307.1033257-1-keescook@chromium.org>
 <20220203173307.1033257-2-keescook@chromium.org>
 <CAKwvOdmzdQ+X2BsUbuVBWzFtaE2Vst4=ihNNR=LmOdozqQ5Ukg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmzdQ+X2BsUbuVBWzFtaE2Vst4=ihNNR=LmOdozqQ5Ukg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 03, 2022 at 12:18:24PM -0800, Nick Desaulniers wrote:
> On Thu, Feb 3, 2022 at 9:33 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > In order to gain greater visibility to type information when using
> > __builtin_object_size(), Clang has a function attribute "pass_object_size"
> > that will make size information available for marked arguments in
> > a function by way of implicit additional function arguments that are
> > then wired up the __builtin_object_size().
> >
> > This is needed to implement FORTIFY_SOURCE in Clang, as a workaround
> > to Clang's __builtin_object_size() having limited visibility[1] into types
> > across function calls (even inlines).
> >
> > Since any usage must also be const, include it in the macro.
> 
> I really don't like hiding the qualifier in the argument-attribute
> macro like that.  I'd rather we be more explicit about changing the
> function interfaces in include/linux/fortify-string.h.

It seemed redundant to have it separate when it would always be needed.
In v5 I had the const in the BOS (now POS) macro, but realized that this
was silly since it would always need to be that way for __pos.

> For instance, in patch 4/4, let's take a look at this hunk:
> 
> -__FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
> ...
> +__FORTIFY_INLINE __diagnose_as(__builtin_strncpy, 1, 2, 3)
> +char *strncpy(char * POS p, const char *q, __kernel_size_t size)
> 
> manually expanded, this has changed the qualifiers on the type of the
> first parameter from `char *` to `char * const`.

Yup, that's expected, and I wanted to tie it strictly to the expansion
of __pass_object_size since otherwise GCC would gain the "const" bit
(which technically shouldn't matter, but this whole series has been
nothing but corner case after corner case, and I didn't want to risk
another one).

> I think it might be helpful to quote the docs
> (https://clang.llvm.org/docs/AttributeReference.html#pass-object-size-pass-dynamic-object-size)
> 
> >> Additionally, any parameter that pass_object_size is applied to must be marked const at its function’s definition.
> 
> One thing that's concerning to me is though:
> 
> >> It is an error to take the address of a function with pass_object_size on any of its parameters.
> 
> Surely the kernel has indirect calls to some of these functions
> somewhere? Is that just an issue for C++ name-mangling perhaps?

AFAIU, this shouldn't be a problem for any of these. Nothing is trying
to take memcpy, memset, etc by address. The macro-ified version of this
change proved that out. :)

-- 
Kees Cook
