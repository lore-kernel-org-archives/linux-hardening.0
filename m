Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC94C4338F
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 20:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5C0610E6
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 20:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhHSUSd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhHSUSd (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Aug 2021 16:18:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B3A6610D2;
        Thu, 19 Aug 2021 20:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629404276;
        bh=JLc6MbNYqramEDF6nTAvsq6MESZmf7zguMGFkkGgcHg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qWo5JIbfjmGVZi+yzG/U7j5d0gwQLO1/cLteNgLHXzqOIBbmRSfbA782mYM1PHhzJ
         S7y6lYlNxwEXl+jo9T/l083VI3JWDT57uiAUueRlLWKqga8Imyeu5vCXMSiSaR8NoW
         PSKOgv0jBWYciM8KYTl8Gz8nFSEJF2dzl8meistXieu2YGYLswS5x7K/zhmoEdP7jT
         XXax6mzWi3JDfJI8N5pc9frY0vkhkqKmy/oEtRBEvx6fTwRZZK0uVQOVyA1GvrWFC8
         n1cO1FP3196VCJ+vkI4EeRz4aNvgoAwl49mEPyEf5Z3yKBPU5jtEalDylVs8svVOIA
         mttbmKf3RCIYg==
Subject: Re: [GIT PULL] Enable -Wimplicit-fallthrough for Clang for 5.14-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
References: <20210819040517.GA329693@embeddedor>
 <CAHk-=whXUJbqhjkRSjOQ2Tm5OmyKv3_JUTh8pxxvykGaC+fM0Q@mail.gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <9ef3265b-a5e7-d21b-68a8-ad137ac6ebfd@kernel.org>
Date:   Thu, 19 Aug 2021 13:17:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whXUJbqhjkRSjOQ2Tm5OmyKv3_JUTh8pxxvykGaC+fM0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 8/19/2021 12:19 PM, Linus Torvalds wrote:
> On Wed, Aug 18, 2021 at 9:02 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
>>
>> Enable -Wimplicit-fallthrough for Clang for 5.14-rc7
> 
> No. Much too late in the release, particularly knowing that we have
> Clang pre-releases that claim to be 14.0.0 and get this wrong.
> 
> So no way does this happen like this.
> 
> That's doubly true since the clang support for this all adds exactly
> _zero_ upside, only downside: we made the gcc checks be stricter, and
> gcc ends up having (a) more wide coverage and (b) doesn't have the
> bugs clang has.

For what it's worth, clang's version of -Wimplicit-fallthrough would 
have caught the bug in commit 652b44453ea9 ("habanalabs/gaudi: fix 
missing code in ECC handling"). Yes, small fix in the sea of patches 
that were needed to address clang's more pedantic version of the warning 
but this version of the warning is completely in line with the kernel's 
stance of switch statements in Documentation/process/deprecated.rst:

"All switch/case blocks must end in one of:

* break;
* fallthrough;
* continue;
* goto <label>;
* return [expression];"

> Honestly, I think the clang "version 14 or more" check is simply
> buggy. We *know* that check fails. Don't do it.
> 
> Make it "strictly more than 14.0.0" which hopefully doesn't fail, is
> cheap and easy, and which will make clang work correctly in the not
> too distant future.

Just to give some more context, Clang is not like GCC where x.0.0 is the 
development version and x.1.0 is the stable release. The first stable 
version of clang-14 will be clang 14.0.0 when it is released, just as it 
is now, so making it "strictly more than 14.0.0" will just delay 
enabling this even more despite the issue being fixed now. Intel already 
upgraded the clang they use for testing to one that is fixed and Mark 
Brown said Arm does testing with clang-14 but they regularly upgrade as 
well. Nobody should get bitten by this check in its current form unless 
they are not upgrading their development version of clang but in that 
case, they are doing it wrong to begin with in my opinion (would it not 
be the same as someone using v5.13-rc1 when v5.13-rc6 is out?)

If we waited until the next merge window, that would certainly give 
various entities enough time to upgrade their pre-release versions.

However, if you are truly opposed to a version check, can we at least 
just check for the presence of -Wunreachable-code-fallthrough as I 
suggested before? Yes, it is slightly more expensive as we have to call 
the compiler rather than using make builtins but then your concern of 
-Wimplicit-fallthrough getting enabled when it is buggy is completely 
addressed and people who have a fixed toolchain get access to the 
warning now.

Cheers,
Nathan
