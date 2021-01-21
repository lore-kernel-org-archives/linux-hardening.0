Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275A8C433E0
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Jan 2021 13:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B34206DC
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Jan 2021 13:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbhAUN1f (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Jan 2021 08:27:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732202AbhAUNZZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Jan 2021 08:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611235438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cvCR/SJT7x/0z+1fK/OgzO3ZsWGWZSRqQrMopnsNWp8=;
        b=T+7BZodwH+s5uNb6IgziWkF2rTEj8/CI9DjoNaI8nvlQ9Nqzi24xA3yXBm7B/1iPEq3KMz
        pojsXC6+BragRoFK4CJ75+2VQ9Ji6fo5iw8VFLrgi26OezYha8pS2imRgMqtQpOVokI8L8
        4kkz/8bbL1/gt8kJRUJaxIiYlf34Xnk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-URClnyMjOUWe6tmOAB6cVg-1; Thu, 21 Jan 2021 08:23:56 -0500
X-MC-Unique: URClnyMjOUWe6tmOAB6cVg-1
Received: by mail-wr1-f72.google.com with SMTP id j5so1011253wro.12
        for <linux-hardening@vger.kernel.org>; Thu, 21 Jan 2021 05:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cvCR/SJT7x/0z+1fK/OgzO3ZsWGWZSRqQrMopnsNWp8=;
        b=K4TbQPn2KwlpulHOP3+Ues8BwykrZ3qQrChSbMNAfSjqGnbJFfPzvrYBqqNP+afh9a
         hc624QSbICSedSaU+hO/yUUJ03uHf3k9MZuBnFGuhpNjnYkkanhoMZkch3BczfSNb0yu
         K6ODqPvheb1nKZ6IBDXxROLyFhj/PPPlLiqA/c+Ga8sZZDaZQbgoz+K6nwO+57pa1cAQ
         oS1miY8YBtnhiWBHNPdnXxLIw1FXvPF4p6RHck0u7cwDNNm4Xi7mRC9gNat+ORaeTjvH
         gcJ1q9m01d7bHvjWtdEBHb9uesnv4F4b7l36A4MEMMex3iDRbrSYYQSZ6i4zlgKmNBvT
         IBKA==
X-Gm-Message-State: AOAM530xhmQtwImhQdq5oxrRjz4/RXeb3ouktvURUxltBL8+KqDxFsik
        ZFqGBd165bzYnxxjXyb65NOmIghZy6wzMc191jN7Xj1PTLgsSJD081UCjcJwKOQ0u6iYmZT1+5Y
        iSbHnHPt6MKWwvELcajSqZu9qgsnF18cXBFGzbio0zocOWl73igIflPMZmj2md+BpXfPjKhw+fK
        YWhGs9
X-Received: by 2002:adf:c18d:: with SMTP id x13mr14020230wre.128.1611235435294;
        Thu, 21 Jan 2021 05:23:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+HMrNE/GzNA0eRvoWZynPl2cm00oo1pYl3yrQV7e/rEXRQYgFCSqJngzxT5WNmFeOF92XUQ==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr14020198wre.128.1611235435102;
        Thu, 21 Jan 2021 05:23:55 -0800 (PST)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id d30sm9999764wrc.92.2021.01.21.05.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 05:23:54 -0800 (PST)
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org
References: <20210120173800.1660730-1-jthierry@redhat.com>
 <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
 <186bb660-6e70-6bbf-4e96-1894799c79ce@redhat.com>
 <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <6e21cd51-017e-2135-ed9d-33a60f22a457@redhat.com>
Date:   Thu, 21 Jan 2021 14:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jthierry@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 1/21/21 12:08 PM, Ard Biesheuvel wrote:
> On Thu, 21 Jan 2021 at 11:26, Julien Thierry <jthierry@redhat.com> wrote:
>>
>> Hi Ard,
>>
>> On 1/21/21 10:03 AM, Ard Biesheuvel wrote:
>>> Hello Julien,
>>>
>>> On Wed, 20 Jan 2021 at 18:38, Julien Thierry <jthierry@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> This series enables objtool to start doing stack validation on arm64
>>>> kernel builds.
>>>
>>> Could we elaborate on this point, please? 'Stack validation' means
>>> getting an accurate picture of all kernel code that will be executed
>>> at some point in the future, due to the fact that there are stack
>>> frames pointing to them. And this ability is essential in order to do
>>> live patching safely?
>>>
>>> If this is the goal, I wonder whether this is the right approach for
>>> arm64 (or for any other architecture, for that matter)
>>>
>>> Parsing/decoding the object code and even worse, relying on GCC
>>> plugins to annotate some of the idioms as they are being generated, in
>>> order to infer intent on the part of the compiler goes *way* beyond
>>> what we should be comfortable with. The whole point of this exercise
>>> is to guarantee that there are no false positives when it comes to
>>> deciding whether the kernel is in a live patchable state, and I don't
>>> see how we can ever provide such a guarantee when it is built on such
>>> a fragile foundation.
>>>
>>> If we want to ensure that the stack contents are always an accurate
>>> reflection of the real call stack, we should work with the toolchain
>>> folks to identify issues that may interfere with this, and implement
>>> controls over these behaviors that we can decide to use in the build.
>>> In the past, I have already proposed adding a 'kernel' code model to
>>> the AArch64 compiler that guarantees certain things, such as adrp/add
>>> for symbol references, and no GOT indirections for position
>>> independent code. Inhibiting optimizations that may impact our ability
>>> to infer the real call stack from the stack contents is something we
>>> might add here as well.
>>>
>>
>> I'm not familiar with toolcahin code models, but would this approach be
>> able to validate assembly code (either inline or in assembly files?)
>>
> 
> No, it would not. But those files are part of the code base, and can
> be reviewed and audited.
> 

That means that every actor maintaining their own stable version of the 
kernel have to do their own audit when they do backports (assuming the 
audit would be done for upstream) to be able to provide a safe 
livepatching feature in their kernel.

>>> Another thing that occurred to me is that inferring which kernel code
>>> is actually live in terms of pending function returns could be
>>> inferred much more easily from a shadow call stack, which is a thing
>>> we already implement for Clang builds.
>>>
>>
>> I was not familiar with the shadow call stack. If I understand correctly
>> that would be a stack of return addresses of function currently on the
>> call stack, is that correct?
>>
>> That would indeed be a simpler approach, however I guess the
>> instrumentation has a cost. Is the instrumentation also available with
>> GCC? And is this instrumentation efficient enough to be suitable for
>> production builds?
>>
> 
> I am not aware of any plans to enable this in GCC, but the Clang
> implementation is definitely intended for production use (it's a CFI
> feature for ROP/JOP mitigation)
> 

I think most people interested in livepatching are using GCC built 
kernels, but I could be mistaken (althought in the long run, both 
compilers should be supported, and yes, I realize the objtool solution 
currently only would support GCC).

I don't know how feasible it will be to get it into GCC if people decide 
to go with that. Also, now that I think about it, it will probably come 
with similar limitations as stackframes where the unwinder would need to 
know when/where the shadow call stack is unavailable for some reason and 
the stack trace is not reliable. (it might be a bit simpler to audit 
than stack frame setting and maybe have less limitations, but I guess 
there will still be cases where we can't rely on it)

-- 
Julien Thierry

