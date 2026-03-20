Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF31378808
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774013301; cv=none; b=cVKpNSKfkR00JC1qA6+NiJQ2ozZsVfz4huNqDbmOWv9mUPycOU9h+YGmG7G0N3PjjKza6c89IEFykPg9dcoeYDWt34myPt6yJbjQnOt0GTUpN3DP1mcYfw4qNKTFUWOoaLNkTs5cD8uKoP2Y+r+mqRpqHyRPuU9U2WdyGmMskes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774013301; c=relaxed/simple;
	bh=YzKXzVaGS/2OIloKcqNaAOwJYnHhATebfduv4sAgUHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZP1E3wwnycGYsZc6Z+9Gw+8xpVYvPf5j/RmGqpq0JcwmzsgKa6ZGwHx7xWTPLhjzbzAh5Jdz8ijlsEuSQ+AkzZFknaB0DLV3PowlFObgqBqJ/a5WBoAJ8tHiHLczxbQF1q1v3U+HtUA1zqUcD9aKdIT3h3rXdON/m6dcsVhWVvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcM9EJl8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcM9EJl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3072C4AF0C
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774013301;
	bh=YzKXzVaGS/2OIloKcqNaAOwJYnHhATebfduv4sAgUHI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qcM9EJl8N/8p9eiTm2vrmTrGsCaY5bdF66SqBs5nF+mB2rt+7Zl9vRUVvtFhtjqlW
	 TJv8Ykr9Fm5S2NBHuRtyR6fjt8LyrCawuX7SHTL/Z5RZ4rmKEUL3evrL++Oec3d7S5
	 M27iRP9UGfYhJ/5EAuLtYXHfmezBryL9rbZVXGW09tGXsaFVP0hw7BIeWHKsdqef6h
	 2taqYSZUySHykKLTFTD7LDlSeDlCyHZ6QyJb5fzP67VsT39IF9LLYNijnNitiqM+e8
	 WLCuQDbfK2ajIpFQg9t9mkNWhlgE7Z0eDLzryV6uZlQiCVByAXCCG741Fr84D/CgGk
	 ORrXZhvQ5FmJA==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79a46260385so20864817b3.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 06:28:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWaKCPDAorZUnjUtRUkXfpLq5jaEZLuZ/xLhGsHIylbEAWe4W/XG2mdqKS//M4XaY6zNj88RlTUxDKB/h+CtYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUtkMzMhWyK5J6q4WOCE28T2Mb7obo615PkR5OeXYzv3BVRrrE
	zkNovVnrB8scQ6qTMUVy054C4sGEawSRuf12UHDs1XwOnE5EimDy3JgjP0z4yjrD0U5u+8b18VR
	8o6a61HtwoKdfSiA/gtEkugioULPRnBw=
X-Received: by 2002:a05:690c:60c7:b0:798:138c:76de with SMTP id
 00721157ae682-79a90c0a1f1mr28204277b3.41.1774013300401; Fri, 20 Mar 2026
 06:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319000558.22108-1-rosenp@gmail.com>
In-Reply-To: <20260319000558.22108-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 20 Mar 2026 14:28:09 +0100
X-Gmail-Original-Message-ID: <CAD++jL=ELqj0Cvd6WBG_UvAOt7+Y0xUPpc7qPEGS-0Dm2upYgA@mail.gmail.com>
X-Gm-Features: AaiRm50ZafYOElWf5QgG_Wj2xMz2THbMMPVrJQETvNw6UshnM47uBG2-F_YKets
Message-ID: <CAD++jL=ELqj0Cvd6WBG_UvAOt7+Y0xUPpc7qPEGS-0Dm2upYgA@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: allocate lines with main struct
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Bamvor Jian Zhang <bamv2005@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 1:06=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> Remove no longer needed kcalloc to simplify allocation.
>
> Added __counted_by along with a counting variable to get extra runtime
> analysis.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sweet!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
