Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F9FC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 22:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE242610CC
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 22:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhJMWhM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:37:12 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55613 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230365AbhJMWhL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 18:37:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UrjCBZ0_1634164503;
Received: from ashimida.local(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0UrjCBZ0_1634164503)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Oct 2021 06:35:05 +0800
Subject: Re: [RFC PATCH 9/9] arm64: implement dynamic shadow call stack for
 GCC
To:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org
References: <20211013152243.2216899-1-ardb@kernel.org>
 <20211013152243.2216899-10-ardb@kernel.org>
From:   Dan Li <ashimida@linux.alibaba.com>
Message-ID: <82104d87-b077-87a0-2393-ab15ac66dcf7@linux.alibaba.com>
Date:   Thu, 14 Oct 2021 06:35:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211013152243.2216899-10-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 10/13/21 11:22 PM, Ard Biesheuvel wrote:
> Implement support for the shadow call stack on GCC, and in a dynamic
> manner, by parsing the unwind tables at init time to locate all
> occurrences of PACIASP/AUTIASP, and replacing them with the shadow call
> stack push and pop instructions, respectively.
> 
> This is useful because the overhead of the shadow call stack is
> difficult to justify on hardware that implements pointer authentication
> (PAC), and given that the PAC instructions are executed as NOPs on
> hardware that doesn't, we can just replace them.
> 
> This patch only implements this for the core kernel, but the logic can
> be reused for modules without much trouble.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   Makefile                      |   4 +-
>   arch/Kconfig                  |   4 +-
>   arch/arm64/Kconfig            |   8 +-
>   arch/arm64/kernel/Makefile    |   2 +
>   arch/arm64/kernel/head.S      |   3 +
>   arch/arm64/kernel/patch-scs.c | 223 ++++++++++++++++++++
>   6 files changed, 239 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 7cfe4ff36f44..2d94fed93d9d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -933,8 +933,8 @@ LDFLAGS_vmlinux += --gc-sections
>   endif
>   
>   ifdef CONFIG_SHADOW_CALL_STACK
> -CC_FLAGS_SCS	:= -fsanitize=shadow-call-stack
> -KBUILD_CFLAGS	+= $(CC_FLAGS_SCS)
> +CC_FLAGS_SCS-$(CONFIG_CC_IS_CLANG)	:= -fsanitize=shadow-call-stack
> +KBUILD_CFLAGS				+= $(CC_FLAGS_SCS-y)
>   export CC_FLAGS_SCS
>   endif
>   
> diff --git a/arch/arm64/kernel/patch-scs.c b/arch/arm64/kernel/patch-scs.c
> new file mode 100644
> index 000000000000..878a40060550
> --- /dev/null
> +++ b/arch/arm64/kernel/patch-scs.c
> +static int scs_patch_loc(u64 loc)
> +{
> +	u32 insn = le32_to_cpup((void *)loc);
> +
> +	/*
> +	 * Sometimes, the unwind data appears to be out of sync, and associates
> +	 * the DW_CFA_negate_ra_state directive with the ret instruction
> +	 * following the autiasp, rather than the autiasp itself.
> +	 */
> +	if (insn == 0xd65f03c0) { // ret
> +		loc -= 4;
> +		insn = le32_to_cpup((void *)loc);
> +	}
> +
> +	switch (insn) {
> +	case 0xd503233f: // paciasp
> +		*(u32 *)loc = cpu_to_le32(0xf800865e);
> +		break;
> +	case 0xd50323bf: // autiasp
> +		*(u32 *)loc = cpu_to_le32(0xf85f8e5e);
> +		break;
> +	default:
> +		// ignore
> +		break;
> +	}
> +	return 0;
> +}

Hi Ard,

According to my understanding (may be wrong), here may need to filter out
'-march=armv8.3-a'. When it is specified, gcc will use 'retaa' instead of
'autiasp' as a pac check.
