Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19923C7EE2A
	for <linux-hardening@archiver.kernel.org>; Wed, 17 May 2023 00:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjEQAJY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 20:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjEQAJW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 20:09:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D192212F
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 17:09:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bf7bb76d0so2134a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 17:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684282159; x=1686874159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6+sA3glVwNYujyPfaMc+ARRP8ltGy3qBe8Uw1+V7f8=;
        b=4OwqK3P6d+8uCpUBN5+GlnVRSZ7+N/8GtPEUqUxg5irzupRwHMPWOqLLOfgTT9pFA9
         Wt9NzaziMW34EUwoTL/wY0W/Ygyz8wvLhrm1UmwKh8DOdzmQvPgQAnkA3XG1ld8NQK6m
         fZgIY6aIsnJu+nbYz/SX0ltNPasXQ2AvPzoJqZo2ifwS17FyZVaBXc7H5kgu89stkYoa
         wpqd30vHKgTtnT4+9WiNVVcx0zB+E0BPTli2KLUQx6wFVAcAbLlGAPooPty0YaxMubdp
         wJoJi/qTz+yj5C7VkuI7WWNcIB+TmDK407oQNiHSC/tCMwhwMhuZBfPomeOptbRQfMEu
         L4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684282159; x=1686874159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6+sA3glVwNYujyPfaMc+ARRP8ltGy3qBe8Uw1+V7f8=;
        b=Jb35CL7QXAA2SwMbW0mPdm5UvBURC74FTQA7BisiI83Stsq4R6QpyTrZ2XIsUBlGaR
         unTD9iVcqv4NLUdAxCcjG+cuJcNUJnzT8RZbQsw6/lYW6l6jyYFVSGseZVPCS1iEFzPP
         AIyUghaxSKGE/LKzDo/WPtNPu97Hz9W6Sj14kzx+jg8JW8mriwOnOfVv5qRete7Euq3q
         PReHbzQPbneFB1uyfBSSwAHsC8jLEB7+Jz7pYcyxZzc3V+XEHInAv3x370WFRvB+rWtF
         rpi49hxrYpuK76m84P2MTVYRVRLfTF+uZydPwWuForqfxsL8sRr8ZAHveNGLaK4BiCA/
         rJnQ==
X-Gm-Message-State: AC+VfDylqaRVVAN3h7tyioO/NhqO6Gzj5v09rcRP5ndDdfY/yFGqRywK
        vYViKuHT/egBcy/lyokgLUeperDSbQ6ns/rsNBSJDA==
X-Google-Smtp-Source: ACHHUZ6DHEWoXAcS3gqSXdcAPxwYIzsFqlA3U40BHQD/hc3Ovr6xApDyft45NrvMujC4HgN2sonyY3noO8ubH+NBctc=
X-Received: by 2002:a50:d4d5:0:b0:50b:c48c:8a25 with SMTP id
 e21-20020a50d4d5000000b0050bc48c8a25mr54691edj.6.1684282159196; Tue, 16 May
 2023 17:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <20230515130553.2311248-6-jeffxu@chromium.org>
 <4f14a645-3569-2e3b-f55c-3b17b567845a@intel.com>
In-Reply-To: <4f14a645-3569-2e3b-f55c-3b17b567845a@intel.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 16 May 2023 17:08:42 -0700
Message-ID: <CALmYWFvcZ+fGrCjfdx6DWNbYj0WQCJ-i4HFKHgSCqRU6Q4YbBQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] KEY: Apply PKEY_ENFORCE_API to munmap
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 16, 2023 at 4:24=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/15/23 06:05, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > This patch enables PKEY_ENFORCE_API for the munmap
> > syscall.
>
> The basic problem here is how we know when the set of syscalls that are
> patched here is good enough and how we catch future functionality that
> might need to be captured as well.
>
> This mechanism really needs to be able to defend against *any* changes
> to the address space.  I assume that folks are using syscall filtering
> to prevent new syscalls from causing havoc, but is there anything that
> can be done for, say, things like madvise()?  I bet it was harmless for
> a long time until MADV_DONTNEED showed up and made it able to
> effectively zero memory.

Not any change, just a limited set of syscall from user space.
I think it is reasonable to hope that any kind of syscall ABI change that
affects VMA will get reviewed thoroughly from now on.

Also, if we continue to add mseal() to the kernel, we will have to pay more
attention to syscalls related to VMA.

Thanks
-Jeff Xu
