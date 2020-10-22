Return-Path: <SRS0=c/1i=D5=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F70C388F9
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Oct 2020 20:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88FC20759
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Oct 2020 20:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D87aIC6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370512AbgJVUCW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Oct 2020 16:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370510AbgJVUCV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Oct 2020 16:02:21 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A2BC0613CF
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2020 13:02:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a200so1866881pfa.10
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2020 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cFPNRFtcPYYUxGQLBpZGVkGsffh0bPYUzGPf0AjIisE=;
        b=D87aIC6RhWXjIFC2wLTyA9sXgg4Ohi35vZlWc6IpsPweIMiuSuPWWV/GUDv5nHmJ85
         VZHEHdDU6+v2ffn1rfa3oGSzdn/lPafbEyay3hC42oYeNVfBehGnh2LHtq3E2bneQqHm
         5Cxx30ICp+zQTttpir5HjfH4xhmU5v7FgZ1Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cFPNRFtcPYYUxGQLBpZGVkGsffh0bPYUzGPf0AjIisE=;
        b=BBfY6KWJVjKcXW9YC9pms2MElGPCO52pI41SD3pSzPvZASdUsuzhDnf3003VBCFOyM
         YLe6JMuUE5OY9qW4E5MmhSNf1NWvMg//zssrIx88Dyx+3ZZnyKrt+7y4FATssin7oy5l
         LQADxEKLVcqgAdshW5/8JVKmMlPnCGbkkJoLo8x8G+sct0SG2x6vYJbW0RxDBw7kYQ4h
         9iJuKU3PrEzVZUJRY9hx5kVu6MiPytNy6JWexaZAnhToTq0FXfsIFLyIxw7YnnwzEAeY
         PWuUY4MImdKLmujqVSWvjFHec0c4VSHcNASZdRGooWo9D7L+5vJbj/Ri4ow1A60MGcRy
         Ag6A==
X-Gm-Message-State: AOAM533nv3KozyYtN1m1jKdRViTjEFfkuA8rVMeQVxl3xWQ/fokgVYUg
        DxkyEhRsA319twl7Xd1cpLerXg==
X-Google-Smtp-Source: ABdhPJxzFj2lWZu9IdxGeO5ZLR3jud5fxKudfnSoE1lSnvp4GFCMO24w5hRAidupXxV/3pvyIOWiyQ==
X-Received: by 2002:a63:1457:: with SMTP id 23mr3631355pgu.24.1603396940642;
        Thu, 22 Oct 2020 13:02:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m13sm46692pjr.30.2020.10.22.13.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 13:02:19 -0700 (PDT)
Date:   Thu, 22 Oct 2020 13:02:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
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
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
Message-ID: <202010221256.A4F95FD11@keescook>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022075447.GO3819@arm.com>
 <78464155-f459-773f-d0ee-c5bdbeb39e5d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78464155-f459-773f-d0ee-c5bdbeb39e5d@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 22, 2020 at 01:39:07PM +0300, Topi Miettinen wrote:
> But I think SELinux has a more complete solution (execmem) which can track
> the pages better than is possible with seccomp solution which has a very
> narrow field of view. Maybe this facility could be made available to
> non-SELinux systems, for example with prctl()? Then the in-kernel MDWX could
> allow mprotect(PROT_EXEC | PROT_BTI) in case the backing file hasn't been
> modified, the source filesystem isn't writable for the calling process and
> the file descriptor isn't created with memfd_create().

Right. The problem here is that systemd is attempting to mediate a
state change using only syscall details (i.e. with seccomp) instead of
a stateful analysis. Using a MAC is likely the only sane way to do that.
SELinux is a bit difficult to adjust "on the fly" the way systemd would
like to do things, and the more dynamic approach seen with SARA[1] isn't
yet in the kernel. Trying to enforce memory W^X protection correctly
via seccomp isn't really going to work well, as far as I can see.

Regardless, it makes sense to me to have the kernel load the executable
itself with BTI enabled by default. I prefer gaining Catalin's suggested
patch[2]. :)

[1] https://lore.kernel.org/kernel-hardening/1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com/
[2] https://lore.kernel.org/linux-arm-kernel/20201022093104.GB1229@gaia/

-- 
Kees Cook
