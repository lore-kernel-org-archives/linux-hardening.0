Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4242D9EC4
	for <linux-hardening@vger.kernel.org>; Sun,  8 Mar 2026 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773000586; cv=pass; b=pntsfvT8M05UmZppGXYOy9U+QO4+7SXDpKtxXplxKZKGvlG4BoTn4X1ehijcwsWAiNkjZqJrBCIYC40TOQc0evpVHb2UXmIG/jvBn7xfyRCKriTJaVxugVrGOQHY8wIO7n9W8McZ7P4F2JrT60XZMJOsFdkD/4kEkyfUSFF32II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773000586; c=relaxed/simple;
	bh=4A09aHx0OcSl3350jjdiiToLVF9TkB24Ro1o2DX9+EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdMjOboohOr4t47y1jS/fbHXrjC16sBeg0Cj9rcZ/Ct3TSs6T1sYKpiou35QNYXDNU3bVDMr+U9v3fN40maQx6KDs8Zc1KM0w2/BNd+i42chZNECVCYVU6XdWYLwKS/yTbzk8buJqDJQchhBmgHOsf5dxlJEXMHeEU0XdLTwKhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/uAk1WJ; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/uAk1WJ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b943a880577so238554766b.3
        for <linux-hardening@vger.kernel.org>; Sun, 08 Mar 2026 13:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773000583; cv=none;
        d=google.com; s=arc-20240605;
        b=l0s+Zmj+jIW7xdJKRGiH9GTAAJG3DD6nVk2opGozCDB2Qv4JgJOyIkQRD7UvA367bw
         OuOqguKsYucTl5/3f1VS46L2FBkn8x0pbdud3uV5r5mi5MfXdHZFRFLiqg6FUoIuibr4
         YcP26OLzAi4EzXsCCIJ/ymbQT/DNKasVj2JZhGh4r3WWdgLWh+KSP0xDAGMBtgyIeUsq
         3vBYQPCHE7ajjT1okWTIwir/47SCtVnnciibnhfJU+qovtthOmZwW1Wrw7xQV8aPtOu6
         Hiq9zzYOPmao3gawSUOS7e7lJdDLpyPF+E4s7Q7d1AW/wWeS5mbOYe0czk9dBRCJjlqW
         L1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Tycv5FoJZx2dSo/XFPLGOTYrMuBDHqvJ5rkTtVQiz4=;
        fh=jZXnNJpHBu2hxXOuA66VJ9Dr2TiuScf8DSd+Ca8ts90=;
        b=aqNKxsSEj+WNboQ/3YcTAJEmphvikF8jdiOgpYcwvhjz8uMqF3NbuJIy5PDs9BrqOP
         FpgERMr26VN3sc4RAYbRShrrvU4SCsOC/Ckb3+b/IlWCb+Uc9RiDJiDluS2f8zqMpZWl
         nCfeL8XW8Vyb1YdGUKvvDcHfF/7GzwDx8XaiqiD72QXO3Z4/t5A50XA17EOibcTBldkv
         yA/n4w6Y6Mkg3tbND/GJzTRonQtg+33/wezcHzzpcpKxtccKXts/pk1y4OcP9sQAUrxf
         nFNcphCRygW6obQexKRPO6Nat4uuCx1YTugjZg2picHlKh5QrgnlnVaNP+s12Hd6QSwH
         0Dmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773000583; x=1773605383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Tycv5FoJZx2dSo/XFPLGOTYrMuBDHqvJ5rkTtVQiz4=;
        b=a/uAk1WJb0SAhTHGpfh+oR7c1EEyPDb38PTTCjVlPg9kunbeVaYeX8DxlCxtU/tN6U
         KAxLu1ifNC0YwXduCRt/dAHtviXRfcG1oucvRLD+ArnvWAglGA44bGUmBrhkRtpq+zK/
         y4505qunb23l4mXly0AWf0uZ0cc5nw19moWQsLubSaY4KtKC1IdlJdCK4k3FTroDEdmv
         E1lHCPfjpW9ou5oupQd6MkcliUpjJZuiIS2gelYnHEusO22/m7hoE0iVQj3jAi9Ahn6A
         FDOUPxYnac8tvMZswrhIBMuh/E1E68lBkYhxGQ4YFC8Bnj6c5Fudv9lgQIqtoDtbb6N4
         MicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773000583; x=1773605383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Tycv5FoJZx2dSo/XFPLGOTYrMuBDHqvJ5rkTtVQiz4=;
        b=fo8lMVZZg8kYObNBf1F0wwGB/z0UtwJ3qVvFJONZZ4c9KaBSOn+wgyF3Fue62xNpZF
         9C8FIUe05Ph9tUm6yRIj6kacEmaLMp0auO95+NSeXfgZYOVDY1utWjf0HUKVKT7r3fmb
         xD6Hzeyhlt4U/bgKsp0Vh4QQU+VZlVpPTo1PdKE52aHHIcgQqB0lSziidfvZg2LT3JKI
         d2ghMchSuY0kx4HlULOFBMIyAJURQkdQ6ujjhDnJQisOy0oY/Kt7cLJHfIDQSof6ndx9
         f34NamPqxdCxg8l26cmQa3jr7F2moAKGhL76n0KGtPtfgOsMh5j2gHVG56YAg+U2cbVl
         gJHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtyDTpDi2RnIpJ9/R+PGSFyPcRiYx0RKYl7vgApyeyXoujgZ+Kip84JxNvyLpjAeExdd+4RUubu04Amn43MiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ4IRHU0PFMGFolXX+yEDLtnxZQlPiC91DystaKLCQ1TXPtBmi
	eBLP0HKSf4Tbm+aLMreG6dmn4non+/vvWNBGJ+EeKJJiGLMdkiTmh/z2A3e9NLrY7qlB8w8rWLh
	C3l9Wp3hk33Xo2QrvkcVo8N2GWnKHnhc=
