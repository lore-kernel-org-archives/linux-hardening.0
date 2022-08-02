Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F37EC00140
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Aug 2022 23:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiHBXqH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Aug 2022 19:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiHBXqG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Aug 2022 19:46:06 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116CCE08F;
        Tue,  2 Aug 2022 16:46:03 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id B7CA440D403D;
        Tue,  2 Aug 2022 23:45:57 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 03 Aug 2022 02:45:57 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] x86_64: Harden compressed kernel, part 1
In-Reply-To: <e8342722-20f8-a566-59c5-8e8f7f271d98@intel.com>
References: <cover.1659369873.git.baskov@ispras.ru>
 <e6e7fef1-0dff-ef72-8a17-8ecec89994ca@intel.com>
 <893da11995f93a7ea8f7485d17bf356a@ispras.ru>
 <e8342722-20f8-a566-59c5-8e8f7f271d98@intel.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <29312ea704885f1b8d3c229e1f22dad7@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2022-08-02 05:41, Dave Hansen wrote:
> On 8/1/22 17:25, Evgeniy Baskov wrote:
>> On 2022-08-01 19:48, Dave Hansen wrote:
>>> On 8/1/22 09:38, Evgeniy Baskov wrote:
>>>> This is the first half of changes aimed to increase security of 
>>>> early
>>>> boot code of compressed kernel for x86_64 by enforcing memory 
>>>> protection
>>>> on page table level.
>>> 
>>> Could you share a little more background here?  Hardening is good, 
>>> but
>>> you _can_ have too much of a good thing.
>>> 
>>> Is this part of the boot cycle becoming a target for attackers in
>>> trusted boot environments?  Do emerging confidential computing
>>> technologies like SEV and TDX cause increased reliance on compressed
>>> kernel security?
>>> 
>>> In other words, why is *THIS* important versus all the other patches
>>> floating around out there?
>> 
>> Now compressed kernel code becomes larger, partially because of adding
>> SEV and TDX, so it worth adding memory protection here.
> ...
> 
> Is it fair to say that the problems here are on the potential,
> theoretical side rather than driven by practical, known issues that our
> users face?

Partially. We do have known issues because kernel PE image is not 
compliant
with the MS PE and COFF specification v8.3 referenced by the UEFI 
specification.
UEFI implementations with stricter PE loaders (e.g. mentioned above) 
fail to
boot Linux kernel.

As for hardening side, these improvements are indeed just nice-to-haves.
But we believe it is good to have them if they are available for free.

Thanks,
Evgeniy Baskov
