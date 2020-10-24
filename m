Return-Path: <SRS0=kTaS=D7=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2AFC55178
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 11:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C96721D43
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 11:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqiOOs7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759737AbgJXLeb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 24 Oct 2020 07:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759684AbgJXLeb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 24 Oct 2020 07:34:31 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAE8C0613CE;
        Sat, 24 Oct 2020 04:34:29 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j30so5354689lfp.4;
        Sat, 24 Oct 2020 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IoKvQwjpmgnwDqwDMU0dzPR0LnLnshRSMNK/AI0kcxw=;
        b=mqiOOs7TyvklH3y6Ood3stRdGCXNjS2vgVdrSrZQ2N5rvNmXE4ypAGwbOH+pu5ZkZU
         cLFinzJ8s1Tc1dBlP3n6K9U1vTiiudbu4H1PwQEoeFI7WihRODKM6wJlcI16HoaXOosR
         PQtOWyYZ5vxd3flAAaj+Fgat/sdOALkni45sy0aydIfRvlwxm3dwa0l5WDx3QP/dG3y6
         pYy6zdGvNsP3Z9aeTINusM1N7KGKTk/bljhK8h8j6gQ8iHYyydmfoS0E2Io29bJlsvT5
         ZfDv1jpttgUuhifKJENIVwPfjjhn0XCWIAk65JMYKL0UIJotL4bcojoT7g08pknvpe9X
         BBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IoKvQwjpmgnwDqwDMU0dzPR0LnLnshRSMNK/AI0kcxw=;
        b=Do0myV1lQhGsRpBq6dZweldI5RIXrfMStYdTrqYeWSnK0RleWmurBZJiFA9oU8KTVe
         ftSaceYAEfo3HuLfsJDj6KabDvDeyA+BQKZ/DWJhKm/RkWSj0ra8NGl0cwzrLUqHWNTZ
         gIRtTidM5cNyP5y378VKGxT88ic6spVv31wffQOKow5jmlujSJhcoJqy+HQH5XKUyD/N
         d1E23hN5uUtCnwhrd1Qnm8NWvh/HP22mzj+/LN61ROXcTE3ty/woLzR2DASAEnMQmbGe
         ZrWy+MN4950xSrwWOThsapIcVvOGp6NuFrzoenQFLpx2ebGRjxD/J0NrBjat8NdReN8R
         KO8A==
X-Gm-Message-State: AOAM530uqtbfVPAFz7vADJc1mHuHby5U/PhkGUPcUq+JTedlXIucvnul
        VYXdoC+hqjvSpPJiOP6nG03F/lvu8zY=
X-Google-Smtp-Source: ABdhPJzwvsaTluGQK36qa7V3CiVSFtEKeTqt9O3nz3uBAt8xGRnoa/SVo39MAjPgTAB/taz96NuywQ==
X-Received: by 2002:a19:2355:: with SMTP id j82mr1914155lfj.36.1603539267465;
        Sat, 24 Oct 2020 04:34:27 -0700 (PDT)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id y24sm411089lfy.194.2020.10.24.04.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2020 04:34:26 -0700 (PDT)
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
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
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022075447.GO3819@arm.com>
 <78464155-f459-773f-d0ee-c5bdbeb39e5d@gmail.com>
 <202010221256.A4F95FD11@keescook>
 <180cd894-d42d-2bdb-093c-b5360b0ecb1e@gmail.com>
 <CAJHCu1Jrtx=OVEiTVwPJg7CxRkV83tS=HsYeLoAGRf_tgYq_iQ@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <3cb894d4-049f-aa25-4450-d1df36a1b92e@gmail.com>
Date:   Sat, 24 Oct 2020 14:34:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAJHCu1Jrtx=OVEiTVwPJg7CxRkV83tS=HsYeLoAGRf_tgYq_iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 23.10.2020 20.52, Salvatore Mesoraca wrote:
> Hi,
> 
> On Thu, 22 Oct 2020 at 23:24, Topi Miettinen <toiwoton@gmail.com> wrote:
>> SARA looks interesting. What is missing is a prctl() to enable all W^X
>> protections irrevocably for the current process, then systemd could
>> enable it for services with MemoryDenyWriteExecute=yes.
> 
> SARA actually has a procattr[0] interface to do just that.
> There is also a library[1] to help using it.

That means that /proc has to be available and writable at that point, so 
setting up procattrs has to be done before mount namespaces are set up. 
In general, it would be nice for sandboxing facilities in kernel if 
there would be a way to start enforcing restrictions only at next 
execve(), like setexeccon() for SELinux and aa_change_onexec() for 
AppArmor. Otherwise the exact order of setting up various sandboxing 
options can be very tricky to arrange correctly, since each option may 
have a subtle effect to the sandboxing features enabled later. In case 
of SARA, the operations done between shuffling the mount namespace and 
before execve() shouldn't be affected so it isn't important. Even if it 
did (a new sandboxing feature in the future would need trampolines or 
JIT code generation), maybe the procattr file could be opened early but 
it could be written closer to execve().

-Topi
