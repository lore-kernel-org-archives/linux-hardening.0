Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A40C2D0E4
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Nov 2020 09:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B113F2075A
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Nov 2020 09:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpdGT+uO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgKSJQV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Nov 2020 04:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgKSJQU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Nov 2020 04:16:20 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F5EC0613CF;
        Thu, 19 Nov 2020 01:16:20 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id h23so5421972ljg.13;
        Thu, 19 Nov 2020 01:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ntgtXrL0m1MaqlEPJt4hou8mjG+zy232AlU7iZoP3lc=;
        b=TpdGT+uOCBhbdb/D1DPEtLzh+6t+zDIZyjldqTx+gQWjMpFZzWdLnxHOnFVac58FYM
         XLO9lkKWdP5cJ8uq6uknT4NzypW0IjmNrj4NSE/ubfWCZNuJww1466Z9AUklyz6iN3rm
         JxHO/D4pVsiDJlRqZfVq/BSlVFshPXya94I41O6DAVrAI8RVwlmyhb21agdTiF7THB93
         uCvMsWiJq1v9USlWKIoSpyPzsVDUW5EmH9ZFAVv4RP+CV30L/35nmpRYUoGAgcfvvptk
         DWt0bMsOTW7vZUmhkRSQid4aHJWCFeKw5syjrPW98XKG1+Wk5XlwrRFia9/PhM+1JuAJ
         Yp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ntgtXrL0m1MaqlEPJt4hou8mjG+zy232AlU7iZoP3lc=;
        b=YsVn0IA4lctGRjQe7MEfpyLjzztmnMsC2sYyPLbT3Z96Rz5HkV8G7BqdkRPXEDUyWp
         IHnwLW34d3bnkD6lxg5ihIGb+6NySakb85Gx6BiUviSJLPN3yBTSQPg8xkC2AUDuenmx
         15mjNFYw17A1sb/4KrBrhO78sFAqARoirQeweo02FPZwokLeeASqlWIqwn7Cydbi+XBg
         9uxxkoLyaK0vMfJ8DN0Z3BAhkNYqg4Fyf7A4vF+k/yWW7O8cRbRxViit6x0eQueS31z+
         A/iUw1XhbbARAslMTPv1P8dDd81RsOXJeqnePBTQg0VESH9UFxIyrYhDy81U+FUxpq6q
         EEhA==
X-Gm-Message-State: AOAM533mgfJv+DqJPm0QHPVsS69kzJjWAnAvyjokqM/ahkxcfJJ+1K+Y
        05NWPArGe9rCEDuRqM+HSE6jpSWtBgS9Ew==
X-Google-Smtp-Source: ABdhPJw1yjaczjdHKDlSU/uCMhzDZIMKbHNsg2zJ9/G+YCZuxtlgUw5VTrOCOWj1IqXMSxMhAM2J0w==
X-Received: by 2002:a2e:958e:: with SMTP id w14mr5827704ljh.367.1605777378993;
        Thu, 19 Nov 2020 01:16:18 -0800 (PST)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id f25sm3675308ljk.57.2020.11.19.01.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 01:16:18 -0800 (PST)
Subject: Re: [PATCH v4] mm: Optional full ASLR for mmap() and mremap()
To:     Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>
Cc:     linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mateusz Jurczyk <mjurczyk@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <20201026160518.9212-1-toiwoton@gmail.com>
 <20201117165455.GN29991@casper.infradead.org>
 <CAG48ez0LyOMnA4Khv9eV1_JpEJhjZy4jJYF=ze3Ha2vSNAfapw@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <7a10cb0c-4426-c0b9-7933-8de5f1a86d67@gmail.com>
Date:   Thu, 19 Nov 2020 11:16:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0LyOMnA4Khv9eV1_JpEJhjZy4jJYF=ze3Ha2vSNAfapw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 19.11.2020 0.42, Jann Horn wrote:
> On Tue, Nov 17, 2020 at 5:55 PM Matthew Wilcox <willy@infradead.org> wrote:
>> On Mon, Oct 26, 2020 at 06:05:18PM +0200, Topi Miettinen wrote:
>>> Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
>>> enables full randomization of memory mappings created with mmap(NULL,
>>> ...). With 2, the base of the VMA used for such mappings is random,
>>> but the mappings are created in predictable places within the VMA and
>>> in sequential order. With 3, new VMAs are created to fully randomize
>>> the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
>>> even if not necessary.
>>
>> Is this worth it?
>>
>> https://www.ndss-symposium.org/ndss2017/ndss-2017-programme/aslrcache-practical-cache-attacks-mmu/
> 
> Yeah, against local attacks (including from JavaScript), ASLR isn't
> very robust; but it should still help against true remote attacks
> (modulo crazyness like NetSpectre).
> 
> E.g. Mateusz Jurczyk's remote Samsung phone exploit via MMS messages
> (https://googleprojectzero.blogspot.com/2020/08/mms-exploit-part-5-defeating-aslr-getting-rce.html)
> would've probably been quite a bit harder to pull off if he hadn't
> been able to rely on having all those memory mappings sandwiched
> together.

Compiling the system with -mcmodel=large should also help, since then 
even within one library, the address space layout of various segments 
(text, data, rodata) could be randomized individually and then finding 
the XOM wouldn't aid in finding the other segments. But this model isn't 
so well supported yet (GCC: 
https://gcc.gnu.org/onlinedocs/gcc/AArch64-Options.html, not sure about 
LLVM).

-Topi
