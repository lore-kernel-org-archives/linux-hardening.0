Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17EAC54EBE
	for <linux-hardening@archiver.kernel.org>; Thu, 12 Jan 2023 23:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjALXXR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 18:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjALXXQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 18:23:16 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4443A625CD
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 15:23:12 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id l185so6303895vke.2
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 15:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqP4q8n6j5NHaDP6TuDnz+ZqcDtT1rQ6LqG9YVhAzNk=;
        b=eg3RE9eE29uzQpufWj+EWFWgVbO9hYfrRYmyCn4badSXfd5wzrqo8x24RQCBIfL9w0
         pYySdnvRZ67vL0HO5EpAi6jcVarBt1Qk938lZr8T80pRP6UQ1hUIOjvIFeOBQVRsBDcb
         E7N7Gfvj81+71cp1mOYeNeBnDw30sIfq3Wp1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqP4q8n6j5NHaDP6TuDnz+ZqcDtT1rQ6LqG9YVhAzNk=;
        b=4FhIgJpsgKX7Exa4X85RArFtpK0XaMxM2GiWNI5FbcWxDJm9/VzyVqoZvjbsua0/nE
         heTVcDOvEvDBX1oGPiuRdSvkJOeVD2chU5Hces1WnewLqG6kMa47jW6m93sytepqnplU
         Uhjckj0O4VbCTA4ZtFCz8tXmQMC3mRpOLmQCzR3CeoT4jV7kc5UMukmjX3WlUHXVBfQ6
         UAMnan9Mpp86MizWQax9kEsgUrvkDyyx4bGcXTxkJ4Zhxv3gODi9FdIrSRrDTXvRN971
         uziiGGbyTKzUj7np7N9MBFFq5v5ynTtMg6YWa0hpYJUofgZTo/fwbKGd+RuCeEEpJ9Th
         0R9w==
X-Gm-Message-State: AFqh2krlAoXN/V5Q8rDP9Tgdhw7czFHaJ9dlIZrlSwXyyMjfnYVVc725
        hWPHdKj5ZFosxZcr3aVzmjQYyuWvmFcVB8UniUQ=
X-Google-Smtp-Source: AMrXdXtyWKBGpwjGe12JUQmArDp5KtkZpK3sXQQCZI/ZJ/GdtfM4caq7Nj96Iz9mK96GZTFhdMvt1g==
X-Received: by 2002:a1f:1c0b:0:b0:3bd:795f:27b2 with SMTP id c11-20020a1f1c0b000000b003bd795f27b2mr5845101vkc.7.1673565791098;
        Thu, 12 Jan 2023 15:23:11 -0800 (PST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id d15-20020a05620a140f00b006fc92cf4703sm11453992qkj.132.2023.01.12.15.23.10
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 15:23:10 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id p17so13758212qvn.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 15:23:10 -0800 (PST)
X-Received: by 2002:a0c:e90a:0:b0:532:31b0:b4fa with SMTP id
 a10-20020a0ce90a000000b0053231b0b4famr1214830qvo.129.1673565789945; Thu, 12
 Jan 2023 15:23:09 -0800 (PST)
MIME-Version: 1.0
References: <167352819915167@kroah.com> <202301121346.D33FD799E7@keescook>
In-Reply-To: <202301121346.D33FD799E7@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jan 2023 17:22:53 -0600
X-Gmail-Original-Message-ID: <CAHk-=wjq1jd4ht7RvB8HYDJFAH=dRQ+43-mj3LWMJReF4yu34Q@mail.gmail.com>
Message-ID: <CAHk-=wjq1jd4ht7RvB8HYDJFAH=dRQ+43-mj3LWMJReF4yu34Q@mail.gmail.com>
Subject: Re: Patch "gcc: disable -Warray-bounds for gcc-11 too" has been added
 to the 6.1-stable tree
To:     Kees Cook <keescook@chromium.org>
Cc:     gregkh@linuxfoundation.org, kees@kernel.org, linux@roeck-us.net,
        vbabka@suse.cz, stable-commits@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 12, 2023 at 3:50 PM Kees Cook <keescook@chromium.org> wrote:
>
> Linus, this seems like a really giant hammer for a single warning on a
> single architecture for an option that gives us real bug coverage. I'm
> not sure GCC 11 will be going away any time soon, either. Can we please
> limit this to either just the affected file, or at least just powerpc?

We did exactly that with the gcc-12 case. Grep for
GCC12_NO_ARRAY_BOUNDS, and see the remaining case on the s390 side,
because initially it was limited to s390.

That was initially thought to be just an issue with gcc not liking how
s390 has special "short" pointers that gcc thought were some kind of
NULL pointer thing and then always considered everything to be
out-of-bounds.

See commit 8b202ee21839 ("s390: disable -Warray-bounds").

... and then a few months later, it turns out that that s390-specific
issue wasn't the only thing wrong with -Warray-bounds, and we disabled
it everywhere.

See commit f0be87c42cbd ("gcc-12: disable '-Warray-bounds' universally
for now").

I'm not going to play this game again. There is nothing that says that
this is powerpc-specific, it's probably just a thing where it triggers
on powerpc for some completely random reason.

And compiler bugs are not some kind of "let's just pray and hope it
doesn't hit us anywhere else". If the compiler is buggy, it's buggy,
and we should make sure we don't hit that bug.

So if you can actually show *why* it happens, and show that yes, this
is limited to only powerpc, then we can revisit.

But right now it seems a matter of "just by luck, we don't hit it
anywhere else", and I'm not interested in playing any more
whack-a-mole with this broken compiler option.

                    Linus
