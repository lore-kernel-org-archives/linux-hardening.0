Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA78624;
	Sat, 16 Nov 2024 03:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731728907; cv=none; b=KIc+dFjtkL3MZJoZ+OEY0aMOMGDqwruRAiN6b6JnJfTD3yxX29oJWsaeL7a6Jfxrmp/DHX7Nls0dhf8lyPLJ70NGvjHjYWZ2eMr3NpdFcVctcYQQgFoYl5h71/itDA9XGMQ9GYPW6pZ1yi5Drig2acdJ6yL/PuA+24FRW2plh6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731728907; c=relaxed/simple;
	bh=ieeUuIerkjDDSrkzSFQbSC37Rio0pr9cSn/Dv1ez9hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oF+cHE0UvtTycDmOt4Jp/6nuwDGlWEKvNTL+twmJyOfHJOmWnhkgRnfU7DTpTTC7765UMDTE5KCjTT/lGyH2LYYT+J6MvcjBF0/xKkK5XaMAO6fYQJlPpuYO1kN5HFAu9PfTg6SpQtOPkL4AZPQ4JlnuHY4Gqnlc76OOLEJcTf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Go+EiRM9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go+EiRM9"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-211f4e2873fso299695ad.1;
        Fri, 15 Nov 2024 19:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731728905; x=1732333705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1X6feTn5BLY+cIw7COfGlCu+hHK0fLj/DvXKOsWr43Q=;
        b=Go+EiRM9efCnVu/xF0FCBOwDAkMtvbqvEmIPBY/imJOAGzewDBwNJKyYhYne5mWAEm
         /+Xda8goaZhOIUi8t9Fom8vDOpYglYvFtZXK7LJTshN+Z1DFdOfJ4sxzQ45VI1B3iMYT
         GDw77smFnicvUOaDSpQQVTFIo2MgnQEPpcLO5yjo8IMF57DDHGFQebGPmgOlatsuKDVZ
         oka+2TMTsX9NKi1OvcZVMmetQ8Z/DawhYCHkEYK/4Nrrn9a/7KBF90lxIxWdo+Foy7ij
         TOghtkOU2N94xi/Qabb4vuCglezQrEJ6OJIPlywPj8Tx+bXJvlIPiuFAMlgO2EgDJNFT
         1T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731728905; x=1732333705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1X6feTn5BLY+cIw7COfGlCu+hHK0fLj/DvXKOsWr43Q=;
        b=qDnmvG1gn0895aHXKslHPHNsqVenpv19qzpra8apS8XZsXiZjqMyTiYihkp5jlTGRX
         TeHnErd9FCj26qzBgx9r/d9kQgfoKCaxhRBdd7fVOlWm6zkqN0qEE8lWwZKRcIxyohzG
         3Lr8xZb4jMt7JlcwObhg9k6+rjhm7Z/T4cJvPor/FxJWFfqyussorQc70BGLb9uf7HsL
         coxQq4G6rMqDpA2R9WbKluVXogTxBvuqAJzVIWxz+xvT4FqfyQZ5KdLhBtJxGFryDWog
         cBeSYoqULlYV1VXEGWcb3e9x69IlBI0vzio87peZ++TBO5GidnNynEEJLmfLzrYxVEMC
         KKZA==
X-Forwarded-Encrypted: i=1; AJvYcCUhmNxP3QkC6htuVv8cS53EyXtXw3lQ4OcqLAQ7WyrBUIy9oKZtJFnT2k2+YFA/Ekjl3SSQmSW+kIFVxwDEP7c=@vger.kernel.org, AJvYcCXwbQaubKJaajwW1+iMHoDPW3JxrK1Q9yFkY4ggiRLQwWTczr/eFnAug5Me/IobpFfxbQNI5i9O3+oOFRHI@vger.kernel.org
X-Gm-Message-State: AOJu0YwuXemUVOFwdJ/FC89pxRUCG1hC1+AwQst+1Cut4mmyhxMUpkYn
	3NQt4VoP9vwsVRFxWrtcLOAGd3A50jZaKF1Xed1S7f9h9iPv/umd
X-Google-Smtp-Source: AGHT+IH9d/94RHkrpzjOvRPbYXCVTRLcWSFbJw+A7dVUDAf2K54LQ2/ZxefrWJKXczHI1MvZ7RvZJw==
X-Received: by 2002:a17:902:cf07:b0:20c:e2ff:4a4c with SMTP id d9443c01a7336-211d0d63769mr28579775ad.3.1731728905286;
        Fri, 15 Nov 2024 19:48:25 -0800 (PST)
Received: from ?IPV6:2402:e280:214c:86:7694:d274:39d8:8ffa? ([2402:e280:214c:86:7694:d274:39d8:8ffa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f55cf8sm19813745ad.260.2024.11.15.19.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 19:48:24 -0800 (PST)
Message-ID: <2a5500a5-c1b6-4c5c-bf37-4cfeda5a9e1e@gmail.com>
Date: Sat, 16 Nov 2024 09:18:21 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] lib/string_choices: Add
 str_locked_unlocked()/str_unlocked_locked() helper
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20241115144616.7453-1-prosunofficial@gmail.com>
 <CAHp75Vfp++XMr8VGjjFRBpJi+uAk8PRVPxMLmQciedBzS8gedQ@mail.gmail.com>
 <CAHp75VdD1KYh9KJWHwhxkXy-+jfh_o=Rn05AtL4QBb0HC-oz6g@mail.gmail.com>
Content-Language: en-US
From: R Sundar <prosunofficial@gmail.com>
In-Reply-To: <CAHp75VdD1KYh9KJWHwhxkXy-+jfh_o=Rn05AtL4QBb0HC-oz6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/11/24 01:16, Andy Shevchenko wrote:
> On Fri, Nov 15, 2024 at 9:44 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Fri, Nov 15, 2024 at 4:47 PM R Sundar <prosunofficial@gmail.com> wrote:
> 
> ...
> 
>>> --- a/include/linux/string_choices.h
>>> +++ b/include/linux/string_choices.h
>>> @@ -82,4 +82,10 @@ static inline const char *str_plural(size_t num)
>>>          return num == 1 ? "" : "s";
>>>   }
>>>
>>> +static inline const char *str_locked_unlocked(bool v)
>>> +{
>>> +       return v ? "locked" : "unlocked";
>>> +}
>>> +#define str_unlocked_locked(v)         str_locked_unlocked(!(v))
>>
>> The rest is sorted (okay, read_write() seems to be misplaced, fix that
>> in a separate change if you wish), please keep it that way (I believe
>> it should go before on_off).
> 
Hi,

Thanks for the Review and Comments provided.

Please correct me, If I am wrong.

The function name should be in sorted order means,  str_read_write() 
will go after str_on_off().

For example, the sorted order of function will be like:

str_on_off()
str_plural()
str_read_write()

> Oh, I looked in v6.11 code, in v6.12 there are a couple of more
> misplacements. Can you fix them all, please?
> 
Sure, Will sort it and send as seperate patch.

Thanks,
Sundar




