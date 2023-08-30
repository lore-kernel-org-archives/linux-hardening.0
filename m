Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D35C6FA8F
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 21:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbjH3V36 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 17:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjH3V36 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 17:29:58 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29ADCE7
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 14:29:24 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a8506f5b73so60870b6e.0
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693430902; x=1694035702; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mX87NFpq5hOfvdT04Pm6d0i+GaLVpBWiM2uVOuPxz60=;
        b=cYHrhovLKJ0sEMTq4zgO8HS67HCdrzFmVUyOFqBC80H2PibOEVEyQmgob1ZHoz+uc3
         ReBfEXceHcuJIGzKuZg91AUrGrm/d7ab0MgnMD/KyCAc295wb3rSmU+XRPMeYeXaBpFA
         Aor+lq3y59gsc7+LGZd94tATl8pE/JJOxarXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430902; x=1694035702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mX87NFpq5hOfvdT04Pm6d0i+GaLVpBWiM2uVOuPxz60=;
        b=mE288s14gBIRL0VUXtyGWFAb0izEixMo9E43eB/mx/2T6fkvV31ZlXy9/g0yX/d76l
         zl6UYnWzOKPetdhTCtWClhAqqf8dvnWTA1vSyBiMemeBxAV27vkQYOd0/7wyLCpr4po0
         U2VYfbp0F42pyO9aR4EdfQgI2BwVjZPDJYtXf2gk48vhgUvzBBOMDZOjjcyQl1MsA41V
         lQHwUIlRyjgF9qol/7EOMfj6jEVbLHOy9qahMXvE8UUDI/fOJRqpdLXUh8CfrBk6dkWi
         ekDqJdI7wAz0e/pEFEQpwKNfcXslO77F+IGkBskBCyVqszlQZecCXtPrV6ukBfaI/ds7
         uYoQ==
X-Gm-Message-State: AOJu0Yxo8RWy4bsIEcT+x+RqxKTya91qkGHTDBuymORi04DWC7UGT+G5
        dOrJDOisp50eAoydbqtDM8V29Q==
X-Google-Smtp-Source: AGHT+IGQ084nkb7iIsJ2XF+m82eh0ID/gW5Gdzzjqr3zKMtpOfpaWSrwZxRRJSR+a0zPwLsgAs5h0Q==
X-Received: by 2002:a05:6808:199e:b0:3a1:c108:41b1 with SMTP id bj30-20020a056808199e00b003a1c10841b1mr4046501oib.25.1693430902532;
        Wed, 30 Aug 2023 14:28:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i15-20020a63bf4f000000b00565e96d9874sm34815pgo.89.2023.08.30.14.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:28:21 -0700 (PDT)
Date:   Wed, 30 Aug 2023 14:28:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
Message-ID: <202308301421.997C4034B5@keescook>
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
 <2023083035-unpadded-amulet-8c7e@gregkh>
 <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 30, 2023 at 03:25:54PM -0400, Azeem Shaikh wrote:
> On Wed, Aug 30, 2023 at 1:57 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Aug 30, 2023 at 04:04:10PM +0000, Azeem Shaikh wrote:
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit if
> > > a source string is not NUL-terminated [1].
> >
> > But that's not the case here, right?  So your "potential read overflow"
> > isn't relevant here.
> >
> > > The copy_to_user() call uses @len returned from strlcpy() directly
> > > without checking its value. This could potentially lead to read
> > > overflow.
> >
> > But can it?  How?
> >
> 
> The case I was considering is when the null-terminated hardcoded
> string @func_table[kb_func] has length @new_len > @len. In this case,
> strlcpy() will assign @len = @new_len and copy_to_user() would read
> @new_len from the kmalloc-ed memory of @len. This is the potential
> read overflow I was referring to. Let me know if I'm mistaken.

First there is:

ssize_t len = sizeof(user_kdgkb->kb_string);

"struct user_kdgkb" is UAPI (therefore unlikely to change), and kb_string
is 512:

struct kbsentry {
        unsigned char kb_func;
        unsigned char kb_string[512];
};

Then we do:

                len = strlcpy(kbs, func_table[kb_func] ? : "", len);

This is the anti-pattern (take the length of the _source_) we need to
remove. However, func_table[] is made up of either %NUL-terminated
strings:

char func_buf[] = {
        '\033', '[', '[', 'A', 0, 
        '\033', '[', '[', 'B', 0, 
...
char *func_table[MAX_NR_FUNC] = {
        func_buf + 0,
        func_buf + 5,
...

Or a NULL address itself. The ?: operator handles the NULL case, so
"len" can only ever be 0 through the longest string in func_buf. So it's
what I'd call "accidentally correct". i.e. it's using a fragile
anti-pattern, but in this case everything is hard-coded and less than
512.

Regardless, we need to swap for a sane pattern, which you've done. But
the commit log is misleading, so it needs some more detail. :)

-Kees

-- 
Kees Cook
