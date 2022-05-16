Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C87C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 23:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiEPXCA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 19:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiEPXB7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 19:01:59 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5094EB
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 16:01:58 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h186so12791403pgc.3
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 16:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lGx5OaF/nNf+wAk/UXSTp7o/h1yC5nC+cmEZ08o7IyE=;
        b=H6Efosz+U4jL2Q/PRaySKd7X1SckPh/0vK1RwkUKGINiTgldM9LZ6aaqeeIxLJrjyA
         0TyW5rImHO2dZuioVDvS5m2xiA38/mzt0eoPEITqOTx40PddhxtCCtpekYSjT4Dt5eQT
         prIv07wrhhjPwKg9g1h+ACZL2KBo8DGGfraR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lGx5OaF/nNf+wAk/UXSTp7o/h1yC5nC+cmEZ08o7IyE=;
        b=A9dMXyX9s7Jkzd26OHejKJuEadizxogfoSJHtmugPOcRXgaD+AATdagom9hCQcrpQc
         MTlisCs2qjFbyHyGmBA1odJ3gklJKR7BeLYP9IJFr1D996Ty5cIjmjlNb5rtrQUqj+pk
         u7zpMfBAeNKAGiULKk1hwTLAp3sTV7/J+5fCE1T+Padm+eJMZpeOeFISOmzcoYbjafad
         HNOACYiFOhjOpeoHeXVnE78A8k/zyOH8vYd8gNxiBmX6fKJRQLX4mj1Wrlm1ACoeRbrG
         L2XGIQmyRX9XK/2/h2IbVJGDvtb6XYh+IsbKSx0VFookoydBLKR+Y+9mzxgFHgGlO7ZY
         CJEg==
X-Gm-Message-State: AOAM531Mh9KK7ulWBBw722Kxamm4OEUebKKFJy0x2v7uq0TADySjGPGX
        6HnTAxtYefMMuFOMzBT85zF8eg==
X-Google-Smtp-Source: ABdhPJxko9JuM1KI2cl8VriIGs+4kOv8T8gQAgbApOgjucLuTCSJVO9OOecJiH06QAjAJNiIJdWiqA==
X-Received: by 2002:a05:6a00:174f:b0:4fd:aed5:b5e4 with SMTP id j15-20020a056a00174f00b004fdaed5b5e4mr19751789pfc.39.1652742118486;
        Mon, 16 May 2022 16:01:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r8-20020a170902ea4800b001618f5186f1sm1908968plg.80.2022.05.16.16.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 16:01:58 -0700 (PDT)
Date:   Mon, 16 May 2022 16:01:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib: overflow: Always build 64-bit test cases
Message-ID: <202205161601.14C4F8DF@keescook>
References: <20220511174531.1098548-1-keescook@chromium.org>
 <CAKwvOdkXUiB3T_YkcqDZAkdvN0=cB2NH-i6jj+Y=sL8r9VCJ6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkXUiB3T_YkcqDZAkdvN0=cB2NH-i6jj+Y=sL8r9VCJ6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 16, 2022 at 02:35:45PM -0700, Nick Desaulniers wrote:
> On Wed, May 11, 2022 at 10:45 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > There shouldn't be a reason to not build the 64-bit test cases on 32-bit
> > systems; the types exist there too. Remove the #ifdefs.
> 
> I think this is breaking 32b ARM for clang-13 and older?
> https://github.com/ClangBuiltLinux/linux/issues/1636

Ah-ha, that's the combo I hadn't found. Thank you!

-- 
Kees Cook
