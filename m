Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992E2C001DE
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Aug 2023 03:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjHKDbJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Aug 2023 23:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHKDbH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Aug 2023 23:31:07 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3480B2D6D
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 20:30:54 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bcaa6d5e2cso1497831a34.3
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 20:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691724653; x=1692329453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xp5z7LamodaJh/ClrTKA1pthnabqoNCq2DAQkj0S7TY=;
        b=cUqXMUhl3Ad4Rkz26Mf298USW9ZFOjP+ZB/jySpmq9wFBGIxjmfjRkGW99E2l41j/I
         GIeB3O6QXJu7N6xo4iQ3aPOoDXvFPXK4QvL7wt/C2ViuH/23B1aeA9mxfupAke64LsqL
         e1jX+yCBAQ/SYdEIdekfX1i7wcOHQAK5Aa8S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691724653; x=1692329453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp5z7LamodaJh/ClrTKA1pthnabqoNCq2DAQkj0S7TY=;
        b=O3FuMrOiIESt93SIaF1jU+hfsQytZHPt5pbs0omuZfSmOVIa/+Z/40gK02U0lxtUnM
         uOBB5B0DS89jUHAaPIB/fLE1hZ1JFNnvgRy+QLbj+aMggnF5wtfvx3x2u7cyBVtMRuwR
         sbl4oUXFnG6t6axvg21ruvu1lwIohThCuMCQjVVi+ZFY7FNO1aN26wkzMh/b652keQAd
         enVvfcMKj8uU21zKkhIsWmDHYQVctvbqG7SLVeglpqpaGv5aLlRdsuFfZqUpo8y5W1xK
         sNEoGeh73eodY9C8yYCeKxipfZuVKkLBouemN+7CUwNZy79/2kCFMVW94AR+we5S7c75
         mleQ==
X-Gm-Message-State: AOJu0YyXVfSEMUxcW65YgNhv+9xN0tuCqghh/AJeTnv0J08egEvmHtwB
        Ce47yt4VE0b8S7983XQq3dzcjA==
X-Google-Smtp-Source: AGHT+IFj85e9xsZ9mrk/Ueg+3ysiCqXhvilxABCE6TsZEtH6t1YoJtivtoiyacTW7b3eXBPwvtkUgg==
X-Received: by 2002:a05:6830:208f:b0:6bd:680:dc13 with SMTP id y15-20020a056830208f00b006bd0680dc13mr732483otq.21.1691724653560;
        Thu, 10 Aug 2023 20:30:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a031300b002677739860fsm2382311pje.34.2023.08.10.20.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 20:30:52 -0700 (PDT)
Date:   Thu, 10 Aug 2023 20:30:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-hardening@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: stable-rc: 6.1: gcc-plugins: Reorganize gimple includes for GCC
 13
Message-ID: <202308102030.76B5309D1@keescook>
References: <CA+G9fYsf0jePDO3VPz0pb1sURdefpYCAYH-y+OdsAf3HuzbeRw@mail.gmail.com>
 <202308101328.40620220CB@keescook>
 <CA+G9fYugggRyxJFgxRwb0GvgXPerCE928S5vVW7ZnzfTJCRnZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYugggRyxJFgxRwb0GvgXPerCE928S5vVW7ZnzfTJCRnZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 11, 2023 at 08:47:53AM +0530, Naresh Kamboju wrote:
> > > # first fixed commit: [e6a71160cc145e18ab45195abf89884112e02dfb]
> > >    gcc-plugins: Reorganize gimple includes for GCC 13
> [...]
> 
> > Commit e6a71160cc14 ("gcc-plugins: Reorganize gimple includes
> > for GCC 13") was added in v6.2.
> 
> This commit is needed.
> 
> >
> > I think you're saying you need it backported to the v6.1 stable tree?
> > ("First bad commit" is really the first good commit?)
> 
> First good commit.
> We need to backport this patch for linux.6.1.y

Okay! Thanks. :) Yeah, this could probably go to all the stable kernels,
if someone wants to build with GCC 13 on older kernels.

-- 
Kees Cook
