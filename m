Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC75C0015E
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Jul 2023 18:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjG0SEp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Jul 2023 14:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjG0SEo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Jul 2023 14:04:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EC830E4
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 11:04:43 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-26830595676so892544a91.2
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 11:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690481082; x=1691085882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h+I2rUZpDiTUDz1eI1/pLmSTQ4ciwxWtdKkx2t6+9gU=;
        b=bRiQGknq+7aGWyD59ocPn2d4UDEvTzh+33b2zNoZ8qUVkXCs9cW8kCWTFviZxRD67t
         mDuVJDfuSJMiS3E+Gya6vTjlmV3wtgFpbpyE/VhiK35nq0s3HwKCLOAq45+uRwboHFTD
         sg1B4rgVTgCol91uSPM0lWTPiCEXxqu4mgOAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690481082; x=1691085882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+I2rUZpDiTUDz1eI1/pLmSTQ4ciwxWtdKkx2t6+9gU=;
        b=dp0MIVHRSuQXZHStqvkv8pAYAs96/fmTtt+2jojN69ToQaKMjYgm3tIv16rCIc6NQY
         nS5l4N/ceMTInvhHAcCZewb0LL5VIWUYdCdpzCXMv0o/LhZHe53sxqTqRmFZkAJZtpBK
         YMoyHlFHOIkD3XoMIfy2sSNi2nyTMpggclCbKJvnX/CYjoji6g49Ttji0OeTuEnz4jkW
         Kl0D0lFSfnuYT1tO24EWpNvl1fAzytjkjrikLNKTiRKWL4ol+rkX+sVfr2my3tgOU9s/
         SyQJhfxhfa+HFC/CWOhR+PjsNwlocTQiQZb6i4M02O/VgX5YuVbOZM8DqKyUIAb3XA/3
         42kw==
X-Gm-Message-State: ABy/qLbTZhIrI5cwASJhjNlmT9EKsz77qWvZI8bJQ2kumrADFZ1onBdg
        /NDlXgNBCsm9+/w/p/TCI3yBEQ==
X-Google-Smtp-Source: APBJJlGCWTnOQJaIeXyvlGXeaqYb+A8tGwmmSHUsP8rS7iOkRaT0xuDVulIjt81SVYkvZfsbc4BkHw==
X-Received: by 2002:a17:90a:fc98:b0:262:f06d:c0fc with SMTP id ci24-20020a17090afc9800b00262f06dc0fcmr81171pjb.7.1690481082683;
        Thu, 27 Jul 2023 11:04:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s9-20020a17090ad48900b00265c9062f94sm1486014pju.21.2023.07.27.11.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:04:42 -0700 (PDT)
Date:   Thu, 27 Jul 2023 11:04:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Replace strlcpy with strscpy
Message-ID: <202307271104.9502C1B932@keescook>
References: <20230710030625.812707-1-azeemshaikh38@gmail.com>
 <169047317161.2400214.15246406234885315012.b4-ty@chromium.org>
 <87pm4dz6js.fsf@kernel.org>
 <202307271003.BCF5F3597@keescook>
 <CA+ASDXPak0M4zSwiTFpkRxw_WOmBmKJUTi9i5wCOY89fiP1vng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+ASDXPak0M4zSwiTFpkRxw_WOmBmKJUTi9i5wCOY89fiP1vng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jul 27, 2023 at 10:30:29AM -0700, Brian Norris wrote:
> On Thu, Jul 27, 2023 at 10:04 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Jul 27, 2023 at 07:02:31PM +0300, Kalle Valo wrote:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=caf9ead2c7d06fd7aa4cb48bd569ad61db9a0b4a
> >
> > For the patch you linked to -- it's okay to have lost the overflow
> > detection and warning?
> 
> It's a fixed constant string being copied into a larger fixed array.
> It really doesn't matter functionality-wise. At best, the error check
> would be useful for human readers or automated tools. So I didn't
> bother complaining one way or another, as it took enough tries for the
> submitter to get things right in the first place.

Gotcha. Thanks!

-- 
Kees Cook
