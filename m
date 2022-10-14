Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C9AC433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 14 Oct 2022 03:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJNDyX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 Oct 2022 23:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiJNDyT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 Oct 2022 23:54:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25829622B
        for <linux-hardening@vger.kernel.org>; Thu, 13 Oct 2022 20:54:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y191so3797465pfb.2
        for <linux-hardening@vger.kernel.org>; Thu, 13 Oct 2022 20:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQMeWu4NUS5XHxpYjKe5lPkeUdCMvZeCueelrFJNv7g=;
        b=hVsj8yBrgKuKkK7M8xkb+HyKOAR1jqjYGdTOSBbuFw1xtWaGZRldfWed4W2s4PX8vj
         gMHC+/MyceBR4MHXpZkl8R1pYEcZzKSZwB0eAGg1tk/SYjiAH2KDJtEmiRns8TV0xEj3
         Z26bm3qSWSWPK1j2fJ6oI+/9oCd9hoET+A3WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQMeWu4NUS5XHxpYjKe5lPkeUdCMvZeCueelrFJNv7g=;
        b=4kCnTw23DGDsNGFs+UgRGw9NSuUV+NOoSTRr0P7D+YaHkDBBhFdSP3mQ60vgNrhkj3
         Rs8xQatn0On9oJLEYVjtAccYpUA0Flk4yl0jvo9RHQG1lpWY75CvetHBSnCOicufU1KI
         6c9/ifOZCYx39hS/9TeT3RAITqnAOakanHs++PHNNE0mCqjfIKmOFWdo/sFX2Rx7mAmE
         lQhp2Yh+UpfQ86xK6cporZCGWbueb8WgEuFlhVUN+rzjUy6HF+6OJb4GTDe/1Vua5Ler
         jlRtCZMfiPKdLyl4777rYxfCLS3UNxhyqkrxATcNo75MRJKsquTCxAtCMy6b7AjPCQLQ
         RMYw==
X-Gm-Message-State: ACrzQf0VCzj4SAuLJG0oYFXkCvQ/Of+l8Q5rzw8A+ZzFoq18UJRig+xf
        jmf/xDjZ7vSjh8v0LEgDBz9l7w==
X-Google-Smtp-Source: AMsMyM7vCfA8wFrsyDJjLw6KB1kvioIeLEFXGEDdVpYcSJdvjz4XjS2+1dICHf/21nwZwt5L/DrvHw==
X-Received: by 2002:a63:591c:0:b0:464:bb3b:d1ad with SMTP id n28-20020a63591c000000b00464bb3bd1admr2830780pgb.146.1665719656162;
        Thu, 13 Oct 2022 20:54:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090a710400b0020ae09e9724sm474301pjk.53.2022.10.13.20.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:54:15 -0700 (PDT)
Date:   Thu, 13 Oct 2022 20:54:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jorge Merlino <jorge.merlino@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Todd Kjos <tkjos@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Prashanth Prahlad <pprahlad@redhat.com>,
        Micah Morton <mortonm@chromium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
Message-ID: <202210132052.32AE372@keescook>
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org>
 <20221006090506.paqjf537cox7lqrq@wittgenstein>
 <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
 <2032f766-1704-486b-8f24-a670c0b3cb32@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2032f766-1704-486b-8f24-a670c0b3cb32@app.fastmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 13, 2022 at 08:18:04PM -0700, Andy Lutomirski wrote:
> But seriously, this makes no sense at all.  It should not be possible to exec a program and then, without ptrace, change its cwd out from under it.  Do we really need to preserve this behavior?

Yup, already abandoned:
https://lore.kernel.org/lkml/202210061301.207A20C8E5@keescook/

-- 
Kees Cook
