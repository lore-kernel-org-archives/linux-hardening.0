Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA25C433FE
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 19:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6451D6137C
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 19:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhJETRG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 15:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbhJETRF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 15:17:05 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D55C061749;
        Tue,  5 Oct 2021 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=FbGbTzVN9zJ2FK467mGNFjxVX9oK9l7Rkf+moaDWL/0=; b=Z4+g5nBtCXAhTOPi8DhfZwuL3m
        npca5yx9Hhy/QGu/cX7271mH8AQusLVQxhczjcmRWL+yCO2TQfC60VKSoL2kMUPpNhY1RkAX+ZT32
        6N/hqhkj+mlvSdBXjRgx7iigKH/1ju92pUlA1H31FvLgu8H774gTvme2lScB7a7kHb/hCcMaes1jM
        M+x7lVVSDQ8gd2factizIqidruofZ9yJs/ZINmw9FZyOiRHn5Dv8UFKnjZhYaGP9oIT+CVBcrndzj
        m68i7thVbN8Ict3e3Sp/rwZ36ymaPSPuzHZHP+1wDu3a57VLPz1WdafsHnwDOp9O0nhD+2lUzudUD
        OjgcQZ7g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXpuD-00BdhP-RL; Tue, 05 Oct 2021 19:15:13 +0000
Subject: Re: [PATCH v5] docs: Explain the desired position of function
 attributes
To:     Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
References: <20211005152611.4120605-1-keescook@chromium.org>
 <7f6e53d04849daabd3e85c23f9974b2eb4a20c13.camel@perches.com>
 <202110051004.C4D9EBA0@keescook>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <742567f3-f043-6fab-235a-5835ca025f54@infradead.org>
Date:   Tue, 5 Oct 2021 12:15:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <202110051004.C4D9EBA0@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 10/5/21 10:04 AM, Kees Cook wrote:
> On Tue, Oct 05, 2021 at 08:39:14AM -0700, Joe Perches wrote:
>> On Tue, 2021-10-05 at 08:26 -0700, Kees Cook wrote:
>>> While discussing how to format the addition of various function
>>> attributes, some "unwritten rules" of ordering surfaced[1]. Capture as
>>> close as possible to Linus's preferences for future reference.
>>> +For example, using this function declaration example::
>>> +
>>> + __init void * __must_check action(enum magic value, size_t size, u8 count,
>>> +				   char *fmt, ...) __printf(4, 5) __malloc;
>>
>> trivia: almost all fmt declarations should be const char *
> 
> Heh, good point!
> 
>>> +Note that for a function **definition** (i.e. the actual function body),
>>> +the compiler does not allow function parameter attributes after the
>>> +function parameters. In these cases, they should go after the storage
>>> +class attributes (e.g. note the changed position of ``__printf(4, 5)``
>>> +below, compared to the **declaration** example above)::
>>> +
>>> + static __always_inline __init __printf(4, 5) void * __must_check action(enum magic value,
>>> +		size_t size, u8 count, char *fmt, ...) __malloc
>>
>> here too, and 80 columns?
> 
> Kernel standard is now 100. *shrug*

That's more for exceptions, not the common rule.
AFAIUI.

> 
>>> + {
>>> +	...
>>> + }
>>
>> Or just put all the attributes before the storage class... <grumble/chuckle>
> 
> I hear ya...
> 


-- 
~Randy