X-Gm-Gg: ATEYQzw9K31xmXQ3PLVExGX/iPV2mDb8dopc3Rwg+SaDcgP9vVDmezgqDEWn0WHIoDy
	rUKa2XZZnKDD/5lxz+eI4GAT0LN06D0EcmHHypXojUWo/J0Fgd9SqJkWiv8czx1tnTLJUkicvOf
	iQzfvWt8bsw7KEhgjyXZICJFJbo2verHIjkvz6S7OIIr2S5N9ZqG48quDwO9nBeZ45piCLD+Fa/
	ylYa7XClob11KsJdBmM77QrL6hK6xNItxPyxi24MwFDBvqxZWmEpJY9mLeggmlnRSAzGMw+jye9
	C/1X+uc4gXlsZWmTatsX+07+e50jEDgq/7+Z044CAQ6MaCp7hozs6fItjct4SiYmTCBfa2F1mDR
	OIsQ8qFwPzH6nImlW
X-Received: by 2002:a17:907:7f87:b0:b96:eae4:e49 with SMTP id
 a640c23a62f3a-b96eae41258mr142013966b.6.1773000582790; Sun, 08 Mar 2026
 13:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308031957.90900-1-rosenp@gmail.com> <20260308155955.GQ12611@unreal>
In-Reply-To: <20260308155955.GQ12611@unreal>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 8 Mar 2026 13:09:31 -0700
X-Gm-Features: AaiRm51OTQiCpQ6fsleTOq7l6ej-X16rffbIJn9LEa0TMIE19Ts-Gq_TErXo2bk
Message-ID: <CAKxU2N_3dmBQPyD84GkyecxO=+5mQVVmSgY0jfGSugFtXvZ4UQ@mail.gmail.com>
Subject: Re: [PATCH] IB/hfi1: kzalloc to kzalloc_flex
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, linux-hardening@vger.kernel.org, 
	gustavoars@kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 9:00=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Sat, Mar 07, 2026 at 07:19:56PM -0800, Rosen Penev wrote:
> > Combine kzalloc and kcalloc with a flexible array member. Avoids having
> > to free separately.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/infiniband/hw/hfi1/user_exp_rcv.c | 10 +---------
> >  drivers/infiniband/hw/hfi1/user_exp_rcv.h |  2 +-
> >  2 files changed, 2 insertions(+), 10 deletions(-)
>
> This patch needs to be rebased to latest rdma-next, due to the conflict
> with already merged 94ff7c59cdfd ("RDMA: Complete k[z|m|c]alloc-to-k[z|m]=
alloc_obj conversion").
https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/=
?id=3D94ff7c59cdfd

Notice: this object is not reachable from any branch.

I'll take your word for it and rebase based on that.
>
> Thanks
