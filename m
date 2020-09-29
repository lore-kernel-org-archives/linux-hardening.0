Return-Path: <SRS0=yYSg=DG=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43D8C4727C
	for <linux-hardening@archiver.kernel.org>; Tue, 29 Sep 2020 23:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53DC820773
	for <linux-hardening@archiver.kernel.org>; Tue, 29 Sep 2020 23:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="QKK+BopR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgI2XbC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 29 Sep 2020 19:31:02 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.21]:38986 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728206AbgI2XbC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 29 Sep 2020 19:31:02 -0400
X-Greylist: delayed 1316 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 19:31:01 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 5EB5A611B67
        for <linux-hardening@vger.kernel.org>; Tue, 29 Sep 2020 18:09:04 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id NOk4k9yYBCjCVNOk4kcf5a; Tue, 29 Sep 2020 18:09:04 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F3Hu8rdqxutt27Kuqs0e/1Cw8tmnLLeziqDGNvmqmjo=; b=QKK+BopRHfjGmAN4Ju9rzC4OgN
        ElYgDFU2I6w8cbKEsM53Oicl3Y0/ZDe38r7c7qq0QpUFZQszW8m2HD60/7ux4Zp84RCo83VqdyAQs
        Bdg22amapHue2QtBS8tTfQMecwGfGQ+3wUo08Brc/VOGE0GGwCvMtbpfLzenUKMO/c+j3rncANujx
        8C5P1RhuNsnq26vWCiAIBv45aftGe5lZGqExgJzdowwdlE88hmdjgn+j9ABPQ8kh+k1qTY9Gyj1Cf
        MAZADaUyaZDEzWDOz/RFGpvCkVlZt+gDS2LRs63aD05JsQWQq3jGR5efgt6c0shB/guJBdycnYQg0
        xTQsdTQQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:52182 helo=[192.168.15.4])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1kNOk1-002v7T-Aa; Tue, 29 Sep 2020 18:09:01 -0500
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
References: <20200518190114.GA7757@embeddedor>
 <20200521232415.GD29907@embeddedor>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 AP7RWS474w==
Subject: Re: [PATCH] x86/uv/time: Replace one-element array and save heap
 space
Message-ID: <1d4a85b8-22e3-3c0d-5beb-28dadda5848a@embeddedor.com>
Date:   Tue, 29 Sep 2020 18:14:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200521232415.GD29907@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1kNOk1-002v7T-Aa
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.4]) [187.162.31.110]:52182
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi all,

Who can take this?

Thanks
--
Gustavo

On 5/21/20 18:24, Gustavo A. R. Silva wrote:
> [+CC John Stultz <john.stultz@linaro.org> and +Kees' Reviewed-by tag]
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> On Mon, May 18, 2020 at 02:01:14PM -0500, Gustavo A. R. Silva wrote:
>> The current codebase makes use of one-element arrays in the following
>> form:
>>
>> struct something {
>>     int length;
>>     u8 data[1];
>> };
>>
>> struct something *instance;
>>
>> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
>> instance->length = size;
>> memcpy(instance->data, source, size);
>>
>> but the preferred mechanism to declare variable-length types such as
>> these ones is a flexible array member[1][2], introduced in C99:
>>
>> struct foo {
>>         int stuff;
>>         struct boo array[];
>> };
>>
>> By making use of the mechanism above, we will get a compiler warning
>> in case the flexible array does not occur last in the structure, which
>> will help us prevent some kind of undefined behavior bugs from being
>> inadvertently introduced[3] to the codebase from now on. So, replace
>> the one-element array with a flexible-array member.
>>
>> Also, make use of the new struct_size() helper to properly calculate the
>> total size needed to allocate dynamic memory for struct uv_rtc_timer_head.
>> Notice that, due to the use of a one-element array, space for an extra
>> struct cpu:
>>
>> struct {
>> 	int     lcpu;           /* systemwide logical cpu number */
>> 	u64     expires;        /* next timer expiration for this cpu */
>> } cpu[1]
>>
>> was being allocated at the moment of applying the sizeof operator to
>> struct uv_rtc_timer_head in the call to kmalloc_node() at line 159:
>>
>> 159		head = kmalloc_node(sizeof(struct uv_rtc_timer_head) +
>> 160			(uv_blade_nr_possible_cpus(bid) *
>> 161				2 * sizeof(u64)),
>> 162			GFP_KERNEL, nid);
>>
>> but that extra cpu[] was never actually being accessed due to the
>> following piece of code at line 168:
>>
>> 168		head->ncpus = uv_blade_nr_possible_cpus(bid);
>>
>> and the piece of code at line 187:
>>
>> 187		for (c = 0; c < head->ncpus; c++) {
>> 188			u64 exp = head->cpu[c].expires;
>> 189			if (exp < lowest) {
>> 190				bcpu = c;
>> 191				lowest = exp;
>> 192			}
>> 193		}
>>
>> so heap space was being wasted.
>>
>> Another thing important to notice is that through the use of the
>> struct_size() helper, code at line 161:
>>
>> 161		2 * sizeof(u64)),
>>
>> is changed to now be the actual size of struct cpu; see
>> sizeof(*(p)->member) at include/linux/overflow.h:314:
>>
>> 314 #define struct_size(p, member, n)                                       \
>> 315         __ab_c_size(n,                                                  \
>> 316                     sizeof(*(p)->member) + __must_be_array((p)->member),\
>> 317                     sizeof(*(p)))
>>
>> As a side note, the original developer could have implemented code at line
>> 161: 2 * sizeof(64) as follows:
>>
>> sizeof(*head->cpu)
>>
>> This issue has been out there since 2009.
>>
>> This issue was found with the help of Coccinelle and fixed _manually_.
>>
>> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
>> [2] https://github.com/KSPP/linux/issues/21
>> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  arch/x86/platform/uv/uv_time.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
>> index 7af31b245636..993a8ae6fdfb 100644
>> --- a/arch/x86/platform/uv/uv_time.c
>> +++ b/arch/x86/platform/uv/uv_time.c
>> @@ -52,7 +52,7 @@ struct uv_rtc_timer_head {
>>  	struct {
>>  		int	lcpu;		/* systemwide logical cpu number */
>>  		u64	expires;	/* next timer expiration for this cpu */
>> -	} cpu[1];
>> +	} cpu[];
>>  };
>>  
>>  /*
>> @@ -156,9 +156,8 @@ static __init int uv_rtc_allocate_timers(void)
>>  		struct uv_rtc_timer_head *head = blade_info[bid];
>>  
>>  		if (!head) {
>> -			head = kmalloc_node(sizeof(struct uv_rtc_timer_head) +
>> -				(uv_blade_nr_possible_cpus(bid) *
>> -					2 * sizeof(u64)),
>> +			head = kmalloc_node(struct_size(head, cpu,
>> +				uv_blade_nr_possible_cpus(bid)),
>>  				GFP_KERNEL, nid);
>>  			if (!head) {
>>  				uv_rtc_deallocate_timers();
>> -- 
>> 2.26.2
>>
