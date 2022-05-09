Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5035C433EF
	for <linux-hardening@archiver.kernel.org>; Mon,  9 May 2022 20:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiEIVCr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 9 May 2022 17:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiEIVCp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 9 May 2022 17:02:45 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA3B2B8D27
        for <linux-hardening@vger.kernel.org>; Mon,  9 May 2022 13:58:51 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id l9-20020a4abe09000000b0035eb3d4a2aeso2789625oop.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 May 2022 13:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=yJKJ2ATgX9mu3/IffO/J0EaKq/jvo17mocUEhwCAE60=;
        b=XSieEDeLW/rwABKUVPDCvXH0w6sECAEnkGHzfrpHucsx1SHRgM/dcBpPOgHjWjsqCb
         leo0ETy5XMaX5kEfyv+oImCvgn/Nr2Cc8dOl33/gdLVYmaNnfeGnl1hjnE945VnzLQv+
         BbtHxr0VqtYXncjJAAbHq+uy1Wp20P5IVOeeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=yJKJ2ATgX9mu3/IffO/J0EaKq/jvo17mocUEhwCAE60=;
        b=OLcCXvksuwPLlYQ9DhZWPHWWTP+TfVBlE56qRRWDdShSp15gr3bEWhwrp0BOwRxjo4
         ZPPh9fmgiKaya0mu9Pa24LyBjj0lAFFXvhF6r6NR8VgGjn/1UTz8w/p818VUjEy14UNV
         +Gqqy6hwnWzAJnzufwyTMo2uGEj8P2b4KjvrCmWbVHertFGwZET+0e0Cb+0Ev7RsYk82
         bZr7TfRY0rAMT5Fre8fSMy6HAMXysKNxbmqLrGmzNFnS9VZcsMcIyohUD95uI9lE9HI8
         L/ZIP9kv6R0CgzUOMR/Wg2JY0g6Oq5W6Q274US0F5BZSRKS9zUiMArS6pfW/jmPQ4bAc
         1gyg==
X-Gm-Message-State: AOAM532Eo/r6TPTIcMT/krNHy9pSziKHSzDi2LjK30ME1zsokwgyX2ya
        PTx11kfVYiejpNd/YdU9GVvDeqD9Intr/f27FVrH8Q==
X-Google-Smtp-Source: ABdhPJwgrl6Fn8gygCe1A38ovT3ghIsMz7Z+cffAmaDb1TNKssJHWbHAPz8jQeXiKh9qKc+zQcnEutlFHA7Nq+3CFlQ=
X-Received: by 2002:a4a:6b49:0:b0:329:99cd:4fb8 with SMTP id
 h9-20020a4a6b49000000b0032999cd4fb8mr6472783oof.25.1652129930567; Mon, 09 May
 2022 13:58:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 May 2022 16:58:49 -0400
MIME-Version: 1.0
In-Reply-To: <8e472c9e-2076-bc25-5912-8433adf7b579@arbitrary.ch>
References: <8e472c9e-2076-bc25-5912-8433adf7b579@arbitrary.ch>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 9 May 2022 16:58:49 -0400
Message-ID: <CAE-0n53Ou1qgueFZ7zL-rFwsit6XJnYZkRtggdx3XXvL7HWrow@mail.gmail.com>
Subject: Re: [PATCH] Decouple slub_debug= from no_hash_pointers again
To:     Peter Gerber <peter@arbitrary.ch>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Quoting Peter Gerber (2022-05-08 07:56:29)
> While, as mentioned in 792702911f58, no_hash_pointers is what
> one wants for debugging, this option is also used for hardening.
>
> Various places recommend or use slub_debug for hardening:
>
> a) The Kernel Self Protection Project lists slub_debug as
>    a recommended setting. [1]
> b) Debian offers package hardening-runtime [2] which enables
>    slub_debug for hardening.
> c) Security- and privacy-oriented Tails enables slub_debug
>    by default [3].
>
> I understand that encountering hashed pointers during debugging
> is most unwanted. Thus, I updated the documentation to make
> it as clear as possible that no_hash_pointers is what one
> wants when using slub_debug for debugging. I also added a
> mentioned of the hardening use case in order to discourage
> any other, well-meant, tries to disable hashing with slub_debug.

Why not add a CONFIG_HARDENED_SLUB option that enables poisoning and
also makes slub debugging not print any messages to the kernel log
containing object internal details? Then it can be enabled in the kernel
config to harden slub and if the flag is enabled we don't hash pointers
based on 'slub_debug' existing on the commandline? And maybe add some
commandline argument like 'slub_debug=H' for "hardened" so it can be
turned off as well if it is built into the config.
