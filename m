Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32019C432BE
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Aug 2021 17:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8E06023B
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Aug 2021 17:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbhHXRaN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 24 Aug 2021 13:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240891AbhHXR1I (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 24 Aug 2021 13:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629825983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wH/laxt92cAPsS5DORg7moxidJ+sFb/ugbwwhp2S/dk=;
        b=S3clO4ogC1f8qlLSTC9sle5VI3PM0JLIWc9eUIDVKJmgJ9CSXby9v141gC72Jb3f+uQwso
        YJANyVswPgy5FSp4PrhN6ivDKRzy+XXbvljCmv7zZPOncbn2V499nk8goOW7Gh1Mzig5Kj
        vUTltUw9g4ueUlAXnAE5S+uZFXTKQ7Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-UMDlqtL2PnWIzLAEsozTMg-1; Tue, 24 Aug 2021 13:26:19 -0400
X-MC-Unique: UMDlqtL2PnWIzLAEsozTMg-1
Received: by mail-qk1-f200.google.com with SMTP id b4-20020a3799040000b02903b899a4309cso14778034qke.14
        for <linux-hardening@vger.kernel.org>; Tue, 24 Aug 2021 10:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wH/laxt92cAPsS5DORg7moxidJ+sFb/ugbwwhp2S/dk=;
        b=NE9c86Y5hd1nl5z2PrmSs+kYOR69s3WylKNRh/QXDglZWJ6s9pULFLPZ6iS9HkFmmz
         Ty4jfxdXY3RQlk4ntvPybPGzdc5taE+/B6ghDGKeTtsPytkGrouiCRnfunEAr3pEizE8
         zs+f35kF/0JHA0WpRKfljH0IByD7db/85AnQXkNDQrsyiDj+NTNWiYtN94Y5g0DQg22T
         GLIczjtOhHEbgU4lnrskEjceHToixiJvdk8drvNCwKXZQ/zo+fBPd+DA/gaWx7CjPd+C
         N1OqpV9yJtIG4d8CglkjnEfAPI98bqp7+sKAWor77XVpa8Ra8Z84F9zoOU+uDwBjb+z0
         PPtw==
X-Gm-Message-State: AOAM5335Ob+u1K+aG5NwEkLX4c30Zk+S825g980OtOKFi+lXmTiweDlk
        EKeCNfL4/B3+rCgBXdTqMMs0Xn3pLGI/LI15H3xvC3PzwkSgbWClbSak0QBzFcfJ5H6L30UONt3
        rzGOugFyKl/aLhBEZ46pXLOTNorO9
X-Received: by 2002:a37:4141:: with SMTP id o62mr6348362qka.380.1629825979546;
        Tue, 24 Aug 2021 10:26:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPfydha2WMaqbxaCR6qCBIVYjLefJCzf43YSyCq1K9A1bslH6yCHFkMwBJ4tvEQvd0jM3DVw==
X-Received: by 2002:a37:4141:: with SMTP id o62mr6348347qka.380.1629825979334;
        Tue, 24 Aug 2021 10:26:19 -0700 (PDT)
Received: from tstellar.remote.csb (97-120-182-34.ptld.qwest.net. [97.120.182.34])
        by smtp.gmail.com with ESMTPSA id t66sm11093328qkc.3.2021.08.24.10.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:26:18 -0700 (PDT)
Subject: Re: [PATCH v2 00/14] x86: Add support for Clang CFI
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20210823171318.2801096-1-samitolvanen@google.com>
 <1706ee8e-c21c-f867-c0be-24814a92b853@redhat.com>
 <CABCJKufrpx9arM-hfX_bR-efO+13VBMFNBTe4ff036VEZi1LZQ@mail.gmail.com>
From:   Tom Stellard <tstellar@redhat.com>
Message-ID: <9349a92d-f2a7-9ee4-64db-98d30eadc505@redhat.com>
Date:   Tue, 24 Aug 2021 10:26:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CABCJKufrpx9arM-hfX_bR-efO+13VBMFNBTe4ff036VEZi1LZQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tstellar@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 8/23/21 10:20 AM, Sami Tolvanen wrote:
> On Mon, Aug 23, 2021 at 10:16 AM Tom Stellard <tstellar@redhat.com> wrote:
>>
>> On 8/23/21 10:13 AM, 'Sami Tolvanen' via Clang Built Linux wrote:
>>> This series adds support for Clang's Control-Flow Integrity (CFI)
>>> checking to x86_64. With CFI, the compiler injects a runtime
>>> check before each indirect function call to ensure the target is
>>> a valid function with the correct static type. This restricts
>>> possible call targets and makes it more difficult for an attacker
>>> to exploit bugs that allow the modification of stored function
>>> pointers. For more details, see:
>>>
>>>     https://clang.llvm.org/docs/ControlFlowIntegrity.html
>>>
>>> Version 2 depends on Clang >=14, where we fixed the issue with
>>> referencing static functions from inline assembly. Based on the
>>> feedback for v1, this version also changes the declaration of
>>> functions that are not callable from C to use an opaque type,
>>> which stops the compiler from replacing references to them. This
>>> avoids the need to sprinkle function_nocfi() macros in the kernel
>>> code.
>>
>> How invasive are the changes in clang 14 necessary to make CFI work?
>> Would it be possible to backport them to LLVM 13?
> 
> I'm not sure what the LLVM backport policy is, but this specific fix
> was quite simple:
> 
> https://reviews.llvm.org/rG7ce1c4da7726
> 

That looks like something we could backport, I filed a bug to track
the backport: https://bugs.llvm.org/show_bug.cgi?id=51588.

Do you have any concerns about backporting it or do you think it's pretty
safe?

-Tom


> Sami
> 

