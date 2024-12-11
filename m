Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DACD1C1F21
	for <linux-hardening@vger.kernel.org>; Wed, 11 Dec 2024 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906794; cv=none; b=coQvd7i/CEzJBpzrCbp7lkLaCRDQgb1DP/O6ZLinA/83v4Eg1kFVlkGBgacMyT4u2PdyBXfC3yXfx6JvCbvn5G6mCc9XrUeCasnod6TBJCQfUNDX8MFH46XByrvps6520A4rFwpDydM0Je17j3V8ubB2hlr3m0Bd0Djbh2j0Lrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906794; c=relaxed/simple;
	bh=XbRLMyt7k3YKZ3F6ya3+jcNz50GxQf5h0+xJvL74Pow=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:In-Reply-To:
	 Content-Type:References; b=LGuN73yD6QppgAy17gs+6pjQLy5/G/upR1KRm0NA9UEy8czb0Wtbje8Mn82tqwv3qqvu0uQuWPyOuwnBHk4AvHBPbv2BmvofS29b9IgGd1OoSc9o1n2zoMXczWRTcu16c7sJSGhs8e1wT98uQYctPjLkycRcsWYxeKRgOeqSuPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=E0K4+dOP; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E0K4+dOP"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241211084624euoutp01d54b7561da244c149cf8c656c0c8a1f3~QEwisEU6g0848408484euoutp01c
	for <linux-hardening@vger.kernel.org>; Wed, 11 Dec 2024 08:46:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241211084624euoutp01d54b7561da244c149cf8c656c0c8a1f3~QEwisEU6g0848408484euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733906784;
	bh=cpqClTx7HZk9gCRNzag5+pPyGl+jmhAwfbU/m/DP3YU=;
	h=Date:Subject:From:To:CC:In-Reply-To:References:From;
	b=E0K4+dOPYFQtoxXGR5PZrn+g9qJVL1YAsLHecTYuCxelSN8okWOzgnt8By69TsTfN
	 C1gY1E3nGXp7FZ09yC+C7PnO8nip2TXZboFIVVm2CtJ5w/WTNwBHlbQM5mt0Oq3nv/
	 4e8Y9ptUgpU4Dt98kpCZ2njjX1zuxis7sdPyOLB8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241211084623eucas1p186e11a3d0905842a8dd10a3b46c3b10d~QEwhrQ9xx2927129271eucas1p1C;
	Wed, 11 Dec 2024 08:46:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id D2.D2.20397.F5159576; Wed, 11
	Dec 2024 08:46:23 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241211084623eucas1p151dc11714ba7c6f5a8168001aaa2107c~QEwhSYGSe2231522315eucas1p1U;
	Wed, 11 Dec 2024 08:46:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241211084622eusmtrp20609eaf6fbbfc312142c815c08d447fa~QEwhRwjX72179421794eusmtrp2b;
	Wed, 11 Dec 2024 08:46:22 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-d5-6759515f0dc8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E9.CD.19654.E5159576; Wed, 11
	Dec 2024 08:46:22 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241211084622eusmtip1a4f3d2a1c700ebd620029913b87df5fd~QEwhGm1o92144321443eusmtip1I;
	Wed, 11 Dec 2024 08:46:22 +0000 (GMT)
