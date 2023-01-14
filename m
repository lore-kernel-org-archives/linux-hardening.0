Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B042C54EBE
	for <linux-hardening@archiver.kernel.org>; Sat, 14 Jan 2023 00:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjANAsS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 Jan 2023 19:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjANAsR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 Jan 2023 19:48:17 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3BD76ED8
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 16:48:15 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c85so14060318pfc.8
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 16:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cS7wan9cbZoOd7zB1+M5b4d8bFVgzEAWJ4LPm7C+GjA=;
        b=NhAuNx2hRH7I5HTrgseohkAywJmS6quhZeL4g2mSVQXB/BJMuYcGSOacHlw//Sebdm
         wMKr2/d4K9SOFwphx4WezYolD/TGjIJSK5/7Z/TDsPu9pUrgOhHPlHFvxterdyKE2R+7
         9++jA/1wSe2cDgCWQEFAizv82BljibbafIdy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cS7wan9cbZoOd7zB1+M5b4d8bFVgzEAWJ4LPm7C+GjA=;
        b=B8TtY6oLzWK9o53w54sYv9gy+cjwAEGoVHGh7TiIoVh2m5FNyB0xMIaBpy7kVnO5UT
         uu9DpZOIiXnrrhzSLmb3Oj8YHvgm6XewrMT+0L2lDs6iWrBgDaOW+0OQeFk3lwr6APWF
         RvxKXm1t2ELB0z+EedX2zm4gIdDzX8qJPEUMkSkGHK6ApwybjB+t+gT6OnpWWBPKT8Mv
         gBJYU+eFiy7wiuTAMv5yflll9yFN9QcJWwK3XJdyzdPNPZ2wmf9mlSiW6vlMuJnNccWg
         aUnWc9VhBkvi/GbRoOezJN+U/A0XR+JG9c7hTC8SWdoLMDjEd50T6a85Gl1EEbXqkh7D
         ZcVg==
X-Gm-Message-State: AFqh2ko6OxmxXsYfbhxRe9Prts3Vqicd3c0pLlh+6W8HuyLfXDl0Y/tn
        RQYviW3Qqq9MBuTyD2P0li6Yog==
X-Google-Smtp-Source: AMrXdXtKyZgobe0TH/q4Y6zrqnUkBT5739LAWAPpq/BoGuch0+u3Sl8bu8jxd+foBa03ljivSBKLVA==
X-Received: by 2002:a62:30c2:0:b0:580:ccae:291c with SMTP id w185-20020a6230c2000000b00580ccae291cmr67924066pfw.24.1673657295096;
        Fri, 13 Jan 2023 16:48:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x9-20020aa79569000000b00581f8965116sm14170634pfq.202.2023.01.13.16.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 16:48:14 -0800 (PST)
Date:   Fri, 13 Jan 2023 16:48:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Terrell <terrelln@meta.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2] lib: zstd: Fix -Wstringop-overflow warning
Message-ID: <202301131643.6D23A4AEA1@keescook>
References: <20230104212048.gonna.331-kees@kernel.org>
 <93130521-AF03-4941-8FF1-C97C76027A02@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93130521-AF03-4941-8FF1-C97C76027A02@fb.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jan 10, 2023 at 11:10:08PM +0000, Nick Terrell wrote:
> 
> 
> > On Jan 4, 2023, at 1:20 PM, Kees Cook <keescook@chromium.org> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  This Message Is From an External Sender
> > 
> > |-------------------------------------------------------------------!
> > 
> > Fix the following -Wstringop-overflow warning when building with GCC 11+:
> > 
> > lib/zstd/decompress/huf_decompress.c: In function ‘HUF_readDTableX2_wksp’:
> > lib/zstd/decompress/huf_decompress.c:700:5: warning: ‘HUF_fillDTableX2.constprop’ accessing 624 bytes in a region of size 52 [-Wstringop-overflow=]
> >  700 |     HUF_fillDTableX2(dt, maxTableLog,
> >      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >  701 |                    wksp->sortedSymbol, sizeOfSort,
> >      |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >  702 |                    wksp->rankStart0, wksp->rankVal, maxW,
> >      |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >  703 |                    tableLog+1,
> >      |                    ~~~~~~~~~~~
> >  704 |                    wksp->calleeWksp, sizeof(wksp->calleeWksp) / sizeof(U32));
> >      |
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > lib/zstd/decompress/huf_decompress.c:700:5: note: referencing argument 6 of type ‘U32 (*)[13]’ {aka ‘unsigned int (*)[13]’}
> > lib/zstd/decompress/huf_decompress.c:571:13: note: in a call to function ‘HUF_fillDTableX2.constprop’
> >  571 | static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
> >      |             ^~~~~~~~~~~~~~~~
> > 
> > by using pointer notation instead of array notation.
> > 
> > This is one of the last remaining warnings to be fixed before globally
> > enabling -Wstringop-overflow.
> 
> The patch looks correct to me, thanks for reviving it. But, I was attempting to reproduce the issue,
> so I could better understand what's going on, and I wasn't able to reproduce it myself.
> 
> To attempt to reproduce, I applied this patch
> 
> ---
> diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
> index 20f08c644b71..190d3d5ab4be 100644
> --- a/lib/zstd/Makefile
> +++ b/lib/zstd/Makefile
> @@ -12,6 +12,8 @@ obj-$(CONFIG_ZSTD_COMPRESS) += zstd_compress.o
>  obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
>  obj-$(CONFIG_ZSTD_COMMON) += zstd_common.o
>  
> +ccflags-y := -Wstringop-overflow=4 -Werror
> +
>  zstd_compress-y := \
>                 zstd_compress_module.o \
>                 compress/fse_compress.o \
> ---
> 
> Then compiled on x86-64 with gcc 12.2.0 on tag v6.2-rc3. I saw no errors.
> I also tried with just `-Wstringop-overflow`, and on upstream zstd. I tried to
> make a minimal reproducer on godbolt, so I could see if it was the gcc version,
> but wasn't able to make it fail with any of them https://gcc.godbolt.org/z/Exzq9arMr.
> 
> Could you please tell me how to reproduce this warning?

I saw it like so with next-20230113 on x86_64:

$ gcc --version
gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0
...
$ make KCFLAGS=-Wstringop-overflow allmodconfig lib/zstd/decompress/huf_decompress.o

-- 
Kees Cook
