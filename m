Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F128B3E7
	for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765581499; cv=none; b=lFqto1UGTqjaXjF6tP5J+d8MgxwKiaSjkw9eN5wUu/BWfTXPPjCEf/cwRvE5x0K6Bi056pPs4VJAApc1SyDUwUmUwsiXlrPuc60eVx41KjdOcc7Fh83AxHJZpFR4UOz0CXpwA38xUOXw9PlDWM/BgZ2Vph3qv8ENwC3vvVAkPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765581499; c=relaxed/simple;
	bh=tKl/sVYKIc83LSrOCLSVo7s+3IH5y45pwC+1rYy0yJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJRN8Qj8KPhuezCWWU9O8RkxhzjFKRolo0wY4jQ3ugu9pbjEZTLEN0kehNGFIlVik79W3NY3PqwP6Lor4+YAgp0SKGzg91e+Gt0i8vNNeRoBc99hGVDtx/q1PvLOEGBvTBCl0BbEmd0V4EQzM1dREVD4Ix865I+RddpHX23GIWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fasheh.com; spf=none smtp.mailfrom=fasheh.com; dkim=pass (2048-bit key) header.d=fasheh.com header.i=@fasheh.com header.b=BVoyd36x; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fasheh.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fasheh.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fasheh.com header.i=@fasheh.com header.b="BVoyd36x"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee0ce50b95so14758991cf.0
        for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 15:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fasheh.com; s=google; t=1765581497; x=1766186297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKl/sVYKIc83LSrOCLSVo7s+3IH5y45pwC+1rYy0yJA=;
        b=BVoyd36xB6yGLztfYYfJdAVAXUVtl16vGXwfG5bUac5CNhZ0CNUBV3b02SQfAVR9LO
         Q01R3yBlKYoV3JurJAnfrhwnMx/9TqhqM9CSe7dBt2XhQ+Udee+6OXZaKpxVhiAeZTcC
         WIDNKIAmT6gnEmNyA27T6+tGCZuXBkFgm4prNgbwdL0t5GGS+jcxZHKBySqUf3K3INuN
         5PViJu57wGmO2g5OGmSzMmDRIt9kz0iLHPsQOX1AhnsLqmj+Yl2HKM1VVBp/lDJyxKjC
         8YbDVvz4z4o91VQU56WwJCcih5VOM0u4hPsK5PdKQSz2e/HXnD8vpHZ6qge+hwjLB1Hr
         Eqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765581497; x=1766186297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tKl/sVYKIc83LSrOCLSVo7s+3IH5y45pwC+1rYy0yJA=;
        b=QGoFVPxzU1RjXe2aV7iG3rrlv6V7XXTCrc4MJ/kGMqV/vWNo2kjvZ9/29uwvzJCjlx
         KiT6QktZVnODq9Ugw+1sVtL6S2id5tYbqhRMAvK4ByqgN7K/cLpfIqbMgdVyehWMgWHc
         TuatZsFJDCM2MBDN7ByIKvgfvrz/2nLImz36ui+0TizWlzH349RbHKeSMmQ+nrUUwXDe
         yLhtFTEk7x+DSBm8k5uMHt36KBKUS4M+Oi/g7nxAwLuL9/sXoWm9/q2gmXY3pXmtBWEI
         fpBmvtPzndAMxb6ipDolYrD6wOFbpo1kgC1Y0cLsruQC1xAqYUv6w+CcoR/3bIETIkaF
         gr1w==
X-Forwarded-Encrypted: i=1; AJvYcCVr0BsFPeQ6KHD6SWdPpfhckSa8hn4EUv7OdyU/HQWgWINUqnSLrMxm5Aqzt/pbNW+U2vgqsCYRXtQnRwIzMxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWVQcVFjqVf/1jwqRDCW0QbvsDlVYy1eSM5ydV55ADQTOLanei
	q74TNe6jcE+bj1UI+QxkBtLTOT6QVaqojLZEGZGQ3iLbCshJ5Rzx6pDE4DxTeC1UaGWMr5+SRZo
	uUP9vOD12eYslx8EsdfO4pnLkLNgct6Ad47oaz5Awzg==
X-Gm-Gg: AY/fxX4k1771xGEnHxcu6Ve8P3s0YTVeN5K5x4ql13p1WKqkcqcFcPJ7Zwc1BPrxaQ/
	vVQfQm+0Htl4ZJ5GTzPKdrurzlwcY3sglSvAgdkoAbNhFgqxZAZUNtR++W0ny/H/HOgcP3d0247
	PStHzag9Z7aAR0691f0C864OqgSLMKZWifx5CUrF0574JUkGOJS+mQ5rjn6XRMCEV8ldj8h9/N8
	I3hgMsuGhK+NElRq6XS1G5sH8jFlv1RyJS3C1uvE47eItyAZmjJKP/f9zhnrKk16DAB/EV8XjVT
	Q/9+mJqLH0e0SU0GwK1gZ8u1ttuz
X-Google-Smtp-Source: AGHT+IFPR02hNpJissvoKNCvcuwELE6c3P8Y7ZsWMkvd5nTd/A78pOB1xN8IBcCVCPPVHFBjx2uRhauo3zaIKWbrF2Q=
X-Received: by 2002:a05:622a:50f:b0:4ee:12e6:dc73 with SMTP id
 d75a77b69052e-4f1bfc359c5mr114046891cf.20.1765581497129; Fri, 12 Dec 2025
 15:18:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212190631.210139-1-swarajgaikwad1925@gmail.com>
In-Reply-To: <20251212190631.210139-1-swarajgaikwad1925@gmail.com>
From: Mark Fasheh <mark@fasheh.com>
Date: Fri, 12 Dec 2025 15:18:06 -0800
X-Gm-Features: AQt7F2r52sHuy_7XqniANYHfN44uoWN5JGv-1U7f2hMtbKAje0UXursg3mdf3Lc
Message-ID: <CAGe7X7nY5iFFNmV5VT5Mji-vknFgi-cGeJYn6U7z5HcnCr=mBA@mail.gmail.com>
Subject: Re: [PATCH] ocfs2: fix xattr array out-of-bounds in ocfs2_xa_remove_entry()
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Cc: Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)" <ocfs2-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, 
	syzbot+cf96bc82a588a27346a8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 5:36=E2=80=AFAM Swaraj Gaikwad
<swarajgaikwad1925@gmail.com> wrote:
>
> Syzkaller reported an out-of-bounds access in ocfs2_xa_remove_entry(),
> triggered when removing an xattr entry.
>
> The root cause is that the original code decrements xh_count in-place usi=
ng
> le16_add_cpu() before reading the updated count value into a local variab=
le.
> However, due to the way the entry removal logic interacts with the array =
bounds
> checking (enforced by __counted_by(xh_count)), the stale count during sub=
sequent
> operations leads to the out-of-bounds access during the removal process.
> This patch fixes the issue by reading the current count first, computing =
the
> decremented value locally, and then explicitly writing the updated count =
back to
> xh_count at the end of the function. This ensures the array bounds are co=
rrectly
> reflected throughout the entry removal without relying on in-place modifi=
cation
> timing.
>
> The fix has been tested by reproducing the syzkaller crash report, which =
no longer
> triggers after applying the patch.
>
> Reported-by: syzbot+cf96bc82a588a27346a8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com./bug?extid=3Dcf96bc82a588a27346a8
> Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>

Reviewed-by: Mark Fasheh <mark@fasheh.com>
