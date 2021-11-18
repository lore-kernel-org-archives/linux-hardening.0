Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1276C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 18:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96216137F
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 18:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhKRSc0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Nov 2021 13:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhKRScZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Nov 2021 13:32:25 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E66BC061574
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 10:29:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q17so5977754plr.11
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 10:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aJ9zhx5y0aG/RaME3/5ksU42Do7i2tWs6AW5Cr2sJu0=;
        b=moOTaEpnht4Ful9gObA6oYHZZUxom2eQ/nowHHfSiH9vWrs9UBXVLwztRc4/WQNs1g
         FWWx37YcaSyX9KoSDp42d3lBDaSiQXhHTpa1Tj+I+GHe1J8aBYXnXp1PBQ7h9gLa4Iz8
         8tmbGSQny4Y97mPl1P67a00DO9QMp6pObI47Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aJ9zhx5y0aG/RaME3/5ksU42Do7i2tWs6AW5Cr2sJu0=;
        b=1Dt4Soz0n8p/2kltW8pzdcMUwudN5iVueM76QhJDnWydVOaHidhSF/gQSohvdXVDUo
         ZhTjnBZv8OD7FSHp2tq9SlLR2UWck+TGhbejZnbFEN/b8q6pIMlbH1cfBwuYnyuGPA2y
         wOYYiCkn5I2G57ran1Yi//OEPyh9GNvZAZvyfcQoTY+AiZ+i5gs4h8Pa8QQIGuKn66a+
         CV8z3U8L9l0Ajws6KXB65r5Y5//nOgTC0McQsVxPs6yz64y9sfTK1IO0EBGtj22dsT8o
         oGoVsSnpGnkjxDhIHNJFPzOfIFr+GXW4+v6OD+xFkRoVI2hVD/Q6cDm8ZtShjPHaSOJl
         pxrA==
X-Gm-Message-State: AOAM530c6MQZHpO0OPEr1I+8ir5L1H6gUYFXcrb9yOIp25AWmmpkqP0n
        n8FPVTIoUBtHZUht96BSiBN+pw==
X-Google-Smtp-Source: ABdhPJyfmoc6S1n51Fi29lAjKMKHjeYfaWcjjKHh2r2tdLjejVzDr3BzNicARWYsyNzPw+XDEZof6w==
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr12803684pjb.173.1637260165083;
        Thu, 18 Nov 2021 10:29:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c9sm271751pgq.58.2021.11.18.10.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:29:24 -0800 (PST)
Date:   Thu, 18 Nov 2021 10:29:24 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, Colin Cross <ccross@android.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Revert "mark pstore-blk as broken"
Message-ID: <202111181026.D7EF6BCED@keescook>
References: <20211116181559.3975566-1-keescook@chromium.org>
 <163710862474.168539.12611066078131838062.b4-ty@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163710862474.168539.12611066078131838062.b4-ty@kernel.dk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 16, 2021 at 05:23:44PM -0700, Jens Axboe wrote:
> On Tue, 16 Nov 2021 10:15:59 -0800, Kees Cook wrote:
> > This reverts commit d07f3b081ee632268786601f55e1334d1f68b997.
> > 
> > pstore-blk was fixed to avoid the unwanted APIs in commit 7bb9557b48fc
> > ("pstore/blk: Use the normal block device I/O path"), which landed in
> > the same release as the commit adding BROKEN.
> > 
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] Revert "mark pstore-blk as broken"
>       commit: d1faacbf67b1944f0e0c618dc581d929263f6fe9

Thanks! I realize now what Geert meant in an earlier thread that I
actually can't split this change from a warning fix that was living in
the pstore tree (and was masked by the now removed BROKEN). Can you take
this patch as well? I've removed it from my tree now...

https://lore.kernel.org/lkml/20211118182621.1280983-1-keescook@chromium.org/

-- 
Kees Cook
