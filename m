Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F52BE7D6
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989840; cv=none; b=XiJ7cnmM+Pb3GllSkafSRdIu710JtXAQckGyMzhY4ylBx9DudExf6WvH5AyGf8hzFqPiCh5JQUNwlGiqaoYvkV/ZDVNXWJTbV++cg0lAHzR4lH3pt91z6FkeJGeWsInoGz6jmZEhvioHryyoPkVfe4Frr75SsvRQuC04yb0Bo3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989840; c=relaxed/simple;
	bh=vvctWtww76RC4KaccTUFTjbl0s7G+U7lzZq5hKQr4DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpACtHhEdn9E9xTTdIoUA+/5Amrk4eLIMOpE2Fb9e/qB2SfJRyeYU2UdWChzZjkuxYrnrRyU7XBr3xFYafJgtrrstp0ADMCCG5/w9v6GCkkpyzrmOk7m0PCb7bQEud3UoQke2V9UivOqv1dqoIHkO9AkHdX78zage/Z5rElKy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLCR5Ut/; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLCR5Ut/"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3e0f19a38d0so3279486fac.0
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 12:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989838; x=1768594638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PafEWsH57/+Cy2yApOc2umEszIJOjiei0uvdsW8xF04=;
        b=iLCR5Ut/XntTV00pjlGBsH4bQq2ajFvGOvDpzrM7GMoV1FcBBNzOd5n+e7dxCwPy3w
         gKYZgK36+wWBm5tugTB1pzJeVFkBw83hRcdww5eL1wFUlaNgErcpzZiD4H/LAcbZdjIk
         uaISIbUGBe7YJh4UjtuSwrgLMRcLEzzV9HJ+P5WubYCw0kj+CBwbCawekHThZQWqXFer
         4pT3+UWsym4bfraDGxOZSBlHwRUDdWTryx2RtuUhZjX6r2kB1qyIgmRmdCI5wAPDuNfM
         gmpcmdksYcUXbEFyuTWLFyP8H+SBqFZxHxDvbjRUyDctdYyPWfIXo0YZaPQpbxTBHsAt
         3XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989838; x=1768594638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PafEWsH57/+Cy2yApOc2umEszIJOjiei0uvdsW8xF04=;
        b=H1zXuDG/CotloKG6PnkQ5abASbHHsR64W8CVvMB0SQ7HKevD/qr9q37ZZ6N4SwMhHs
         My0sgdrhpLEEmboXw0d4wBYXl2WVQQ/Trsu+il+TaG6YhB4fxLxKKBpiMsNE/GGDcFTN
         icpevIQWU0n7Uxe9kjFSs/D9VUa6wC59UDaoB2ngL61wlVyT0h/gN2vCFMtZPizJeZ8B
         YlKCYj7Piez48NbNAcSZ+WBF/+ydtAXQ9YJIoAXyThwpp4Rp1T9+70LHhpmc9lYmf40N
         4KQZ6MQpsMMCl35KbDFJDrRF0pg/5ibpy8kc3Ke2vgkbrih36XCpdQY7pOp9UAQgFfj7
         hkPw==
X-Forwarded-Encrypted: i=1; AJvYcCVvUupLKu9PRn9qmogJQHVR4cyQpz3ae1QSABVt2h5hOe9EwqtGgD4/7D17emszLbwPlW4xuFdi9yBnviFZvXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOgRKcZGe2AAjZBFEad9bxZj8SitJi6PIXn/2evofAL1JEcm1c
	Z2/4OKY5maKCo4WLG4iEGuG6WK0B8ess/BJbZ3DSXvsd31Zr2lzDzKWL3httYJ2BRCc=
X-Gm-Gg: AY/fxX5FCvwTrp7K2URlxknTxFOiroDWzarQed5/ymA7V3YqDZJDDpsfFND1+XBv3FD
	EOuccRo4XsAtkJhvvpJyMsbv8XpdkgJwxOU2OgHNsQJKOW9ppesLYt5iS10dtqty6OS2i9CB+Ea
	Q+H8fCZ8LONrnK/WSl1USuRdjP17IcqbA3C+4mGHS3KD527KcpCCSUSenZ56EX9tMUdcznxjHbR
	q9vd4TozYx66vc8TIWVguVgbePrd36Ha8NHc7uJDjuomDjW228W7Z8MhiX6LKkSEsT+tD4cO7XS
	LGVWQNSIk3mlBjABb60PLxdtQhsSGAhWFGfV5NVqZuCvYeBOPPrE3iYpCbo6GP5l943Cx9dpXo2
	mlk2pahYmUih/35D8omcmZJn4fltKKst67b8gcgurl0bRgsx3/sNqHgI72ya5O+Q0bWCE1PAry0
	GRB46FWNUJNEU2X1wACqtQJ5tqMyi+pQ==
