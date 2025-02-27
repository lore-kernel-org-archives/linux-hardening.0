Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F827781A;
	Thu, 27 Feb 2025 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695835; cv=none; b=k6+Jl/Bc1jxsc7icnOdovNydeP4N8oFX8p4G7jqakGDRXToNg2hJwmUWbohBE0A4/ItOSvjHxGrkw0gLG9v9yRCxq/GE7BzwMfv8/MLif+H1Pp1BrltIxl4JIunD3c2Hv1i653wq9bHwtWv4oDXGyFBnKNe02ED0VIfplKGN85w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695835; c=relaxed/simple;
	bh=pW7Pdt0rmwm7FNDVulLdJ93cpcQjOWJ9CVjmL1Tf2JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7KSRbM//Bymoil9EpioIIMWPlWUcPscL3YJmMQbu6ClAaveOY98wDswvPkm0LdG0MP9F4PbkP/aq2i7+8pAIuVRFMacGfPoWCtVvh09FRzhJLG53homLltldQB0JY2C8WDgcJduKHglZ7HDu705tfnIjgD4AfKIoKrrJcWap1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WG71HB6B; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG71HB6B"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2feb867849fso1064283a91.3;
        Thu, 27 Feb 2025 14:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740695833; x=1741300633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6Iy1LUUvHq8vj9gzevAPpKpsLnWKuYQr3vI8QLdyD9I=;
        b=WG71HB6BB9vCUeG4ygq6KLrgGwj0E4eam/dsFIAj0fbZpO4J0Vof4+N0i9JZ/4lrYv
         2wbfc1R8FS8Ext8nHDS5rKmtzvUtfU17LHY/6KBnd4+YBvBk7z9kOb9UiGZ+GxHoHGlp
         F8eWq/2UFk+k6pE209USzZOME8J4/nHSwa9lbqXNwQS0PF8NVZF6x7H3jYyJeex5095j
         1sCNgzgu9BrQTfvqwxirl/2B1uwGM7Diuz7xS/EhI0n6BVrzx+Nt8a2+mpCk+b7S4yT2
         fWSmMqmzS+KKn8kFtlI/LqJ3sXQ+Kgn0+LMNHIiaYQpUdAn42vmS9fchVUbu+yJ9qmyT
         fk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695833; x=1741300633;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Iy1LUUvHq8vj9gzevAPpKpsLnWKuYQr3vI8QLdyD9I=;
        b=uLms28oKohmeU9SLimAWBvWvTpBY2OE3JDQvraiSaJhn5QA2U5vx6ZyCGAzRY8aDD2
         0sGmP1YfGGfY67N98LzFYREpyipieDEMVCqjD7gf4AUn0JBukMdRqKL+JDB4lLz8l9Lp
         it6hga0pLhojLlx31Ethwba4vLfreX7ldIh4tVE6jSLru2XiSZUekVcEZUnulFm+JHUf
         BpZw3ejiJMc5ZKljkCO9OEAGrEFqE6RpJesr1eXZo1IUwuOCYLSGgLlgHRBhR7u5/O5d
         8pFHItP541e18g5ukr3Y7kMRKRwSl+4MVqmCnzw0EBudiN5JDFmp3nm4+NOFF4RoMWYG
         VbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7HI27aIkM0DrYvBdpeVoGvPkf2IeSYhox6aiwh6Y15nfWS/WN124rqMQ7O8qwfZXNHlFJsLsjZ3jBDA==@vger.kernel.org, AJvYcCVBw43oSYHxV7Jp5Fz7jJtl5hT7ml/qOdKkCzuUEDlsNJhV/GLbtBGst7kRpcb+02TrYcLG4+yDpWe7+LER@vger.kernel.org
X-Gm-Message-State: AOJu0YwGKSwIHJhsEBsMEWCKoVQZedw5oa+HUS72qXG3kmKov2djv2vV
	EFUB+xsD0eIigkjjjFQTUilptTUORmPpUAuDwQqBpC7dSvgsSDEBByryzA==
X-Gm-Gg: ASbGncsPe0NQbwcwDUwjZeqC+R54PV9GPssH4J9wPSA3JXZEM8R6ftPgCVfNwr1B4CX
	rAMHtw4GqV6eXivlgU0VTZZy5sVevgoZRT8qHRppcTE8xsDq09rXx9Lbb5TXYjmNK748NOonFbQ
	GWc86Dw0P/CyvKDWN0+PqVTU3NS8bu1EvgkfPQNhWHM7HSnhxv5gflWZSlnDiBabE4hBDLiFAhy
	W5cVIouR+vWBbhdAOD7Y7RnQmuxYs+wd3htyQI9p9yXdFvv8tQO1HutdufIrt4CAI/itOyv4LvE
	cHv+CykErRk+L846+mWVgb1E+C889t9j73FW6YsuANv7/XcIzNanFZ3KoV1zh8nmstt0ItM9/lw
	=
X-Google-Smtp-Source: AGHT+IHpxdxU//hiBiQ6H+EjSOzz4Wt5znAzqxlS8QMzZsREd5STqSQslq2h0QFh1xkXe0KhS8iPyQ==
X-Received: by 2002:a17:90b:2f87:b0:2f2:3efd:96da with SMTP id 98e67ed59e1d1-2febabf1aeamr1673940a91.24.1740695832975;
        Thu, 27 Feb 2025 14:37:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350533186sm20647075ad.243.2025.02.27.14.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 14:37:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <25793e9f-211e-4e4e-86ac-88e3b902fb68@roeck-us.net>
Date: Thu, 27 Feb 2025 14:37:10 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (pmbus/core) Replace deprecated strncpy() with
 strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>, Jean Delvare
 <jdelvare@suse.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Patryk Biel <pbiel7@gmail.com>, Ninad Palsule <ninad@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: linux-hardening@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250227173936.7746-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250227173936.7746-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/25 09:39, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers; use
> strscpy() instead.
> 
> Compile-tested only.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 787683e83db6..cdde8b03a6e9 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1470,8 +1470,7 @@ static int pmbus_add_label(struct pmbus_data *data,
>   	snprintf(label->name, sizeof(label->name), "%s%d_label", name, seq);
>   	if (!index) {
>   		if (phase == 0xff)
> -			strncpy(label->label, lstring,
> -				sizeof(label->label) - 1);
> +			strscpy(label->label, lstring);

What guarantees that strlen(lstring) < sizeof(label->label) ?

Guenter

>   		else
>   			snprintf(label->label, sizeof(label->label), "%s.%d",
>   				 lstring, phase);

