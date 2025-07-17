Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C642F6FAD
	for <linux-hardening@vger.kernel.org>; Thu, 17 Jul 2025 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770941; cv=none; b=beQN7miI7ZTCLjT97RKpumSA7VzN573hm4aycn1JKQovHnjmtZSNFAsrn8t5xdG1qIL9VNNUxCpuuFnZebo0EIz3RoFvZY86WKVDf3bILpyHZccMVODYf4WkIkxDtqr62VbQU+C//0WMKMSai+58dzIFaMp99UzTwgAMqA6iswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770941; c=relaxed/simple;
	bh=ATfb/Vyv7N7+qY0CZhZfMQ/VkrzG4iMeplRhL+HK3KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aM6zZm8TBz9RPGZMMxI1oRSgx6DmuYI7jJBJvA3TZwI0uHfk5sZk+X8u4l4i3cPcgbTadEcpLdBKXwfWxrblSSgyLGiHHlbiCSosH7+fbu+wKtPpuPI5jPX+D3Mug1QA0X6IuROY1IWB7f4GQTZHKQmNZt62u81gDsPmP44c1uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGNALOzq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGNALOzq"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2357c61cda7so1655ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 17 Jul 2025 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752770939; x=1753375739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATfb/Vyv7N7+qY0CZhZfMQ/VkrzG4iMeplRhL+HK3KU=;
        b=HGNALOzq1gm/5++mNEQ469Zr9O0+XTu0KXCYhkTp9HeIXXXu7fC9PA3IKBaYT0ubEy
         Uze0/qXvumhYgnXz3mjDDjvTGXiZl5AZA991UCL8uhFpvHFU10lW/2KPmRU2kmy9mO2E
         G8ojKmREUuXCztik/x5IANFJULbGEldnB8mKzpv/GrljQB++bEBngFT45GYogOdMXir4
         rqMn7BLX7B93+nXYB6GdudU227w+s+TobzHiN986B7sKwcdCqr/zdM0UK+iZwf+gvd1t
         IY4y50s+Z0x2Rzl5ECY/QvLmNRljShB7LSuqasX/YKVX5XboQul1RkTP7HWINrVMLcl7
         iwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770939; x=1753375739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATfb/Vyv7N7+qY0CZhZfMQ/VkrzG4iMeplRhL+HK3KU=;
        b=n0JDtwKALK9BrQ6sXBFw/w23V1hiUMh4QPKUOxdxYPE+A+K3oaSkO6cWyUUsXfKHJx
         qEzwCrHGjKHTiih8MYCvKkC+V4qDCJwugHcabwLXnhp8nEguy8RhCaI6R7XmgGxvvGMq
         yassUW+st8K7/tz78PxERP9XTRW3ujR0XIhz5QKi4BvATtDn7Mx5JU1X72vm+dy4qa4K
         /yGo9qUiXG+tEFa13VXJQ2nBCvNq8QNugeeUVHKj9+tU9tfRi02UAD+2jRWEX4dgH16p
         UhIy1ruCyGrpxqvF9+UwFfkghaVgO2c88P9h49nUX4PBj3oqoXO4lP4y8CU1eGHeE96P
         yxmA==
X-Forwarded-Encrypted: i=1; AJvYcCV2VTLkgCare9/RzCZ5cuNJUBAAZVEwZDWiphGacxC2ptmSvqNloc6eyP2KyJujxYmmE5KfSPZtmT+Gwo67xWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze0XDMO0DWcCblJXBHmUNXTwH64KtiGCKVZgIeLi6AF4toQnAN
	NesxdkYzT7cfuqVqLIu2a3g3LQbbd4X++XBFkmHWU6Rt9XvbGAbRpVBa80zLeFhLbo4u/4WGcOZ
	hitbMCX5lGnUIfKKm+GjkpQx/fYo2b83ZLz6xKgHP
X-Gm-Gg: ASbGncsy8qD43GnOHzCtU+YHySgxuA/kjlBkeTuxlA/lI2gV8r9TVl7bSIx5CmluMW+
	cTxQmFdma0XqbbI+WMKb69ADXr9QCwNp6Qq19V2ODGf2IBiaH4UzFSD/EQTnB6q+H4zZlpRocsr
	e5Wwb63psRDCvEd6xBw04zDicBgwhbT7/k8g9WICNhcLySv2aLOFD+bYgd2Dj0qONys8xX+PVBW
	s4b
X-Google-Smtp-Source: AGHT+IE+PDwwXnWhFQm24s8cPhGCQ5EY64CdyLsDsuABTQ+2CmXVfJv7P3ynyPa5W8nuCz7rsH1o5Cw3ZUsHX0Zgg+0=
X-Received: by 2002:a17:903:2342:b0:23c:5f63:b67 with SMTP id
 d9443c01a7336-23e39268bacmr302515ad.4.1752770938454; Thu, 17 Jul 2025
 09:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717085300.work.146-kees@kernel.org> <CANiq72kPmb+7Ygk_Qvsiq+22EJVSPjjwn4whdLuTGCPwvTAssQ@mail.gmail.com>
 <CANiq72nqg79xB=iV4GCH8XCak2jCn+XxUX4Hm1s6n5L=5cLuvw@mail.gmail.com>
In-Reply-To: <CANiq72nqg79xB=iV4GCH8XCak2jCn+XxUX4Hm1s6n5L=5cLuvw@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 17 Jul 2025 09:48:21 -0700
X-Gm-Features: Ac12FXzbJOlwBZd244gzQ7hjYG8HHbdgWFdeM8CQEG3LxeALfQRXXRCHDtw62hI
Message-ID: <CABCJKufPphD3en91N89yekUam4Nv7+C7YPJMv7h2SmZcyhGhdA@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: Add __kcfi_salt
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 3:08=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jul 17, 2025 at 11:51=E2=80=AFAM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > It would be nice to have a quick sentence inline summarizing how it
> > will be used, e.g. what kind of functions will need to be annotated.
>
> By the way, related to the use case question: would we eventually want
> such an attribute for Rust too? If so, happy to help.

I would definitely like to see Rust support for this too. Otherwise,
we would have to drop the attribute when Rust is enabled to avoid CFI
type mismatches with C code.

Sami
