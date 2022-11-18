Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15200C4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 08:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiKRI61 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Nov 2022 03:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241606AbiKRI6Y (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Nov 2022 03:58:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729BD6EB58
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 00:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668761842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p0ERrz7JCn9BnDY0Ayxan7lnfD5vEWFwGFrA85kPodc=;
        b=OgUb7Rrvd0S/1tG9DsbgoEtyLBNYbCxqqbYFJDbu35hqQZr+wJtAgx+w6bHE4eJ5qICerB
        PrUVi5E4XJ3R+fwhh48R+uyH9MRTyR0deqnoNeQqWHjDMXZH/jSahOOlZYNILqGReO7bUD
        +MDfdnfgesbPwedipXYp9OSr/kKJZUc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-156-AX4gT3A_MrCNT0WYiIG3oQ-1; Fri, 18 Nov 2022 03:57:21 -0500
X-MC-Unique: AX4gT3A_MrCNT0WYiIG3oQ-1
Received: by mail-wm1-f72.google.com with SMTP id o5-20020a05600c510500b003cfca1a327fso1959214wms.8
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 00:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0ERrz7JCn9BnDY0Ayxan7lnfD5vEWFwGFrA85kPodc=;
        b=K9Pi8bR+buMyYfEha2F/8d+A2+aZf9EgQSWCUoxniKL17P+M1uvDn7iebFZRtzRUa9
         hDI6L5EnqG+xWf+cwZi4E7A5PwM30AbNHRgQzP8cuM1d+nFSE2+pppKhswUuV2Dajjyl
         759IKUgWJ/OS1e0uS40JibYfvmr97Y0boH39zxv3PL5uVK6GkjqD3e4fCS3iN7YzJS+u
         FIrMWTj54VL9XOcHYKp5jZ3wZ5x9O15SSyp+V3bYSf2qkTpWeZi9Vg68BO06V0R7vC2/
         oc84YkUa6snZyttAKP4+DCexIcJ7cAFXNe1ljCl05hQDmPajmW09wF6B/hzHPW+gyXYO
         IhWw==
X-Gm-Message-State: ANoB5pmXJ3Tf+a0s7zrc67C0kAZoJ5OCbMlRq2yjSwMTgPXcH+5CsuE8
        L+z7QbzLsdb0n1uihvdSCFc9prx+Ks80XiJlPktGRtHz6pvW5FI/OLszDXtE13LJr9EM4Fknjhe
        5QQLwOFoGF06QLMpH4ljOqSwr/O/Q
X-Received: by 2002:adf:facd:0:b0:231:482f:ed6b with SMTP id a13-20020adffacd000000b00231482fed6bmr3694259wrs.253.1668761840126;
        Fri, 18 Nov 2022 00:57:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf50oZR0yD/v8/9UR7ki7wIw/KZLKr9m6FVoEPYMGY5P+v3sgErCbw58kQiRgWrcKNl7n+7VHQ==
X-Received: by 2002:adf:facd:0:b0:231:482f:ed6b with SMTP id a13-20020adffacd000000b00231482fed6bmr3694247wrs.253.1668761839750;
        Fri, 18 Nov 2022 00:57:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:f500:6512:fac3:2687:15ff? (p200300cbc704f5006512fac3268715ff.dip0.t-ipconnect.de. [2003:cb:c704:f500:6512:fac3:2687:15ff])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c024600b003b50428cf66sm3709552wmj.33.2022.11.18.00.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 00:57:19 -0800 (PST)
Message-ID: <16759fd4-3a8c-b52c-20c3-9a9129f26799@redhat.com>
Date:   Fri, 18 Nov 2022 09:57:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] exec: Remove FOLL_FORCE for stack setup
To:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221118003410.never.653-kees@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221118003410.never.653-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 18.11.22 01:34, Kees Cook wrote:
> It does not appear that FOLL_FORCE should be needed for setting up the
> stack pages. They are allocated using the nascent brpm->vma, which was
> newly created with VM_STACK_FLAGS, which an arch can override, but they
> all appear to include VM_WRITE | VM_MAYWRITE. Remove FOLL_FORCE.
> 
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Link: https://lore.kernel.org/lkml/202211171439.CDE720EAD@keescook/
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for looking into this!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

