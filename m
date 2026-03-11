Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55533DCD87
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229925; cv=none; b=H5H9FF6niaAIQHzeA7c6CE16IjxR7TueELsJQEDrPZF91+QXBKgmElWmgSSN2vaZSw3MuSUX3appQj5RQYQjEH0h4iLCtn21HieuswvPkaZhF2E/aGcZ1CnTjBYaQLTI7EcPAnbDlPWiF/b5ECKuQePH3vL2sb5YAG6fn2M+Z4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229925; c=relaxed/simple;
	bh=J26iwcTH0Z/huqTH2Fmcqab+8MgnO27SnkHJz4TSMMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnsL4qYPpYkMdRoFBLcEog178XUzIXWxaG5HbH3+YE25ILX/2A8b9TDCi1kkBGJ2ia9w6G/aReJZ1kzSArdV1nvu9Ky2VJ0Yn14MWIL6XaPzUtD0gd96hUfaPYwlesGdnJUQ5D0SQymVXa+r29WiB4Q5E0P48smXjYs630abfNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WezULfVA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WezULfVA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so32924095e9.2
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773229922; x=1773834722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6HzbTr74KcfnoTLlMcxfPo8bn4yDRViVRsJ4L7TL1o=;
        b=WezULfVANJe54A2pOD7IgJ0JRT8yPu6L1q3+tS3WRjBprfJ0JKv3cb8QZyrARSsEid
         wWb/Sf8KknDXZxb3mW5EkkkjvsqjDxQIBRXydGcG7d9pYkVlu5pFu6f/pR6AjINnyo+5
         FXnjgqd72s04+2Iaen5gy0imIHV+wGf3OahUa3gpQ5Y3JrW9XCdiG0YCbSU10TjYe9iB
         ety8aErd+iTNqYK/h3e2EBger9kg4OeU1HjlbP1D3LaArhFoJCQK/zrXQL2wecGTSQ+a
         78YF7Baa+09AYwS3r5/rnzhndM4TXg3nHESR88BJ43Ee6e7jOMMtCfW8DXboeFh95uII
         JQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773229922; x=1773834722;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6HzbTr74KcfnoTLlMcxfPo8bn4yDRViVRsJ4L7TL1o=;
        b=puSfHxSIIIqHbWlQNLFOnS/W7zqjQP4GAevhu/nWqwZ6uzJBmDkpuAZ+BqLHxbmpGq
         rLN6R/+MLVkTd5f3qDdeeBl4yrQ4NDIwXt1fbydGOJqjWurKgTFUKxwJaenUCHER7tFV
         6wuIbTgX2yVLM+dyn9zXjZBQcvofVo1peJMFZeHBsy44U+fH/AdxHgqzka/k4yU7RAyu
         cGz3YVn2UyKDT36JCqNjDRGaDUA2UYZCByR6GMbl30LPYkfqlsUfrtDQIfI7HKjrhmda
         JP//1vo3pINsn5OD8xx1pcimUcOgaS+o2wiQoI64jZrWEPzlBXbqwPVPqEKnR7oWS1h0
         qgsg==
X-Forwarded-Encrypted: i=1; AJvYcCX/hbrHcqf9yBPeiDlolOduBp/+tqjfQSA87CFCbL7QoSRg8FtXOYGn5vykK5oJkHfct7G04S1JO8Be1v5zh0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ31bdC3jsAJptQJAYI5HvaYi7riuCu35xjJq5l0UwONxQgbZ/
	F0onE22LYoRzezKpbMhQ1ODw6F5BWRWTT+CAln7xlQHPFvaK607duPpM
X-Gm-Gg: ATEYQzxd8TOeduYrK3+NgG3828LypstHbB8euBB6oPKStZrJhV2eBiiV0p2c+alNbvf
	on3nz3ddwrDu5nRq/8XRK4IcI9K2ZL9kqwfAVX5A5exu47Yhoo8Ubjnn4cyvGhsVZeQURonDBuN
	R09Ch416GKNIrfvXzIx5Ba+0X646zw8SlBbZyBzyVjtE/Mn+YQ5QiklIyAcD1dzIeNVsekOc0IB
	t0VZcDZe4xDMPM3rlqsGUKv7MCpGSec3WWabjlUu/Q6vXy7/wmzFD59nQYgFQsyMbVQL1+jIvjg
	hquWU74H1uXv68uXrAjZ7AcT51FQZhcIe/NLlATc8YZKXSoge34gOn2ca5FNK/YzNbINXOFLmsR
	2LYh7ybyvO0157CuR54smMxTSU9ddNDqVu0Oa/xGU1m0kgHabO3RqLM/cW/3LZRmuW1xtOPtfXB
	+sQOsACWVO7dLO/ophAwVBEcYWy320O3N+0puQHmrF/TNtDqhyRj7fOaA56Bs=
X-Received: by 2002:a05:600c:4f89:b0:485:2fd9:3d4a with SMTP id 5b1f17b1804b1-4854b102656mr37907285e9.22.1773229921984;
        Wed, 11 Mar 2026 04:52:01 -0700 (PDT)
Received: from [10.247.12.125] ([129.234.0.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm123205825e9.2.2026.03.11.04.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 04:52:01 -0700 (PDT)
Message-ID: <be86c64d-db3f-447b-92e8-085333c28d11@gmail.com>
Date: Wed, 11 Mar 2026 11:52:00 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy() in
 amdgpu_virt_write_vf2pf_data
To: Kees Cook <kees@kernel.org>, airlied@gmail.com, christian.koenig@amd.com,
 alexander.deucher@amd.com, simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-hardening@vger.kernel.org
References: <20260109162514.308143-1-yiconghui@gmail.com>
 <202601091117.122A9268@keescook>
From: Yicong Hui <yiconghui@gmail.com>
Content-Language: en-US
In-Reply-To: <202601091117.122A9268@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/26 7:18 PM, Kees Cook wrote:
> On Fri, Jan 09, 2026 at 04:25:14PM +0000, Yicong Hui wrote:
>> strcpy() is deprecated as it does not do any bounds checking (as
>> specified in Documentation/process/deprecated.rst).
>>
>> There is a risk of buffer overflow in the case that the value for
>> THIS_MODULE->version exceeds the 64 characters. This is unlikely, but
>> replacing the deprecated function will pre-emptively remove this risk
>> entirely.
>>
>> Replace both instances of strcpy() with the safer strscpy() function.
> 
> This looks correct to me -- dest and src are both fixed-size, so strscpy
> happily checks everything at compile time. :)
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> 
> -Kees
> 

Hello!

Is there any further feedback or progress on this patch?

Thank you!
Yicong
