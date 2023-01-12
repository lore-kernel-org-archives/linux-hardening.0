Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181F3C54EBE
	for <linux-hardening@archiver.kernel.org>; Thu, 12 Jan 2023 22:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbjALWyG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 17:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240676AbjALWyD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 17:54:03 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6699F59539
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:54:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p24so21658233plw.11
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQ92ABzCp6Jl5QDky7FURKc+0/452Lig7If4O1MqQzg=;
        b=PKyEQ52i3ol00UrT1vGbws7m4PqbNRc0gRSeV1duTeoKgk+58OhABGjiPstS9MzTvh
         AzhHO3nCZh0tYXjxyeJLi5AsO4vlwlaZwEk+Ab4QFUy+6NKVwSv+Yqgt5MTxn8qcKcxl
         5We2FDl8IN23vtUDhG/H2rkax3wh2N4VWUf84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQ92ABzCp6Jl5QDky7FURKc+0/452Lig7If4O1MqQzg=;
        b=KtjHzbHr9PRII4YhjBwLxQc1zrn0Tew2rs4ZXn0wObnJvFsqGlyHlOl+Bwv4FSHSDC
         ez8zEJhxjGUPsCRLe1xDxtv7yPdPt3mMJQ2CFRSzZ1jlPsx8lQMIJWa60rUVDmYmLEyb
         VIiDpU6NXkbyXjtsJEvi6ujecJgKNEFJ1dCmG/CgCVBWqALW9nCB9otPEhhLN50TRusf
         dX2Rd4NmGNj4Y54x2KBveSHrA5IinhkjMS4j9Rp/wQiYYFotin9MaimFJSpcX77hcScT
         JvlixlyMs3JVzm5BVPe7E9EbBF5m5bkla8T3umMOLktPZO7NIp2UA6s7ceSs6mZHZAoE
         PEUA==
X-Gm-Message-State: AFqh2kpwQpQJUlyWPFbvZO22DGP3uLS6IvbAQTD/K6OCOUzJWSD4tACd
        I73NAuRvKXWZlHD/ltgDw+lljw==
X-Google-Smtp-Source: AMrXdXvMv8yN47H6GSFCZr5psKK8TzKaYe0YkAruHqVF2SbvjKlRhxKmgs+QSymp13hXwlB3hjshxA==
X-Received: by 2002:a17:902:bc81:b0:192:bb38:c412 with SMTP id bb1-20020a170902bc8100b00192bb38c412mr43457240plb.44.1673564041886;
        Thu, 12 Jan 2023 14:54:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ik4-20020a170902ab0400b001925d6fdfebsm3976552plb.299.2023.01.12.14.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:54:01 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:54:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Halasa <khalasa@piap.pl>, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: ixp4xx: Replace 0-length arrays with flexible arrays
Message-ID: <202301121452.14D1A95CA@keescook>
References: <20230105215706.never.027-kees@kernel.org>
 <CACRpkdYfsY7K8GksccDunCfKHbq_Df8ddrYGRg2gmeu6CVCF5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYfsY7K8GksccDunCfKHbq_Df8ddrYGRg2gmeu6CVCF5w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Jan 08, 2023 at 12:58:37AM +0100, Linus Walleij wrote:
> On Thu, Jan 5, 2023 at 10:57 PM Kees Cook <keescook@chromium.org> wrote:
> 
> > Zero-length arrays are deprecated[1]. Replace npe_load_firmware's
> > union of 0-length arrays with flexible arrays. Detected with GCC 13,
> > using -fstrict-flex-arrays=3:
> >
> > drivers/soc/ixp4xx/ixp4xx-npe.c: In function 'npe_load_firmware':
> > drivers/soc/ixp4xx/ixp4xx-npe.c:570:60: warning: array subscript i is outside array bounds of 'u32[0]' {aka 'unsigned int[]'} [-Warray-bounds=]
> >   570 |                         image->data[i] = swab32(image->data[i]);
> > include/uapi/linux/swab.h:115:54: note: in definition of macro '__swab32'
> >   115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
> >       |                                                      ^
> > drivers/soc/ixp4xx/ixp4xx-npe.c:570:42: note: in expansion of macro 'swab32'
> >   570 |                         image->data[i] = swab32(image->data[i]);
> >       |                                          ^~~~~~
> > drivers/soc/ixp4xx/ixp4xx-npe.c:522:29: note: while referencing 'data'
> >   522 |                         u32 data[0];
> >       |                             ^~~~
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> >
> > Cc: Krzysztof Halasa <khalasa@piap.pl>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Looks good to me:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

> Do you need me to funnel this to the SoC tree or do you have
> some quickpath for fixes like this?

I'll take it via my tree if unless you'd rather it go through yours.
Most maintainers take these directly, but some don't want to. I'm
flexible! :)

-- 
Kees Cook
