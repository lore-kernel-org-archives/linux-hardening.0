Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD512E92D2;
	Tue,  4 Nov 2025 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762288520; cv=none; b=ixpAPPCtYpZRCuGV1SeGcyevo1ueNSelu2Vuge9HACA47ZumHQFzpuWu+bRRYSzgvTJlIUYSFuCdGBF2sIMcqrlmrYmo92sDdSlxJ76iTDbN25jSsdnGCOjXFs4Tp8IBgCvD4SD6VhDgrbAKbraANlxWp0ZLyGJaW1tYjdOpoYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762288520; c=relaxed/simple;
	bh=HgVhdxtFSyX9CccL6AbdASo63mTi6Wjb99T6AHS9VIM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RO7h6WFzbhI+bIsbZVDRhqSOE7sCBbFhE9bVY1vKm5xDZ6vG7xgxkU9H42JZ0X2hLv7F2S6AALbAB8gdEEx1XSgtN0FMu9OYg2/WaDGREMEm2eovpvoftj1R/d9XfPVJ7jDkyQqD+ZYZB0KuMsv5IpaG37Hi43j9//FIOb1wPBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCesmbE3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCesmbE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092F3C4CEF7;
	Tue,  4 Nov 2025 20:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762288519;
	bh=HgVhdxtFSyX9CccL6AbdASo63mTi6Wjb99T6AHS9VIM=;
	h=Date:Reply-To:Subject:From:To:Cc:References:In-Reply-To:From;
	b=XCesmbE3crso4mSuje/BO1HGzPSNaMQClYjRG0UAdOWZfYuv1IgfbsTaUPDDfW/NG
	 2VsAmHzlfx1tFtv6uwxBgAxwtOSmNuoGhVWkquz4E7oMg7co2Zm8gApKE3EGPnpTyX
	 IYTbR5ma+w5KiGVsMNtDW8jRewjqERrCEB5PFaoI/5YQVI8h2Pt0VZPyXHjlP7psvA
	 8L78NsFHnzmMWl3faKwaOOm8HaFaUvyMphP+obEeY6YsMDuVZfKANLaO60Xqanz7uI
	 I359OKIoc/Y8rlPBqK8AjwN/qy2XpI73CG0jPywkAVz+3le8/4cvCJa3vptE866fUA
	 b8h1Cg4xDmi5A==
Message-ID: <1eecc666-ac73-425b-9d11-676fce70592a@kernel.org>
Date: Tue, 4 Nov 2025 21:35:14 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v2 0/3] module: Add compile-time check for embedded NUL
 characters
From: Daniel Gomez <da.gomez@kernel.org>
To: Hans Verkuil <hverkuil+cisco@kernel.org>, Kees Cook <kees@kernel.org>,
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
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <032ef71c-fcbd-42a9-98ea-b2568d663978@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/11/2025 13.03, Daniel Gomez wrote:
> 
> 
> On 04/11/2025 11.35, Hans Verkuil wrote:
>> On 04/11/2025 07:35, Daniel Gomez wrote:
>>>
>>>
>>> On 04/11/2025 01.13, Kees Cook wrote:
>>>> On Mon, Nov 03, 2025 at 08:49:43PM +0100, Daniel Gomez wrote:
>>>>>
>>>>> On Thu, 09 Oct 2025 20:06:06 -0700, Kees Cook wrote:
>>>>>>  v2:
>>>>>>  - use static_assert instead of _Static_assert
>>>>>>  - add Hans's Reviewed-by's
>>>>>>  v1: https://lore.kernel.org/lkml/20251008033844.work.801-kees@kernel.org/
>>>>>>
>>>>>> Hi!
>>>>>>
>>>>>> [...]
>>>>>
>>>>> Applied patch 3, thanks!
>>>>>
>>>>> [3/3] module: Add compile-time check for embedded NUL characters
>>>>>       commit: 913359754ea821c4d6f6a77e0449b29984099663
>>>>
>>>> I'm nervous about this going in alone -- it breaks allmodconfig builds
>>>> without the media fixes. My intention was to have the media fixes land
>>>> first...
>>>>
>>>> Should I send the media fixes to linus right away?
>>>>
>>>> -Kees
>>>>
>>>
>>> I can take both patches. But I think it'd make sense to drop patch 3 first and
>>> then, apply all 3.
>>>
>>> Please, Kees, Hans and Mauro, let me know if this is okay with you.
>>
>> I'm fine. If you take it, then I'll drop the media patches from our tree (I merged the
>> media patches yesterday).
>>
>> Let me know if you take them.
> 
> Thanks, Hans. I merged patch 3 yesterday as well, but since patch order matters
> in this case, it makes sense to take all of them through the modules tree.
> 
> Sorry for the trouble, and thanks Kees, for pointing this out.

Kees,

FYI, I have dropped patch 3 from modules. My intention is to merge all 3 patches
tomorrow.

I believe Hans has also dropped the patches from the media tree as I do not see
them here: https://git.linuxtv.org/media.git/log/

> 
>>
>> Regards,
>>
>> 	Hans
