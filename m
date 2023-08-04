Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CA8C001DB
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Aug 2023 07:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjHDHkT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Aug 2023 03:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjHDHkS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Aug 2023 03:40:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2213D3AA6
        for <linux-hardening@vger.kernel.org>; Fri,  4 Aug 2023 00:40:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2681223aaacso1256173a91.0
        for <linux-hardening@vger.kernel.org>; Fri, 04 Aug 2023 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691134816; x=1691739616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+S/9HOpKs+1jF9GSXyS733mVpklGbIJgO96+jDBzHA=;
        b=fxgjU+IoMNHEYmoEJLl4XaO1ytDgzRbm9Mu+8tVQJDpnJwpOkW6RB8OONKaubdlpxn
         RrpMvvKVPuWFxusmkY74T5X2o1qRTWu17iWmY56NydavR89C3npXYpl/lSib2eK0LgK8
         yzo8ChMPoroZwEQlSkc+lPVGqKOeR4+DxMK8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691134816; x=1691739616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+S/9HOpKs+1jF9GSXyS733mVpklGbIJgO96+jDBzHA=;
        b=akdDgt9pNN3UuE0mEHfwSnFtK2IpVRLPLKuXQSC1xF4HoFmkW13kfJ8rwSlpzI3y+d
         DgfrADj2CQca0vz1hKrA4ENd+32I6r1M8o7HXpDs8WjA757gk6PVzUgyEkEuaC0qa8pl
         lzzywcEtljC7dJEOanwXLYGtUAv/UXST6MBFxRyANozzAS5Rc8dTv8TyMkcd/vrfjxOl
         UytvEnRXSUO99x1YmYB6ybvLxlRmPvM5bHqJ1xEQtm/+agSr6YtiU0WybZIIrF84Sc2S
         zvA9UF1FNEVkTd+q51nopjyZM9AnY5EcIal+8wkptWZwClOC2w51VrUEt5J8t1uo77CT
         MkVg==
X-Gm-Message-State: AOJu0YxdrMASYp10AJWHWLI8yUqBg2fobFvDbWKEHqU3CDvRCLZ1kkuF
        uB+1Y7jSahcrDcYbQYqaR9duNQ==
X-Google-Smtp-Source: AGHT+IFsmqQUMHGEjD/HoJ7z9cdXciny8xZesWp4+Fj8uiyFOUA9fz/ha/zaCCgefg4s9kErw4dayw==
X-Received: by 2002:a17:90b:1e10:b0:268:94b:8d0 with SMTP id pg16-20020a17090b1e1000b00268094b08d0mr1404750pjb.11.1691134816644;
        Fri, 04 Aug 2023 00:40:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090a64c400b0026307fa0442sm3577655pjm.49.2023.08.04.00.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 00:40:15 -0700 (PDT)
Date:   Fri, 4 Aug 2023 00:40:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tomoyo: refactor deprecated strncpy
Message-ID: <202308040039.D9B575B3F@keescook>
References: <20230803-security-tomoyo-v1-1-c53a17908d2f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803-security-tomoyo-v1-1-c53a17908d2f@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 03, 2023 at 09:33:44PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> It should be noted that the destination buffer is zero-initialized and
> had a max length of `sizeof(dest) - 1`. There is likely _not_ a bug
> present in the current implementation. However, by switching to
> `strscpy` we get the benefit of no longer needing the `- 1`'s from the
> string copy invocations on top of `strscpy` being a safer interface all
> together.
> 
> [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> [2]: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks! This looks correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
