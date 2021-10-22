Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A672C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 22 Oct 2021 03:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 087616103E
	for <linux-hardening@archiver.kernel.org>; Fri, 22 Oct 2021 03:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhJVDlW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbhJVDlW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 23:41:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C14C061766
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 20:39:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f21so1813540plb.3
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 20:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yy5rRpKo2fw53nbqx7qopu8aspq5/Q7NCCnnOq+gk3c=;
        b=Cn2Xsk7upRNROV5qt7FnTqWCajekr42FLh6s8J2a0aJQ836/Z3uSQ4Vk6PVWjRrdkg
         2fwCtanYMpNbn6R6rA6TPEAd6mvvkyZ7K5BDsCm3l2i5KHjSU6q31Qlh+Swh10NBpXpd
         wRVPrLAKa+et+O/gGLSt0NR6gkxStW4ptwf0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yy5rRpKo2fw53nbqx7qopu8aspq5/Q7NCCnnOq+gk3c=;
        b=r4QhbIBWpLhG0AtGNbN6qdV7BL0LIaQzuRLLVmuKVQHljpABon104jcXynR1T+QMHu
         7OOBvkeOEztLt5QbYMdWO41GeX7KL4OmkmeEh0y3ntYNzUTz1HlyzcrOCIII/rDy3YiA
         gNvz7T6cWoCLBDpWyLEwMaRkIyEDriGrysBRbpaXerYYOyRWYnX14d612zaruYK/CJnO
         1XaWXiE/dnMb6RIFQdGeWre5e+T5AT+ajzhoVXnNuGMc4wadUgUo1osslNYvbTqFABVR
         eIpIPiZEN5JkeptE1GFkhjeyzm+Wv6qC/6O9MawLsgFFM6tkbYrjJQN/0rk5kh6Mmpd9
         +2ow==
X-Gm-Message-State: AOAM533SaXll3DF8hVyywQ7k1K0FA3+bsmxcXrZMBnPdR0pxyquebWNr
        yr2Zx+hW0DRof72TkaV/rGKDig==
X-Google-Smtp-Source: ABdhPJyTM8I19F2FqzotuNQUV0QBtp7k6bw9s+ngwQ75RmF0tNa9jRPSOazWUsPVmZ5KB0k4z3J6jw==
X-Received: by 2002:a17:90b:3886:: with SMTP id mu6mr11450646pjb.40.1634873944883;
        Thu, 21 Oct 2021 20:39:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d137sm8200122pfd.72.2021.10.21.20.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 20:39:04 -0700 (PDT)
Date:   Thu, 21 Oct 2021 20:39:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Jordy Zomer <jordy@jordyzomer.github.io>, linux-mm@kvack.org,
        Dmitry Vyukov <dvyukov@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/secretmem: Avoid letting secretmem_users drop to zero
Message-ID: <202110212037.E18CD404@keescook>
References: <20211021154046.880251-1-keescook@chromium.org>
 <20211021195311.6058b90f573641542605dae4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021195311.6058b90f573641542605dae4@linux-foundation.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 21, 2021 at 07:53:11PM -0700, Andrew Morton wrote:
> On Thu, 21 Oct 2021 08:40:46 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > Quoting Dmitry: "refcount_inc() needs to be done before fd_install().
> > After fd_install() finishes, the fd can be used by userspace and we can
> > have secret data in memory before the refcount_inc().
> > 
> > A straightforward mis-use where a user will predict the returned fd
> > in another thread before the syscall returns and will use it to store
> > secret data is somewhat dubious because such a user just shoots themself
> > in the foot.
> > 
> > But a more interesting mis-use would be to close the predicted fd and
> > decrement the refcount before the corresponding refcount_inc, this way
> > one can briefly drop the refcount to zero while there are other users
> > of secretmem."
> > 
> > Move fd_install() after refcount_inc().
> 
> I added cc:stable.  Or doesn't the benefit/risk ratio justify that?

I hadn't because commit 110860541f44 ("mm/secretmem: use refcount_t
instead of atomic_t") wasn't, and this would build on top of it.

I think the exposure is very small in both places, so probably best to
avoid the churn, but I'm not _opposed_ to it.

-- 
Kees Cook
