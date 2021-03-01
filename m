Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF26CC433E0
	for <linux-hardening@archiver.kernel.org>; Mon,  1 Mar 2021 03:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ABD464DFF
	for <linux-hardening@archiver.kernel.org>; Mon,  1 Mar 2021 03:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhCADR4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 28 Feb 2021 22:17:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13024 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhCADRz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 28 Feb 2021 22:17:55 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DplkJ3SWWzMgGy;
        Mon,  1 Mar 2021 11:15:04 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 1 Mar 2021
 11:17:07 +0800
Subject: Re: [f2fs-dev] [PATCH][next] f2fs: Replace one-element array with
 flexible-array member
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chao Yu <chao@kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210224190313.GA144040@embeddedor>
 <bee16b72-f2e2-b113-9785-7f760be867df@huawei.com>
 <YDsjg1LqnkYIvvtB@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c8f5daa3-ec01-c6ba-7823-04c3650b689a@huawei.com>
Date:   Mon, 1 Mar 2021 11:17:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YDsjg1LqnkYIvvtB@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2021/2/28 13:00, Jaegeuk Kim wrote:
> On 02/25, Chao Yu wrote:
>> Hello, Gustavo,
>>
>> On 2021/2/25 3:03, Gustavo A. R. Silva wrote:
>>> There is a regular need in the kernel to provide a way to declare having
>>> a dynamically sized set of trailing elements in a structure. Kernel code
>>> should always use “flexible array members”[1] for these cases. The older
>>> style of one-element or zero-length arrays should no longer be used[2].
>>
>> I proposal to do the similar cleanup, and I've no objection on doing this.
>>
>> https://lore.kernel.org/patchwork/patch/869440/
>>
>> Let's ask for Jaegeuk' opinion.
> 
> Merged, thanks.
> This looks better reason than code readability. :)

Agreed.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
>>
>>>
>>> Refactor the code according to the use of a flexible-array member in
>>> struct f2fs_checkpoint, instead of a one-element arrays.
>>>
>>> Notice that a temporary pointer to void '*tmp_ptr' was used in order to
>>> fix the following errors when using a flexible array instead of a one
>>> element array in struct f2fs_checkpoint:
>>>
>>>     CC [M]  fs/f2fs/dir.o
>>> In file included from fs/f2fs/dir.c:13:
>>> fs/f2fs/f2fs.h: In function ‘__bitmap_ptr’:
>>> fs/f2fs/f2fs.h:2227:40: error: invalid use of flexible array member
>>>    2227 |   return &ckpt->sit_nat_version_bitmap + offset + sizeof(__le32);
>>>         |                                        ^
>>> fs/f2fs/f2fs.h:2227:49: error: invalid use of flexible array member
>>>    2227 |   return &ckpt->sit_nat_version_bitmap + offset + sizeof(__le32);
>>>         |                                                 ^
>>> fs/f2fs/f2fs.h:2238:40: error: invalid use of flexible array member
>>>    2238 |   return &ckpt->sit_nat_version_bitmap + offset;
>>>         |                                        ^
>>> make[2]: *** [scripts/Makefile.build:287: fs/f2fs/dir.o] Error 1
>>> make[1]: *** [scripts/Makefile.build:530: fs/f2fs] Error 2
>>> make: *** [Makefile:1819: fs] Error 2
>>>
>>> [1] https://en.wikipedia.org/wiki/Flexible_array_member
>>> [2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-length-and-one-element-arrays
>>>
>>> Link: https://github.com/KSPP/linux/issues/79
>>> Build-tested-by: kernel test robot <lkp@intel.com>
>>> Link: https://lore.kernel.org/lkml/603647e4.DeEFbl4eqljuwAUe%25lkp@intel.com/
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>    fs/f2fs/f2fs.h          | 5 +++--
>>>    include/linux/f2fs_fs.h | 2 +-
>>>    2 files changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index e2d302ae3a46..3f5cb097c30f 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -2215,6 +2215,7 @@ static inline block_t __cp_payload(struct f2fs_sb_info *sbi)
>>>    static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
>>>    {
>>>    	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
>>> +	void *tmp_ptr = &ckpt->sit_nat_version_bitmap;
>>>    	int offset;
>>>    	if (is_set_ckpt_flags(sbi, CP_LARGE_NAT_BITMAP_FLAG)) {
>>> @@ -2224,7 +2225,7 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
>>>    		 * if large_nat_bitmap feature is enabled, leave checksum
>>>    		 * protection for all nat/sit bitmaps.
>>>    		 */
>>> -		return &ckpt->sit_nat_version_bitmap + offset + sizeof(__le32);
>>> +		return tmp_ptr + offset + sizeof(__le32);
>>>    	}
>>>    	if (__cp_payload(sbi) > 0) {
>>> @@ -2235,7 +2236,7 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
>>>    	} else {
>>>    		offset = (flag == NAT_BITMAP) ?
>>>    			le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
>>> -		return &ckpt->sit_nat_version_bitmap + offset;
>>> +		return tmp_ptr + offset;
>>>    	}
>>>    }
>>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>>> index c6cc0a566ef5..5487a80617a3 100644
>>> --- a/include/linux/f2fs_fs.h
>>> +++ b/include/linux/f2fs_fs.h
>>> @@ -168,7 +168,7 @@ struct f2fs_checkpoint {
>>>    	unsigned char alloc_type[MAX_ACTIVE_LOGS];
>>>    	/* SIT and NAT version bitmap */
>>> -	unsigned char sit_nat_version_bitmap[1];
>>> +	unsigned char sit_nat_version_bitmap[];
>>>    } __packed;
>>>    #define CP_CHKSUM_OFFSET	4092	/* default chksum offset in checkpoint */
>>>
> .
> 
