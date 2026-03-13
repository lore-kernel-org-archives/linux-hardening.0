Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA53246EB
	for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383413; cv=pass; b=Vjsrfrp8RXEYcF+azkhvDnl8jzSP/XQuw9Lhb5IYChqt1e0tkPg6xGBZ58r6y/REiGGhfqCmPCIeTOcDokoqpfMRvvX16pus8CHak/r8hxE0guMFqputv5Ao44xw4gihFPPmH3Hf6gri8Exv2F24VyWpjKVW/FXcV1NV3SkMM48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383413; c=relaxed/simple;
	bh=3WtB1EO7ULP2dv1nFjQ5XE7neEDPZu3SzQtV2a9e/Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jqyv86MhkI1vTCKVpIrdC+aL/YYu9fS8eYPh35EQ73kC0yE6LkxlLcqhG7/ddEBAQajsmncVBVa3L516UBjMG0WBRql1yzRf1JmwCvcnC/bF52G8pyq+d4xvsP+IX0tev7FVN1BpWAE96brSd4HejUkkpWD9iK3kPonyr7IPCS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYu64oVK; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYu64oVK"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66391baf250so1369039a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 23:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773383410; cv=none;
        d=google.com; s=arc-20240605;
        b=BlF4BhM0l9WAOi9YJEtjjGdKEavwLkqtedq7pEWIMcUM1CeaOkwRg2Xn5rnqylYfRM
         ik0HWFdFNIDNQMl1dnEUlXrBvB6oi8NPvrIDj7j9YQLNvaEyKgV7e5uw58DJXxMtHrDS
         UeynTyjAGxtyjDU+s9jG6FBEg22eKQ/Q34My8XNfeFIbpfdF96n7zSTITzbvtu07hIbs
         8nf9o/A21TYgY0qJRvAqqtSAdatRTGYfW6VyLgZp3y3Zz5PTSrSo1l9ppkluU+PHcwjl
         O6MPf/lQp3avCIPg2Xcb3u7/pvDfl09BGyTOfqVIpRupqu/797KCKF1DK9OSAHTYyW5o
         XcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dPJHfICB2kVM1pQvzl6TqPezMCEYItbR1A1kcv/R7E0=;
        fh=aybr/iVWXwgX/MEFJdx7xNQUxpTbvoTVo6xvkBlMHsQ=;
        b=Bg5dcxGC++ZBbGeOVUyh8VtArlvcAeWgC9AJj1cao0L2YuIUQupSXGfhLE2g76RrJk
         yKEFEU0ku4kXv8ptY3IgQHeNPPQUccOwcUHkYUBBttnz4pZdr1FhvaYPnvlFwV+exVzI
         SQyoRnkihRQ9HFM8sEfq3FNiBYE0viG04Ui/dy3bM0g1sMvVb3U1pG4ulBXlijikklhe
         38RGODXoBwMEVc8GjJzXtrMqyFjYbg8Sgw3JmKWWIg1HBlquym5VDIRbldVbIBCC9cKA
         KyFmYHetegcNOw6b6OxTDIL/LNQvTT2eZolcFWpMKm+QZZBSbGtnYCNc5JIn2O5dYDwp
         TtpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773383410; x=1773988210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPJHfICB2kVM1pQvzl6TqPezMCEYItbR1A1kcv/R7E0=;
        b=GYu64oVKzwgzn8ZAuawiupzGgdpEC8YMZ5rJ/rLOiuLO1yKiLBKflt6gHMmS7FMA+l
         vKrKE4Rs0LN/B3OpW9U4FpXdZjKQg9iWmIkH2nrWXbXaY6sziUcP1StBToPW9u7DMdwJ
         MEqSR1WpHDqGYeFhCqU4OqfabnGYFZtOcyGy2CJ5uDpGlWMpgSAIMGnQqaRYqdb+Zayj
         mnGvXiv3ly+NmEznAiW7DRh2Am4TIYkxY+Aj1J7L0+It7bQpdr+Rc3U5+ljIoMW9qcvY
         ErNXbWvobiWjBk07OElHISCRq3GxSozVzZlmwlbe6j0BafOSxZITzW4vunqFLsOxk+0N
         S4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773383410; x=1773988210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dPJHfICB2kVM1pQvzl6TqPezMCEYItbR1A1kcv/R7E0=;
        b=U67gUrIg9KH6tglALxaPbynoRgw9BVpS0ficEXkzkH+wUmdL7yL6pYxhVwwGM/Ocjz
         wG4DZwmih8rbKC9dw66RvdeaoZ7AGGvp+ZxzJpMUWknUH370SqmRDE7W9mPahVwoHksV
         5QojAfKlXmFgrdYMTgEARjxmU6KIFX0E2Nis8odj8ZNqxUIUqwrG8iujdLGrpmeFU831
         iiL9KQA9/SqR9O9N3vPc93p3aLhyrHBFhF6KDfHXj7iwwJGeX5GkT0XA59h+6VPiLgmn
         a+rAMvHCcw/6LoN+ncIzeqr/vZfo6PHNfImX2rW/LX0lT5coHYU5Y+1eFKVZfRSOmTAh
         xt+g==
