Return-Path: <SRS0=8UcS=EK=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA04C2D0A3
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 18:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24AB20780
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 18:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgKDSrO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 Nov 2020 13:47:14 -0500
Received: from foss.arm.com ([217.140.110.172]:42154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbgKDSrM (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 Nov 2020 13:47:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40FF114BF;
        Wed,  4 Nov 2020 10:47:11 -0800 (PST)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77B623F718;
        Wed,  4 Nov 2020 10:47:10 -0800 (PST)
Subject: Re: [PATCH 0/4] aarch64: avoid mprotect(PROT_BTI|PROT_EXEC) [BZ
 #26831]
To:     Mark Brown <broonie@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>, libc-alpha@sourceware.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
 <20201103173438.GD5545@sirena.org.uk>
 <8c99cc8e-41af-d066-b786-53ac13c2af8a@arm.com>
 <20201104105058.GA4812@sirena.org.uk>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <8c2d08a7-5595-6221-8da8-a7cbf6e1d493@arm.com>
Date:   Wed, 4 Nov 2020 12:47:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104105058.GA4812@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On 11/4/20 4:50 AM, Mark Brown wrote:
> On Tue, Nov 03, 2020 at 11:41:42PM -0600, Jeremy Linton wrote:
>> On 11/3/20 11:34 AM, Mark Brown wrote:
> 
>>> Given that there were still some ongoing discussions on a more robust
>>> kernel interface here and there seem to be a few concerns with this
>>> series should we perhaps just take a step back and disable this seccomp
>>> filter in systemd on arm64, at least for the time being?  That seems
>>> safer than rolling out things that set ABI quickly, a big part of the
> 
>> So, that's a bigger hammer than I think is needed and punishes !BTI
>> machines. I'm going to suggest that if we need to carry a temp patch its
>> more like the glibc patch I mentioned in the Fedora defect. That patch
>> simply logs a message, on the mprotect failures rather than aborting. Its
>> fairly non-intrusive.
> 
>> That leaves seccomp functional, and BTI generally functional except when
>> seccomp is restricting it. I've also been asked that if a patch like that is
>> needed, its (temporary?) merged to the glibc trunk, rather than just being
>> carried by the distro's.
> 
> The effect on pre-BTI hardware is an issue, another option would be for
> systemd to disable this seccomp usage but only after checking for BTI
> support in the system rather than just doing so purely based on the
> architecture.
> 

That works, but your also losing seccomp in the case where the machine 
is BTI capable, but the service isn't. So it should really be checking 
the elf notes, but at that point you might just as well patch glibc.
