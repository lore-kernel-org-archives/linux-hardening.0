Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F936C4332F
	for <linux-hardening@archiver.kernel.org>; Mon, 17 Oct 2022 18:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJQSBq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJQSBp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 Oct 2022 14:01:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A5962916
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 11:01:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 70so11664065pjo.4
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0dPSILD0fz6+hHDKRa0DrcnmU24d1fwAr5y/3mLAghY=;
        b=mtxvCNrQHeFU2z7E52M6ReIfWOUx4f1Vt/0bBEhqoaLmsuIn38ne/1mVK2kth7WrqG
         VzhnEYQ/wCAvweINwfQk5bTcyUoZA4At01PZZUpRLs8PvOZ6Gf4AzrffzwoIrVYlhmyr
         7wXP+tBBLd1EMI+jW/o3qkR5qrK2YPVQN4e4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dPSILD0fz6+hHDKRa0DrcnmU24d1fwAr5y/3mLAghY=;
        b=NgMCrgBC9n6wdBV+9P8LiuOtbFRxKuXDBBlpMo7U2PAHgz4RxW2VdxptFzieS9dH1V
         I5hahSvjQsIow0CBqTB40wrVBa+RaHieK4k2mtkxB7V4/NZvCcbb+yi4O9syKFInnaBJ
         LEJ87laK5DqOzdr7235042X6/7YQIGmKPll0GO+l4C2mWdJnyRzGtBrR37P9ydUX4Tjy
         OtYEN0X7ljbhG1aIQYyTwyuwxXHpoctPxtKPi+pa/3ypLKPL7DqECD0vtzXXwKdUriaN
         V5cv2rbc7qF0pLXOJO8NwkWiLm0Hi9FoB1HgvVHMPVvPUDlSe78u+ni7wp+lpWf9nxoC
         pbHQ==
X-Gm-Message-State: ACrzQf3YOYLqqpBwzygkB/X0CppVac2EIxT1XFyuRYZHIP/ji1dStu3A
        bTzNVTEpCd8l4bQJg8QtPltbE7x/klXdYw==
X-Google-Smtp-Source: AMsMyM4kblho2j2or0iiU5gOYmPCRjaRxTYSNnheSLa4H+zvGlp3SbU0MsPiwxniAAbFp9Hjbf0SDQ==
X-Received: by 2002:a17:90a:f192:b0:20d:2ea6:4b18 with SMTP id bv18-20020a17090af19200b0020d2ea64b18mr15216803pjb.27.1666029701638;
        Mon, 17 Oct 2022 11:01:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x20-20020a17090300d400b0017f95efe62esm6851112plc.13.2022.10.17.11.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:01:40 -0700 (PDT)
Date:   Mon, 17 Oct 2022 11:01:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Message-ID: <202210171100.5BAC4A5CC8@keescook>
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 17, 2022 at 01:26:12PM -0300, Guilherme G. Piccoli wrote:
> On 06/10/2022 20:41, Kees Cook wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > The crypto 'compress' interface is deprecated, so before adding new
> > features, migrate to the acomp interface. Note that we are only using
> > synchronous implementations of acomp, so we don't have to deal with
> > asynchronous completion.

Ard, given your observation about all the per-cpu memory allocation,
should pstore still go ahead with this conversion?

-Kees

> > 
> > [ Tweaked error paths to avoid memory leak, as pointed out byGuilherme
> >   G. Piccoli <gpiccoli@igalia.com>, and fixed pstore_compress()
> >   return value -kees ]
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Link: https://lore.kernel.org/lkml/CAMj1kXFnoqj+cn-0dT8fg0kgLvVx+Q2Ex-4CUjSnA9yRprmC-w@mail.gmail.com/
> > Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  fs/pstore/platform.c | 74 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 57 insertions(+), 17 deletions(-)
> > 
> 
> Hi Kees, thanks for re-sending this one.
> 
> Just tested it on top of v6.0, with efi-pstore/ramoops, using zstd, lz4
> and deflate - everything working as expected.
> So, with the typo fixed, have my:
> 
> Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Thanks!

-- 
Kees Cook
