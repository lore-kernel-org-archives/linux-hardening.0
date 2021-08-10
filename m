Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8202C4338F
	for <linux-hardening@archiver.kernel.org>; Tue, 10 Aug 2021 17:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C2A600EF
	for <linux-hardening@archiver.kernel.org>; Tue, 10 Aug 2021 17:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhHJRML (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 10 Aug 2021 13:12:11 -0400
Received: from gateway30.websitewelcome.com ([192.185.147.85]:21295 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhHJRMK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 10 Aug 2021 13:12:10 -0400
X-Greylist: delayed 1495 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Aug 2021 13:12:10 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id B301C15516
        for <linux-hardening@vger.kernel.org>; Tue, 10 Aug 2021 11:23:22 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id DUXCmIIwDBvjyDUXCmuSuu; Tue, 10 Aug 2021 11:23:22 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bnDaw1wxkjMKThH+uNl7hV3zzBoyfGurRa+dO+/NGiE=; b=kVDsDhK+t/xS86aAjKzbTRGqxO
        txWYP/sOTXUepnyM1JGk6umOrtrCUmx51YxNMYLlLcsvKcXHnfvRF3Q5MRNq/6KO6gdgo60L7J1oH
        WODzq7FHP0dLLnwfkxvS/zsdv48j21fMbYFWONMkEH5ifTSrWev8vZxeGlrll+Q27HY7KwYd6wh6j
        Ii14xskiXbrYM9qXF5b179XuFpEgEc1Hqw1nWQ2QPRtwlw/4zozIyLFS7fXyKGQd3DthPEzunQfjC
        kyt31NJghBk/QS8LsWZWK5ncyoO15eqrouOee/J/pEvfnzY3LtrbC/7ul7av4E4I8APlBaie4ilOw
        ux6F/rDg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:37790 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1mDUXC-000oNK-1m; Tue, 10 Aug 2021 11:23:22 -0500
Subject: Re: [PATCH v2 1/2] media: staging/intel-ipu3: css: Fix wrong size
 comparison
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-hardening@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <cover.1627646101.git.gustavoars@kernel.org>
 <184d96f95d6261b1a91704eb68adbd0a2e1c2cc2.1627646101.git.gustavoars@kernel.org>
 <20210802060546.GL3@paasikivi.fi.intel.com>
 <3c9ac43d-09ca-e5d5-83a8-7b6d23928763@embeddedor.com>
 <20210810151852.GI3@paasikivi.fi.intel.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <a5e19508-4d7a-ba63-7ac0-ed2e56bc3bc1@embeddedor.com>
Date:   Tue, 10 Aug 2021 11:26:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810151852.GI3@paasikivi.fi.intel.com>
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
X-Exim-ID: 1mDUXC-000oNK-1m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:37790
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Sakari,

Please, see my comments below...

On 8/10/21 10:18, Sakari Ailus wrote:
> Hi Gustavo,
> 
> Apologies for the delay.
> 
> On Mon, Aug 02, 2021 at 08:46:20AM -0500, Gustavo A. R. Silva wrote:
>> Hi Sakari,
>>
>> On 8/2/21 01:05, Sakari Ailus wrote:
>>> Hi Gustavo,
>>>
>>> I missed you already had sent v2...
>>>
>>> On Fri, Jul 30, 2021 at 07:08:13AM -0500, Gustavo A. R. Silva wrote:
>>>> There is a wrong comparison of the total size of the loaded firmware
>>>> css->fw->size with the size of a pointer to struct imgu_fw_header.
>>>>
>>>> Fix this by using the right operand 'struct imgu_fw_header' for
>>>> sizeof, instead of 'struct imgu_fw_header *' and turn binary_header
>>>> into a flexible-array member. Also, adjust the relational operator
>>>> to be '<=' instead of '<', as it seems that the intention of the
>>>> comparison is to determine if the loaded firmware contains any
>>>> 'struct imgu_fw_info' items in the binary_header[] array than merely
>>>> the file_header (struct imgu_fw_bi_file_h).
>>>>
>>>> The replacement of the one-element array with a flexible-array member
>>>> also help with the ongoing efforts to globally enable -Warray-bounds
>>>> and get us closer to being able to tighten the FORTIFY_SOURCE routines
>>>> on memcpy().
>>>>
>>>> Link: https://github.com/KSPP/linux/issues/79
>>>> Link: https://github.com/KSPP/linux/issues/109
>>>> Fixes: 09d290f0ba21 ("media: staging/intel-ipu3: css: Add support for firmware management")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> ---
>>>>
>>>> It'd be just great if someone that knows this code better can confirm
>>>> these changes are correct. In particular the adjustment of the
>>>> relational operator. Thanks!
>>>>
>>>> Changes in v2:
>>>>  - Use flexible array and adjust relational operator, accordingly.
>>>
>>> The operator was just correct. The check is just there to see the firmware
>>> is at least as large as the struct as which it is being accessed.
>>
>> I'm a bit confused, so based on your reply to v1 of this series, this patch
>> is now correct, right?
>>
>> The operator in v1 _was_ correct as long as the one-element array wasn't
>> transformed into a flexible array, right?
>>
>> Notice that generally speaking flexible-array members don't occupy space in the
>> containing structure:
>>
>> $ pahole -C imgu_fw_header drivers/staging/media/ipu3/ipu3-css-fw.o
>> struct imgu_fw_header {
>> 	struct imgu_fw_bi_file_h   file_header;          /*     0    72 */
>> 	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>> 	struct imgu_fw_info        binary_header[] __attribute__((__aligned__(8))); /*    72     0 */
>>
>> 	/* size: 72, cachelines: 2, members: 2 */
>> 	/* forced alignments: 1 */
>> 	/* last cacheline: 8 bytes */
>> } __attribute__((__aligned__(8)));
>>
>> $ pahole -C imgu_fw_header drivers/staging/media/ipu3/ipu3-css-fw.o
>> struct imgu_fw_header {
>> 	struct imgu_fw_bi_file_h   file_header;          /*     0    72 */
>> 	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>> 	struct imgu_fw_info        binary_header[1] __attribute__((__aligned__(8))); /*    72  1200 */
>>
>> 	/* size: 1272, cachelines: 20, members: 2 */
>> 	/* forced alignments: 1 */
>> 	/* last cacheline: 56 bytes */
>> } __attribute__((__aligned__(8)));
>>
>> So, now that the flexible array transformation is included in the same patch as the
>> bugfix, the operator is changed from '<' to '<='
> 
> '<' is correct since you only need as much data as the struct you're about
> to access is large, not a byte more than that. As Dan noted.
> 
> I think you could add a check for binary_nr is at least one.

If we need to check that binary_nr is at least one, then this would be the right
change:

        css->fwp = (struct imgu_fw_header *)css->fw->data;
-       if (css->fw->size < sizeof(struct imgu_fw_header *) ||
+       if (css->fw->size < struct_size(css->fwp, binary_header, 1) ||
            css->fwp->file_header.h_size != sizeof(struct imgu_fw_bi_file_h))
                goto bad_fw;


--
Gustavo
