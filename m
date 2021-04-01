Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B5DC433B4
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 08:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4E460190
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 08:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhDAIiZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Apr 2021 04:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233024AbhDAIiL (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Apr 2021 04:38:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6D0B61041;
        Thu,  1 Apr 2021 08:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617266286;
        bh=pL7zEm/CJ6Uq13TbvMopTgicNXFZzItUs41gFNFs0bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3X3lduCFkIuAeuQcqpzhul7wvKwDj5UjZ40gX0BhH6coMkam04N1fMhBXiO1k9fr
         Qx/8Cp+zmkSw5yt/9WD3OWEBwEdVVUiTgmrKXPktPG5MJhpkzp1IqJLPCbqq2ePs32
         NzwqEkscV/FJQFSYJe0Z+pA7s1+1j2kz8cRLj9B2ZGRPbxRir0oMbkz4NORBnn08Qw
         zpEovn8ARnysgKDkNQpa5nWT4UqQLnGUIgZL92lSn8A0CTU6eFdvu51VF/lz3gas5G
         NbEBSMnsjL1na3BP/51tBCx3wTgdCqXYFtiXlE20KJqh/YGMRt2tzdaxvdOsy5SBYF
         Da/Tpgqva8b+A==
Date:   Thu, 1 Apr 2021 09:37:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/6] Optionally randomize kernel stack offset each
 syscall
Message-ID: <20210401083758.GA8745@willie-the-truck>
References: <20210331205458.1871746-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331205458.1871746-1-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees,

On Wed, Mar 31, 2021 at 01:54:52PM -0700, Kees Cook wrote:
> Hi Will (and Mark and Catalin),
> 
> Can you take this via the arm64 tree for v5.13 please? Thomas has added
> his Reviewed-by, so it only leaves arm64's. :)

Sorry, these got mixed up in my inbox so I just replied to v7 and v8 and
then noticed v9. Argh!

However, I think the comments still apply: namely that the dummy "=m" looks
dangerous to me and I think you're accessing pcpu variables with preemption
enabled for the arm64 part:

https://lore.kernel.org/r/20210401083034.GA8554@willie-the-truck
https://lore.kernel.org/r/20210401083430.GB8554@willie-the-truck

Will
