Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172C2C159A
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469350; cv=pass; b=UEczrOgiA13rUId7Q8nqMXpEKPfmUCa3hZwK0AZIbrHK4o+rJbzFc8f/CPfLHzNYbaldKrjOD5RGa6ZVPMeDXBh/GXbiMpsW70YN9mrenRzd90SKXa83Pp4zo/algl0sC+LORAQ6kow+HFmbt79ecyWAcX5o6fdUXuB1kXiwH8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469350; c=relaxed/simple;
	bh=zdaylvfqnYYIK20Uqia/+5JYlhQmjS2royCRC4+lVTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWljRahrZmC0fXiDZmdqt4923hSQjpLkKVYwXw0wtCOIUj8E9epiSW1i4ApQ4o89VVxeYFLNf7XnZxaehr2oaYYcn6nScPtxrlZjuNhmbMKnwJpT7PtAi1lYtwVe1/NDkmNPwBNwgwIp8fgCnR0qSmdBxLl5fMp+H6jkPx6wzPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8PFWHQi; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8PFWHQi"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bad54961385so1067360566b.2
        for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 06:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777469347; cv=none;
        d=google.com; s=arc-20240605;
        b=RoFjoejIZP0M2yDFttNOpQXX83ysUZxxoTLgiMUmYhLDZnIcAfHRNYDyIyoltekdau
         kl1Q8jZsYV/KBB7EUMC0hPhY/70apXX+/iTBzalqyHEpOjEFtBTiKJf0daigPmS0SLgF
         mKpDbgdxS/a0J7IWtSG9r2s4iORQiy6BKX4qQmW7GG63fJenL4K5sZB0IGKiSjc4EsK5
         CZRnxWpN/CplxDFcHvcAMIAKvVXPNPP8wevPPmyQjWe8/I6iazXuUYWUwJ4eWUZgi5ck
         f6y7Jkw4XJDu05p1jWkfLl2+LhapJlwCsKGMFDpfE/T80L3ojfkqf6x0ZX94WQnaeoV9
         qeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MBgUB2lL8gCfWeVj8BNkirc3KzBobuAjabTSBqzD7bU=;
        fh=M4JWiCBqzojoJFSVMn2oLZZdrnD5DBdjA61UJzvnHMo=;
        b=JhgqUZwZxTWj3w+wNK+qv+d2aiLpAueCXEMF2kxiSI/cba3XnW1rDMX5XNHzrKS8Kd
         wnPcKf5jVhPyTKKKJfxoxYhQF7l6jLCyRcaZqV6yQN0te6jN1w1uWoI5XcNMAd/xAltx
         2Wi8xPjer5ZrB/m1G/Gt0k9+a4Q2aldNLwp+XKJgpW1kH8e1Qb6e2KqOZI02e2j3DNAF
         Ci9ZY88H+YHnNY7Yvk5VLd/DgQcpxG1XfPiUl0LIF6gaiNkdq6802h4IgAK6IIfS0UYS
         GTGS+RqYskmdXlBxhr1gOyb8AiiTwlIEwAWZe29G+pErYeEThKi9+kxZU81dBUXDpW/i
         B1bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777469347; x=1778074147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBgUB2lL8gCfWeVj8BNkirc3KzBobuAjabTSBqzD7bU=;
        b=Q8PFWHQiWBLMgBuIC/SDraRG5WeIQ4AgNhocFaKsSlQfj2QTPB095LLKVcLZqpQD0O
         a90LAbc1zd56ofb+kC0eBolfLc9ZhsNSdAG2YbZS3TWHxwdTIa1HVln2XjXFwv7qgTLe
         GaRWua6ZeJeQmxum/opSGDZGZkU5Cw67ne2FXF3isGAqNz7itOL1Y98QXmqGBUsP5qsA
         6tnsXkJQK6mfu5hVm1/Q/Nc21tNpFR3Sil52v+5NYBH/SQtG2B/q5BfTLDAp8pR76YcM
         8aFPF0QkZKN5LGmDRUJdP5MvKt4HabAjenZZZIM3lOs1IpKtSIhWbPyv7IoTt1PSREpq
         x2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777469347; x=1778074147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MBgUB2lL8gCfWeVj8BNkirc3KzBobuAjabTSBqzD7bU=;
        b=NocDU2y2x/VCeq8sviIpvaW2rIAM7XrOFXaG2aZ/XdeQPWBnwNCFJ7Pm4QRVL9K/A4
         xxPWW71AXe+dHj/my82IuSnFlpSasrrmS2VBXbZ+3C7Eam53/EZfghDWfGfALe0J367U
         MOZWV2GdVdH731cHFmsgxLOJ/M0cyzRwTOsU5yYupcZQHWl0Cg7sTFWrViPm8MBGb38K
         VbYDLyFAdB/hWFSgHLrBjUkRYjtIpo6/yaMs4WOvIZtfX1ddWFhUF/jLh9T1TFFageIe
         /9lIANSl8OUxCNx99Vp96WTydCW8PHVTKb2wSTxJa/FhDmaIWowoe50FXJgqfBXKnLDL
         A8oQ==
