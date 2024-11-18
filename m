Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDACC139D;
	Mon, 18 Nov 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731899431; cv=none; b=DzLBqlwv1+uko/MZuYklIzHxNOp02BT+1C7o6tPZ/BOHJO9X4CHp69WpNuDF4wXw0MZ14la1vxzE9wHjb0LHrt1Pw381lzXHzZGGIZNxQZqU7w93o3OBqDoQ0/g/nhETQTdfCKCiO/pEMXy7idkgv5DFIbUtY0JK69VJxZknd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731899431; c=relaxed/simple;
	bh=uoqabqJHtaS3WL8HVCwPVeD9PvKlSZIfUGocqAz4BYo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tW+Coa21BIrWn75/wsyp1iEVQ/N5wQG+Ki5H+9KcUu4aaeVnl1Q6/6pmm7WF2VfN9rkmHCiWOpWGoHkiQoWfoqtT9cOVKRd5GE52FSV1aIqYukzT/n3esBfvPjbi50v62JRfiK+Xim9HU6T6HeAdNFFnR7PqmbMSEFslS8nqYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYZSRppU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYZSRppU"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ea46465d69so34754a91.0;
        Sun, 17 Nov 2024 19:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731899429; x=1732504229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B7G620YEdRwkQ8csskloZqBOnEEpoMxFxGmYTocvfwk=;
        b=ZYZSRppU6QW+1SVokozRX4X3EO4Y0I0yFZqp2R6sUfgXdlEBsLB3lzhlD+hvMAnpzw
         UpDTi+w7YkWON1IIr+hiLRLbEZrOn6BHuwBccpJeBxizGUQnYD0jNwTCHGbXqKfkofze
         MFO1IddRA1EeBPadUpmkOjRNZTA6Etm1dvGIvz1U7UurmhlxCWUuFjdiz6feuZCtiZpO
         PhQmiDg0ypqw36x5tqirNPAv7f1jPf8wAbU7XAiXx/N7d+VtvMYCvzMolVGSm5HLX9Wn
         gwcP1W9J9TclFrz0JR7H/7dBcbly1dI8hhGHtf5Utd7bCSOYR76Xo+LyucrOXMXSXZ4L
         8h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731899429; x=1732504229;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7G620YEdRwkQ8csskloZqBOnEEpoMxFxGmYTocvfwk=;
        b=qVfiW6XESnCrwUsS9uH7NAiobu875tqk5SkNAnWH00i3z6WxZcVLNRYQQvLdMAKL13
         nlhjs7jBrdCyH2Xgp09UhzSHprUAN2v/aQrpvkHI8AxXmTJesLxOIpiwsZC3Hjy4QO7h
         276AENY6sOHzZQLF2eJHLjkp471FF74T3bhWWiPZpV60aGNiD6kZYT2YUMFozjp2jhgr
         WcxECOM6wJrefQf2ZeHN5PEF5QEnPFdOvYJFS/JmuKkRxVdmwYVEUObVMJzrFwUunMG+
         IkA4/QYSkzzbQbLzTrr64dakjqA9QX7HLXlehv02ZklCmePUi4YjaodeG17E/qAYiXF9
         +Lfw==
X-Forwarded-Encrypted: i=1; AJvYcCW2eYsxLU4fPVHw0Kar347mzND8Pk4xeQG43q78IcmlKZf/wNYK0G465a3rGEj7LJyFatV+a8YBhpO7hRIG@vger.kernel.org, AJvYcCWlZBmcbqsza5izQaoeZCSksWSW0zqXLg5jPOhJQIPvgOYe4fqXNDImS9h+BWbOtcY07grOjzbDRqN0BmLTgGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NO09xHH+8EOPVK3Qw5TkalPw2hjOFLzYDJMCKgL7LlIz/Jvz
	kUZEJH37vd3rBC9S1f3nbRKL6J1cWHv9jwykoyX5DGWOP6CDilWeEIOh+w==
X-Google-Smtp-Source: AGHT+IF+0VPFRuOgue6L/1CB9KUxscJTJXK2ORhni9pSMg3t6iKhfyd5Hjw4bIgl9bdAIsItfry5gg==
X-Received: by 2002:a17:90b:1645:b0:2e2:da69:e3fa with SMTP id 98e67ed59e1d1-2ea154be694mr5258044a91.2.1731899429029;
        Sun, 17 Nov 2024 19:10:29 -0800 (PST)
Received: from ?IPV6:2402:e280:214c:86:89a5:5659:771a:757d? ([2402:e280:214c:86:89a5:5659:771a:757d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea5832e629sm1707240a91.23.2024.11.17.19.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 19:10:28 -0800 (PST)
Message-ID: <ee215d32-477f-48d0-9a4c-c535fadcdfe5@gmail.com>
Date: Mon, 18 Nov 2024 08:40:25 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: R Sundar <prosunofficial@gmail.com>
Subject: Re: [PATCH linux-next] lib/string_choices: Add
 str_locked_unlocked()/str_unlocked_locked() helper
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20241115144616.7453-1-prosunofficial@gmail.com>
 <CAHp75Vfp++XMr8VGjjFRBpJi+uAk8PRVPxMLmQciedBzS8gedQ@mail.gmail.com>
 <CAHp75VdD1KYh9KJWHwhxkXy-+jfh_o=Rn05AtL4QBb0HC-oz6g@mail.gmail.com>
 <2a5500a5-c1b6-4c5c-bf37-4cfeda5a9e1e@gmail.com>
 <CAHp75Vd9tm_QOYHJ2RgK3_vF_aztEkuf68yO7a=QLHKpJAH=cA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHp75Vd9tm_QOYHJ2RgK3_vF_aztEkuf68yO7a=QLHKpJAH=cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/11/24 01:33, Andy Shevchenko wrote:
> On Sat, Nov 16, 2024 at 5:48 AM R Sundar <prosunofficial@gmail.com> wrote:
>> On 16/11/24 01:16, Andy Shevchenko wrote:
>>> On Fri, Nov 15, 2024 at 9:44 PM Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>> On Fri, Nov 15, 2024 at 4:47 PM R Sundar <prosunofficial@gmail.com> wrote:
> 
> ...
> 
>>>>> +static inline const char *str_locked_unlocked(bool v)
>>>>> +{
>>>>> +       return v ? "locked" : "unlocked";
>>>>> +}
>>>>> +#define str_unlocked_locked(v)         str_locked_unlocked(!(v))
>>>>
>>>> The rest is sorted (okay, read_write() seems to be misplaced, fix that
>>>> in a separate change if you wish), please keep it that way (I believe
>>>> it should go before on_off).
>>
>> Thanks for the Review and Comments provided.
>>
>> Please correct me, If I am wrong.
>>
>> The function name should be in sorted order means,  str_read_write()
>> will go after str_on_off().
>>
>> For example, the sorted order of function will be like:
>>
>> str_on_off()
> 
>> str_plural()
> 
> Leave this one to be last, it's special in comparison to the rest. See
> what the type of the parameter it has for the details.
> 
Hi,

Noted. Thanks for clarifying it.

With Regards,
Sundar

>> str_read_write()
>>
>>> Oh, I looked in v6.11 code, in v6.12 there are a couple of more
>>> misplacements. Can you fix them all, please?
>>>
>> Sure, Will sort it and send as seperate patch.
> 
> Thank you!
> 

