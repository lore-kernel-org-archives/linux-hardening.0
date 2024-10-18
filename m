Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A2D2036E9
	for <linux-hardening@vger.kernel.org>; Fri, 18 Oct 2024 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283339; cv=none; b=Lm8Q2aajn7HM+5zkiht1gTB/JUrEIuyZuKhOgbpi/SazVFxd9EnyVRYg0+So21/Rck/ZJ6BgTi3n4fRnP9TMfd4b68zQEBX26aqg6tZpiFh+WjDIjcwRIzA7NsJxsSwWNCy0U1OlgHQ3S1cSfZBK9ZlwoB3/7Afo09LxY1xMjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283339; c=relaxed/simple;
	bh=wqiuD1vh/FuZqOOmwY/4qml0aFB+KWxNRCvJRKHqsKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llkJuucmwyGF7t7BdTtAR97HaB6Lu+gRJxvq6Hdf8PCmzBOvMc6QeAs8Och454YEUpWCLk4IZeULpeTA2szVtsvx07w4MMncljcZPoggu16HM4crZWio3UkJVopKm7S8zDjl11x0ab1A2TcKNokKEvSONJNavvXyOzErE7AKHv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rh3TrejE; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rh3TrejE"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-83ab21c269eso92111839f.2
        for <linux-hardening@vger.kernel.org>; Fri, 18 Oct 2024 13:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729283336; x=1729888136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEIxT3pzjyKiKOABBKcn+MsmKD+aZXCEjCwEplxkrC4=;
        b=Rh3TrejEQ7yarZAfMleS9ihjBsfZhfAeqxeNPYZPGDa5L46T4heN7s7Kaptiu4Xx6r
         MpNfzPDm3AHeI0QAWnN4c3YT4757FRHQxa6aNTDgh6xDULK7FwbsP3+/AzLoQdgYsk8g
         i1xap+zjXVG9X5S81pVlnEEtI4FwY6P0jrgUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283336; x=1729888136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEIxT3pzjyKiKOABBKcn+MsmKD+aZXCEjCwEplxkrC4=;
        b=L6joPQcf4PFcClh0eC3yJr7tL0ci8IGPyDfezfae7pfP0mz/UcAgElAebuWd6cpZG+
         uo4TNz7wDcDRt+gg+4Tg3BnGYmjmZT4fPUWlm2dIBZqsY1gHzRTEXPwBOEPQyODQWUui
         xPdFwPA+dz4sp7crorUghb0oIQBtPJOh2T7d0xZAhPCgY5lOxCi66pf5iqA57Xd/0jRB
         heBsiITou7jqf4c8mmtFE7KRGEbL1BXmU1njvbJtc3HPFPRqJIvV9bjWKlunKkIF22sf
         /5Gy7+JgfWv/Q37X9Zpg0wF6pwZbCOq/8uwxtLm1PMAF3yaPcXvmEAw1UrvOqMOSgFCp
         +6yg==
X-Forwarded-Encrypted: i=1; AJvYcCXUmobHYOwB0s4LRC1L+ie2gJcyz+RKVXRcZohw6n4EP2tBCxpgiL2ilrWXHdN0bTbm6fagGK+dz/mt8lMUk/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPhHHzk7mUMCcu4OLtLoePBFfKyx4oFT/7xYgIarFa35TEVoO
	XWhPZRtV+JDJTGtt/ck8i3+/fFXKri2U+sLxOyltFG5rdZdyvIxjsI/drucD5Dk=
X-Google-Smtp-Source: AGHT+IEmNTlbTxL/CzSKbj6Z1Ayoclfp2LZg5Ml5s5uZ6FaqD2hmPUC5+ArYCuRJH83neks98+42+g==
X-Received: by 2002:a05:6602:3fcb:b0:83a:b3f8:e517 with SMTP id ca18e2360f4ac-83aba2f3b7bmr370716439f.0.1729283335889;
        Fri, 18 Oct 2024 13:28:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83ab9d80c17sm57750739f.6.2024.10.18.13.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 13:28:55 -0700 (PDT)
Message-ID: <6c9796ff-ccf8-404b-917f-57b48b42f6d6@linuxfoundation.org>
Date: Fri, 18 Oct 2024 14:28:54 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Jeff Xu <jeffxu@chromium.org>
Cc: Mark Brown <broonie@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>, akpm@linux-foundation.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 pedro.falcato@gmail.com, willy@infradead.org, vbabka@suse.cz,
 Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
 <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local>
 <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
 <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local>
 <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
 <1f8eff74-005b-4fa9-9446-47f4cdbf3e8d@sirena.org.uk>
 <CABi2SkV38U-ZCAq9W091zYkOM1m5e-C27YmVXdTCi-t+p_W_fQ@mail.gmail.com>
 <a2652ed4-ea8b-4b56-bac6-6479b3df6c14@sirena.org.uk>
 <CABi2SkVF3OtRcq9cCgLh_hOjxRnWq0owypw++xodrEfm=dt_qA@mail.gmail.com>
 <736fefd9-4bce-4aec-a492-2267fdc83776@lucifer.local>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <736fefd9-4bce-4aec-a492-2267fdc83776@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/18/24 13:52, Lorenzo Stoakes wrote:
> On Fri, Oct 18, 2024 at 12:32:37PM -0700, Jeff Xu wrote:
>>> when they encouter a failure, the pattern I sketched in my earlier
>>> message, or switch to kselftest_harness.h (like I say I don't know if
>>> the fork()ing is an issue for these tests).  If I had to have a macro
>>> it'd probably be something like mseal_assert().
>>>
>> I can go with mseal_assert, the original macro is used  by mseal_test
>> itself, and only intended as such.
>>
>> If changing name to mseal_assert() is acceptable, this seems to be a
>> minimum change and I'm happy with that.
> 
> No.
> 

Jeff,

Please pay attention to the feedback you have been receiving so far from
Mark and others about using the existing kselftest framework for reporting
results and don't reinvent wheel.

We have two frameworks to choose from - they both have been in use for
quiet sometime by tests. If there is a need to add new functions and
fix the existing ones that should happen in kselftest_harness.h or
kselftest.h. We keep fixing problem and enhancing them as needed.

With my kselfest and framework maintainer hat on, I don't want to see
yet another framework emerging which is buried in tests.

thanks,
-- Shuah
