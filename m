Return-Path: <SRS0=thHn=D6=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92C1C4363A
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Oct 2020 17:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C48D20760
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Oct 2020 17:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD+nsvaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463150AbgJWRxC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Oct 2020 13:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463135AbgJWRxB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Oct 2020 13:53:01 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C06C0613CE;
        Fri, 23 Oct 2020 10:53:01 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y17so2205286ilg.4;
        Fri, 23 Oct 2020 10:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtAgTEHRkAGqz+I14jNPk509SDkqha7SHbM3mBCCgZY=;
        b=bD+nsvaIX4zp29UYZ+2JOdkUFkScGE8zl+rcJpNB4AsWeJe0EJpHRYpGF9ckMXyEAE
         eY6nY+lL78x+HZe3dqUl0NiWH3V7J8yP9nwnBEh+ssJ6yWJ4KLH8KjbXfyTlckN25RX7
         VkolVVpARdJ1j3kH8s9VUT9CY4qpphaYqthbfNQ+WP3Ff4aSw3LUoU5qWGc7iUFJ4n7y
         m1vAyhI1jWbcMfYcHDitC0D/AAPkG/igpqDpwO4crbtgU3PRhg2xswA6w78CDzh0jrBy
         /flM8gaJ2HK0VxqkgAi4O0EsED4eLdGMthqGWhfNnXJsLLDe2P8RUXvO4B5ieoJOO2Y+
         XtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtAgTEHRkAGqz+I14jNPk509SDkqha7SHbM3mBCCgZY=;
        b=nkc8Wk3oe776csUvW9tKM5/TjkI769bbWQZLz2sM3MJLr7UvzfGLS+MS6NLGGa+Wt2
         9hXbrU2Sr8/MPuoZRR+cRCLYJzZY0mLKyoKB+4nED58F4e1j6q6kiCKpp6UlAPJjEjZQ
         /x2QvJOJrhvxGdGFHRetdtATJ1pemGNeKiVponOccdntRBPENcA6JSROLRNa9GOSZJkb
         NDHA+LzDVjafpFb1W8z5o+r+SiZ9YkxNMibVnQxB17D+Z79FYRLhW6C3Cowu8346V19Y
         ApWURfbI4Z5XFJTH52kb3o1te+7b5lZBhA0zdciQNvqcCi1UjnfgB6JEDbpKQRZZ0n/g
         6TsQ==
X-Gm-Message-State: AOAM530PukmVntuq/bWd6EPs1Lt/8+ofst3PtijZ279K2WYDmQ/SkNcZ
        p44xUXUsYN1FrBqNDuuZjph86iCtjPNyJxpaqHUPsYp/Yk95sg==
X-Google-Smtp-Source: ABdhPJy2EtC+Jp6f2du99WT/FJet4nqfOd4rMxYcV8yqiQVUKzPy9q5NN3+QK+mO/scRsa8G2nVIF4q9Fo9IJWlasYo=
X-Received: by 2002:a92:ba14:: with SMTP id o20mr2650068ili.76.1603475580876;
 Fri, 23 Oct 2020 10:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com> <20201022075447.GO3819@arm.com>
 <78464155-f459-773f-d0ee-c5bdbeb39e5d@gmail.com> <202010221256.A4F95FD11@keescook>
 <180cd894-d42d-2bdb-093c-b5360b0ecb1e@gmail.com>
In-Reply-To: <180cd894-d42d-2bdb-093c-b5360b0ecb1e@gmail.com>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Fri, 23 Oct 2020 18:52:50 +0100
Message-ID: <CAJHCu1Jrtx=OVEiTVwPJg7CxRkV83tS=HsYeLoAGRf_tgYq_iQ@mail.gmail.com>
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, libc-alpha@sourceware.org,
        systemd-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <dave.martin@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On Thu, 22 Oct 2020 at 23:24, Topi Miettinen <toiwoton@gmail.com> wrote:
> SARA looks interesting. What is missing is a prctl() to enable all W^X
> protections irrevocably for the current process, then systemd could
> enable it for services with MemoryDenyWriteExecute=yes.

SARA actually has a procattr[0] interface to do just that.
There is also a library[1] to help using it.

> I didn't also see specific measures against memfd_create() or file
> system W&X, but perhaps those can be added later.

You are right, there are no measures against those vectors.
It would be interesting to add them, though.

> Maybe pkey_mprotect()
> is not handled either unless it uses the same LSM hook as mprotect().

IIRC mprotect is implemented more or less as a pkey_mprotect with -1 as pkey.
The same LSM hook should cover both.

Salvatore

[0] https://lore.kernel.org/lkml/1562410493-8661-10-git-send-email-s.mesoraca16@gmail.com/
[1] https://github.com/smeso/libsara
