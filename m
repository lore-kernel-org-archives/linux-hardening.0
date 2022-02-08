Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CD2C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Feb 2022 22:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiBHW71 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiBHW71 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Feb 2022 17:59:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DE0C06174F
        for <linux-hardening@vger.kernel.org>; Tue,  8 Feb 2022 14:59:25 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b9so808311lfq.6
        for <linux-hardening@vger.kernel.org>; Tue, 08 Feb 2022 14:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItA6TI8Ni0PvSK9MRYCU3UPCNW2YkPVfVW+7WyXcgIY=;
        b=afjxbKw+HzBUlQ3VvuygQbzk9tugRPl9+vCKl+hHOnudj3FtAdcYJm+J0obNuEvQkF
         mMdDm1UwYtIBcQYD+5S69w2LC/oAIIi/zEFuRkTuJXaT25X71WtPXS4N9QxghiI29Zw6
         K2PCvrwgk7c+ntSYrQLtBLuKdljo30Ej3qX5OIQqDw9temAZsjNWDUrOXXTu/gYTG+0B
         4IHqkeQKU0bmSqngH3QnAumzP+5C6EPz0BRZ1WQ8bNcJX8DsOqVPh+foqEjAMVhADIvv
         fJaCY0xTm3hvMswNVpOcc3EIMuqy51gbtJE7qUz4sn7uTHYRZmCOEQWmQZNFkthU435E
         H9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItA6TI8Ni0PvSK9MRYCU3UPCNW2YkPVfVW+7WyXcgIY=;
        b=DtwS/pVXXxlNLAiBgY8QtqHFj/H1MlgMJXOt8p9f6CcRIbiEwyzMSstwRmUTcr5ONI
         45aArM5Kc0H/WGsxy7+oV8/vvzHnH9kLdBDAVbCWXyjwgeRwvjM2UekO7FkevAkwk4lS
         C7ng5qwYGMRnoKsylRtDi6N2anBq3u/A2UHXOalr/DV3VFB3vBRkgKu7BdJ5Y6gVy085
         4D8dnJEIc51fLuVwoRZU+FoLTNWVKsg6cfoEBM/3VMVHsNSy3WRU8DwPv4jilHZ2Xwvi
         FtFJ7z3xL8icmpEOrSmQVPTAU3BN6n2IE9Ez1BFF5+T0UEEl2w2/fEbgNNMaeBMO22fo
         rCeA==
X-Gm-Message-State: AOAM533trjMGCDbppwsJYK1FjrmpPElX/+luCSSy6WNRnks+1hgfFxyn
        nAAvZnLtIngEGhCAzvLQppmLaySd20/DPqvTzZo89g==
X-Google-Smtp-Source: ABdhPJzrXjvmHbg4P8xDaIMkX3/azpSsByQPI0FL0T+S/upQWiXIjKfa7421S1XvVu6Ron9ZMXcooOEZEXBDJE9GEbk=
X-Received: by 2002:ac2:43db:: with SMTP id u27mr1290745lfl.651.1644361163719;
 Tue, 08 Feb 2022 14:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20220208225350.1331628-1-keescook@chromium.org> <20220208225350.1331628-2-keescook@chromium.org>
In-Reply-To: <20220208225350.1331628-2-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Feb 2022 14:59:11 -0800
Message-ID: <CAKwvOdm425gzxFbjcq8UmWOiBNV_POYemFgqK9CyZtdyg=Z8Qg@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] fortify: Replace open-coded __gnu_inline attribute
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 8, 2022 at 2:53 PM Kees Cook <keescook@chromium.org> wrote:
>
> Replace open-coded gnu_inline attribute with the normal kernel
> convention for attributes: __gnu_inline

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 53123712bb3b..439aad24ab3b 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -2,7 +2,7 @@
>  #ifndef _LINUX_FORTIFY_STRING_H_
>  #define _LINUX_FORTIFY_STRING_H_
>
> -#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
> +#define __FORTIFY_INLINE extern __always_inline __gnu_inline
>  #define __RENAME(x) __asm__(#x)
>
>  void fortify_panic(const char *name) __noreturn __cold;
> --
> 2.30.2
>
>


-- 
Thanks,
~Nick Desaulniers
