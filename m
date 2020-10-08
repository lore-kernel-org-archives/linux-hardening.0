Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF89C433E7
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 18:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7EC020760
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 18:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhCVwNEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbgJHSL3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 14:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbgJHSL3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 14:11:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07705C061755;
        Thu,  8 Oct 2020 11:11:29 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i2so6773270ljg.4;
        Thu, 08 Oct 2020 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G3mrHFgsl4yRBSpBY2KK+yE6uxmlc+TxwEDQsNmv4cc=;
        b=PhCVwNEQPJOov0cSmL537oCIOTrYgAe4jM+pmEbETQZDP2DHFu8p2t5cROBpiAGJPg
         Yo/yGIIYiuK5Gtnh6JkTAjANM6mZjLgyZ1Qp/nzVsOgDBbjDhk9epotbdyztKO7s3jH/
         HpXV4FGK4pTp6il0zGS8nLgpfztWn/mesNVDAAACvfXeOyvVRavwGju/AEaCeBb/3xUE
         C70X92MMFGQevzm3dK1C0anSPhkJGHLY4p2K5DVHhfXGBXPmEbtFJI3toCeeiak7RXlF
         uuUhGpj1uXd/SPuPz14ehDlle7QxEkf8FrxrHIgpo+wzqRw837ePeNEuFL7RN/5+ZHvw
         p6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G3mrHFgsl4yRBSpBY2KK+yE6uxmlc+TxwEDQsNmv4cc=;
        b=b2oeQeTMnf3KR/xcMNPY+OIX0LlrueJs1AHusDTrTggAzbibiZ3AGGO7pqqCE3gU4P
         wCTitMW5tbSJ2AdIp07K8pvFty3D7OAtTTY7ZmxFD/3UK8/Ac15nhVTDjGB2mG5JX177
         1PLR09Ldz/Ekub0YjCF8cgZYgeb660iLR0HVhyxmgBfJmIqRTx8C6ac7+FHr9payns8l
         V5bR46RZOuJZSP08bvd2WNpTghJqhDc5TIEN0biZARY2hQ+UyrtnF/waQWK8EkyEbQQF
         xgaCXDTLT+I843AhOsZe0agDgKJKa2cgojMKhaC2+Dg5s+V6urEZXpQAc6vQHz2+68vo
         Q7NA==
X-Gm-Message-State: AOAM5327KFTASqXwsDpeNl+NY0F3HVUma83AEEQdW2dcNqde+I1oAXfo
        rPYgj4SPjiJ7grn8vGpOnvMrfJVL6k8=
X-Google-Smtp-Source: ABdhPJz1UBLxdWzx8/hYgAzppJLKkNeg+nW+R08uBrpCVJSk6ut97gWc1kHPX8suMHfg7491c84EEg==
X-Received: by 2002:a2e:82c8:: with SMTP id n8mr3998729ljh.62.1602180687184;
        Thu, 08 Oct 2020 11:11:27 -0700 (PDT)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id e19sm992864lfd.200.2020.10.08.11.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 11:11:26 -0700 (PDT)
Subject: Re: [PATCH RESEND v2] mm: Optional full ASLR for mmap() and mremap()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201008165408.38228-1-toiwoton@gmail.com>
 <20201008170728.GK20115@casper.infradead.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <1d08abd1-4343-59e7-108a-68af5f7778c0@gmail.com>
Date:   Thu, 8 Oct 2020 21:11:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201008170728.GK20115@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 8.10.2020 20.07, Matthew Wilcox wrote:
> On Thu, Oct 08, 2020 at 07:54:08PM +0300, Topi Miettinen wrote:
>> +3   Additionally enable full randomization of memory mappings created
>> +    with mmap(NULL, ...). With 2, the base of the VMA used for such
>> +    mappings is random, but the mappings are created in predictable
>> +    places within the VMA and in sequential order. With 3, new VMAs
>> +    are created to fully randomize the mappings. Also mremap(...,
>> +    MREMAP_MAYMOVE) will move the mappings even if not necessary.
>> +
>> +    On 32 bit systems this may cause problems due to increased VM
>> +    fragmentation if the address space gets crowded.
> 
> On all systems, it will reduce performance and increase memory usage due
> to less efficient use of page tables and inability to merge adjacent VMAs
> with compatible attributes.

Right, I'll update the description.

>> +	if ((flags & MREMAP_MAYMOVE) && randomize_va_space >= 3) {
>> +		/*
>> +		 * Caller is happy with a different address, so let's
>> +		 * move even if not necessary!
>> +		 */
>> +		new_addr = arch_mmap_rnd();
>> +
>> +		ret = mremap_to(addr, old_len, new_addr, new_len,
>> +				&locked, flags, &uf, &uf_unmap_early,
>> +				&uf_unmap);
>> +		goto out;
>> +	}
>> +
>> +
> 
> Overly enthusiastic newline
> 

Will remove.

-Topi
