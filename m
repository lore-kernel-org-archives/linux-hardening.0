Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B85217660
	for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789074; cv=none; b=baTuFohlDwxovqQOPcp5xBb66QOXfZIKKkclAuJsMES6EIqTXUIFXJE7HUH+dNuiV58GAJQD8lHcRzVEUgNhVgo3FhoRF8KvFqHfuXQnoBYK26YQ787nFBbmF6upPXZushfvBpWfJaviCaaBoXrgIC6GvHEnXOKScaGyOdcQDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789074; c=relaxed/simple;
	bh=lAVINVnHlWjTWaGVpFZbbokZJSBj5vEpW5VZeY4f3Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QW2CfAiGQGMOhxXp2UM8SnJiF+kMXV2OHDZeM0vgSzzTsGL2dY8HjY3gwhPWmRA3f0LVLhji81w0h2qwBXfoAgxeA4Bn5cBRQUIY3MIttpFCkcSSLJDb2BnJ0MXL2kiWTjBrn8hnqwqzvNdNHgoXAN9EoI1cVjEQQk6vaVsUcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wJm40Mts; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJm40Mts"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb97e15bcbso158473666b.0
        for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 02:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739789071; x=1740393871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEbDsC7zOesvvA0J5tAlZE6+h1PCWgc42liU2tI3McI=;
        b=wJm40Mtsm01IIjp0pJOT9kUXukQqG0N/QpN4wHm0TM361GJW7JlaAgT3oyUTjIUmR9
         qImGSRYTQStQPs3aewejzhkhbqgzNANqZ01ON08QqiD173a7oSdoQJezq9r36rVNu+tn
         S7NFB8wriv6dZdZJHuoxC+4HVhJy7lO2y2DWRYggtzZ5pWGJ8a+WM7Il2EoApe+s3Q7c
         M+XjuBv4OrZjf0tn1i40Jn8MuRh0362PKZCrh0gAEDBCIsNziAVqk4cYPEIkZTQlTY7Q
         T2XLazv3HeyFXDpstHmRg2pRWvSu0WNwnYElogPcvV0U5EO07GxRo6fVmLra+OqQVBA3
         Rrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789071; x=1740393871;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEbDsC7zOesvvA0J5tAlZE6+h1PCWgc42liU2tI3McI=;
        b=JhEyDnFc4qanSeHHcF79jVBY6iEs9fAmEurvQyx4mUpMBye38kh9HXI7xrNOaLPmVd
         rh1V+gN2DQ0y9FOX/hEs7W1mNcJH943RnDf/Xnx75tjOYGjN0DL7Dr9VyfX6CHlbS4b3
         WORe0Pq3ZyaMJGei5cbmuGArhtWlnSXdV90TYmEgOQ3Ma44lRjbaoP9k+z8E+5LJmcIU
         WDV3EugcfeZqlCOKxl1fJ1kosGY9gkJfvdvJoM1aj+799Y3Vv1+X1mIccdt28lF1nMQE
         3z0vctNiS3Clxhhg2rcOxOSOl0GLGt08/h4d0pExO1QXChrV+K68IGQRjOOHvWv+C/23
         on+w==
X-Forwarded-Encrypted: i=1; AJvYcCV0HK7QQXTCjvyF3inhFoeRvxFMBtQ88e4ARBpy4YuPNRAwaL4lRV1lSIMRuCMKw2Z7gPa88pVPEsK1ZuI+x94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJdClLd3Qkc6RBJ2Q3Kn4fDN5h8hTtTFuGZxKH4Xr7rmicQz7V
	Bh3GQhqvixYNxuR9TwCkHNTJ8Xjcm5g8NGSP8Pg2HUrA4kCnpiHVX8WBKntUoeI=
X-Gm-Gg: ASbGncvuFbTnrKtiCxqPSnAjdbNvzAc1hh6VmH8yA+X20Rd/oyv8Y1SUYtloNlgYPYi
	kPw88UZ59MC/PmqZFaO6WdySCvMDBc7QNAL/uR525Iudjag/syQdJy1ASTU9ZcZokqCmV2dAqcc
	bCCNfSgWtu+PCBZgRDriUZDIyj1tob60UmgwJUIY6FyipdeuRoIHKXgZQz+ZuygdQWn1h8MaSfY
	+1Hta9JgPjPzLupkkPD7Wa+UsaWMK1LbaivxBR5yPK3pIdlfM6KCjj8Q9LMgE+xsV8epPT9wJ1w
	vWqo8M759QXXsA0/WjL/gbs=
X-Google-Smtp-Source: AGHT+IE+qR+XkSpEa4n8UFFb2YUXaqm+JYBZqs/0Cfmj9Y8tSfbfIbKyD0WPukltsMDTzYdEa4UX0g==
X-Received: by 2002:a17:906:7312:b0:ab7:ca44:feb8 with SMTP id a640c23a62f3a-abb711304d9mr1001080366b.52.1739789071395;
        Mon, 17 Feb 2025 02:44:31 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb88c69c1bsm330535466b.110.2025.02.17.02.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 02:44:31 -0800 (PST)
Message-ID: <b304d582-9328-4e1b-9e34-5604125b0c06@linaro.org>
Date: Mon, 17 Feb 2025 12:44:29 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 00/10] pstore: directly mapped regions
To: Johannes Berg <johannes@sipsolutions.net>, linux-arm-msm@vger.kernel.org,
 linux-hardening@vger.kernel.org, kees@kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com,
 pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
 senozhatsky@chromium.org, quic_mojha@quicinc.com,
 linux-arm-kernel@lists.infradead.org, kernel@quicinc.com
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
 <c4b48faeae8531e670ea5909800d1a0bfed69862.camel@sipsolutions.net>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <c4b48faeae8531e670ea5909800d1a0bfed69862.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 12:23, Johannes Berg wrote:
> On Mon, 2025-02-17 at 12:16 +0200, Eugen Hristev wrote:
> 
>> This series comes as an RFC proposed solution to enhance pstore and
>> devcoredump with the following functionality:
> 
> ...
> 
>> This patch series attempts to solve this by reusing existing
>> infrastructure in pstore and devcoredump, and provide a copy-free
> 
> ...
> 
> You mention devcoredump multiple times, but it almost seems like you
> don't even know what devcoredump does? I don't see how there's any
> relation at all, and the code added to it seems to have no relation to
> the actual functionality of devcoredump either?

At this moment going through devcoredump is not something that impacts
the idea of the implementation.
The whole reason of going through it (because things work without it as
well), is to see whether this has any kind of impact or not, and if
there is any kind of fit/reason of going through it.
Devcoredump is involved because the whole core registration is similar
to a core area that devcoredump could use.
For example, would it be interesting to have a handler going through all
devices, and have the dump areas already registered ?
Meaning, when there is a request to generate a core dump, one could
directly dump this area instead of calling back the driver, and provide
that to the userspace instead of the driver calling the dev_coredumpv by
its own.

> 
> johannes

