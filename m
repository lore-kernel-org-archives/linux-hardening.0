Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF15C433F5
	for <linux-hardening@archiver.kernel.org>; Sun,  6 Feb 2022 18:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345918AbiBFSed (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 6 Feb 2022 13:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiBFSec (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 6 Feb 2022 13:34:32 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BDEC043184
        for <linux-hardening@vger.kernel.org>; Sun,  6 Feb 2022 10:34:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cf2so9393462edb.9
        for <linux-hardening@vger.kernel.org>; Sun, 06 Feb 2022 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipr/Xj8fJQrczHUCPPzyBQs76OpGS0ISVv/nwSX/Q/g=;
        b=dYRZuMOdE0zra95En3hQ336g936a76Wau4yHF4u1bfE01951DLVfumlqZ9Q74obZqc
         hPZ9xZ99bpUlqu83kcZVxPY/qOaQZOqvKsZfDCRfBBsZYHufiU6QnM0FeFVF0s/hqsd1
         PuZGdkt8GAATL9YRERL6Kc+k6WnrbrcLjLnV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipr/Xj8fJQrczHUCPPzyBQs76OpGS0ISVv/nwSX/Q/g=;
        b=EKL1SUWOSEbKSC7SUyvcyFyHo5uFLTeGY3z/A9w/Eba/iU7r8+t1NEz7z7CCGJzjTy
         XIAVNox9MK7J51UMAzBvc1DXq1EjRyKE57XA697CrWp6NmppSOGWG5qvdRohW1k/YTzy
         6aDRJOYe7MjQqmfYntT40LTXCCuAb4RBO6yOAarMlpHoT9gOG0G9Iva8yaZkKu6SicT1
         VpW/5No4EtMkn3IROVzfPYVqQHEsajpRnzinDI5G7pvb/rSLp++wMtXYG2bYwVdpiseJ
         XQ6MVKd7egEgf39cOqagGmlpi7Sl4rnHwnJlbeWRueK3tyP5ZvTiqDVuetj8bxlfbJBa
         kOKQ==
X-Gm-Message-State: AOAM532q1BGaklgrHhyM0B7A8X8uN0LbQOmDH9lkEgFykQTYi5IK6frn
        mLot7yUqE9uvY76sJ/Pi0IkoUbnVHkbKrfKZ
X-Google-Smtp-Source: ABdhPJwtRkFTce01nXIUeNCB+UWL701UtbdTb6lRao4bBmEtTEk5SqUCOi/b/1BC/+YMet8cN2lb6Q==
X-Received: by 2002:a05:6402:51d1:: with SMTP id r17mr10010418edd.22.1644172469158;
        Sun, 06 Feb 2022 10:34:29 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id e2sm2844093ejr.210.2022.02.06.10.34.27
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 10:34:28 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id v19so6243503wrv.6
        for <linux-hardening@vger.kernel.org>; Sun, 06 Feb 2022 10:34:27 -0800 (PST)
X-Received: by 2002:adf:d1c8:: with SMTP id b8mr7032248wrd.442.1644172467014;
 Sun, 06 Feb 2022 10:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20220206174508.2425076-1-keescook@chromium.org> <20220206174508.2425076-3-keescook@chromium.org>
In-Reply-To: <20220206174508.2425076-3-keescook@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Feb 2022 10:34:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5oaiJty+pCLd7aS3c-86=JDvF_vuaUvyq+Yo6+cKhyg@mail.gmail.com>
Message-ID: <CAHk-=wg5oaiJty+pCLd7aS3c-86=JDvF_vuaUvyq+Yo6+cKhyg@mail.gmail.com>
Subject: Re: [PATCH 2/3] gcc-plugins/stackleak: Exactly match strings instead
 of prefixes
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Feb 6, 2022 at 9:45 AM Kees Cook <keescook@chromium.org> wrote:
>
> +       return !strncmp(TREE_STRING_POINTER(node), string, length);

Why is this "strncmp()"? That makes no sense when you've just checked
the exact lengths of both sides.

You're not comparing strings any more, you've already checked the end
of the string - you are comparing memory contents.

So make it just do a "memcmp()".

> +#define STRING_EQUAL(node, str)        string_equal(node, str, strlen(str))

.. and please change this name too, since it's not comparing two
strings. The first argument is something else entirely.

It's checking the node value of a section, give it some name related to that.

I do also get the feeling that the nodes should actually be checked to
be a STRING_CST rather than these blind TREE_VALUE() following things,
but I don't really know the rules for gcc plugin internals very well -
or at all, really.

                   Linus
