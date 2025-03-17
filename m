Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD70A47
	for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234551; cv=none; b=NDqJ6IvoENZ/yUYE7HOdTs0smjRK04KMJRbV7WcxWyYBR/9k4XDB+ZzyFo5oS7mH2dpA9/dUOWmXlrgd7b+pZDLzTMU/JuhTIIhoQzWYUANUuaYHW63yJDyMWZNj/6O/itQa1bZUtqu6Tai3iLseh7Lp5IPKrSsZ1mVbGHFdjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234551; c=relaxed/simple;
	bh=4KfOxJpzkEUrnebM6VwsEcKtTjAcaAGCcRWL1ZuUb3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnKpLuxDym3ksGnt/0HAOkPUy/IqKM2WbcoxYrwds5QRFNitZLL8tjq4PfJm+UoS0zLNzEepFzI2aH82FqcaY+umcmPpEYEOfXilFo1f0rxJ2mMCgRxdAZh4Eod5Rduo7dkDrhSxlaK/MqIFaJURoPb00iIIbSV8R89oP5GqtZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TQjZ4CNq; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TQjZ4CNq"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6000f9179f8so584701eaf.3
        for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742234549; x=1742839349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1itwOhs8U8rwjZwMJNYdUQbaZzgT4ddqbJE4Ck2w3E=;
        b=TQjZ4CNqIwc2FsLwoUROBmKU4JWNjh3o8eIfLQ3z8BH27GA48l9TH5+mp7FfoE0LZi
         4pIWtW/AjMPd81+N956AThvEtOR+EV9nOOPF6MXnPzNfLSFJ2VTGoDDPeIg+Z0kj7BV+
         aBvnOcGq5Q0qaVWg7ojsJTOwWqCoeJpynAZW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742234549; x=1742839349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1itwOhs8U8rwjZwMJNYdUQbaZzgT4ddqbJE4Ck2w3E=;
        b=JLj7Zqr8zQIrH/M8Nbnx2Z3WVUbLEhx9WgJVnLlhO9m5YaFnsW1NSe9JSywElOCr3N
         A6jOj0sYI1JFkDnVGs9EBMAO84kEmPShy2FG8D3NSqvUWMG6Hvo1S8abFIpC3A3MhHAS
         GcVPcwPWEaOuf1kVa80IZDdQY0Eh1Hs6vH58D1kgTdw7dUPVqj/aX1oyz95PMqH4A7kQ
         dU5igC9FedUGQv67fO7VXPXtIBg+MGpVikb3q1Jw52uo4TQTWDf4sgt6qnCF8Idxlej0
         FNV5FrcDfk3GTIdiHfOKEzxenkBzLwftSXe+mNrHlN1lN9R0ehWttbaF/XN23lS+Ow/M
         sF6w==
X-Forwarded-Encrypted: i=1; AJvYcCXKbiwFZqMSVoIPRTiNcZwAyWxsfFQuHjMyhV93uv7hQSmG5ZmHWX0X67bJGxMCRQCNI5fz1qx0/Gedf53hqIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysscZ3o9CEpZg5FAu07TBJeEM/zdaHVQBBc6aY7hA9o8mvEfKj
	C5Q32YN9WMO1hOCucM5Ju12lsBElr9C0LM3BrMJa+kF+txt0nZ+EWy0twE5cmX1RczOuFofuG6c
	Zw0zj9GK/9fo0uMDLPIOopFVWYLHppjKg4x+Y
X-Gm-Gg: ASbGncuQYWsXMranxhq1cVhvvM4hvwvNFauRHmS6i5LuDby5zOqxHMQ3YyhPqq1CnA4
	lEVEvRNYRDefxc22CSlJ0vGrZhac5yy97DmuxckAe6oxVI5IsuoQrgtLu8jJTBPN3ebiCSC/27E
	5gLJptbM0LRekXwIYjWZ2my9De/6j7NnnymX21fdIk5w00pmczYgztIF+v0HJJivjx4Q==
X-Google-Smtp-Source: AGHT+IH41ADt60ghf2dtIE0xa1vEg/Fl38J9bkXH2gfzhBcovPRVrAs1ZYcAeCq+O+e58p8x/FAYdjgdu3Uz68CYukc=
X-Received: by 2002:a05:6870:1649:b0:2b8:f99d:7ce6 with SMTP id
 586e51a60fabf-2c690e9eb05mr2645749fac.3.1742234549024; Mon, 17 Mar 2025
 11:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317131917.1332402-1-hca@linux.ibm.com>
In-Reply-To: <20250317131917.1332402-1-hca@linux.ibm.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 17 Mar 2025 11:02:17 -0700
X-Gm-Features: AQ5f1Jr1hVHzTn4m-ziG33n8GzM14Gv6-Eef_doYe18OdvN44Mevu0pERcSM5Ws
Message-ID: <CABi2SkXajtCz=wBpuFLbiW7jDWRR4+5DRNB5p+Rniy1By1QGCA@mail.gmail.com>
Subject: Re: [PATCH] mseal sysmap: update supported architectures
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Kees Cook <kees@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 6:19=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> Add s390 to the list of architectures which support mseal sysmap.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>     Andrew, please feel free to merge this with "mseal sysmap: enable s39=
0".
>
>  Documentation/userspace-api/mseal.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/usersp=
ace-api/mseal.rst
> index 56aee46a9307..1dabfc29be0d 100644
> --- a/Documentation/userspace-api/mseal.rst
> +++ b/Documentation/userspace-api/mseal.rst
> @@ -143,7 +143,8 @@ Use cases
>    the CONFIG_MSEAL_SYSTEM_MAPPINGS seals all system mappings of this
>    architecture.
>
> -  The following architectures currently support this feature: x86-64 and=
 arm64.
> +  The following architectures currently support this feature: x86-64, ar=
m64,
> +  and s390.
>
>    WARNING: This feature breaks programs which rely on relocating
>    or unmapping system mappings. Known broken software at the time
> --
> 2.45.2
>
Reviewed-by:  Jeff Xu <jeffxu@chromium.org>

Thanks for this patch and caring about the documentation !
-Jeff
