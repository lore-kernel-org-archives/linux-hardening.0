Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E409F9EC;
	Tue,  4 Nov 2025 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289979; cv=none; b=nsAphm8FJuKx7fFRh1FtvLC4jnyEUIUgFGQLMyn/dFosCzmhUSewi3i7Xb+1S89MnEP33y+g7ZG1Zg0h79Nr8TgYnYYhOjZ8gB0ngRke6T6BGCVpvHDOvAm9EwzQ57RvBrKsoxSlhr0JipApTWnC/+pNDia6lE2xNUkhBUMQ2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289979; c=relaxed/simple;
	bh=8PLo1vEl1baJbraulj2KcCy3IhdKLmTO4iwq+CU+rNE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pA+P8nCGCtUipdZScosrEGTVwHHp717NIGPQRg6YgXK64YSPYpDvzt3eKBqhObY64JURp43W5LKC1F7IAOl4nidI/YZ6mlD5PNvmLqojsIKJczV7+rh7f1pIbRHMYpbG8aTkh4F1J/vYNW/tKV4Ln2XXoTKLYPS2BmmepJHllOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGejYg6b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGejYg6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8ECC4CEF7;
	Tue,  4 Nov 2025 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762289978;
	bh=8PLo1vEl1baJbraulj2KcCy3IhdKLmTO4iwq+CU+rNE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=HGejYg6bhLXBpB8Dz3OditLI1PxMulJQYoihBd/rs4DuK3OESoS5d9OG4kJlW9T7w
	 JSopJHh6rQG6N1+B4wDZHCUE/an9NlrjkpzwzO4wEekKkCf4dh78WBceVCc3ewUcBn
	 P5RBk3PFgx2TiMyLVmTXAq8pJuR/nZCmsiTMpS329M0u8CYEU1fzNRTbnujlSzpnxb
	 fy3REIS2mhKva+oCi738pS3H14rZseukNmfMe2waBNJMby0xYWPITSoyzffKrog9LB
	 bTsBe1ttdciyhrX6K87/5tqvZlXTkmP818yAe3cUpTZRx9bpIPqMgf/6CEBTOh4LG+
	 18S2bsBUR+4Pg==
Message-ID: <3fc84948-37c2-4191-922e-c2e8c47fa313@kernel.org>
Date: Tue, 4 Nov 2025 21:59:33 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v2 0/3] module: Add compile-time check for embedded NUL
 characters
To: Daniel Gomez <da.gomez@kernel.org>, Kees Cook <kees@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Malcolm Priestley <tvboxspy@gmail.com>, Hans Verkuil <hverkuil@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251010030348.it.784-kees@kernel.org>
 <176219902728.2668573.8447418880394997824.b4-ty@kernel.org>
 <202511031612.8A05E2FD1C@keescook>
 <ab56339a-8736-4d68-bf11-d27c8d591597@kernel.org>
 <5dba319f-56bc-40bf-9137-acb90f3cc754@kernel.org>
 <032ef71c-fcbd-42a9-98ea-b2568d663978@kernel.org>
 <1eecc666-ac73-425b-9d11-676fce70592a@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <1eecc666-ac73-425b-9d11-676fce70592a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2025 21:35, Daniel Gomez wrote:
> 
> 
> On 04/11/2025 13.03, Daniel Gomez wrote:
>>
>>
>> On 04/11/2025 11.35, Hans Verkuil wrote:
>>> On 04/11/2025 07:35, Daniel Gomez wrote:
>>>>
>>>>
>>>> On 04/11/2025 01.13, Kees Cook wrote:
>>>>> On Mon, Nov 03, 2025 at 08:49:43PM +0100, Daniel Gomez wrote:
>>>>>>
>>>>>> On Thu, 09 Oct 2025 20:06:06 -0700, Kees Cook wrote:
>>>>>>>  v2:
>>>>>>>  - use static_assert instead of _Static_assert
>>>>>>>  - add Hans's Reviewed-by's
>>>>>>>  v1: https://lore.kernel.org/lkml/20251008033844.work.801-kees@kernel.org/
>>>>>>>
>>>>>>> Hi!
>>>>>>>
>>>>>>> [...]
>>>>>>
>>>>>> Applied patch 3, thanks!
>>>>>>
>>>>>> [3/3] module: Add compile-time check for embedded NUL characters
>>>>>>       commit: 913359754ea821c4d6f6a77e0449b29984099663
>>>>>
>>>>> I'm nervous about this going in alone -- it breaks allmodconfig builds
>>>>> without the media fixes. My intention was to have the media fixes land
>>>>> first...
>>>>>
>>>>> Should I send the media fixes to linus right away?
>>>>>
>>>>> -Kees
>>>>>
>>>>
>>>> I can take both patches. But I think it'd make sense to drop patch 3 first and
>>>> then, apply all 3.
>>>>
>>>> Please, Kees, Hans and Mauro, let me know if this is okay with you.
>>>
>>> I'm fine. If you take it, then I'll drop the media patches from our tree (I merged the
>>> media patches yesterday).
>>>
>>> Let me know if you take them.
>>
>> Thanks, Hans. I merged patch 3 yesterday as well, but since patch order matters
>> in this case, it makes sense to take all of them through the modules tree.
>>
>> Sorry for the trouble, and thanks Kees, for pointing this out.
> 
> Kees,
> 
> FYI, I have dropped patch 3 from modules. My intention is to merge all 3 patches
> tomorrow.
> 
> I believe Hans has also dropped the patches from the media tree as I do not see
> them here: https://git.linuxtv.org/media.git/log/

Correct, I dropped them. They are all yours :-)

Regards,

	Hans
