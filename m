Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC30C433DB
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Mar 2021 22:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98F86197B
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Mar 2021 22:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCSWvP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 19 Mar 2021 18:51:15 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:34705 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCSWvL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 19 Mar 2021 18:51:11 -0400
X-Originating-IP: 73.37.121.169
Received: from Joaos-MacBook-Pro.local (c-73-37-121-169.hsd1.or.comcast.net [73.37.121.169])
        (Authenticated sender: joao@overdrivepizza.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 9108A20009;
        Fri, 19 Mar 2021 22:51:07 +0000 (UTC)
Subject: Re: Fine-grained Forward CFI on top of Intel CET / IBT
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86-64-abi@googlegroups.com, kernel-hardening@lists.openwall.com,
        samitolvanen@google.com, hjl.tools@gmail.com,
        linux-hardening@vger.kernel.org
References: <0537dc00-db0e-265b-9371-783c55717e74@overdrivepizza.com>
 <202103181230.2CA57FA5@keescook>
 <8e7dfa49-2c74-1349-017c-9a4700557519@overdrivepizza.com>
Message-ID: <632c02ef-efef-c068-1228-1b869d395142@overdrivepizza.com>
Date:   Fri, 19 Mar 2021 15:51:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <8e7dfa49-2c74-1349-017c-9a4700557519@overdrivepizza.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


>> That is a good point about R11 availability. Have you examined kernel
>> images for unintended gadgets? It seems like it'd be rare to find an 
>> arbitrary R11 load
>> followed by an indirect call together, but stranger gadgets show up, and
>> before the BPF JIT obfuscation happened, it was possible for attackers
>> (with sufficient access) to construct a series of immediates that would
>> contain the needed gadgets. (And not all systems run with BPF JIT
>> hardening enabled.)
>
> I haven't. On a CET-enabled environment, these unintended gadgets 
> would need to be preceded with an endbr instruction, otherwise they 
> won't be reachable indirectly. I assume that these cases can still 
> exist (specially in the presence of things like vulnerable BPF JIT or 
> if you consider full non-fineibt-instrumented functions working as 
> gadgets), but that this is a raised bar. Besides that, there are 
> patches like this one (which unfortunately was abandoned) that could 
> come handy:
>
> https://reviews.llvm.org/D88194
>
Actually (as clear in the end of the patch review) this was replaced by 
a different patch, which got in :)

review: https://reviews.llvm.org/D89178

commit: https://reviews.llvm.org/rGf385823e04f300c92ec03dbd660d621cc618a271


o/

Joao

