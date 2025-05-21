Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B31D7989;
	Wed, 21 May 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838582; cv=none; b=LqoGPvVwa/kYXsKvSKsxcMvkjyNPf8yep7fSxvpr31kcALg5XPunCW36FgrB2lM9yCD4F2/W8waP5rwVXIGf6gxBYt/Ine3rykrA7U8GBfeMcYL5XrFqWekaMU1mR3vGgID9hatXdr2pE7NTtYLSltaJY+fWpwaKutKEUVpxuUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838582; c=relaxed/simple;
	bh=D5RhzRWw4d0omBLnLJq7eWCJqJ16WamE4002P45GfM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FifzLXnliZkE2mSQ1tJqm/WoD8LnE6cJmn1N6RWCiyrZt4cPE/FzvgqFFApl4zOJxxUFXiFPGP+7sRJvIQmDBAYJQCs88V1FBsDCap2nbcU5EBH8sLo+VnBQQK7aMfD7ULdZI6S1E908973Hbim84zSjL6ubBUAONluwuyfSBnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id AEF7A43137;
	Wed, 21 May 2025 14:42:56 +0000 (UTC)
Message-ID: <3be862ef-f8b7-40d6-a3b1-5e8161801ba1@ghiti.fr>
Date: Wed, 21 May 2025 16:42:56 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: enable mseal sysmap for RV64
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: jeffxu@chromium.org, jszhang@kernel.org, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, kees@kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <5e7f2acd-2eef-4e69-9c11-ba8d1ec0bbc5@lucifer.local>
 <mhng-db41d38d-d3ec-4515-99f9-7368c82d46ca@palmer-ri-x1c9a>
 <26e04390-058f-4174-ad6f-3f0afd803fb1@lucifer.local>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <26e04390-058f-4174-ad6f-3f0afd803fb1@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffeehucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeefueejtdegkedvhefhudfhgeefieevheeugeehgedvgfejhfetjeeiudelvdefteenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghdpihhnfhhrrgguvggrugdrohhrghenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeduheehvdemtgdviedvmegvsgejsgemvdhfudefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeduheehvdemtgdviedvmegvsgejsgemvdhfudefpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeduheehvdemtgdviedvmegvsgejsgemvdhfudefngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrt
 ghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopehjvghffhiguhestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepjhhsiihhrghngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopefnihgrmhdrjfhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Lorenzo,

On 5/8/25 20:08, Lorenzo Stoakes wrote:
> On Thu, May 08, 2025 at 10:39:35AM -0700, Palmer Dabbelt wrote:
>> On Wed, 07 May 2025 09:22:09 PDT (-0700), lorenzo.stoakes@oracle.com wrote:
>>> On Wed, May 07, 2025 at 09:18:31AM -0700, Jeff Xu wrote:
>>>> Hi Jisheng
>>>>
>>>> It seems mm maintainers might prefer arch change reviewed by arch
>>>> maintainer and goes to arch tree, according to discussion in [1], I
>>>> don't have an opinion on this,  adding mm maintainers as FYI.
>>> Thanks Jeff, appreciate the ping!
>>>
>>> Jisheng - the main point here is to ensure that the arch doesn't rely in any way
>>> on, within the arch code itself, relocating any of these mappings. It's pretty
>>> easy to eyeball it and get a sense.
>>>
>>> Because if this is the case, the arch will be broken by this change should a
>>> user enable it, and obviously we'd rather avoid that! :)
>>>
>>> It's really likely that you're fine, as it'd be unusual for an arch to do this,
>>> but I strongly suggest you do so.
>>>
>>> And yes, I think these should really go through arch trees as explicitly arch
>>> code.
>>>
>>> Thanks, Lorenzo
>>>
>>>> On Sat, Apr 26, 2025 at 7:16 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>>>>> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS for RV64, covering the
>>>>> vdso, vvar.
>>>>>
>>>>> Passed sysmap_is_sealed and mseal_test self tests.
>>>>> Passed booting a buildroot rootfs image and a cli debian rootfs image.
>>>>>
>>>> mm maintainers like to get confirmation that the arch doesn't rely on
>>>> remapping the VDSO, VVAR, or any other special mappings, see
>>>> discussion in [2]
>> Do you have some description of what remapping is disallowed here?  There's
>> not a ton in that referenced thread.
> Any remapping of these special VMAs that would be disallowed by mseal that is
> being performed by kernel code.
>
>> We play a few tricks with remapping, including some aliasing to handle
>> different VA widths and text patching (via poke pages).  IIRC those are
>> similar in spirit to what's going on in x86/arm64 land, though sometimes the
>> exact flavor of the trick matters.  If you've got something I can look at it
>> might save me from having to read though the mm code...
> To risk sounding grumpy, and it's not your fault of course, but... this is
> the... fifth? Architecture where somebody's enabled this without seeming to
> understand what the feature does, and I'm a bit tired of it. And every time it's
> been _me_ who goes to check :)
>
> Anyway, I guess let me go check again.
>
> So it looks fine to me - the initial mapping to mm->context.vdso done by
> __setup_additional_pages() in arch/riscv/kernel/vdso.c appears to be final,
> except when vdso_mremap() is invoked, but that's when _userland_ does it,
> which this feature strictly disables, but that's fine.
>
> Note that the patch simply indicates that the architecture _supports_ this
> feature, the feature itself is disabled by default as it breaks a bunch of
> userland, which is why I insisted on it being put behind a config flag for
> users who really know what they're doing.
>
> So perhaps I can link to this again in future, what I'm talking about is:
>
> - Any instance of the architecture code, NOT at the behest of userland
>    (which we expect the sealing to break), but for its OWN purposes, for
>    whatever reason, moving the VDSO, VVAR or other special mapping around in
>    virtual memory.
>
> - So you'd really need to be doing something _weird_ for this to be the
>    case. It's unlikely but until each architecture is checked we are being
>    conservative - so as not to break the kernel (!) - and disabling
>    architectures until we know they're safe.
>
> - Sending a patch setting ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS is _very
>    explicitly_ stating that you have checked and are certain there are _no
>    problems_ with the architecture doing this.
>
> So this is why it's quite annoying to have people enable this with a commit
> message like 'enable mseal system mappings' rather than 'I have carefully
> checked the architecture code and the architecture does not manipulate the
> VDSO, VVAR or special mappings after establishing them, I have also tested
> the feature in practice'.
>
> I feel like anybody setting 'ARCH_SUPPORTS_xxx' should - you know - have
> determined that the architecture supports xxx. But maybe that's
> unreasonable...
>
>> and ya, we'll pick it up through the arch tree once one of us can be
>> convinced this works ;)
>>
> Thanks! :) Your skepticism is appropriate. But I do think this will be fine
> for risc v.
>
> I'd ideally like to hear from somebody who's checked this on a risc v
> system with CONFIG_MSEAL_SYSTEM_MAPPINGS enabled just to be doubly sure.


