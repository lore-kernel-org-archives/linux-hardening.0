Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF6AC433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 16:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918CB610FC
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 16:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhKBQP3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:15:29 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:54509 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234662AbhKBQG7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 12:06:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0Uumn27h_1635868998;
Received: from ashimida.local(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0Uumn27h_1635868998)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Nov 2021 00:03:20 +0800
Subject: Re: [PATCH] [RFC/RFT] AARCH64: Add gcc Shadow Call Stack support
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, frederic@kernel.org,
        yifeifz2@illinois.edu, Steven Rostedt <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, andreyknvl@gmail.com,
        Colin King <colin.king@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Marco Elver <elver@google.com>, linux-hardening@vger.kernel.org
References: <20211102075812.122715-1-ashimida@linux.alibaba.com>
 <CANiq72meBX1g6z2-vfNpMw2C8S-BavuA4CTyPLpD4zUcX193Sw@mail.gmail.com>
From:   Dan Li <ashimida@linux.alibaba.com>
Message-ID: <b08a94af-f7a4-c228-0ec8-24709385f1d5@linux.alibaba.com>
Date:   Wed, 3 Nov 2021 00:03:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CANiq72meBX1g6z2-vfNpMw2C8S-BavuA4CTyPLpD4zUcX193Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 11/2/21 5:51 PM, Miguel Ojeda wrote:
> On Tue, Nov 2, 2021 at 8:58 AM Dan Li <ashimida@linux.alibaba.com> wrote:
>>
>> I tried to submit a patch[1] to add compiler's SCS support on gcc-11.1.0.
> 
> This would go into GCC 12, right?
>
Oh, yes, gcc-11.1.0 is the version I used to test this patch.

>> [1] https://gcc.gnu.org/pipermail/gcc-patches/2021-November/583062.html
> 
> Nit: you can use the `Link: ` tag for this.
>
Thanks, Miguel :)

>>   # Supported by clang >= 7.0
> 
> We should add a comment here saying the minimum version too, e.g. GCC
>> = 12 (assuming it will be merged)
> 
Ok, I will add a comment in the next version, if this patch will be merged.

>>   config CC_HAVE_SHADOW_CALL_STACK
>> -       def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
>> +       def_bool CC_IS_CLANG || $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
> 
> This is changing the default for Clang (which looks fine due to our
> minimum Clang version), but if the test for GCC works the same way,
> why not just keep the line as it was since it covers both?
>
That sounds reasonable, keep this line unchanged is fine.

>> +#if __has_attribute(__no_sanitize_shadow_call_stack__)
>> +#define __noscs __attribute__((no_sanitize_shadow_call_stack))
>> +#else
>> +#define __noscs
>> +#endif
> 
> No need for the `else` branch here, it is done in `compiler_types.h`
> (to be consistent with Clang).
> 
Oh, I see, thanks.

> Also, I hope one day GCC and Clang doing the same for these
> sanitize-related bits...
> 
> Cheers,
> Miguel
> 
