Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAAEC41513
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Jul 2023 17:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjG0RCc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Jul 2023 13:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjG0RCb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Jul 2023 13:02:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC8E271B
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 10:02:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8ad8383faso9771595ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690477349; x=1691082149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wT/ZsiiDZwcgiQgl4DELrnCzGmHF+3XYDdWiMBrFYvo=;
        b=K0phnEYk/GVAqF5YbTQkVwMdPv8mpH4CuAkx7IsfmRJ5aLTp4xG8IBBDRxwU3rp18M
         H3sZi0bD5d69IgZnJX0pGk+67CRDZxTrseYrgwlMhuP5Q9J4PWS82sWweo8TAt9iHOuR
         rX1q8/lxZ76BFQzEOl67eODr84NVHK31gql9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690477349; x=1691082149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wT/ZsiiDZwcgiQgl4DELrnCzGmHF+3XYDdWiMBrFYvo=;
        b=JTSk2t7HAyp/Y+iWi+ePIwgc0jk40W4vziPm4cFuDtMoDvOz8d0J0krtoWS7oOKiG4
         czuLVtIb2ZxZ0QlzxgK0BTCB9UDbT1Z/PAzN7xzb8OIL6lsCCZJjmMXqvxbSzTEHd9j2
         xmvS3UmvfVEoYAM/tfuDAt6sYckGdQnfFMmYfUVS5wbZ3RbDLk+fCYK1cNGfDuFFezNZ
         0OJgaMOyG8jNvGhIieRYCVGI9eYp7PukC43OcO5E9xJ1mXbaqsXxdehl2w9hd/3t6T8W
         IoM5kigUKlmgrrGqJ5kIykM07eF0fn+xkWtYsb2igKspnztwVDTEOfB/X+XeKKYHRIio
         v4xg==
X-Gm-Message-State: ABy/qLYSINREyJt+sPz/y3U3bARv0YyXHE0GJwkG6p4ydcdfJ9KWEqHP
        nkWl5C5E3iAQvaFDxzZ8ZIitfQ==
X-Google-Smtp-Source: APBJJlEJpUVqcSMnFLWNvhMQvBdF6RrGYz2iohHdmUVWppDCrgiBB6p74K9WRtxaVJoGd8oU9n28vw==
X-Received: by 2002:a17:902:dac4:b0:1bb:cd10:8209 with SMTP id q4-20020a170902dac400b001bbcd108209mr5653824plx.50.1690477348974;
        Thu, 27 Jul 2023 10:02:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902d38200b001ac7f583f72sm1879688pld.209.2023.07.27.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:02:28 -0700 (PDT)
Date:   Thu, 27 Jul 2023 10:02:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-hardening@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: Replace strlcpy with strscpy
Message-ID: <202307271001.13EA5FB@keescook>
References: <20230703181256.3712079-1-azeemshaikh38@gmail.com>
 <202307121653.4A9C69C655@keescook>
 <CADmuW3UY=w0p-h1h4qOord7z1nFnvpyCOU3fcCaATm_PvFFUeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADmuW3UY=w0p-h1h4qOord7z1nFnvpyCOU3fcCaATm_PvFFUeA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jul 18, 2023 at 12:38:37AM -0400, Azeem Shaikh wrote:
> On Wed, Jul 12, 2023 at 7:54 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Jul 03, 2023 at 06:12:56PM +0000, Azeem Shaikh wrote:
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit.
> > > This is both inefficient and can lead to linear read
> > > overflows if a source string is not NUL-terminated [1].
> > > In an effort to remove strlcpy() completely [2], replace
> > > strlcpy() here with strscpy().
> > >
> > > Direct replacement is safe here since DEV_ASSIGN is only used by
> > > TRACE macros and the return values are ignored.
> > >
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > > [2] https://github.com/KSPP/linux/issues/89
> > >
> > > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> >
> > Looks good -- thing is using return values from the macros.
> 
> Just to confirm, you mean *not* using return values from the macros?

I thought I'd replied to this, but I see it didn't happen: yes, I meant
"not using return values". Sorry for the confusion!

-- 
Kees Cook