X-Forwarded-Encrypted: i=1; AJvYcCVbp/fxodg8G6pTj5JHkuVERKpbZ6EjHr+tQvyRYFs88+WMlS68bagOlY4QUU0ukdaaciCSBqPLOzyJLHcf1Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXX4v2oS46XY/MCIz62yfhRPId85e/Oiyw7eRZw9bg747O8lvR
	pIWAJxUJahfCsu/iPLm9QkW5YPuO7TbRg4n7uNfmRmBU8xM0mm4w9Kv4E1NhoJFh026xx054mYN
	bKStpo3Z7FDnzmyQtk9FVc1RJISgbUVM=
X-Gm-Gg: ATEYQzx7LMXUNGUp/WnEnvZ2QmeGgwXYnTx6ngpbd4hEE75OzmEl6jvYJYIb9G0JALx
	2cDL/Qkg3bfyvaRdk1zk7dmhcpwSeWFVaz6wdfimNlqzVflmBxpwzfi3k9gH1ATspZn6oEwWGqf
	9H4AvO/DCA5FbJTzcp3GAzyWF5VgmicIq4H6iP0Pss4Yb9mZ8m76xvSYPSsoxmMryKKA0mk9TQ4
	KXr7ZPsYhS6Cg6v9qbl9z2upnbqPOBC7lrh+YQIrvVQibid0chdKM2/vFkcnGFGw75xHIflLaJt
	NKtWZOjjXgCSqDioDO9Wz274Kydvm5CKoZ4U9xj3aQEVgtYenSlrxpC4wt5t1+DT4sa9FTFKgJj
	jTQ563Q==
X-Received: by 2002:a17:907:3d87:b0:b93:a3db:a68c with SMTP id
 a640c23a62f3a-b97651e7241mr118021166b.40.1773383409452; Thu, 12 Mar 2026
 23:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312193717.12221-1-rosenp@gmail.com> <7jwgbrijeldghk44tdg2be5q7o7vuj5np3nlbl2pxuln6c7ll7@ntuquxxdnfmm>
In-Reply-To: <7jwgbrijeldghk44tdg2be5q7o7vuj5np3nlbl2pxuln6c7ll7@ntuquxxdnfmm>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 12 Mar 2026 23:29:58 -0700
X-Gm-Features: AaiRm51lyu5fd17YeYxCP6g9ZNV_rgw3odQq_g1fIwHyYebHzAUSuwEuLroDVYs
Message-ID: <CAKxU2N_7sZu+J46sCQH4jgVB0r9HsHREToeCTg0Hz4PaVjY+sQ@mail.gmail.com>
Subject: Re: [PATCHv3] gpio: virtio: remove one kcalloc
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-gpio@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:VIRTIO GPIO DRIVER" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 11:09=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 12-03-26, 12:37, Rosen Penev wrote:
> > A flexible array member can be used to combine allocations.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  v3: add counting field for __counted_by.
> >  v2: add space in struct
> >  drivers/gpio/gpio-virtio.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> > index ed6e0e90fa8a..57d0eb532c3c 100644
> > --- a/drivers/gpio/gpio-virtio.c
> > +++ b/drivers/gpio/gpio-virtio.c
> > @@ -52,7 +52,6 @@ struct virtio_gpio {
> >       struct virtio_device *vdev;
> >       struct mutex lock; /* Protects virtqueue operation */
> >       struct gpio_chip gc;
> > -     struct virtio_gpio_line *lines;
> >       struct virtqueue *request_vq;
> >
> >       /* irq support */
> > @@ -60,6 +59,9 @@ struct virtio_gpio {
> >       struct mutex irq_lock; /* Protects irq operation */
> >       raw_spinlock_t eventq_lock; /* Protects queuing of the buffer */
> >       struct vgpio_irq_line *irq_lines;
> > +
> > +     u16 ngpio;
> > +     struct virtio_gpio_line lines[] __counted_by(ngpio);
> >  };
>
> I wonder if it is worth it anymore. Why combining allocations is better w=
hen we
> are ending up using more memory ?
No idea. That's what maintainers suggested for some unknown reason.

Anyway, I don't care if this gets merged anymore.
>
> --
> viresh
