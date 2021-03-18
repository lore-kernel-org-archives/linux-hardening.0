Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520E7C433DB
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 12:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2163864F69
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 12:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCRMrD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Mar 2021 08:47:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:37456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231327AbhCRMqq (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Mar 2021 08:46:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FC7FAEFB;
        Thu, 18 Mar 2021 12:46:44 +0000 (UTC)
Subject: Re: [PATCH v6 2/6] init_on_alloc: Optimize static branches
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Potapenko <glider@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210315180229.1224655-1-keescook@chromium.org>
 <20210315180229.1224655-3-keescook@chromium.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5d626b9b-5355-be94-e8e2-1be47f880f30@suse.cz>
Date:   Thu, 18 Mar 2021 13:46:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315180229.1224655-3-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 3/15/21 7:02 PM, Kees Cook wrote:
> The state of CONFIG_INIT_ON_ALLOC_DEFAULT_ON (and ...ON_FREE...) did not
> change the assembly ordering of the static branches: they were always out
> of line. Use the new jump_label macros to check the CONFIG settings to
> default to the "expected" state, which slightly optimizes the resulting
> assembly code.
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Link: https://lore.kernel.org/lkml/CAG_fn=X0DVwqLaHJTO6Jw7TGcMSm77GKHinrd0m_6y0SzWOrFA@mail.gmail.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>

For the fixed version

Acked-by: Vlastimil Babka <vbabka@suse.cz>
