Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3559F39901A
	for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669586; cv=none; b=VMt6k70tb61rWrmzqusDDLGF2VzJfKC7LUoGDUeaU2Ycydq2t+dUgJKEjNS8RDCH+esTmSDCjKfhwXeb1CxRsW2sOnXvZghiDfGlyPtGj4llcnv9alvtS5F4cDcpJKgmHvKPK4kD8THwgsPuQAqgM7GqmiLu9KOkZ5RLU873xR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669586; c=relaxed/simple;
	bh=Fjb9fZZs1ZvFOQ4C9uQbO/1B6MRyMCO+ilDgqLwjVi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePzamLiVLi4gkl62pNwfQx/MZgkUKXQ7If5o8quAgDRvIWJ23T02lJIpBwmsD7V53oDut01I7bA1+79Whsyn/awdfAx0Ai0MrVvOFU5hL+1/jLungP2abOXifhE6ylFlKdgduo85jcnsphmSfBhPq975otEP3nuViSf/bBlKORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yn9DXagf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yn9DXagf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFA9C2BCB3
	for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 13:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773669586;
	bh=Fjb9fZZs1ZvFOQ4C9uQbO/1B6MRyMCO+ilDgqLwjVi0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yn9DXagfJsfs3laOSMQVRObFhFBDtyumJ3oCvC1NdJYPg6KRBMhhKe2oLxrosDllQ
	 4GKWWBDzGKb81HjA5jLfHovxY3hS2T82dC+3l4VzF7KwW+2EpLyIBhbGrZDlNEmqnm
	 d+Bg9s9nZzuC3kMFfz5toBfpjzyQe3bep6InWJ1FtWt31+JknwOZgr0p+ZwdpvBEeY
	 NAg3MrA5g6gF/fDpuHSOooHzQJp5/e36Z2EPkcHQigbUASnQmw6OZxeJPgu0DmNOu9
	 uuw0is/jOV5cRxsrgwWX3Q0dZ98tZL6BLpgLUnZmDutq3MHJF1nRoOcbvCFppeOUIJ
	 HTyGby6Uj7rZw==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ae222d978so4856847d50.1
        for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 06:59:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAvNGdCoNXF/kWFPWrz06Nxd/Lo6NV+LFim7IR8GwKZcJe/8v9ZAz5RdTasOKzocb6P4/hN/yYnPkKxrX9szg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxnNVJU7b3ojnYBoqh+cq0DUS5VpmdhguC5fE0rmcflVfTMfxj
	7uf+ivKU1trp2OyhKFQXxLge3vcGOScJGBU3LjqgTN/ywjeFtWEMMwHqiMb8oobhKTMBrTqcV62
	03qbP1Tb/p4JIhQ4Owub67crNj1uQOCc=
X-Received: by 2002:a05:690e:1c7:b0:63c:f5a6:f2ef with SMTP id
 956f58d0204a3-64e6307f5dcmr9995930d50.65.1773669585234; Mon, 16 Mar 2026
 06:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312193717.12221-1-rosenp@gmail.com>
In-Reply-To: <20260312193717.12221-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Mar 2026 14:59:34 +0100
X-Gmail-Original-Message-ID: <CAD++jLnRseLfMFq982ggXSYCrO-5xoxPD30eepGKY6-EEeuhLA@mail.gmail.com>
X-Gm-Features: AaiRm51aOzZzJaZ_mm2VdjhqhKeQ3AoEaq_JqIIJjrVjOdtyD03zXAXm1_l24VE
Message-ID: <CAD++jLnRseLfMFq982ggXSYCrO-5xoxPD30eepGKY6-EEeuhLA@mail.gmail.com>
Subject: Re: [PATCHv3] gpio: virtio: remove one kcalloc
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:VIRTIO GPIO DRIVER" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 8:37=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:

> A flexible array member can be used to combine allocations.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
