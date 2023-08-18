Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BA1C05052
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 05:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357128AbjHRFYo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Aug 2023 01:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357453AbjHRFXr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Aug 2023 01:23:47 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB86A44BF
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 22:23:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RRqz86Wpxz4f3jMj
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 13:23:32 +0800 (CST)
Received: from [10.67.110.48] (unknown [10.67.110.48])
        by APP3 (Coremail) with SMTP id _Ch0CgBXe8NSAN9kaCyzAw--.3431S2;
        Fri, 18 Aug 2023 13:23:32 +0800 (CST)
Message-ID: <d3af78d4-9b15-347e-f3e8-5ce83f44faf6@huaweicloud.com>
Date:   Fri, 18 Aug 2023 13:23:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [netfilter-nf-next:testing 2/9]
 ./usr/include/linux/netfilter_bridge/ebtables.h:163:26: warning: field
 'target' with variable sized type 'struct ebt_entry_target' not at the end of
 a struct or class is a GNU extension
Content-Language: en-US
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To:     Kees Cook <keescook@chromium.org>, Florian Westphal <fw@strlen.de>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org
References: <202308171249.g1ywxhII-lkp@intel.com>
 <202308162257.F7876776C9@keescook> <20230817082618.GE4312@breakpoint.cc>
 <202308171000.C97EEC7@keescook>
 <247c158b-f1d3-1bba-b2fa-1d741a566837@huaweicloud.com>
In-Reply-To: <247c158b-f1d3-1bba-b2fa-1d741a566837@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgBXe8NSAN9kaCyzAw--.3431S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw47GFWDKw1fKr1xKrWUXFb_yoW5Zw17pF
        y8Aa1jkr48JrZ7Gw4IqF47uF1Yvw47Jry3ur13G348Z3Z0vry2kF4Ikr4a9F90yrsrGr1a
        yF4jqrWxZrsFqaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 2023/08/18 11:24, GONG, Ruiqi wrote:
> 
> 
> On 2023/08/18 1:02, Kees Cook wrote:
>> On Thu, Aug 17, 2023 at 10:26:18AM +0200, Florian Westphal wrote:
>>> Kees Cook <keescook@chromium.org> wrote:
>>>> On Thu, Aug 17, 2023 at 01:03:20PM +0800, kernel test robot wrote:
>>>>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
>>>>> head:   015e2d9101d3713c7bee16dccad171df04a3bbd5
>>>>> commit: 61b9e6bd48a6317c0a44ee4f3fecdec9de5baa9e [2/9] netfilter: ebtables: replace zero-length array members
>>>>> config: i386-buildonly-randconfig-r004-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171249.g1ywxhII-lkp@intel.com/config)
>>>>> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
>>>>> reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171249.g1ywxhII-lkp@intel.com/reproduce)
>>>>>
>>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>>> the same patch/commit), kindly add following tags
>>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202308171249.g1ywxhII-lkp@intel.com/
>>>>>
>>>>> All warnings (new ones prefixed by >>):
>>>>>
>>>>>    In file included from <built-in>:1:
>>>>>>> ./usr/include/linux/netfilter_bridge/ebtables.h:163:26: warning: field 'target' with variable sized type 'struct ebt_entry_target' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
>>>>>            struct ebt_entry_target target;
>>>>>                                    ^
>>>>>    1 warning generated.
>>>>
>>>> Eww, it looks like "struct ebt_entry_target" is used _within_ another
>>>> struct:
>>>>
>>>> struct ebt_standard_target {
>>>>         struct ebt_entry_target target;
>>>>         int verdict;
>>>> };
>>>
>>> Yes, same as xt_standard_target.
>>>
>>>> These have been fixed in the past in a variety of ways -- it all depends
>>>> on how userspace is using them. In looking at Debian Code Search:
>>>> https://codesearch.debian.net/search?q=struct+ebt_standard_target&literal=1
>>>>
>>>> It is exclusively doing casts and looking at the "verdict" member. So
>>>> the easiest conversion might be this:
>>>>
>>>>  struct ebt_standard_target {
>>>> -       struct ebt_entry_target target;
>>>> +       unsigned char hdr[sizeof(struct ebt_entry_target)];
>>>>         int verdict;
>>>
>>> I don't think its worth doing all of this.
>>>
>>> Can't we just keep it as-is and drop the relevant hunk from the patch?
>>
>> For now, yeah. But we'll need to find a solution as flex-array
>> structures overlapping variables is considered deprecated (it can lead
>> to ambiguous sizing results). But as long as the kernel itself doesn't
>> use struct ebt_standard_target, we can kick the can down the road a bit
>> more. :)
>>
> 
> I agree that we can complete the whole transformation step-by-step. I
> will make another patch without the problematic replacement.

I didn't notice that the patch had been modified and merged into
nf-next's testing branch. Let's use that and I won't send another one.
Thanks Florian! XD

