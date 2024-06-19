Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE131A29;
	Wed, 19 Jun 2024 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813527; cv=none; b=mf7qygc9S1lRWq8X9ZZtmtmijN0VCCkYBUA6qIJkqIS/zgLyn9iOkIAwuHYZ2o96+UUp/94j6ab/P37JQ2aJHznArwyu386RLF5YYz/QhmTHoIYN477ZJC3QNAYRxcYMzP7hXSdFWmiesgeRl0KbkTGjQNX5GZj2IrXOuUg9b5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813527; c=relaxed/simple;
	bh=WvxkYqGLa/yBd53bZMfPZ2U1lIrtO/ZWbnXsdP4ZNy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RD9498V9ZbiGo5mF2A8Pl1wnRm6VvV0TQ1qPWORmAZpe1QPg5cqXg+R9m+njU3fcE2yKajmGgXq0BbXYtD0W7R41vsLjJooxPt9IKCaHnbk1bQbcBK8SJypfQLc9ugsJNw+YJnncCUouj2FAr1Ls26irTVloxNplreq095/azi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dd91JLfq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dd91JLfq"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6ef8bf500dso769539066b.0;
        Wed, 19 Jun 2024 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718813524; x=1719418324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eGorT4rH9fVB+lgR1JoKoDxU9RpCSgqSCB5TfWxaDpc=;
        b=Dd91JLfqTOgHAqa9OIUBuRkE3bjEe0vIfBRn45wxXaYqpJFBKKrz7ES/8ac7/s6OD+
         bY/n7OhbUdQT3mcK6y/HNyZ1FdcRwsFk9Vux4mdfZAt2GqSeQbAdiSJXhpSSrErb9Nxp
         hvlF27spfu+TvsxWgo8hFeHqK+YcmOTaGCjE39OEViGQSv34RvoOopau7sOAIyukHD7U
         bOnQvAwxb1lLzO6my+PxTzqefYoSqg+d+I+Yp+jErMtNmXy5aqazcPSk4vTI0a+DhEK8
         x5Ghn6i6Oi34xhEuqHwlltFFjZ6Xzh/izsLQ1sTXzY8zw1d9PSw4n7oOnveLgbhvHsjX
         faNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718813524; x=1719418324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGorT4rH9fVB+lgR1JoKoDxU9RpCSgqSCB5TfWxaDpc=;
        b=XgsDxcNX3uOlWyqAsYeobkW8RUJ1Up8ST7IkYQ3tPxVRyQ9r/MW82DJarNhDHek8Q3
         v9WHQv3eLkUGXLGZolcFlRiblhOOYPFsq/muVOP88XlyrvZxPyP5Elxu/COyME1EEWE9
         91bkS5mNlQoODyIYqXHg6p//KaiGhRayqTCIwCWTVm/vv2yPFQIreNxbgE8NGvj7qp44
         INTN5b4VQRvnH64Qv0AmkqDNrUsNeZ3wFeZPnjuCjjDdBn0Tf1chDEaA28wLimLjo51/
         PxvQHpSuHgtNu6IXx0/Eddo9EcTmTdQXqb30YWSAjIxVDX1XKDr3doOUt0F4tBRI0RM7
         jvag==
X-Forwarded-Encrypted: i=1; AJvYcCXIomGQzVwqeGAB37gKl1XPfuQfwdUHfO/ruoeexMo02A2Y8BTa0fSY9TWE8nUqYEmXPSIZaLwrQlcIbcqPEwNdqqj4U7kxP2mm82Xj0DZEdb6Kz6sqZFa0k24MX4ebVRHk4nbbhDucM3Y7EwGxushjzxzlApKsSYBNO758WgJbQkfu+tM94JEI
X-Gm-Message-State: AOJu0YzK12WA7WF29GgcEmSpELWzbz6tAtqHvGXfJc8oCI90sf5rRY2C
	wyaBLZQmte0+V4P5PtiWPfUQSDRfWpEbiLglMPrnf3VE1Cr56S+k
X-Google-Smtp-Source: AGHT+IETTsmKISRF6ckXFNkhnsxj3NqZsZJqQvxJi608L+mYCRbLb7SKQNKkDttWyIXFvpoJx8Hezw==
X-Received: by 2002:a17:907:cc06:b0:a68:bae4:d66f with SMTP id a640c23a62f3a-a6fab615d55mr157162366b.30.1718813523802;
        Wed, 19 Jun 2024 09:12:03 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f5f1c8d6fsm615589166b.0.2024.06.19.09.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 09:12:03 -0700 (PDT)
Message-ID: <4c74c145-4fc1-44b9-88e7-1075c541adba@gmail.com>
Date: Wed, 19 Jun 2024 18:12:01 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: garmin_gps: annotate struct garmin_packet
 with __counted_by
To: Nathan Chancellor <nathan@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20240619-garmin_gps_counted_by-v1-1-d8d816f085d9@gmail.com>
 <20240619144320.GA2091442@thelio-3990X>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240619144320.GA2091442@thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/06/2024 16:43, Nathan Chancellor wrote:
> On Wed, Jun 19, 2024 at 11:40:57AM +0200, Javier Carrasco wrote:
>> Use the __counted_by compiler attribute for the data[] flexible array member
>> to improve the results of array bound sanitizers.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>> The size is assigned before the first reference to the flexible array
>> (see pkt_add()), which allows for a straightforward annotation without
>> further modifications.
> 
> Agreed, this seems like a reasonable patch in and of itself that should
> work:
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> It might also make sense to change the pkt allocation to use
> struct_size() instead of open coding it?

Sure, it looks much better. I will send a v2 with the patch and the
corresponding Suggested-by:

Thanks and best regards,
Javier Carrasco
