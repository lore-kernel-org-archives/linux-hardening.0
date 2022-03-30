Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720D2C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Mar 2022 21:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351288AbiC3VpU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Mar 2022 17:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351296AbiC3VpS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Mar 2022 17:45:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DC56A42A
        for <linux-hardening@vger.kernel.org>; Wed, 30 Mar 2022 14:43:27 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t4so15430462pgc.1
        for <linux-hardening@vger.kernel.org>; Wed, 30 Mar 2022 14:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3P2ZbSJZ9rgiHSYYO2m+2nx9BByc630ioHG/IwLoqJE=;
        b=PjUfutm1lwuZaM1pE8wgcTpIk9hG3LkKam3kBHUB2ZUJS03trhR+Q11c7jyPX0kRlw
         WUSUUF0BakNGVgLGhV6Rmk5ubdoZL3PdnInLnWzcwz7dXKNBpsSLcHbQUEZ25E663cxN
         iSHaORzhGnqOpItkX1nzwI1xILdSFE//tB+94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3P2ZbSJZ9rgiHSYYO2m+2nx9BByc630ioHG/IwLoqJE=;
        b=wiTPh23pvqOt8prOdhLnF3/ofGFGd8bp9SBvwA8LOmUllsOdBIIo+nCD/VtAaWTGJ5
         oxrt05veWnayA3ypJy8ueaHRY3dAbltCE4wkkZyUHxrB45pGMF3AweuQ9IEvZ1VQrBeK
         LO/dYoKgYMFtMPxY1Y6FkqYSxZqzN0p0yrJSXrAcSYn/oB3X3S+zO848b3A+QfdTad7V
         Y5vK55II0VEYkalm0zXbRVOOid4kRdCiRCXVzUNNBW/UOE3kKtAAnwQOJf9LZYFvBYbK
         LVwTYw3eUD1Uz2jRqzN5a46Ked2qbdiJQJBt/BEkblTZSqZI/d7t8CFiN1k04IHHAj3u
         Y/eQ==
X-Gm-Message-State: AOAM531UA+5E4ZtPoT+M6gmKThLGJiPiOaxpkbdjdGqJa4uWDOY36pna
        QIo7r8H/sWM64UJNOirneS7brQ==
X-Google-Smtp-Source: ABdhPJw+oIZ8Zdq1D8w87isFRTzwrCPJdubT8myP52JAOXHEOY4AG29Q15HtDYJmZ5irVYhIv9Qklg==
X-Received: by 2002:a63:340b:0:b0:398:dad:c396 with SMTP id b11-20020a63340b000000b003980dadc396mr7709875pga.574.1648676606992;
        Wed, 30 Mar 2022 14:43:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v189-20020a622fc6000000b004fb72e95806sm10161274pfv.48.2022.03.30.14.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 14:43:26 -0700 (PDT)
Date:   Wed, 30 Mar 2022 14:43:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] lib: zstd: Fix Wstringop-overflow warning
Message-ID: <202203301416.568595B87@keescook>
References: <20220330193352.GA119296@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220330193352.GA119296@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 30, 2022 at 02:33:52PM -0500, Gustavo A. R. Silva wrote:
> Fix the following -Wstringop-overflow warning when building with GCC-11:
> 
> lib/zstd/decompress/huf_decompress.c: In function ‘HUF_readDTableX2_wksp’:
> lib/zstd/decompress/huf_decompress.c:700:5: warning: ‘HUF_fillDTableX2.constprop’ accessing 624 bytes in a region of size 52 [-Wstringop-overflow=]
>   700 |     HUF_fillDTableX2(dt, maxTableLog,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   701 |                    wksp->sortedSymbol, sizeOfSort,
>       |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   702 |                    wksp->rankStart0, wksp->rankVal, maxW,
>       |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   703 |                    tableLog+1,
>       |                    ~~~~~~~~~~~
>   704 |                    wksp->calleeWksp, sizeof(wksp->calleeWksp) / sizeof(U32));
>       |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/zstd/decompress/huf_decompress.c:700:5: note: referencing argument 6 of type ‘U32 (*)[13]’ {aka ‘unsigned int (*)[13]’}
> lib/zstd/decompress/huf_decompress.c:571:13: note: in a call to function ‘HUF_fillDTableX2.constprop’
>   571 | static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
>       |             ^~~~~~~~~~~~~~~~

Reviewing this changes would be easier if the reason for the warning
could be explained. i.e. why has GCC decided that the region is 52
bytes, and how did it calculate the 624 bytes?