So I double checked and tested this so I'll merge it for 6.16 and:

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


>
> Thanks, Lorenzo
>
>>>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>>>> Cc: Jeff Xu <jeffxu@chromium.org>
>>>>> ---
>>>>>   arch/riscv/Kconfig       | 1 +
>>>>>   arch/riscv/kernel/vdso.c | 2 +-
>>>>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>>> Please consider updating document as part of your patch:
>>>> features/core/mseal_sys_mappings/arch-support.txt
>>>> Documentation/userspace-api/mseal.rst
>>>>
>>>> Sample change in [3]
>>>>
>>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>>> index bbec87b79309..3cb0b05eef62 100644
>>>>> --- a/arch/riscv/Kconfig
>>>>> +++ b/arch/riscv/Kconfig
>>>>> @@ -70,6 +70,7 @@ config RISCV
>>>>>          # LLD >= 14: https://github.com/llvm/llvm-project/issues/50505
>>>>>          select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000
>>>>>          select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >= 140000
>>>>> +       select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
>>>> The "if 64BIT && MMU" are not needed here.
>>>>
>>>> MMU is not checked by MSEAL_SYSTEM_MAPPINGS, which we should,  this
>>>> can go to security/Kconfig separately. If you'd like, please submit a
>>>> fix to mm tree directly.
>>>>
>>>> [1] https://lore.kernel.org/all/7EB087B72C4FBDD3+20250417132410.404043-1-wangyuli@uniontech.com/,
>>>> [2] https://lore.kernel.org/all/3de559d6-be19-44bc-ba8f-4c52d4bca684@lucifer.local/
>>>> [3] https://lore.kernel.org/all/648AB3031B5618C0+20250415153903.570662-1-wangyuli@uniontech.com/
>>>>
>>>> Thanks
>>>> -Jeff
>>>>
>>>>>          select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
>>>>>          select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
>>>>>          select ARCH_SUPPORTS_RT
>>>>> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
>>>>> index cc2895d1fbc2..3a8e038b10a2 100644
>>>>> --- a/arch/riscv/kernel/vdso.c
>>>>> +++ b/arch/riscv/kernel/vdso.c
>>>>> @@ -136,7 +136,7 @@ static int __setup_additional_pages(struct mm_struct *mm,
>>>>>
>>>>>          ret =
>>>>>             _install_special_mapping(mm, vdso_base, vdso_text_len,
>>>>> -               (VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
>>>>> +               (VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC | VM_SEALED_SYSMAP),
>>>>>                  vdso_info->cm);
>>>>>
>>>>>          if (IS_ERR(ret))
>>>>> --
>>>>> 2.47.2
>>>>>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
