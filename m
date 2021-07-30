Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B817AC4320A
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Jul 2021 10:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C24661019
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Jul 2021 10:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbhG3KTL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 30 Jul 2021 06:19:11 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbhG3KTJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 30 Jul 2021 06:19:09 -0400
Received: from [192.168.1.155] ([77.2.78.21]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MHWzP-1mMM2x1mQj-00DYDV; Fri, 30 Jul 2021 12:18:54 +0200
Subject: Re: [PATCH] RFC v2 struct const ops pointers member hardening
To:     Wang Zi-cheng <wzc@smail.nju.edu.cn>, keescook@chromium.org,
        tycho@tycho.pizza, linux-hardening@vger.kernel.org
References: <20210728065239.472464-1-wzc@smail.nju.edu.cn>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <26f5c90b-2e5d-5c95-efd2-aa9149acbf26@metux.net>
Date:   Fri, 30 Jul 2021 12:18:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728065239.472464-1-wzc@smail.nju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WBEirOJxfB2TBQ0ZqnP0MdQ18cFK3zfdvjl4XCC1xJbVYdG56im
 ZVCoUJ3mu75CJsE6QnliF9vOfaBsgmw9QZYE9w4wkP8XIsibKyc5aaczDMvu3db9ekr/7s0
 K8eXMNNdDeTmFM4r/9PiZup7p2XXIMSyaQfZfLqWpSbn8BbBI1BGM5DJzVBZfR3oUEjGjx7
 8k7vKgVHsayRSvTZmWooQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L1S2QitxdHY=:IdKBFDnROQiaRvtlIjawPM
 wbtGt5oNHSBS0sHyi/XKVu2/WoENITIoA7n1iXnv5GC35akR6Zo0DAn5RYfb/sn0fEA24ov0k
 CS44nXLDFksGx8z4V5A4LnG5kLg0/EMYTFUql8YOqaas1MC9lQmUrMA/ycP9NOJA9pnQG/Mhu
 WRxHZpcndlBADhlqZ/ucuAVzusF6cT4jiGbn9zqTj/F9jU4MYTd5udEdQNm/J85QRaag9BW5x
 Rf6NVUSo4JlHZRfDZ9GroNQXypby8OkItdpknunElk1UC6Wf+LbEsrx4iiqfvR+/jbQCdwe0y
 Yx6jFoV3/taV96b/6SMU31LHOCFvT5H57Nxe6434xPdbKEexXpJpPFf5oItjvB2NSZj64vg6l
 ACUYILBY4wp31Z5O5MuIWA7wvD1amK7FIYejITK6RakwSWv25q7LY0fMIkvdbtHdhvnjcjJ/V
 SuKTtnWB/+XOEH1jYO+Arcfp6PVIOA7mhhnwoOjpBd72d4JUghFEnmUqR22iROA3UjNjtr4+t
 O9iCQm7CyyPWCrl64JNmmmqNPWUITNpdvJ9xFkvJyGEoWNi8mjpdLBHQu//mpI2mxeK5W9Exj
 ZJo7BEJf9Au1aaSf7BPSPYZGVkWf8GZXFkXR/UCs91NWRXJ9ZMOF06sPKVSS8mfs783ncj7W5
 ofqu19UXsTQF7TxZEdI42ks1YSzPzreoR1shvHvHUP3y5Cn0i1XqClpqZe7pod67XbVFb9FIM
 Znf+WWc0h1fdLS8Fa30aGNdIOTrMgoBN8aGtSfqnEdbCsPaCiZAfwLOxWKmDXZLeRCDNdjmNE
 RD74DY7pTfTye+nhOP2RORfISQVBu5g9oreqlpHcNFuXhw689Crr1P1YQLudUeaPJtDHbcF
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 28.07.21 08:52, Wang Zi-cheng wrote:

Hi,

> 1. this is a useful hardening, my opinion was wrong in the previous patch,
> because the attacker may overwrite a struct with an "struct file*" pointer,
>   which point to a manufactured file struct with malicious f_op.
> Hardening operation pointers CAN help.
>> On the other side, kernel uses `kmem_cache_create` to alloc file/inode rather than `kmalloc`,
>> which makes it hard to exploit through heap overflow or UAF, so maybe this is not a "must" update.

note that there can be situations where a file_operations struct is
actually created at runtime. quite rare, but still possible.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
