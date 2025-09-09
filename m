Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D28239E7D;
	Tue,  9 Sep 2025 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405114; cv=none; b=SDl6fWxdHIlapQ2qk3oD/2QPjXPdFcbpL5sOTJAGfwdelj49ZUEoGVV8m6hraKJYgPf7JwSGCDRCy2xG0fZQKelRnTsZDBcELk+I6Hbtn43tnb4UfT+t/r/io+KhEY1BSK/CEFi9pQFYf8vU74Wgi6VNjFmoKiQhFafPoijohZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405114; c=relaxed/simple;
	bh=pBZU3wKG151HKhMwytmvCOqvfVDL2EvNagCVejdReJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHujlSlIaD1TzTd5ugCZbznOKzELwr7X9TCZy3l35aEholr40IBi8iFysNpFiH+XghiQWxV+GD18Iat8YFJ09in8cjY3pSVFucza1DFkql24h4ruzRzHjil+baSIr3Yo5d1/wGjzQhUskjXtBICW5pApQKGgGzsl0XfiqpwLl0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMNNBNf7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMNNBNf7"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62bec18abe6so872710a12.3;
        Tue, 09 Sep 2025 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757405111; x=1758009911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pBZU3wKG151HKhMwytmvCOqvfVDL2EvNagCVejdReJI=;
        b=FMNNBNf751spKcXV7Rf21Yfyn5r37WP4qrooXmNtQIdw/ZDLik/vD8Wbb0ox6E0OAK
         Ah8jxLlttCI9qS3gFF1zJbrcBaWJw/aVm/b09ezsJ+JB5ldtgl6njP1OANUUbjSh01Cc
         LnZtXRhMD2u70kyF2gtGCtRzJYtGrObYe7CMMUBznkdFBZ1zuU4xqSlPmQFdCTT+Jr8o
         bPJy00d1ZiYO0jENMXaV7mkTbV3pbGnAEEnq/tLN+zTGz5C+bWJ/0KSZKgDxAPHuAkOV
         wCFMOFtFGfQ5aSVfAR3x8rCJiL9/Xk1oRxf39+P/RuR6sD97xQwsbKojJreen9J5Sf5R
         +G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405111; x=1758009911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBZU3wKG151HKhMwytmvCOqvfVDL2EvNagCVejdReJI=;
        b=JoNPlPfELeER/AIINltykQAzqN7ayPEgtfeV5/IluR4DgJiL+50rKEa7W0d7ru51qA
         u04ACTzMXWyNhvXV7SaSm3ACIq1RvXdB3e/tvxPzzBqSVF+JcriBxD64E2+2BqQjECL8
         v9bypc65eTUnCQFtVlS3dO9DGNaSQWIhYGleQnD3CpgeR+yWFn3FmaGCt9UrWtQQFEDd
         cBMnoEskS6lSHrfQGOejI7QkG/NUvW3jw7aVNSzNT5VYAOHcGDkcOR7H5XhwhO0Hnyro
         m3xG/hu/oytIdJ0/Zwuq75X59DJpx+wVJC6vRChxh3V1Mi0wKzFQzBdp564Fvp/3eNY9
         Ux5w==
X-Forwarded-Encrypted: i=1; AJvYcCWIvTif8WcCCsXHqgfwFGbFKn4ZScBiKLQ3gdWzKSuIjOxWvtS8USBYPAFotjNWt9LVK/VOy7gaPy1YZNkg@vger.kernel.org, AJvYcCXZ2xz+G1AS5HYUmHrK+rYuHLMTXb7Lxtty9L4ZSLEvgTW+Fcii2aW2U5iZYXwRMV5qNg/xUrxoQt+yCLiA5KhY@vger.kernel.org, AJvYcCXcFDA65q+luheX4ej3uNk/F9pA5gmaDkGwbulXBUFGT/cO49p5Bi8usVmkeh+MaFTwsCBrbxxMdx1spg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtSFSIq8OfgEM7V6iDgG7Yx9ZwZmmqxf0VuR2aKzR3A/O4xm8q
	YX8K3N+voDKHSaHM8k8XbVhj0ZCvARjhtBdxCpSFK1NamOlgBd26U8W/3ovmVDAqpBEQW8PuZeM
	QaXx8poZTGigWPhrWGeRjPgtg3B9uTkE=
X-Gm-Gg: ASbGncsjA4IlcUa1xhWky3InRtLP4jwyjdzGYmqXD/jvCEI/oxUf7Q5JWFxWYzhQqaz
	YEuh+qkjN2391EHlIRLSIzD/TNryjc2PyKAvqsizaDVSzZcail/KkTfNppfKk6PEGBwPrSOW7kV
	/YVJv6NzpG0fTRXiklULqgkMjSNx90ZiQhyh/3030arXbXXS/KshPf2BZnO6qaL5H/Hf4Sm7dPL
	l88eg/s
X-Google-Smtp-Source: AGHT+IGhSr2nRdX/GwanQsM7D9csZEomcNuAEsUAg4nXEuyDiJfy9+JqqkmkYHd3CU065tr0IMpW/+pxLieFVAVPbRY=
X-Received: by 2002:a05:6402:27d2:b0:61d:1188:42d2 with SMTP id
 4fb4d7f45d1cf-6237883300cmr9496366a12.28.1757405110823; Tue, 09 Sep 2025
 01:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817231753.633899-1-thorsten.blum@linux.dev>
 <CA+=Fv5QdP-qGjUXQZ4ig1RX=0zx5c11gdrvwT9gqXNqTTqSZvA@mail.gmail.com> <99A381BA-47F7-410E-AC3C-D6EFA298DD5A@linux.dev>
In-Reply-To: <99A381BA-47F7-410E-AC3C-D6EFA298DD5A@linux.dev>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 9 Sep 2025 10:04:58 +0200
X-Gm-Features: AS18NWAnvpwMcZvP7SNJjCHzW2KoVfLGZupdjP1XerZf-rEkh53eYHSLHSmar7Y
Message-ID: <CA+=Fv5TBj1qJtqP21_WaXX6x1cgB8oerMQpeZ=hujkrWmLdokw@mail.gmail.com>
Subject: Re: [PATCH RESEND] alpha: Replace strcpy() with strscpy() in setup_arch()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	linux-hardening@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> The current code feels unnecessarily inconsistent, with one line using
> strscpy() and the next using the platform-specific strcpy().
>
I guess you have a point there, I believe that this already existing instance
of strscpy came from the patch you referred to as an attempt to replace strlcpy.
strlcpy does not have an Alpha specific implementation.


Regards

Magnus
