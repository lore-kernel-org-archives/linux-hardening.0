Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB378F40
	for <linux-hardening@vger.kernel.org>; Mon,  3 Mar 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022833; cv=none; b=HwQAWTbdB8DcPKStnSW7wtxzdyLj7qel0QIvGAAifNxKSXMTI5BKP1Ig0zYzaAlzgdrHTyMI0qQZB5S8e6tzw2qdMQ+u6yd/BPdpggpDqAeZMmLcnqZaf1OlrPSOvCr0L9QXIz2EqUCv6TL6hK2dX2XihnzDMwo2Bh15DfoP6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022833; c=relaxed/simple;
	bh=M/NLsBCFfpC4tZjqwwQRp8JpDdcPM+RWEG3vt+y44r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMuUvBcWuyy/vv7sy19A5P5jWNY2EorraLHpeaxPD1dAUkQWpQka+VvrdBkryJISRwWITa7mq0Z+qu0dyTvF+g8CJG9KDtlnusyeWyqLP77yBb5/JDBqcQRsbN/uwAv7zCK+WeOtdgpyCJxga1iAlYjUxC/b112mIqEIl8FrWIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOAzoSZu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOAzoSZu"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf57138cfaso397480966b.1
        for <linux-hardening@vger.kernel.org>; Mon, 03 Mar 2025 09:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741022829; x=1741627629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/NLsBCFfpC4tZjqwwQRp8JpDdcPM+RWEG3vt+y44r0=;
        b=iOAzoSZuHFsK5zalLlh+4HyOb2Ktp4QPhksFnrxevrGVeFuYvlh8OFMYK0c1Fq+C1S
         70i9yS3SnJfQh1dX4CCDGKBeJn9JrLCc6FC/P0U8rJQFO0He47NvA99ItbHxMxTasWSj
         e4Ndb2bV8Bt2PCxnhv30C1F+3YxzYUMEXFS/qqM5dUCsvGMoc/6Kq6iv80wBmDXKhe00
         K9vhUhJsq1Qdv9v29ApX3PGG/7xJZlexiOQFWlSF8A4NXc+ehqNks/Jz1///+9YEXxDn
         m6zEMn/JqPq3SydG5HZzO4AgaWi3TPVQm7hGu2SYaJCGqFd09hHtJP6F2AaHQYUP5HAj
         I1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741022829; x=1741627629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/NLsBCFfpC4tZjqwwQRp8JpDdcPM+RWEG3vt+y44r0=;
        b=WTq0Avdnyg19OeRG6KmBlWjvZ63S+12brNDX9C+4lsDyTA7rSqB29RlbtarocOTW18
         7wqj8m4Jj3qPSKWBhCcGykoPoC2e8YHLk7E3CosSyO1VAQ9eXrn8JtN4bpvCAZ+B5q/B
         7oEFSzwEgTSM5Md6EiukK5FTuUfTjnhDyNNdE6KJ4WE9xO/DfA2qIlAlwjTd51W8dbNN
         G9uOsFnOJGCohSqTwB8s6Z8sPljMyH4QVkKvbvlk6Y3lYjMnBgH239uVJ1uHQTLueCEc
         AO3+/jVIpKNSOj+fiRP6EuaJoGAqXO1auf+olbxYm2V8da8gbkcKEjwueqqULSkDzDmu
         7/CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHe+9MGZGo8qJ36Rx33JyDQycgIze4eptqSzzl2r8Pc4+LP6jjN5yZsnSos/nlW1B0KdbVFPpuDge6AVBUcNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy41MVj0/Df4FQk5641w1EMyZ376GOkCqNcK1gLjREy949NYdKk
	0i6n1vpMReBAFPJZX4ZONu6Pf0G3v6baA7W85tsAxwk+V63ROC/j64bkQGOOEzoj+E024xdMgZp
	6CgKkC5IONuepVCONsne9fnojpR1mV2+g
X-Gm-Gg: ASbGncsPB/9fxmTGwSlScXQF7KK8nRh/ERBlEBjt5DQgJILbprJmmYDmOz2fa10hnbG
	TipJ7m9o8YUNn9WjLY85TTiscmyfpoKQaWIHP2ZK3nf9XhzKtf7CS1CIRxdNaxWHYuc+Ahydw1j
	eOPlYiVs2fbVbYFwpT1QIjuRKXK1fo
X-Google-Smtp-Source: AGHT+IHGOkIrc+48QGk9y1/aeGwvULfVmx0ESFD3a5sJGJoGahb4pNFYpQMvZGRDvViyet0018GmccWPs93Ttqv+mdg=
X-Received: by 2002:a17:907:9690:b0:ac1:e30e:bf5a with SMTP id
 a640c23a62f3a-ac1e30ec2c1mr282935866b.35.1741022829155; Mon, 03 Mar 2025
 09:27:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
 <202502281143.149423E53@keescook> <CAHp75VdX_LtL8vJAjwSqHfW9KbLGV5xhjX4MjFnpFo0VA2SMWA@mail.gmail.com>
 <202503030917.6A99B05D2D@keescook>
In-Reply-To: <202503030917.6A99B05D2D@keescook>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 3 Mar 2025 19:26:33 +0200
X-Gm-Features: AQ5f1Jo08bKYZOT0Bj9qaSloxJfVu1SvdujZdepJGj54KTpu7VltRoW6DFuO0II
Message-ID: <CAHp75Vese0qwdkWbj3OQ7dD_v=EB+hWvf6QLNOY-mUpzGrvtcQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] lib/string_choices: Add new helpers
To: Kees Cook <kees@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 7:18=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Fri, Feb 28, 2025 at 10:24:22PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 28, 2025 at 9:44=E2=80=AFPM Kees Cook <kees@kernel.org> wro=
te:

...

> > Kees, what is the status of the
> > https://lore.kernel.org/linux-kernel/20241119021719.7659-1-prosunoffici=
al@gmail.com/
> > ?
>
> Fell through the cracks! I've applied patch 1 now.

Thank you!

> If we can see some conversions for locked/unlocked, we can do patch 2 as
> well.

Definitely.

--=20
With Best Regards,
Andy Shevchenko
