Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2400346AC6
	for <linux-hardening@vger.kernel.org>; Wed, 18 Mar 2026 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773863426; cv=none; b=VVDC8Gq0s5DbOM2rileF9tLx1vm25lNXp/mXrnF/csxgQRTp9xj37qsCnmg4igM1wFAAmQVoogIrwDOj98phKNU5hNB7RqQY60IcskF3jAlfYNrCZlYSiXWrrpPe7ojnU1UgYuai14vJnypsPtMuOT5xgafCejluO53QtWtgakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773863426; c=relaxed/simple;
	bh=4E2+mgnoT/O7gf1R4+xQjIqP6j0a3Jp5OE1RFcWGio0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ooTxCL7MNd5ZfdmijSrj7M+pPagAzoSfSOXF7FkEvu+txI55ORWnjMMe8f7Yox08ErcRN1Uh0/Mke5k1iSrj4TagiaUzdXRDQDh8tHvoLZRc0MrqRZkaWFxlbkxW496ISqgdN4JSkBgsJMA3YVVZ5OIxQ6k7BEBAReu71jTpSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz+2XbqE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz+2XbqE"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so228475a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 18 Mar 2026 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773863425; x=1774468225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Resi8n+oQ1vXGyEjFOBn4ZBz6ktHZ1vnUrgtEXoKXe8=;
        b=Dz+2XbqESJyUtSPtOhEVpUmtjfikkbMatpzTDEcTGQCm0jFZjQspE5oFsi790c7YPe
         hvocUm01ymkyYUl1xjbaxPLAcsHGNjZL1KzEuUq9V2Q+I3eEVXmbtvSOEood8Hy4lEUH
         z1JZqCoakAwWLvCwJF5svLSU7TcyZ8XLIzVMnyxyBjefJ0otnBQKtvvzdQrcYDbbrmr5
         FjOGqXW+tkwDsHwRgRrLZO2Iaphrlh9rn3SdcKqh/iSJRaC96yWuaGiVnILH8ey6x/5v
         U67cySGOHXJerhYeemq9lBTgnW9rc3f0IbpVu5yJvGPTFpRxTs/HWrzZzoy0n1wmvkuH
         HjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773863425; x=1774468225;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Resi8n+oQ1vXGyEjFOBn4ZBz6ktHZ1vnUrgtEXoKXe8=;
        b=kmLS510ZlQbK7vzRJRupASxs2TG3tLbDhvvBzGUkXItfGp9Ul+fgFxdLNBdv9f/sxi
         24XvBXiDKW6sPjpLgO0N2sOUp1W4lz6p/qHFrDqwu/ehXYFVIXFZe6zchpA1m1RlAtlV
         csY8Kvud7SWq464hz3GOJfx2AE1dX624vNi8oz1B3JGvh4ZRgTc/h9cv7MMQHFm8nZQt
         FFcNVNaWkxGbVBMywIMga28FlFOwmWJFS0o6j4DI3iCZRTJt9o/Dajdm3AENFW5l1iHP
         5ZdTqeCWenzN3JfSIYHg84r3UEL09qFW3JZonMDbE1EmUVxuoWDyqZxLoS3/tG89M5ON
         Rp2w==
X-Forwarded-Encrypted: i=1; AJvYcCWS1CcJgwlySgBPTzJB0qmyITKl31Dt/3jECY9AWlVgp4KR+PstM2YJg6L/kvdlBMN+SkqFTT8u4HZ18bE16Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuktEtGsccw4MYroUsOC4kvi4M0RceFC2J2c9CoNDVj64q+opt
	gCm8TohQSZ1nkLbFl6un8Q1JF/9oH5iQILMwafb/XNJwulqtixtifY2f
