Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A332C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 01:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC1E61B7D
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 01:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240757AbhKRBfV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 Nov 2021 20:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbhKRBfV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 Nov 2021 20:35:21 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03086C061766
        for <linux-hardening@vger.kernel.org>; Wed, 17 Nov 2021 17:32:21 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so5522395pjb.1
        for <linux-hardening@vger.kernel.org>; Wed, 17 Nov 2021 17:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SUDgqfw79hNY26jZLVy2BdIxOeMeyBTKUtGKG0JHeTw=;
        b=QYl8ZU55MVbn3YPwuz5xDclB08EJ+6GPPyntZKH9cfg2QabRftq+ARsPg369M8Sxqh
         yLd1Q6n81LUZii+3Vluc61d0pMKUvIiV1BaIJ+TdbXqc+uRohINknm3Kf8rmUdataLhR
         j5CW+tjM8I/7R4yU0LQd/pqJDGTsQJBIW0yvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SUDgqfw79hNY26jZLVy2BdIxOeMeyBTKUtGKG0JHeTw=;
        b=hZYFe3AUrCbZ4XxDEACuDNbkH2oxEO7cqEadCorOWIDFgs//K57AtrIYG9Ox7JgBig
         /54OxjghpxoNGQ7Sd/sXhXZuj6RuQKDUfkbROUIyW/JAsJttxZBjPAhLBv1ejvIs8WOh
         R0asEHvFPCes7VdS7geUeinhMqCPCamVhnIhSuNOYsVVO75BnmVFo0bKQinGkiDvoMim
         WxmXyG0TYhktiGusTPuPTe5qYY8u8FaZ/DE456wFHF+JtaYoe8+GTH41Jz7GwokgMErD
         FnglIkfySolAZjl//2u39ZNP01X/+0Nw7YvDIKC5UGyGy1m0RmId4SsZXnUTnBEl8EyH
         kL5A==
X-Gm-Message-State: AOAM530dSIQjOpwA/DwdewE1aEEyy78rKuAUMa6laoSPwDGvBfDiOfPl
        3vap6ToO7WsA7P6Tw32tN0GkNg==
X-Google-Smtp-Source: ABdhPJw9NtNZOMzIIpkK69AK3HEXLRQJphzbtDxsSk/X76HyTEGYyivUAENDyGjliOWUtPegjsJMUA==
X-Received: by 2002:a17:90b:4c44:: with SMTP id np4mr5467213pjb.195.1637199141467;
        Wed, 17 Nov 2021 17:32:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ip6sm6855084pjb.42.2021.11.17.17.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 17:32:21 -0800 (PST)
Date:   Wed, 17 Nov 2021 17:32:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kyle Huey <me@kylehuey.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Robert O'Callahan <rocallahan@gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
Message-ID: <202111171728.D85A4E2571@keescook>
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook>
 <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
 <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org>
 <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
 <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
 <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
 <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 17, 2021 at 05:20:33PM -0800, Kyle Huey wrote:
> Yeah that's one way to solve the problem. I think you're right that
> fundamentally the problem here is that what SECCOMP_RET_KILL wants is
> not really a signal. To the extent that it wants a signal, what it
> really wants is SIGKILL, and the problem here is the code trying to
> act like SIGKILL but call it SIGSYS. I assume the ship for fixing that
> sailed years ago though.

Yeah, this was IIRC, a specific design choice (to distinguish a seccomp
KILL from a SIGKILL), as desired by the sandboxing folks, and instead
of using two different signals (one for KILL and one for TRAP), both
used SIGSYS, with the KILL variant being uncatchable.

-- 
Kees Cook