Received: from [106.110.32.87] (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 11 Dec 2024 08:46:21 +0000
Message-ID: <7274aee6-2f51-4ae8-b085-b9a111c2ac03@samsung.com>
Date: Wed, 11 Dec 2024 09:46:21 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
Content-Language: en-GB
From: Daniel Gomez <da.gomez@samsung.com>
To: Petr Pavlu <petr.pavlu@suse.com>, Kees Cook <kees@kernel.org>
CC: Christophe Leroy <christophe.leroy@csgroup.eu>, Luis Chamberlain
	<mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
	<linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Thomas
	Gleixner <tglx@linutronix.de>, <linux-hardening@vger.kernel.org>
In-Reply-To: <95871917-9747-40d4-8305-51bc5d75cf82@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7rxgZHpBsu+CFncmfSc3WLd2/Os
	FvPW/2S0uLxrDptFw+zvrBY3JjxltFj65R2zxdIVb1ktNm+ayuzA6fH15jkmjwWbSj02repk
	83h37hy7x/otV1k8Pm+SC2CL4rJJSc3JLEst0rdL4Mp409PPVPA8smLqqz/MDYwvvbsYOTkk
	BEwkNrUcZuxi5OIQEljBKHH16T12COcLo8Sqpl42COczo0R340UWmJb+930sEInljBLXz3cy
	w1UdvdQF1b+TUeL72kOsIC28AnYSh66+A2tnEVCV6Fy3nQkiLihxcuYTsLiogLzE/Vsz2EFs
	YYFcibZrz8DizALiEk1fVoLNYRPQlNh3chNYjYiAo8Sba09ZQZYxC0xkkngxazsjSIJTwF7i
	X+MFoGYOoISVxPQTnhBz5CWat85mhnhBUWLGxJVQ79RKnNpyiwlkjoTAdE6JDd/Os0MkXCRa
	3z9kgrCFJV4d3wIVl5H4v3M+VDxdYsm6WVCDCiT23J7FCrJXQsBaou9MDkTYUeLu581QYT6J
	G28FIc7hk5i0bTrzBEbVWUghMQvJx7MQHpiF5IEFjCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS
	9ZLzczcxAlPU6X/Hv+5gXPHqo94hRiYOxkOMEhzMSiK8N+wj04V4UxIrq1KL8uOLSnNSiw8x
	SnOwKInzqqbIpwoJpCeWpGanphakFsFkmTg4pRqYHMwkBZ8neJntzs2Ne7J1rbiqjkbzoZse
	hqVvmrXTvh9/zFfF/m2niomU9OGlfTxdbxl2NLjvqjgtOndWV+dPnSdtU7hrLS4duX1Oq6t7
	w5+g/FM5z6XeB6l9ZNTdfdNKTGuj49Hb089fvsjq6vu+7OrmVWLPLpyW088rf8AyKXp/M4P6
	wpf3/zeubHu5aabOZgFl9f4N87wLG38z9+jkH5fWfbFrIaulJ/vsxKq92/9m7chi+vGFtypP
	YpryzclmHnO6wzc/6izK2LyyZV526KUPecK31pWxbZuz8HiQQafEkacCalk/WbuPfzZ7vabj
	5nWh2g2B/2OyzU4UuqyRbhX/Fr7o2UsxfauvPqqLlFiKMxINtZiLihMBJU73FsADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7pxgZHpBnPPWFjcmfSc3WLd2/Os
	FvPW/2S0uLxrDptFw+zvrBY3JjxltFj65R2zxdIVb1ktNm+ayuzA6fH15jkmjwWbSj02repk
	83h37hy7x/otV1k8Pm+SC2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXS
	t7NJSc3JLEst0rdL0Mt409PPVPA8smLqqz/MDYwvvbsYOTkkBEwk+t/3sYDYQgJLGSX+fLKB
	iMtIbPxylRXCFpb4c62LrYuRC6jmI6PEy41bmCGcnYwSW//OZwap4hWwkzh09R3YJBYBVYnO
	dduZIOKCEidnPgGLiwrIS9y/NYMdxBYWyJVou/YMLM4sIC7R9GUl2DY2AU2JfSc3gdWICDhK
	vLn2lBVkGbPARCaJrnmL2CFOfcoiMWkPN4jNKWAv8a/xAtQgC4nFbw6yQ9jyEs1bZzNDvKAo
	MWPiShYIu1bi899njBMYRWchuW8WkjtmIRk1C8moBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS
	83M3MQJje9uxn1t2MK589VHvECMTB+MhRgkOZiUR3hv2kelCvCmJlVWpRfnxRaU5qcWHGE2B
	gTSRWUo0OR+YXPJK4g3NDEwNTcwsDUwtzYyVxHnZrpxPExJITyxJzU5NLUgtgulj4uCUamBS
	/PT/zKXKhOCC2YkXAzLDTpb9MWOcYxZUf0b0o7vohnPXJik/FpmSz2wwzTLA9Ejjca6DuYoP
	rPjvu7NXLb8vflnlRhLD/lA2kRkndN7n3bBX6mw+sqj90SePWqOZmckKNtKeU5ICFq+Y6dE2
	+eqzOtuHy/Nlwj1bCjvX7Gx3KWJnrfm2Jbh28vHiyriI5Wm9ExMO72FdaP37YaFj7jH/81/T
	pJ40rDS0DPXcUpO3uyDJoSL17YWd3WpfzMO+z03zX+qx4NalVvfGM8d/9yRsfn/3X2b0H8/D
	X9kr9Gd+errm373Zq0ySj/066jGv7c7P3qZF12tC9lTPjZ4p/P7gqpqFSwqfPU5d5ieSGrtJ
	iaU4I9FQi7moOBEAZdWRn3YDAAA=
X-CMS-MailID: 20241211084623eucas1p151dc11714ba7c6f5a8168001aaa2107c
X-Msg-Generator: CA
X-RootMTR: 20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
	<CGME20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be@eucas1p1.samsung.com>
	<164e5f22f8ab59d1d516e3c992efdd9f83ab4819.1731148254.git.christophe.leroy@csgroup.eu>
	<D5HZV4A6SC9A.25U3Q0WUVDJHZ@samsung.com>
	<b74f0845-4916-47eb-945b-eb91ae05fc91@csgroup.eu>
	<D5K3PNXEIKYK.11GZ8BMY02OA4@samsung.com>
	<7fdcf601-524b-4530-861d-e4b0f8c1023b@suse.com>
	<9734d93d-73c8-464e-8f32-6117c6f6c952@samsung.com>
	<cee55e3b-9028-4f56-8ac6-9895ca383334@suse.com>
	<95871917-9747-40d4-8305-51bc5d75cf82@samsung.com>

Hi Kees,


Could you help clarify the handling of __ro_after_init? What do you 
think is the best approach when a second attempt fails at setting a 
section to RO after a module is already initialized? (please find the 
deatils in this pach series or in [1]. Reporting the failure to the 
caller seems logical to me but adds some complexity. On the other hand, 
logging alone feels insufficient but may be the simplest option. Could 
you advice on handling this corner case and if it's relevant to KSPP?

You can find below the conversation. And the v1 PATCH series here [1].

[1] 
https://lore.kernel.org/all/cover.1733427536.git.christophe.leroy@csgroup.eu/

Thanks,
Daniel


On 12/10/2024 11:49 AM, Daniel Gomez wrote:
> On 12/4/2024 4:14 PM, Petr Pavlu wrote:
>> On 11/28/24 21:23, Daniel Gomez wrote:
>>> On 11/12/2024 3:35 PM, Petr Pavlu wrote:
>>>> On 11/12/24 10:43, Daniel Gomez wrote:
>>>>> On Mon Nov 11, 2024 at 7:53 PM CET, Christophe Leroy wrote:
>>>>>>
>>>>>>
>>>>>> Le 09/11/2024 à 23:17, Daniel Gomez a écrit :
>>>>>>> On Sat Nov 9, 2024 at 11:35 AM CET, Christophe Leroy wrote:
>>>>>>>> Once module init has succeded it is too late to cancel loading.
>>>>>>>> If setting ro_after_init data section to read-only fails, all we
>>>>>>>> can do is to inform the user through a warning.
>>>>>>>>
>>>>>>>> Reported-by: Thomas Gleixner <tglx@linutronix.de>
>>>>>>>> Closes: https://protect2.fireeye.com/v1/url?k=d3deb284-b2a35ac3- 
>>>>>>>> d3df39cb-74fe485fff30-288375d7d91e4ad9&q=1&e=701066ca-634d-4525- 
>>>>>>>> a77d-1a44451f897a&u=https%3A%2F%2Feur01.safelinks.protection.outlook.com%2F%3Furl%3Dhttps%253A%252F%252Flore.kernel.org%252Fall%252F20230915082126.4187913-1-ruanjinjie%2540huawei.com%252F%26data%3D05%257C02%257Cchristophe.leroy%2540csgroup.eu%257C26b5ca7363e54210439b08dd010c4865%257C8b87af7d86474dc78df45f69a2011bb5%257C0%257C0%257C638667874457200373%257CUnknown%257CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%253D%253D%257C0%257C%257C%257C%26sdata%3DZeJ%252F3%252B2Nx%252FBf%252FWLFEkhxKlDhZk8LNkz0fs%252Fg2xMcOjY%253D%26reserved%3D0
>>>>>>>> Fixes: d1909c022173 ("module: Don't ignore errors from 
>>>>>>>> set_memory_XX()")
>>>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>>> ---
>>>>>>>>     kernel/module/main.c | 6 +++---
>>>>>>>>     1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>>>>>>> index 2de4ad7af335..1bf4b0db291b 100644
>>>>>>>> --- a/kernel/module/main.c
>>>>>>>> +++ b/kernel/module/main.c
>>>>>>>> @@ -2583,7 +2583,9 @@ static noinline int do_init_module(struct 
>>>>>>>> module *mod)
>>>>>>>>     #endif
>>>>>>>>         ret = module_enable_rodata_ro_after_init(mod);
>>>>>>>>         if (ret)
>>>>>>>> -        goto fail_mutex_unlock;
>>>>>>>> +        pr_warn("%s: %s() returned %d, ro_after_init data might 
>>>>>>>> still be writable\n",
>>>>>>>> +            mod->name, __func__, ret);
>>>>>>>> +
>>>>>>>>         mod_tree_remove_init(mod);
>>>>>>>>         module_arch_freeing_init(mod);
>>>>>>>>         for_class_mod_mem_type(type, init) {
>>>>>>>> @@ -2622,8 +2624,6 @@ static noinline int do_init_module(struct 
>>>>>>>> module *mod)
>>>>>>>>         return 0;
>>>>>>>
>>>>>>> I think it would make sense to propagate the error. But that would
>>>>>>> require changing modprobe.c. What kind of error can we expect 
>>>>>>> when this
>>>>>>> happens?
>>>>>>
>>>>>> AFAIK, on powerpc it fails with EINVAL when
>>>>>> - The area is a vmalloc or module area and is a hugepage area
>>>>>> - The area is not vmalloc or io register and MMU is not powerpc 
>>>>>> radix MMU
>>>>>>
>>>>>> Otherwise it propagates the error from 
>>>>>> apply_to_existing_page_range().
>>>>>> IIUC it will return EINVAL when it hits a leaf PTE in upper 
>>>>>> directories.
>>>>>
>>>>> Looking at that path I see we can also fail at __apply_to_page_range()
>>>>> -> apply_to_p4d_range() and return with -ENOMEM.
>>>>>
>>>>> My proposal was to do something like the change below in modprobe:
>>>>>
>>>>> diff --git a/tools/modprobe.c b/tools/modprobe.c
>>>>> index ec66e6f..8876e27 100644
>>>>> --- a/tools/modprobe.c
>>>>> +++ b/tools/modprobe.c
>>>>> @@ -572,6 +572,11 @@ static int insmod_insert(struct kmod_module 
>>>>> *mod, int flags, const char *extra_o
>>>>>                   err = 0;
>>>>>           else {
>>>>>                   switch (err) {
>>>>> +               case -EINVAL:
>>>>> +                       ERR("module '%s'inserted: ro_after_init 
>>>>> data might"
>>>>> +                           "still be writable (see dmesg)\n",
>>>>> +                           kmod_module_get_name(mod));
>>>>> +                       break;
>>>>>                   case -EEXIST:
>>>>>                           ERR("could not insert '%s': Module 
>>>>> already in kernel\n",
>>>>>                               kmod_module_get_name(mod));
>>>>>
>>>>> But I think these error codes may be also be reported in other parts
>>>>> such as simplify_symbols() so may not be a good idea after all.
>>>>
>>>> It isn't really possible to make a sensible use of the return code from
>>>> init_module(), besides some basic check for -EEXIST. The problem is 
>>>> that
>>>> any error code from a module's init function is also propagated as
>>>> a result from the syscall.
>>>>
>>>>>
>>>>> Maybe we just need to change the default/catch all error message in
>>>>> modprobe.c and to indicate/include this case:
>>>>>
>>>>> diff --git a/tools/modprobe.c b/tools/modprobe.c
>>>>> index ec66e6f..3647d37 100644
>>>>> --- a/tools/modprobe.c
>>>>> +++ b/tools/modprobe.c
>>>>> @@ -582,7 +582,8 @@ static int insmod_insert(struct kmod_module 
>>>>> *mod, int flags, const char *extra_o
>>>>>                               kmod_module_get_name(mod));
>>>>>                           break;
>>>>>                   default:
>>>>> -                       ERR("could not insert '%s': %s\n", 
>>>>> kmod_module_get_name(mod),
>>>>> +                       ERR("could not insert '%s' or inserted with 
>>>>> error %s, "
>>>>> +                           "(see dmesg)\n", 
>>>>> kmod_module_get_name(mod),
>>>>>                               strerror(-err));
>>>>>                           break;
>>>>>                   }
>>>>>
>>>>>
>>>>>>
>>>>>> On other architectures it can be different, I know some 
>>>>>> architecture try
>>>>>> to split the pages when they hit hugepages and that can fail.
>>>>>
>>>>> Is it worth it adding an error code for this case in case we want to
>>>>> report it back?
>>>>
>>>> I feel that the proposed kernel warning about this situation is
>>>> sufficient and the loader should then return 0 to indicate that the
>>>> module got loaded. It would be more confusing to return an error but
>>>> with the module actually remaining inserted.
>>>>
>>>> A module loaded without having its RO-after-init section changed
>>>> properly to RO is still fully functional. In practice, if this final
>>>> set_memory_ro() call fails, the system is already in such a state where
>>>> the additional warning is the least of the issues?
>>>>
>>>
>>> __ro_after_init is used for kernel self protection. We are loading
>>> "successfully" the module yes, but variables with this attribute are
>>> marked read-only to reduce the attack surface [1]. Since we have
>>> considered this stage already too late to unload the module, IMHO we
>>> should at least indicate that there was an error during the module
>>> initialization and propagate that to the loader, so it can decide the
>>> best action for their particular case. Warning once in the kernel log
>>> system, does not seem sufficient to me.
>>>
>>> [1] Documentation/security/self-protection.rst
>>
>> I'd be careful about introducing this new state where (f)init_module()
>> returns an error, yet the module actually gets loaded.
> 
> Perhaps we just need this new stage? module loaded with permission/ 
> security error?
> 
>>
>> The init_module() interface has one return value which can originate
>> from anywhere during the load process, including from the module's own
>> init function. As mentioned, this means that the userspace cannot
>> distinguish why the module load failed. It would be needed to have
>> a specific error code returned only for this case, or to extend the
>> interface further in some way.
>>
>> Another concern is consistency of the module loader interface as
>> a whole. Returning an error from init_module() in this case would mean
>> that only the specific caller is made aware that the module was loaded
>> with some issues. A different task that then decides to check the module
>> state under /sys/module would see it as normally loaded, and similarly a
> 
> Maybe we need to change this state too to indicate the problem.
> 
>> task trying to insert it again would get -EEXIST. That likely would need
>> changing too.
>>
>> What I'd like to understand is how reporting this as an error to the
>> userspace would help in practice. I think the userspace can decide to
>> report it as a warning and continue, or treat is as a hard problem and
>> stop the system? I would expect that most tools/systems would opt for
>> the former, but then this doesn't seem much different to me than when
>> the kernel produces the warning itself. The second option, with some
>> stretch, could be implemented with panic_on_warn=1.
> 
> Ideally, we would reverse the module initialization when encountering 
> this error [1]. However, since it's not feasible to undo it correctly at 
> this stage, reporting the error back to the caller allows them to assess 
> and decide whether to accept the risk.
> 
> [1] https://lore.kernel.org/all/Zuv0nmFblHUwuT8v@bombadil.infradead.org/
>>
>> Do you envision that the userspace would handle this problem differently
>> and it is worth adding the complexity?
> 
> What complexity do you mean?
> 
> A module driver has ro_after_init for the purpose of protecting the 
> kernel from attack [2]. If we ignore it by warning once, the caller will 
> not be aware of such risk (unless the caller it's parsing the kernel log).
> 
> [2] https://lore.kernel.org/all/1455748879-21872-1-git-send-email- 
> keescook@chromium.org/
> 
> Another option could be adding a kconfig to decide to report or not 
> which I would strongly suggest to report by default.
> 
> 
>>
>> As a side node, I've noticed that the module loader could mark also
>> static_call sections as ro_after_init. I'll post patches for that.
>> Additionally, both __jump_table and static_call sections could be
>> possibly turned RO earlier, after prepare_coming_module() ->
>> blocking_notifier_call_chain_robust() -> ... ->
>> jump_label_add_module()/static_call_add_module().
>>
> 

