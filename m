Return-Path: <SRS0=c/1i=D5=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBE6C388F7
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Oct 2020 22:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3931624631
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Oct 2020 22:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng91Tdl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372577AbgJVWYi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Oct 2020 18:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372504AbgJVWYi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Oct 2020 18:24:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A92C0613CE;
        Thu, 22 Oct 2020 15:24:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a28so3667136ljn.3;
        Thu, 22 Oct 2020 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UkMo9YSByP/9a+a4AdI+yi1vCaJEUjkdx9AvlbGG/VA=;
        b=ng91Tdl3pBDoUkFKc2xVpnTG6o2MSBkFORHCAoFWFxOTuXcSSix3p48H5kxjR3nEWa
         AdVvc0c2ziFBrWsswAVwD1yD+S5SzTPqtfzqXo0aodkq+OiTrgVdN1/4GuKOdUqyUmQr
         +GRE7KLCrzhSUdATfpPd+h+gOp/E8oy30yyrWHiuTytbDUgoEFIP3XRcYPkG88+etdbU
         vNLQHlrvXgYoqwCfudllzcoqxrgW33i8LHTj89uBQjW5chudCu5CNynRRKRbBl+MZoXV
         TTOkrpS3bZ2Y3zJ3QgwHg33LdIYo3UBPzNPWNwaAlw1p/NaVd2Wp5fg6n9fJ4micW7KS
         /PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UkMo9YSByP/9a+a4AdI+yi1vCaJEUjkdx9AvlbGG/VA=;
        b=BpSRUWKdCGLkJCNTsDZKv1JJqkesaWec2YtArKT/NupVBGphuXkQYv5bQ+CISbNuK+
         3FYdodeoah37/ZIz2mlGRbTI/ia/C/4s7mGOIkN3Vwpd0yNHbq0sPFzFbFG7q41fiHad
         6oN5L0IiTU2Jn9GbpnXWZ/asmxDNl2zJv3g2vIZGhwRU9BsdE8S2QQSgdOP89zGVoS5U
         8skL7T2Txtneelw/0eAcnl9hJCFYU2fhuWMOI1OmgYHteZSM6jyj0h5ti720eS4a3dpo
         2mMCZS1QSco8dWNLTsuc3GnWTVq4eAue6AQgow5xdBgt60bR3louCcXd+2c6jW7e/fry
         BMDw==
X-Gm-Message-State: AOAM533BgG8nAbbosyg3I9IPa67r1l6QaVRO3Kaehx9SFCWQv8TB773w
        1fGF2qMvMzJwYZm5ze0p3GpOL5GZ+fxqlQ==
X-Google-Smtp-Source: ABdhPJx5YviZO9AmLfC4zO4HDKLBOEanXPu68ZVGSRTNYTaA44O+Q72epSPqVvZXgnaj8XxH5i8bEw==
X-Received: by 2002:a05:651c:1194:: with SMTP id w20mr1737072ljo.174.1603405475827;
        Thu, 22 Oct 2020 15:24:35 -0700 (PDT)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id i22sm396520lfl.52.2020.10.22.15.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 15:24:34 -0700 (PDT)
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
To:     Kees Cook <keescook@chromium.org>
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
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022075447.GO3819@arm.com>
 <78464155-f459-773f-d0ee-c5bdbeb39e5d@gmail.com>
 <202010221256.A4F95FD11@keescook>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <180cd894-d42d-2bdb-093c-b5360b0ecb1e@gmail.com>
Date:   Fri, 23 Oct 2020 01:24:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <202010221256.A4F95FD11@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 22.10.2020 23.02, Kees Cook wrote:
> On Thu, Oct 22, 2020 at 01:39:07PM +0300, Topi Miettinen wrote:
>> But I think SELinux has a more complete solution (execmem) which can track
>> the pages better than is possible with seccomp solution which has a very
>> narrow field of view. Maybe this facility could be made available to
>> non-SELinux systems, for example with prctl()? Then the in-kernel MDWX could
>> allow mprotect(PROT_EXEC | PROT_BTI) in case the backing file hasn't been
>> modified, the source filesystem isn't writable for the calling process and
>> the file descriptor isn't created with memfd_create().
> 
> Right. The problem here is that systemd is attempting to mediate a
> state change using only syscall details (i.e. with seccomp) instead of
> a stateful analysis. Using a MAC is likely the only sane way to do that.
> SELinux is a bit difficult to adjust "on the fly" the way systemd would
> like to do things, and the more dynamic approach seen with SARA[1] isn't
> yet in the kernel.

SARA looks interesting. What is missing is a prctl() to enable all W^X 
protections irrevocably for the current process, then systemd could 
enable it for services with MemoryDenyWriteExecute=yes.

I didn't also see specific measures against memfd_create() or file 
system W&X, but perhaps those can be added later. Maybe pkey_mprotect() 
is not handled either unless it uses the same LSM hook as mprotect().

> Trying to enforce memory W^X protection correctly
> via seccomp isn't really going to work well, as far as I can see.

Not in general, but I think it can work well in context of system 
services. Then you can ensure that for a specific service, 
memfd_create() is blocked by seccomp and the file systems are W^X 
because of mount namespaces etc., so there should not be any means to 
construct arbitrary executable pages.

-Topi