rankVal_t is HUF_TABLELOG_MAX-many rankValCol_t, which itself is
HUF_TABLELOG_MAX + 1 many U32s. So, basically:

U32 array[HUF_TABLELOG_MAX + 1][HUF_TABLELOG_MAX]

sizeof(rankValCol_t) == 52
sizeof(rankVal_t) == 624

> 
> by using pointer notation instead of array notation.
> 
> This helps with the ongoing efforts to globally enable
> -Wstringop-overflow.
> 
> Link: https://github.com/KSPP/linux/issues/181
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  lib/zstd/decompress/huf_decompress.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/zstd/decompress/huf_decompress.c b/lib/zstd/decompress/huf_decompress.c
> index 5105e59ac04a..0ea34621253a 100644
> --- a/lib/zstd/decompress/huf_decompress.c
> +++ b/lib/zstd/decompress/huf_decompress.c
> @@ -570,7 +570,7 @@ static void HUF_fillDTableX2Level2(HUF_DEltX2* DTable, U32 sizeLog, const U32 co
>  
>  static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
>                             const sortedSymbol_t* sortedList, const U32 sortedListSize,
> -                           const U32* rankStart, rankVal_t rankValOrigin, const U32 maxWeight,
> +                           const U32* rankStart, const U32* rankValOrigin, const U32 maxWeight,
>                             const U32 nbBitsBaseline, U32* wksp, size_t wkspSize)

This really feels like we're papering over the warning. This removes the
type information and makes it a U32 * instead, and then later makes a
cast?

Can this be fixed in a way that retains the type information?

On the other hand, all the arguments are also U32 *.

I see stuff like:

    ZSTD_memcpy(rankVal, rankValOrigin, sizeof(U32) * (HUF_TABLELOG_MAX + 1));

That looks like it's ignoring type information as well. i.e. why isn't
this sizeof(rankValOrigin)? (The length above is 52 bytes.)

I'm especially curious here since rankValOrigin is rankVal_t, which is
624 bytes, not 52 bytes (i.e. the above is copying a single rankValCol_t
from rankValOrigin. I'd expect this to be:

    ZSTD_memcpy(rankVal, &rankValOrigin[0], sizeof(rankValOrigin[0]));


>  {
>      U32* rankVal = wksp;
> @@ -598,7 +598,7 @@ static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
>              if (minWeight < 1) minWeight = 1;
>              sortedRank = rankStart[minWeight];
>              HUF_fillDTableX2Level2(DTable+start, targetLog-nbBits, nbBits,
> -                           rankValOrigin[nbBits], minWeight,
> +                           rankValOrigin + nbBits, minWeight,

And here I'd expect to pass	&rankValOrigin[nbBits]
since HUF_fillDTableX2Level2 is doing another rankValCol_t-sized copy:

    ZSTD_memcpy(rankVal, rankValOrigin, sizeof(U32) * (HUF_TABLELOG_MAX + 1));


>                             sortedList+sortedRank, sortedListSize-sortedRank,
>                             nbBitsBaseline, symbol, wksp, wkspSize);
>          } else {
> @@ -699,7 +699,7 @@ size_t HUF_readDTableX2_wksp(HUF_DTable* DTable,
>  
>      HUF_fillDTableX2(dt, maxTableLog,
>                     wksp->sortedSymbol, sizeOfSort,
> -                   wksp->rankStart0, wksp->rankVal, maxW,
> +                   wksp->rankStart0, (U32 *)wksp->rankVal, maxW,

It's possible the problem is with this structure:

typedef struct {
    rankValCol_t rankVal[HUF_TABLELOG_MAX];
    U32 rankStats[HUF_TABLELOG_MAX + 1];
    U32 rankStart0[HUF_TABLELOG_MAX + 2];
    sortedSymbol_t sortedSymbol[HUF_SYMBOLVALUE_MAX + 1];
    BYTE weightList[HUF_SYMBOLVALUE_MAX + 1];
    U32 calleeWksp[HUF_READ_STATS_WORKSPACE_SIZE_U32];
} HUF_ReadDTableX2_Workspace;

it's not using the rankVal_t type for rankVal for some reason?

i.e. what's passed to HUF_fillDTableX2 is a rankValCol_t (52 bytes), but then it
gets passed against later as rankVal_t (624 bytes).

Does changing the type definition above solve this more cleanly?

-Kees

>                     tableLog+1,
>                     wksp->calleeWksp, sizeof(wksp->calleeWksp) / sizeof(U32));
>  
> -- 
> 2.27.0
> 

-- 
Kees Cook