X-Forwarded-Encrypted: i=1; AFNElJ8iJsia64clw1vknVMVrm5cUCiWTY/CihqRo8QE3hUI915pjgNjkaU1HwDf0WVUlB0ljAhKKFYkQFgaXPYXluk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYEgxtj8qDVRaIElHHj+tGmNFQntOk+O7qEDZZkirqIUtswHih
	ADr6Z+lcz9RDnlPPHLGPamjsEu1BEa6SdtrCo0Ie25EDSS29rJMIF/YlY2sA30Eel5ybgX214Kc
	GB/DElNHDR1rHttaP0MvKfM3lE9lrTuE=
X-Gm-Gg: AeBDies/vb81gAhHnPLBGgHzPffwNs1naYtqlhiSOol1g2LaWubu13OAmDykL6IUotu
	LA/7iK95EAAV1KJYoxYogtJcahhnAe8oAFt6OKBGiBeF8dvfyf57Bpx2NPyMxkrvls4U+k1xM2X
	1QohA7Z8kuOxhmpPRy+0vYIZeBdBwsh86UY993uy1jPPtYEQVq26eX6tgVj5HGEeSVSMPpZiS5Z
	PcBqUqGgDiyZOfLXe3rz3VjHf+F4d4BuTObMvD2U2MoHEufCfzg4YYA+NyeoR7SBKCmsEtwYP5c
	qHq4MjsuzVbWmW8Fq3OqD4X8hsYWkZ+9ZW6a3PZODVJwzG2FUBoRWmbVjva6ffFgnmG6uPPgXbL
	hUsdOJ/FkDVAdw55TfA==
X-Received: by 2002:a17:907:9814:b0:ba0:fd75:9c58 with SMTP id
 a640c23a62f3a-bb803971fc5mr492253366b.32.1777469347217; Wed, 29 Apr 2026
 06:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777369070.git.jqqlijiazi@gmail.com> <f04886692531b6f6af52b75113bba43ecf2c7def.1777369070.git.jqqlijiazi@gmail.com>
In-Reply-To: <f04886692531b6f6af52b75113bba43ecf2c7def.1777369070.git.jqqlijiazi@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 Apr 2026 16:28:30 +0300
X-Gm-Features: AVHnY4JPOJTIfKTGgnSEk3kkfUxwmrw4S8s_xdQ4JaeVmBf9UVlkmkrNfqEgLhg
Message-ID: <CAHp75Vd8Pif2s+7tXNbB8c8Un-NP2ZYAT2FyeUcF0Dwe3byPXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] coccinelle: Add rules to find str_alloc_free() replacements
To: Jiazi Li <jqqlijiazi@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-hardening@vger.kernel.org, "mingzhu.wang" <mingzhu.wang@transsion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 2:24=E2=80=AFPM Jiazi Li <jqqlijiazi@gmail.com> wro=
te:
>
> Add rules for finding places where str_alloc_free()/str_free_alloc

str_free_alloc()

> can be used.

...

>  coccilib.report.print_report(p[0], "opportunity for str_yes_no(%s)" % e)

> +coccilib.report.print_report(p[0], "opportunity for str_alloc_free(%s)" =
% e)

Perhaps also makes sense to keep coccinelle stances sorted in the same
order as they appear in the header.

--=20
With Best Regards,
Andy Shevchenko
