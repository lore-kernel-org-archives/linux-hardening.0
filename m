Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1F2C433B4
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Apr 2021 21:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6BE61246
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Apr 2021 21:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhDGVhU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Apr 2021 17:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232943AbhDGVhT (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Apr 2021 17:37:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3B6C61205;
        Wed,  7 Apr 2021 21:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617831429;
        bh=RFTs87mWw0H1NgKsi6VoKVt5brrjF6rBaHU/Q3oJcOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJqDViRiIwRnmM3YMFuWCFiMrlE6kkSCoyOgBYkbhZjOWQy+LU7BrpPRbOuAnIFsF
         4J/gP9rqJYlB6S+FdzbLcIjo0LcernQ4xfVLqOqv6XGkmkibX8QADKKG3fcooPtKf/
         5R8638Kj2tsbgQh24sFjWw94F41DOwE/FWdgVA/f/ndVKn5v2IJpWT35L9FDhQN1M8
         7YU+doIt3z0UPy7LM6kl69Pprv/+2rjJYtlqERzxtnsn4kHhFZFR85DfKdsJCCN2MC
         yveisBlQZtXyXQVjE49EAxUpf8/ASsb7xDTJT7C5JNvSxDZnwgAs1x90+NU2SUzDxi
         zRR+acRM2RpKQ==
Date:   Wed, 7 Apr 2021 22:37:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v10 3/6] stack: Optionally randomize kernel stack offset
 each syscall
Message-ID: <20210407213702.GB16569@willie-the-truck>
References: <20210401232347.2791257-1-keescook@chromium.org>
 <20210401232347.2791257-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401232347.2791257-4-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Apr 01, 2021 at 04:23:44PM -0700, Kees Cook wrote:
> This provides the ability for architectures to enable kernel stack base
> address offset randomization. This feature is controlled by the boot
> param "randomize_kstack_offset=on/off", with its default value set by
> CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT.
> 
> This feature is based on the original idea from the last public release
> of PaX's RANDKSTACK feature: https://pax.grsecurity.net/docs/randkstack.txt
> All the credit for the original idea goes to the PaX team. Note that
> the design and implementation of this upstream randomize_kstack_offset
> feature differs greatly from the RANDKSTACK feature (see below).

[...]

> diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
> new file mode 100644
> index 000000000000..fd80fab663a9
> --- /dev/null
> +++ b/include/linux/randomize_kstack.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _LINUX_RANDOMIZE_KSTACK_H
> +#define _LINUX_RANDOMIZE_KSTACK_H
> +
> +#include <linux/kernel.h>
> +#include <linux/jump_label.h>
> +#include <linux/percpu-defs.h>
> +
> +DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
> +			 randomize_kstack_offset);
> +DECLARE_PER_CPU(u32, kstack_offset);
> +
> +/*
> + * Do not use this anywhere else in the kernel. This is used here because
> + * it provides an arch-agnostic way to grow the stack with correct
> + * alignment. Also, since this use is being explicitly masked to a max of
> + * 10 bits, stack-clash style attacks are unlikely. For more details see
> + * "VLAs" in Documentation/process/deprecated.rst
> + */
> +void *__builtin_alloca(size_t size);
> +/*
> + * Use, at most, 10 bits of entropy. We explicitly cap this to keep the
> + * "VLA" from being unbounded (see above). 10 bits leaves enough room for
> + * per-arch offset masks to reduce entropy (by removing higher bits, since
> + * high entropy may overly constrain usable stack space), and for
> + * compiler/arch-specific stack alignment to remove the lower bits.
> + */
> +#define KSTACK_OFFSET_MAX(x)	((x) & 0x3FF)
> +
> +/*
> + * These macros must be used during syscall entry when interrupts and
> + * preempt are disabled, and after user registers have been stored to
> + * the stack.
> + */

This comment is out of date, as this is called from preemptible context on
arm64. Does that matter in terms of offset randomness?

Will
