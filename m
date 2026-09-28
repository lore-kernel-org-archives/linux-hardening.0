Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com [74.125.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295263BED42
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621884; cv=pass; b=d3zpXyL19e9xxO5MEG+4H6eE2KuFBl/zaTk26bMRfc7dzz7OPT5rCJlEOWYP4HCYWi80aZI6oEOu5MmGkJT033n5Cd6sl6esywCVoIi8JpvVULwyRCrkrI6McJHm0rzoLALSwTvbxwNMFLDaer/4GU4SQrIQka4ZKdNsjL3jCzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621884; c=relaxed/simple;
	bh=Im1NAfF0TnV3CDpW6n2DT1Ez9Xb/l8e1pIhIoS8My2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qgk1XfDbaHbo65iF6L346Qhl18QqhWmaFIYukiHSg5dp5t5DDiVC0dWKnsPmKN1cnn0HmK22EysY088cGN+SGLkdvVINilq45FTbJ/yfocARTdO/UXBRB2DEVeCAiDsDnx/SPjfskz0KQgDNooAWnTr021xEnKhTh/sHPYfr1g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZqVXuoc; arc=pass smtp.client-ip=74.125.227.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZqVXuoc"
Received: by mail-vs2-f37.google.com with SMTP id 71dfb90a1353d-5cfd29f1208so533126e0c.3
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 11:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790621882; cv=none;
        d=google.com; s=arc-20260327;
        b=Adr5RGFNlosDqau+1C4Ux55qBZ4r59OlYpUzuDhh87mgW+hxIPS2TSZnLpy5Kh2bjf
         G2Dd6Y3Seg3v+F35cAdV6U9WpcpNlvDIoHYIpBfGde78XpDAcqV1zI8t/F0jKTvbepXw
         lAJqxLqj1Q3wIw+4l2XjMjRg+y4u5MKoVcvchl5VOfh9hPE1xeom3eU+BmzWl2cI/Xtm
         cTFzvn8WUjLPPniDmYNWLSWPVewmauiQKEdn1RzZXPYITppome7z/u3sFVXilAeHwsIg
         1sXwa0TXvygT3cuverNYFVHQva4s4tmijDD6xkbaW+a0Kh2V0Xx/MF+Cp6b/7OEQN7Wi
         db2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t2cIO50UyguhSiU6G2c4CxKHoZiSwBuo4uMuhhmaldo=;
        fh=He2e7b1GINLPerr0k9ayNoDuKUp/8cX453JhOpLEp+8=;
        b=CvprPlKiOqAn7xSwaAInY7bCY7MmuZYPSj1TW1k4VwXZVyX7k9/nzfqH9d2njoGcFP
         jgQZ6oDR4F2thm9X1j6WfE3UPNdHrUpK4ZP1PRSnNjwour8QT3qb1ZbhRfIZujMXIKRB
         EmeDRMX7ycHdhxrc/Nj8CJaM5/5Om4/HdBFxxju3JMHYrjUaTVyca7n2EyWft5mk1Us/
         W1VBV/UJAeSqVW6Lyeu7/t6CrtQDigU+06LAQCgAW0CnJk8XiXaFXJlQj+Po+2dA7MJv
         CU3BWNbQuMWwuM7UmTjXNdU7gCNp8sJGZociZO2an7ZipMMnKa+L5ObaQYmJ7av81ARB
         Ezgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790621882; x=1791226682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t2cIO50UyguhSiU6G2c4CxKHoZiSwBuo4uMuhhmaldo=;
        b=sZqVXuoc6h7XgKkZ6kU3dpZ6kYOv6gI4W9xnXG2hM6Z1O344XYWhjK/63pN2esHBRI
         H05fFVuuhbEhKGu8CF+3nhPraTmlbDyN6xSLF+ayaP/3m3HjCX4vR41ye7bTb4EKQGNS
         QlRlWu0YUff0rpSPmNpr4vOub6G6TwpULNbKe6P3TdmZTVoItMEeaJ93cWPMLRq1hNjV
         vLnjnFjIv7byHsvBAlsQ2FCpzAkSB7vvofs96fgARyVgszBZcDtkuxkjpEp43pwP9/xU
         AjZM/ObJ0zTOUWAmiVf/sj/7CFQvBt3D6zFXx9aCiwjBh3b51jTX0pUKYiJjseZqB5tr
         dm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621882; x=1791226682;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t2cIO50UyguhSiU6G2c4CxKHoZiSwBuo4uMuhhmaldo=;
        b=CHBkKTt4FeQd0R7EiyHSPbAdWsitqCS5mBt117yOhuS+S0ZLh0iXUHMpb6FzSV9rjV
         jd4l5se842uaLzpkQ0xmhb9EtP+63gcfelF+eTMVwXY1g7jzyRcJ2AcejxAHjIo+hYO3
         MtDrYHCKBfAF/H07122Kaeytb4pxFzzRLAyuZkfCYJRLcMJyu1Wm/1DpqjthlUYWZe/0
         cq9W0sRYnmRigmvqJX7BgccrxSsKZTIeX2AmGLwT1EYck/of9KHnZu2cxUnOkr09kzri
         fQrpvZybXFY3UV7G+G4X9nmdl+qlH97ocRTKTXXLE9MH9tc1CBzrLyqqmi8/YudY4wi9
         Ty2w==
X-Forwarded-Encrypted: i=1; AKwUvByOwk5UkFcnwz3jSzQ7Oe/sE8D55hxLH02sq33VUrzl9+8HrbUWWBIZwSyGgz3V3LhY9W3NH7+uHh4wWhznbjY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLO9aqKwWe0Dysg4g4RHXVVeo7gsIvV+6URClaFNxEEEWqyH4wu
	R0xPlWihlpr1XHuBSoylHqi2V/O4amuaFC8jI186sfI1V7nZAcgFuVKkBOW9F4wwzyEP3YWfcHa
	NhUnxgppKCRjF15pnGk7EyLsnw7+q+INleDvKqWQZMuczdfNY+qIKKE2eYw==
X-Gm-Gg: AYBFou1bSZWvtImoYwfsLYEBb4o9UaZxgVkDb687JFwDBK3H3iZ5jr+V077SgAQxBOt
	524ihxdTfNi1lYB+smAi8IywKcQjcIZRVx6xIMHahopVNH/GeBjEd215NCLasQSo8KEjkdY7iGS
	6ZxDkHIhh4CP3O7AkNmgYxl/J4RNdgv2EYdgwwCvfXummIRFPE8UnuOn6xL4dWZae+2eHh36FA7
	k7jy0ti+FnOr9+90BrXWOkrRcur4/wtOIcoNpa6jPozGEUOomexCqI+UOIlzpUzN9AGS/K+yG62
	dbVZrzhF59zF+k23Y1fcF0iA0UoDH8cgmkeQe0P5wsFBoaQfWxIz2dBVb9Z7n+rsbcj7yDYTlv7
	dtdCeV9Xd05/sD3lUUqeX
X-Received: by 2002:a05:6102:2d04:b0:7a6:accf:72c1 with SMTP id
 ada2fe7eead31-7af19740319mr4949454137.0.1790621880968; Mon, 28 Sep 2026
 11:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928044513.1330392-1-morbo@google.com> <fb409745-856d-44c6-b9a9-387bb7499811@opensource.cirrus.com>
In-Reply-To: <fb409745-856d-44c6-b9a9-387bb7499811@opensource.cirrus.com>
From: Bill Wendling <morbo@google.com>
Date: Mon, 28 Sep 2026 11:57:44 -0700
X-Gm-Features: AclHuK_sC2R2kVmE83msZCKkzBaFLDE0QnCGPY-epZGSZc4zNKjrTMXfdmX0tnM
Message-ID: <CAGG=3QWAhuHptY1qGsMoP_s6rkBthx3nWadPmYQdjWRMcRCH=w@mail.gmail.com>
Subject: Re: [PATCH] firmware: cs_dsp: Annotate struct cs_dsp_coeff_ctl with __counted_by_ptr
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Simon Trimmer <simont@opensource.cirrus.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:51=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> On 28/09/2026 5:45 am, Bill Wendling wrote:
> > Annotate the 'cache' pointer member of 'struct cs_dsp_coeff_ctl' with
> > the '__counted_by_ptr' attribute. This allows the compiler and KASAN
> > to perform run-time bounds checking on accesses to the 'cache' buffer,
> > preventing potential out-of-bounds reads or writes.
> >
> > The 'cache' pointer points to a buffer of size 'len' bytes, allocated
> > to hold the cached value of a DSP coefficient control. The 'cache' and
> > 'len' are initialized in 'cs_dsp_create_control()'.
> >
> > Every subsequent access to 'ctl->cache' is strictly validated to
> Is that true?
> When I last looked at these __counted_by they were only checked by
> a subset of library functions (which was documented) so I was still
> able to write code that overran the buffer.
>
There are several flags that need to be specified when trying to
trigger an out-of-bounds error, like this:

  -fsanitize=3Darray-bounds,object-size,local-bounds

They should produce code to check each array access if the compiler
can determine that it's from a struct. E.g., Clang probably won't
generate the bounds checks if the field was passed into a function
that isn't inlined. GCC may have better luck with that.

-bw

> However, recent compilers might do more checking now.
>
> Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