X-Gm-Gg: ATEYQzy2DWglIts3/5c+0EXr5IxmiYimq3hBTY2xVkMd+u3fLCY8TCslk5etPz+KkUF
	lxQ+2XX1eLAUyb7S+wWZQ6wsSFf+qSRJKVBxBBygwVd9m/IXalry25OA6Ln/Vbs9Cyd1lowLTr3
	cW2xtMwBe2ZsNf8CJg7FRnUQlkQgztR+1rIh/U8LjbTbig8paNv7AkLz7RdiBfKACpliZoVlEtE
	H2TSFElVmJPIkqOrp1SmNSvgA4iCumB5jrRONwP0DcXW42Ag2YfOSl+ix3Ydbt+P/gqQqY5MqW5
	VIcUahnkkCkcWYaEEXzEycX6H+uQYAPbnyH5N3nzpNd7FRcQW1fGdxFvwn20kfgTuiPoVULhCWg
	ATYO4Ksy+jRkotHwWdYEZ+R75Tc1c9uTBNrJzfdkAA7IV40C7uGPOZklJNYfKdFfqCx94WwJMHw
	a//rvvZHuo6h6QUxoGm/vfVXvrXcyhMDkqu9IKlCZlNNu2/STgoElINPDf0ADtoac7wovr18joc
	qkNbM5LHGU=
X-Received: by 2002:a17:90a:d604:b0:359:ff8a:ee5a with SMTP id 98e67ed59e1d1-35bb9e51090mr4450775a91.12.1773863424940;
        Wed, 18 Mar 2026 12:50:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc618be0fsm409804a91.0.2026.03.18.12.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 12:50:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cce7a4aa-0786-4c55-afcd-4816f977806a@roeck-us.net>
Date: Wed, 18 Mar 2026 12:50:23 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] exec: Add KUnit test for bprm_stack_limits()
To: Kees Cook <kees@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
 Justin Stitt <justinstitt@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240520021337.work.198-kees@kernel.org>
 <20240520021615.741800-1-keescook@chromium.org>
 <a3e9b1c2-40c1-45df-9fa2-14ee6a7b3fe2@roeck-us.net>
 <202603181132.507C829A9@keescook>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <202603181132.507C829A9@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/26 11:33, Kees Cook wrote:
> On Mon, Mar 16, 2026 at 12:16:58PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Sun, May 19, 2024 at 07:16:11PM -0700, Kees Cook wrote:
>>> Since bprm_stack_limits() operates with very limited side-effects, add
>>> it as the first exec.c KUnit test. Add to Kconfig and adjust MAINTAINERS
>>> file to include it.
>>>
>>> Tested on 64-bit UML:
>>> $ tools/testing/kunit/kunit.py run exec
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>> Cc: Eric Biederman <ebiederm@xmission.com>
>>> Cc: Justin Stitt <justinstitt@google.com>
>>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>>> Cc: Christian Brauner <brauner@kernel.org>
>>> Cc: Jan Kara <jack@suse.cz>
>>> Cc: linux-fsdevel@vger.kernel.org
>>> Cc: linux-mm@kvack.org
>>> ---
>> ...
>>> +++ b/fs/exec.c
>> ...
>>> +	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
>>> +	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * (_STK_LIM / 4 *  + sizeof(void *)),
>>                                                                     ^^^^^^
>>
>> Google's experimental AI review agent tagged the above change as syntactically wrong.
>> How does this even compile ?
> 
> Wow. I have no idea how this ever built either. I will get it fixed.
> 
I ended up writing a test program.

#define TESTVAL 10
...
long int x = TESTVAL / 4 * + sizeof(void *);

does build, as does

long int x = TESTVAL / 4 * - sizeof(void *);

or even

long int x = TESTVAL / 4 * 3 - - sizeof(void *);

long int x = TESTVAL / 4 * - - sizeof(void *);

It doesn't even have problems with

long int x = TESTVAL / 4 * - - + - + - sizeof(void *);

Weird. Looks like the compiler takes the "+" or "-" as sign value,
not as operator, and once can have as many of those as one desires.

Guenter

