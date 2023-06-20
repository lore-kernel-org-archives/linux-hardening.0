Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E810EB64D7
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Jun 2023 18:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjFTSm7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Jun 2023 14:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFTSm6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Jun 2023 14:42:58 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465C51733
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jun 2023 11:42:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-668711086f4so2104380b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jun 2023 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687286571; x=1689878571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+Plwr1huw+Iprthw8GSo9mwUqiU0W0HO5ZTEyvRXxM=;
        b=ky7pjJzMtQWP1zNtVfoPIiocJ5Jjmz3iNOCu22pPgRJ4IKBDArGJn/fwGyzo3UioAR
         He6IkG//7leBnBUqOmTMyScv+sRQmvzUHonIIvdPFuBCHhc9olFgH1HsitbSs7F7lvml
         fT25rEFkDoERwbsxJYyGjK+WRwU/fdTKFC/0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687286571; x=1689878571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+Plwr1huw+Iprthw8GSo9mwUqiU0W0HO5ZTEyvRXxM=;
        b=kVXBDc5Jp/+aY8UbX/enY0bcskqKjFf/FQrQD3kEpqpMvmTm6N+6WFJw6j21el1REH
         C0Len0v+Z0AtjmHE+xc4xDr5mC+EbzNBhrXeXrmm56RG2Fba2Nyt3H3zVn2C2GqEzqea
         UDjxpQddlaJ4rXwBWjvV8TTX3LW3vJ5qWaXuBQyE9vW+dMc/PVyrn9meKJchSxI4qBJb
         a6SbgVI1zARtN8ZLEfi5flMaOomEZYQZhizWWZE5GrFe9CtIoqP2fzh2dznof8nuGD77
         qbLzYMWBCTOFnZxb7MoNJgsUMT/pADqA+dUOiGW0tlfs9qjzTpZ81H8SCf0KSAeWFQ8h
         tIYw==
X-Gm-Message-State: AC+VfDzHASPuHIotE69ebSgMTgKnhwOV/CZg7hskj/YVenzvtaIAyQVc
        sEiQjRF0Ffk6notbRPZJmh0uvw==
X-Google-Smtp-Source: ACHHUZ6xyUn85z6Ohu6udB7Pzp4abdWNuTB2aieXWsmYAErGG6uR+KUaoZPZKjpuZDilSEYoGKMxhA==
X-Received: by 2002:a05:6a00:2353:b0:666:b22d:c6e0 with SMTP id j19-20020a056a00235300b00666b22dc6e0mr16497710pfj.11.1687286571456;
        Tue, 20 Jun 2023 11:42:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r23-20020a62e417000000b0063d670ad850sm1662655pfh.92.2023.06.20.11.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 11:42:50 -0700 (PDT)
Date:   Tue, 20 Jun 2023 11:42:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] readdir: Replace one-element arrays with
 flexible-array members
Message-ID: <202306201142.235D900@keescook>
References: <ZJHiPJkNKwxkKz1c@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJHiPJkNKwxkKz1c@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 20, 2023 at 11:30:36AM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in multiple structures.
> 
> Address the following -Wstringop-overflow warnings seen when built
> m68k architecture with m5307c3_defconfig configuration:
> In function '__put_user_fn',
>     inlined from 'fillonedir' at fs/readdir.c:170:2:
> include/asm-generic/uaccess.h:49:35: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>    49 |                 *(u8 __force *)to = *(u8 *)from;
>       |                 ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
> fs/readdir.c: In function 'fillonedir':
> fs/readdir.c:134:25: note: at offset 1 into destination object 'd_name' of size 1
>   134 |         char            d_name[1];
>       |                         ^~~~~~
> In function '__put_user_fn',
>     inlined from 'filldir' at fs/readdir.c:257:2:
> include/asm-generic/uaccess.h:49:35: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>    49 |                 *(u8 __force *)to = *(u8 *)from;
>       |                 ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
> fs/readdir.c: In function 'filldir':
> fs/readdir.c:211:25: note: at offset 1 into destination object 'd_name' of size 1
>   211 |         char            d_name[1];
>       |                         ^~~~~~
> 
> This helps with the ongoing efforts to globally enable
> -Wstringop-overflow.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/312
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks! We're getting closer every day to killing this code pattern
for good. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
