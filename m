Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31614F964
	for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069014; cv=none; b=nlxGr0QaI4l3ENK0nyLdHeFFl30lV+lz18rhY8bzpMOimNXnXEPijud/T4h4wBCheiiboMUbhQ0z9Nfg8k6LQM1uXxuOnCnAAr+SZOmp09L0MgUnpnrIAuRDzP0j9VYbEbVYeVFr3L35hZCHcMIWz2ywHNb+aiHaVjJlwVRwuNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069014; c=relaxed/simple;
	bh=x0k9KPWxpMjPpZo+FkyIevXhBqRIFk50MHuqVr7KDaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOQMOOXNK2G9kxxd8poeUn8Z/+EVM2XlV26ofmAsQKNuzvOaP+Lwn4Qp6Hpy6KPE7zxP24m2/xPboMUYC4oiPGITJEHygJ1IlKYWz5LUe8Yom+BzD5yqJ/ByYxWEQt9nOpYX9h1tH6c6LBvZVt2g+UKtpFOXASY6UU37R7fjpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZNOB4uOg; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZNOB4uOg"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso96217839f.1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 13:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709069011; x=1709673811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbGdkLlpvK16N0hfZoWh5Gw9/QwXnepLBQjOEcjQHHM=;
        b=ZNOB4uOgno+VpIO2W4PY1beOucE+SHUoDmzXisJWwdwQ+IUsoQ4sF4GepJZyx3g2tO
         C87f+kflSg4ivpCjlD/8eb09Qsh37gaJzgN67dTMBXrZ5TxJ766ybe9cpAOY5xWD252T
         Zs3+lWGB8C4nAuZaqg6GLmi4YYHOAZRu1Hv4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709069011; x=1709673811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbGdkLlpvK16N0hfZoWh5Gw9/QwXnepLBQjOEcjQHHM=;
        b=KQCvXwvKxY6kpKormRx4d5qE18V8UAiGsaicQRxIxKcIc2h/2t7p+idD6NhQKFx1Li
         3JIVaTXYTSFVF9dviTbqcITDkUarfp5qBu+AQTDtcIHIPeQITjJlnNQxFumwishFiVps
         dnrH9f3bLcNxq64NztIuZchtIlqp/DayWS13r7v2dYJQdOBjNym4B2Fi3GAKlCbCLKeK
         Oi0tp9Y8dksl58h+gsI6JlTAhR40BdCWFbC/eGiz0DzgqVChZSGeUeqw/bzMZKxk/mE5
         nJt33WEHRmuF8BnTyAX4P3rNeZTdrvi7GkFhzAk6yYRln0zf/Tno1dFn+3DF28a0h0s0
         XBIA==
X-Forwarded-Encrypted: i=1; AJvYcCVWtTY4rHpSlPM4FWSnkaCsczPjye+sUwg0hiX+cQ+kiM4/BgkEKnaSHOeZCjsyiTw2aXrVomONp/YUQGPkaeXlWisO+D63gvZvV1ArbekT
X-Gm-Message-State: AOJu0YwgGizTCwOH6ZlZlbpUkuoGkCL73SFN9UWcr93RHB628WKz9kl8
	N/xs1HxZuoy+5EjDGL2k5slgAcoggOQZwvbXYYnjeZcX3q1e6IeRhqHWal698YY=
X-Google-Smtp-Source: AGHT+IFc3RgJRdGVkP2NPs5Y/GfM+e2c3LeD0bxO2noPvCmHIWJaDhFOLsvOZQ0IljP20IzU/UY25Q==
X-Received: by 2002:a05:6e02:214d:b0:365:3fb7:f77 with SMTP id d13-20020a056e02214d00b003653fb70f77mr11217673ilv.3.1709069010744;
        Tue, 27 Feb 2024 13:23:30 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bf19-20020a056e02309300b0036524b8c632sm2413353ilb.0.2024.02.27.13.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 13:23:30 -0800 (PST)
Message-ID: <56680d34-59f1-460c-a835-f1258abf4569@linuxfoundation.org>
Date: Tue, 27 Feb 2024 14:23:29 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] rtc: test: Fix invalid format specifier.
Content-Language: en-US
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Kees Cook <keescook@chromium.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>,
 Cassio Neri <cassio.neri@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Arthur Grillo <arthur.grillo@usp.br>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 Daniel Latypov <dlatypov@google.com>, Stephen Boyd <sboyd@kernel.org>,
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-6-davidgow@google.com>
 <20240227203243070e7d85@mail.local>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240227203243070e7d85@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 13:32, Alexandre Belloni wrote:
> Hello,
> 
> On 21/02/2024 17:27:18+0800, David Gow wrote:
>> 'days' is a s64 (from div_s64), and so should use a %lld specifier.
>>
>> This was found by extending KUnit's assertion macros to use gcc's
>> __printf attribute.
>>
>> Fixes: 1d1bb12a8b18 ("rtc: Improve performance of rtc_time64_to_tm(). Add tests.")
>> Signed-off-by: David Gow <davidgow@google.com>
> 
> Who do you expect to take this patch?
> 

I am going to be applying this series to linux-kselftest kunit next
in just a bit. Would you like to ack the pacth?

thanks,
-- Shuah