X-Google-Smtp-Source: AGHT+IGBzO2q7nJzg4TgWUct2DLRUcFwljyf3IpWHRWEpWo3SxWs9J6P9wb+IDG4Syrn5uV1vstmcg==
X-Received: by 2002:a05:7022:3d12:b0:11b:c86b:386a with SMTP id a92af1059eb24-121f8af824fmr10437605c88.5.1767984187579;
        Fri, 09 Jan 2026 10:43:07 -0800 (PST)
Received: from [172.31.0.33] ([136.38.201.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f249894fsm13563501c88.15.2026.01.09.10.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 10:43:07 -0800 (PST)
Message-ID: <e25bee08-908c-402e-bd5d-9723073f0a37@gmail.com>
Date: Fri, 9 Jan 2026 11:43:05 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/7] Introduce Kernel Control Flow Integrity ABI
 [PR107048]
To: Kees Cook <kees@kernel.org>,
 Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Uros Bizjak <ubizjak@gmail.com>,
 Joseph Myers <josmyers@redhat.com>, Richard Biener <rguenther@suse.de>,
 Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
 Martin Uecker <uecker@tugraz.at>, Peter Zijlstra <peterz@infradead.org>,
 Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
 Richard Earnshaw <richard.earnshaw@arm.com>,
 Richard Sandiford <richard.sandiford@arm.com>,
 Marcus Shawcroft <marcus.shawcroft@arm.com>,
 Kyrylo Tkachov <kyrylo.tkachov@arm.com>, Kito Cheng <kito.cheng@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Waterman <andrew@sifive.com>,
 Jim Wilson <jim.wilson.gcc@gmail.com>, Dan Li <ashimida.1990@gmail.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Ramon de C Valle <rcvalle@google.com>, Joao Moreira
 <joao@overdrivepizza.com>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>,
 "Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
 "Constable, Scott D" <scott.d.constable@intel.com>, gcc-patches@gcc.gnu.org,
 linux-hardening@vger.kernel.org
References: <20251210022025.harder.803-kees@kernel.org>
 <CALvbMcACT19UHPJme0w1rStX5XEJwNWdAMTuJ=cERkY38+EMQg@mail.gmail.com>
 <269C524E-2FDB-4156-98FE-548993666B03@kernel.org>
 <CALvbMcCi8SZs415AE8WYFiijh6K0HYixqz68Nbios=BvuB_jsg@mail.gmail.com>
 <202601091022.F01CFC86F@keescook>
Content-Language: en-US
From: Jeffrey Law <jeffreyalaw@gmail.com>
In-Reply-To: <202601091022.F01CFC86F@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/9/2026 11:22 AM, Kees Cook wrote:
> On Thu, Jan 08, 2026 at 09:48:58PM -0800, Andrew Pinski wrote:
>> On Thu, Jan 1, 2026 at 7:42 PM Kees Cook <kees@kernel.org> wrote:
>>>
>>>
>>> On January 1, 2026 2:42:59 PM PST, Andrew Pinski <andrew.pinski@oss.qualcomm.com> wrote:
>>>> On Tue, Dec 9, 2025 at 6:22 PM Kees Cook <kees@kernel.org> wrote:
>>>>> Hi,
>>>>>
>>>>> This series implements[1][2] the Linux Kernel Control Flow Integrity
>>>>> ABI, which provides a function prototype based forward edge control flow
>>>>> integrity protection by instrumenting every indirect call to check for
>>>>> a hash value before the target function address. If the hash at the call
>>>>> site and the hash at the target do not match, execution will trap.
>>>>>
>>>>> I'm hoping we can land front- and middle-end and do architectures as
>>>>> they also pass review. What do folks think? I'd really like to get this
>>>>> in a position where more people can test with GCC snapshots, etc.
>>>> So looking back into the other implementation that was submitted a few
>>>> years back (https://patchwork.sourceware.org/project/gcc/patch/20230325081117.93245-3-ashimida.1990@gmail.com/),
>>>> a regnote (REG_CALL_CFI_TYPEID) was used instead of the wrapping with
>>>> kfci rtl.
>>>> I get the feeling a regnote would be better as there is less for the
>>>> backend to deal with including new patterns.
>>>> What do others think?
>>> I started there and it created way too many problems that I had to continuously hack around. Switching to RTL solved all of it. (See v1 and v2 of this series where that was how it was implemented.)
>> Ok, thanks for confirming that. I will try to give v10 a full review
>> by the end of next week. But since GCC is starting stage 4 on Monday
>> and I think it is too late to add this feature so this might be the
>> first thing to be pushed once GCC 17 stage 1 starts (mid to late March
>> depending on how fast regressions are fixed).
> Thanks! Yeah, I'm not expecting to land this in GCC 16. We're very late
> in the cycle. :)
Good, I'd already mentally pushed it to gcc-17, but hadn't explicitly 
mentioned it outside the RISC-V patchwork call..  While I would have 
loved to have user and kernel CFI lit up for gcc-16, as you note, it's 
very late in the gcc-16 cycle.  Good to see we're in alignment on the 
schedule.

Jeff
