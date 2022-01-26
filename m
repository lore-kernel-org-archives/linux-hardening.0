Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB36AC28CF5
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jan 2022 20:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiAZUNS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiAZUNS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jan 2022 15:13:18 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17E7C06161C
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 12:13:17 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z5so572176plg.8
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 12:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wj7KZuqwaOnmEdiVWVR69LpJrxWukw8SVQkUC4MLo7s=;
        b=JIYMQZEueLmr/Bcu+0hn3GJkYnsMrkdWIxCMlEUBwg4HvJdd/pwwuuoFtclMne7x5f
         mBVWpQjR6YOrZexhCa/idsq6RSWlTK3VUS8Gft1RQQprU/wPVUmHmVKlGriHabfjGlyZ
         RSlRONtD2MuECMp9iPdBrJw00YjCmXqbC1UPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wj7KZuqwaOnmEdiVWVR69LpJrxWukw8SVQkUC4MLo7s=;
        b=yFb+dxy+Wp0CMwPJPrvkJ0RyOwHVr7IzPXMMrLjEyh5590iMzlP/UVBmsROmB5cuvn
         XIUsLvxNYHiZIfXYwPBO+upCIO7RWGe9CJ0e1/eRfNgvoQyd/KUSR44yzawjMxCWREOA
         eaRq15pLkMk8n8jZFv9xF94EIlScSuK3KZ9bOQscm+XWH8bvSgjKbgbnIKbpe47mjtp6
         HPq5HdIe0sA4Tp04oJAfEfNJOZjxOw7aAhq5oEzZK8lx2W4CfQ4T+I0EdmFW6Wx1j9Vl
         A//7N6ZLC5e/MONYcooXrzBOXxm11TgFDCKz0eMThUXD28rXIjevOJmoW4hRh5xfAQxo
         0mcA==
X-Gm-Message-State: AOAM533v5uAVdHgTWhxRpMG/wvoNH5cZbA4F9JEiSnlw+Eh/bxbLEWVz
        KH2ufh7kpTGV2rvVMzvn7EgxpA==
X-Google-Smtp-Source: ABdhPJxiY1aw0y3NlidY2z5Lk8fjvBuxzocWaDNhHTsZhuIhROUDos217Gqqbv4yyE8RnXJs6shjzQ==
X-Received: by 2002:a17:902:8f8a:: with SMTP id z10mr618939plo.59.1643227997497;
        Wed, 26 Jan 2022 12:13:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8sm3195141pfv.64.2022.01.26.12.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:13:17 -0800 (PST)
Date:   Wed, 26 Jan 2022 12:13:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Ariadne Conill <ariadne@dereferenced.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs/binfmt_elf: Add padding NULL when argc == 0
Message-ID: <202201261210.E0E7EB83@keescook>
References: <20220126175747.3270945-1-keescook@chromium.org>
 <CAG48ez3hN8+zNCmLVP0yU0A5op6BAS+A-rs05aiLm4RQvzzBpg@mail.gmail.com>
 <a89bb47f-677f-4ce7-fd-d3893fe0abbd@dereferenced.org>
 <CAG48ez3iEUDbM03axYSjWOSW+zt-khgzf8CfX1DHmf_6QZap6Q@mail.gmail.com>
 <202201261157.9C3D3C36@keescook>
 <YfGqLnE9wNieTsAg@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfGqLnE9wNieTsAg@casper.infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jan 26, 2022 at 08:08:14PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 26, 2022 at 11:58:39AM -0800, Kees Cook wrote:
> > We can't mutate argc; it'll turn at least some userspace into an
> > infinite loop:
> > https://sources.debian.org/src/valgrind/1:3.18.1-1/none/tests/execve.c/?hl=22#L22
> 
> How does that become an infinite loop?  We obviously wouldn't mutate
> argc in the caller, just the callee.

Oh, sorry, I misread. It's using /bin/true, not argv[0] (another bit of
code I found was using argv[0]). Yeah, {"", NULL} could work.

> Also, there's a version of this where we only mutate argc if we're
> executing a setuid program, which would remove the privilege
> escalation part of things.

True; though I'd like to keep the logic as non-specialized as possible.
I don't like making stuff conditional on privilege boundaries if we can
make it always happen.

-- 
Kees Cook
