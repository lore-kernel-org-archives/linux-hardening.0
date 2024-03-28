Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B59713AA5F
	for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658550; cv=none; b=d33DKhrPfeFHNaPEXQJeIqUqIBBbyHLmS6RTaLab9OVDJL3hkoWfEkBfn1Ihb03ykBUaKO56Ak1Fn8qJ4Dn3KyQy6oe5+ueb+X5egDOXmsI97DtAvGceoeBoST/CHeJeQ8HLinxB0HRle4ce9oPFCMAyHK3nmn7oZliUGF8xrKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658550; c=relaxed/simple;
	bh=Xvp2uzp/QTshAzSCZHYKZUXilg18C3KOX1kGmd5mi/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vu65K2cEwtTTHHhvA3WX/IrpDtaFdPyMT7tCkgtEJQYdJxLapltzeySXvgvYXdpncK8M2UsGs25Mgc9ihJhq7d3XNi4o0O4FmGWbF8Ugj5Q6GwwHSE52p1rx9Jl+jrVoOvwPkzwIFm723LoOvhupu1KS+L3BHCRIuGGx0PMXIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUxXwm9o; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUxXwm9o"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4e1742d3a3so177810066b.1
        for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711658547; x=1712263347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvp2uzp/QTshAzSCZHYKZUXilg18C3KOX1kGmd5mi/k=;
        b=vUxXwm9oJsnXRK86vLRxRSCc8vaNnRtf5+2D6eOe01lrXh8yQq7frJWjr7debMq6al
         LS76w0JG256Zxn7GgaQXYrlPhwD7O9sq0czcbsIu7ny8RSp3UbAGsepCS8ysppufD55s
         3muCOk9S53P7+K/cfzP3jzF8lSQDSD1DakmAGdGlMPAvcdrk1x1enhsBylWCVwMqD13j
         DDIM1A4VHUwCgFqoX403FF8xTSpUfYOxuLXaY5NsG//MLxmqPAfTZGeJThe7TkKudYDq
         WGm4lG/k1U4QMeiqhjzkYcw2ylF/0bONGrmQWUkT9mHpbrCB1PLtuKxS3GkglzpGMkHz
         KfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658547; x=1712263347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xvp2uzp/QTshAzSCZHYKZUXilg18C3KOX1kGmd5mi/k=;
        b=L13VW656IbPR3n+GANdtqfV9ZX+2mEgHq2wlhz7FAQLJmErYEROD8C2GcoSXhBmf8r
         D9tmYkit2o/Z51BiPAseZhjWEC0EVAB+5hF/bwFHjFDlNiaatcYMcKdV4iSxBeTRFPMR
         ww1GIYP8/GUbCfPynTTNwJ02YGiZk5ypT/bw5qQVTY/u/ofo+G3DwdBMRJw1ov+3wVzQ
         10eSUc+2pEsS2e82Q2eEJwTNEv+BD1rPhxNF9n4EmrAAcGOMO0aq3qnl9J7eH+5gro8M
         wGKL+P7Vzs9H4symQqmI/A1Y/nwPdo4cPoqmNdAjUr1yUFwe1ZthSKkvQ78xmJZcGvVE
         692g==
X-Forwarded-Encrypted: i=1; AJvYcCXPuqTar9V9biqdP9sk/6t3v3cWPAkO2T8VkSHaQMbmMFqnMq1qsTgy958RjwOR4KYEOc7xD/PIKVmw9fWx61+uyamRV9pXELi0fy0VNIxD
X-Gm-Message-State: AOJu0YzIhK46/XhrjSYvaYhQAbaPZPL2W/+c8NchW45WgOWVaDZbg9jK
	ahhDG1XRfovWyTExajGkDWQ8p3r8wEkjJmgnCiOs2w1h90P0gAiMp+rxhlt5fgfsLzZ4ojqNRLf
	Su4uO9fAu9KWiZRV52nhMBDshqVg7ZNOIlg8N
X-Google-Smtp-Source: AGHT+IH8/usAUioO+qTpOeTXvg7l2hto6OnlgP6NOT2Q0qO008pCvTP/WT/jXd9Z+X+Kqw0CBmjAO9+FEscgo7LRR4o=
X-Received: by 2002:a17:906:594:b0:a47:32b3:18c5 with SMTP id
 20-20020a170906059400b00a4732b318c5mr203139ejn.68.1711658547456; Thu, 28 Mar
 2024 13:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com> <ZgTMZ1HYheBMDbei@MiWiFi-R3L-srv>
In-Reply-To: <ZgTMZ1HYheBMDbei@MiWiFi-R3L-srv>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 28 Mar 2024 13:42:15 -0700
Message-ID: <CAFhGd8pU-utbgHhU5s_20pC_aNK7xtsJDbf+Ayg4Dck2K=4kag@mail.gmail.com>
Subject: Re: [PATCH] vmcore: replace strncpy with strtomem
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 27, 2024 at 6:48=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
> > Mark these buffers as __nonstring and use strtomem_pad.
>
> Thanks.
>
> I didn't build, wondering if '__nonstring' has to be set so that
> strtomem_pad() can be used.

I do not believe marking buffers as __nonstring is strictly a
requirement. However, the documentation from string.h +302 says we
should do it:
/**
 * strtomem_pad - Copy NUL-terminated string to non-NUL-terminated buffer
 *
 * @dest: Pointer of destination character array (marked as __nonstring)
...

and so does [1] ... "mark the destination buffer variable (or
structure member) with the __nonstring attribute..."

FWIW, this builds just fine without the __nonstring attribute but we
should use it :)

>
> Thanks
> Baoquan
>

[1] https://github.com/KSPP/linux/issues/90

Thanks
Justin
