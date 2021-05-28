Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F081C47087
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 21:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76D16127C
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 21:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhE1VEC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 May 2021 17:04:02 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.60]:13273 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhE1VEB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 May 2021 17:04:01 -0400
X-Greylist: delayed 1503 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 May 2021 17:04:01 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 6B19C181E7
        for <linux-hardening@vger.kernel.org>; Fri, 28 May 2021 15:13:07 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id miqxlB6SrDedfmiqxlIKXB; Fri, 28 May 2021 15:13:07 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b4RggtcWr10kE7KQSbvkFrlP2HqZbnYXFSkESTT5YzU=; b=jDhCpVBDQPiR6pSO/44S+ji/65
        zw/rNxeXFgQl+RDXlIeWnjHkLw9BufEyUT44CjqyUPZguiWGsXmo9x+G2WPGwcjOeaZCd+aYs6DOf
        5H06UkXLE5pUICjMxIWRTKnWeTugzL6stOZW8lnnsKk6vgh819QA1MN81jv6aAFtCNPhvG7bYnEYJ
        QO2AoBwfu0wz5vbYbDTtLffnodoyinVoHYS0DlfCnmhhmBpDrOFscnpc85i2ruM6sSxBkkIKa1Uei
        jJljBqw4j8wiz3V8/u+vv08wl9S0Vvr9gKoYiPaNL+1Q4Rg/4CG27t1r/JyYxsQ1nCjs0/H/M6hNs
        F5e38Hyw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:38312 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lmiqv-003PAP-29; Fri, 28 May 2021 15:13:05 -0500
Subject: Re: [PATCH][next] ring-buffer: Fix fall-through warning for Clang
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210528195942.GA39174@embeddedor>
 <20210528160858.287e33ac@gandalf.local.home>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <b8f5aef0-ea0b-07b3-c46f-302e456f9a24@embeddedor.com>
Date:   Fri, 28 May 2021 15:13:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210528160858.287e33ac@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lmiqv-003PAP-29
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:38312
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 5/28/21 15:08, Steven Rostedt wrote:
> On Fri, 28 May 2021 14:59:42 -0500
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix
>> a fall-through warning by replacing a /* fall through */ comment
>> with the new pseudo-keyword macro fallthrough;
>>
>> Notice that Clang doesn't recognize /* fall through */ comments as
>> implicit fall-through markings, so in order to globally enable
>> -Wimplicit-fallthrough for Clang, these comments need to be
>> replaced with fallthrough; in the whole codebase.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> JFYI: We had thousands of these sorts of warnings and now we are down
>>       to just 25 in linux-next. This is one of those last remaining
>>       warnings.
> 
> And I have it fixed locally already.
> 
>   https://lore.kernel.org/lkml/20210511140246.18868-1-jj251510319013@gmail.com/
> 
> I've just been on vacation and haven't pushed it to next yet. It's still in
> the "to be tested" queue.

Awesome! :)

Thanks, Steven.
--
Gustavo
