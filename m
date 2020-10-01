Return-Path: <SRS0=C0P2=DI=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1550DC4727C
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Oct 2020 15:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4FB220575
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Oct 2020 15:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgJAPqA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Oct 2020 11:46:00 -0400
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:46286 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731885AbgJAPqA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Oct 2020 11:46:00 -0400
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2020 11:45:59 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 32BBE1801BE47;
        Thu,  1 Oct 2020 15:39:47 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 8956A1802912F;
        Thu,  1 Oct 2020 15:39:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: flag54_230d6c72719c
X-Filterd-Recvd-Size: 2832
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Oct 2020 15:39:42 +0000 (UTC)
Message-ID: <ee3f75c1555c927e05b78c1afca1ed5a3b2cd50f.camel@perches.com>
Subject: Re: [PATCH v2][next] x86/uv/time: Replace one-element array and
 save heap space
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Date:   Thu, 01 Oct 2020 08:39:39 -0700
In-Reply-To: <20201001145608.GA10204@embeddedor>
References: <20201001145608.GA10204@embeddedor>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 2020-10-01 at 09:56 -0500, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use “flexible array members”[1] for these cases. The older
> style of one-element or zero-length arrays should no longer be used[2].
> 
> struct uv_rtc_timer_head contains a one-element array cpu[1].
> 
> Switch it to a flexible array and use the struct_size() helper to
> calculate the allocation size. Also, save some heap space in the
> process[3].

trivia:

> diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
[]
> @@ -148,9 +148,8 @@ static __init int uv_rtc_allocate_timers(void)
>  		struct uv_rtc_timer_head *head = blade_info[bid];
>  
>  		if (!head) {
> -			head = kmalloc_node(sizeof(struct uv_rtc_timer_head) +
> -				(uv_blade_nr_possible_cpus(bid) *
> -					2 * sizeof(u64)),
> +			head = kmalloc_node(struct_size(head, cpu,
> +				uv_blade_nr_possible_cpus(bid)),
>  				GFP_KERNEL, nid);
>  			if (!head) {
>  				uv_rtc_deallocate_timers();

Maybe save the value of uv_blade_nr_possible_cpus(bid)
to reduce duplication and make the sizeof_struct more
readable?

		if (!head) {
			int ncpus = uv_blade_nr_possible_cpus(bid);

			head = kmalloc_node(struct_size(head, cpu, ncpus),
					    GFP_KERNEL, nid);
			if (!head) {
				uv_rtc_deallocate_timers();
				return -ENOMEM;
			}
			spin_lock_init(&head->lock);
			head->ncpus = ncpus;
			head->next_cpu = -1;
			blade_info[bid] = head;
		}

