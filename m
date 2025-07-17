Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF302289808;
	Thu, 17 Jul 2025 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752746882; cv=none; b=TcPnMMfnMYeyb1+rBE//5rX2YUGxhxACfkW/WwfLaNkp8X3mWax/8wbcY8A5REpCfkuU0EiYTZLYJZUO/2nIj5a4yRUOA4ZhlXv1DNbmKpGzY2j59IT5QQPv+drMkpSM4f6nIF5vdi9catg6E8O85ZyAy+UAMCUWYx5eEjiEBs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752746882; c=relaxed/simple;
	bh=FkQy/Y3q6tMqhobUejvgOD3UsPfO0JsXG2mMvZoSgj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7lsvvwhojdHZoBRS5mwTpBnX8/OlfhRMq4w01qGaOxUhB1MphnTcl7e+m5ibBjiefe46PXK0SZW01jApkqK+4Y3G+NyDuesS6XKthdJ4KeCXgOtf/24kUTex/xgzsxTJQzzH9Wvo2JAq6pRaNqr6gJJDUROJipXh7ihJQXXCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQHxz/cz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQHxz/cz"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-312efc384fcso147169a91.3;
        Thu, 17 Jul 2025 03:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752746880; x=1753351680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkQy/Y3q6tMqhobUejvgOD3UsPfO0JsXG2mMvZoSgj8=;
        b=WQHxz/czFU4uwoHXtVPwJjHrwsXiw9SQeVDmVEntSTPgp28g6qhJRTwxf9R5ej1h3+
         w+crIpgND5ZSOZ8dVX9bkMNRUqOicfzfJfryFJAjn+nlkFv5aT+t0vJw9BXqsBnS3Xds
         wEk6z20qOIIXorvqceJH0IM+1poM8WvFeg/PyK4zA9f+zgsUx2AuQq6PTSW5fFNDcx5g
         mdSFREIfYLYkgr9XusQF0vA7IDcbUAhlVIdAdGpqHgEIUed6yr7UDM7nO0G7KChLMtZu
         QwNf2apXq1EPO19bfk8v1pd+zv0UZgxXH9oGCHte5d8IuZcA7Dc5AG8uCOzdoT+m6DGc
         SoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752746880; x=1753351680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkQy/Y3q6tMqhobUejvgOD3UsPfO0JsXG2mMvZoSgj8=;
        b=re1CW3kgvLj/5s7CEKIcz/wtsoGpyHgjGmSLN7BbHSgg2Fvw3WhTYREVdPlcEQJpGM
         Wpw99NBWRPOsXqmn+55zJb/m5TJSb6MKgW6tqQ4bTqCA1H/S7JUWs0WXjwfgYjM6HL6w
         aMcyW18zZ4v6UzoJCAJvpuwOV+NH4nTTu2/JYWmbP/pDY5N68OekG9Bv1MjMVBu6hMLO
         qIcCOKP8xNKGo0qMwtuAkgYWBYCEqAA0DNf21EyJOSaaNZhKgcO6QdHRlbfDdHOurH4L
         EP2/uafa8CIoAF+WRoTmjoNQgdjN3ATbtn+XF1UGQath7A877viZmPHlzKtnv+h4r0xX
         o8Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWGCrhG1FBOSvFSMOpdMEe8zJAXyqMQdH81XkWiPzLMLnW2Fxrw9mZdndh18JRkLSejAU0SYVCZ/xlqfyBk@vger.kernel.org, AJvYcCXEEuZ1s8jpOZtI980mq8HB6FG4wFgwU1HOcGZqOyTN4vwsx3v3+b7P2+uhhQx00ZoxSwv8cgJaskU+yHmMjno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ILh7wFJ2OGuXKqM8wU6YCYbnPxnQI65efZw+oyRUx0j7DGYT
	ylmb9hh65psFPEiAbu2PAZy8dVLI7b2pv/eXUcuA6LPBJF4sKmrzvozVhbIVVHGSXbAg2NKiVnV
	HJ8petXUtnd2w/RZoABK1Fac1VCeVolM=
X-Gm-Gg: ASbGncsK8Zeu9rrxmyVm3QfSoeBlpC0h0bdxrX6L8kEgHINYYP3SNSg12HHMvA5WenY
	HyMGqrshB9ecVibzRsz8zTzkKVzFEDDzqJSPUID9PSdx+P/AABpLVSZju3pei9Efp0DWmxYAFuh
	Bw3ocwyIZeuIEbRf29ar0F7RqdaADJ7tlH4iRJEAuBDfADYHDiNAsKY3zhq7sha2sD3to/rqy0S
	oZsXhSv
X-Google-Smtp-Source: AGHT+IHx7O5PAXTasiy9yyPUprUELmj79np3hybUvsshq6jLwxK4T3fmJzDg7uiXUMAUYMEcAk0CpU7R+CJUVfZd4m0=
X-Received: by 2002:a17:90b:4f8f:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-31c9e5fd68dmr3290528a91.0.1752746880122; Thu, 17 Jul 2025
 03:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717085300.work.146-kees@kernel.org> <CANiq72kPmb+7Ygk_Qvsiq+22EJVSPjjwn4whdLuTGCPwvTAssQ@mail.gmail.com>
In-Reply-To: <CANiq72kPmb+7Ygk_Qvsiq+22EJVSPjjwn4whdLuTGCPwvTAssQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Jul 2025 12:07:47 +0200
X-Gm-Features: Ac12FXwT-j99yzQ1QeDKF2d9w3_kpLJ5UpDscxnEoLwurYXccSzH2vvm19x_7h4
Message-ID: <CANiq72nqg79xB=iV4GCH8XCak2jCn+XxUX4Hm1s6n5L=5cLuvw@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: Add __kcfi_salt
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 11:51=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> It would be nice to have a quick sentence inline summarizing how it
> will be used, e.g. what kind of functions will need to be annotated.

By the way, related to the use case question: would we eventually want
such an attribute for Rust too? If so, happy to help.

Cheers,
Miguel
