Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306664595B;
	Thu, 21 Nov 2024 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732216072; cv=none; b=JepRJX9taJdQ30usrWVoE1yE1bxlfnPu6u+x3w2q9VawRLd7TpFFuxlwD99uduN8WoeJxjZ78eP9bx/eauLx6gVA+oj+QSaYAH9/Mn+C95oPm9g+M1zxSDReGkqlW/pJDgLkKLNMadt+DWXYLXxQ/j4NFFzTo01396L4UxWD9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732216072; c=relaxed/simple;
	bh=/d2+VVHaIsc9e1mxOzdZ7xoJ9mN0pQZ1sfrcN0FYsiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSIIhsjiXKExPOsnhsTkvI/7ZPiM5oRM6DmAjnyZEDJjsSVh5YYN5mOzEcn2SdfBrd6Gd2pxAj2ZNTO9v3Y5VEHBcB9lwP5Z8VR0uKIrOB177WENZ/M3p9vafZt/vivwN2jsNq6H7M0dcSxAHJRAbLvHXefVuRMJ6DIGapPsDQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVrmBAd0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVrmBAd0"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ec86a67feso230514666b.1;
        Thu, 21 Nov 2024 11:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732216069; x=1732820869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OFLbG/GNSVDQ8hLVIP7nasORNGr4F2pT8NcKMANcTg=;
        b=kVrmBAd061ZiuUOHuwcQX0lZ4XTRMakDETh3+JtBsb0FYLKpfj3NQbgE8rLhj7GKGc
         62Y2f+Zq+bLJmhsiFG5QT+g0R72Ff1Ie28wj5syAxB4ynuKa4ek4E6uWvzbBfG7+7pIt
         8lnckeEbV6ROYuTj+cGzcT66zFxL5hwMe0x6VmRTOFRzpsllxyD+83oLGU0BVZDdJf7Y
         ZPTy08VI7EYVBJ238mBe9d99xI8jDxdgfG9LG3iP0neDkXys9AKfR6lAz+MisCk3/Ol2
         BAASoltuyYwbTzQuYTKoUE75zF9q83n7RUny2Cer7qd2zBZ1TXJuZ/Xsh34SRuDvviJw
         6F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732216069; x=1732820869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OFLbG/GNSVDQ8hLVIP7nasORNGr4F2pT8NcKMANcTg=;
        b=L62+4QnZpAYr1VxwxTjCMW798oSTY9wAugbB0IjHybwkravEYB9wn37/YLvBK+rYYQ
         m+CycUpwTbCcPRyPzKWvRDyh+t/gC+qlYGXNF9VyB2vN8XGUep8KELz3rpwJ6RNoVX9I
         PrXL1gm/AoS5v5giawPO7cBEquZW4vNcuQ/WCYOBbHqcG2CccbYLDQ8ksRkY1KarJkcK
         Vcu9czcKw/X3Vx5zINqM9fAP30+BU2hHeGhfu8nzKslJqfRujZDfkwuFYQhmzVpk4UN3
         VgJ0B34fPol8VQXYq60gFx6rlIsyViJK/MyN36lHgx5xnnEoKR3un4pcbHZ5uW0p40UP
         4O5A==
X-Forwarded-Encrypted: i=1; AJvYcCWw2r44TZJgIvVqrB38blxiMRl19g2cc6QGBRYFUhvLEkrMw8YfRTuSwUVRhiP7bTWhW+vCmzlGkJDX8ymf@vger.kernel.org, AJvYcCXXYYv8jtS0oOQm+Q9/iXSje/wezYgHg7vYLeO6ZysI1awBUMlqUjxsKIUdJtczE7HRxJAz5EE1bS8w/XTwRn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMcUr4opN+GcgS4K80rJUFj66vnc8excFP6dRVVegEZVDB5rVp
	kDnTlRUo5razYrGLJwsnVurtOb6QtjWnFKu1hAgombPYNSx+mglhFDukwsrzoyxQYVD+qnFWQS4
	VxPVWmUcPhzdmVfbOKPlSSdXt+7I=
X-Gm-Gg: ASbGnct3XE5HoUWfhOLNHzSHN6xGpTmaZ89KETZAX8tx15HL7rTXdhtzXBAk2wZET5S
	7KkIV8w2EZeZgZlP/32mOIinpczHYkmP7
X-Google-Smtp-Source: AGHT+IHwL2oKd5Z4PJMHiT2EHcC1N94XnI9wGB1yGPBHyd5+/F2SPV0zcqrDbXyJqDQd8mxE0gciUKgsM4683iaTXq4=
X-Received: by 2002:a17:906:9ca:b0:aa1:dd58:aebc with SMTP id
 a640c23a62f3a-aa509bbfc31mr17333666b.39.1732216069286; Thu, 21 Nov 2024
 11:07:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
 <Zz2r73CFtfuRmjup@infradead.org> <Zz4vzSRcdjvWNIgK@kbusch-mbp>
 <CAOZ5it1v3zxiavxctm-d32bT9aO701Os1-EnEeG0KCUhBPLMnw@mail.gmail.com>
 <Zz6q85eMTko7P-Y3@kbusch-mbp> <CAOZ5it3xiMwD4_HsgXR_7-ERTzoS+FG3W5Og4sKtgthFA7HsVQ@mail.gmail.com>
 <Zz92l2gxYtK4SUC_@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Zz92l2gxYtK4SUC_@kbusch-mbp.dhcp.thefacebook.com>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Thu, 21 Nov 2024 12:07:36 -0700
Message-ID: <CAOZ5it0LKViPsOJrfLXmB-zk1OGWhKT6XMrj03etV-MA8-HOkQ@mail.gmail.com>
Subject: Re: [RFC v2 0/2] dmapool: Mitigate device-controllable mem. corruption
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Raphael Isemann <teemperor@gmail.com>, Cristiano Giuffrida <giuffrida@cs.vu.nl>, Herbert Bos <h.j.bos@vu.nl>, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 11:06=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
> If you have the time, could you compare with using xarray instead?

Sure. Good idea.

**With the submitted patches applied AND using an xarray for
vaddr-to-block translations:**
```
dmapool test: size:16   align:16   blocks:8192 time:37954
dmapool test: size:64   align:64   blocks:8192 time:40036
dmapool test: size:256  align:256  blocks:8192 time:41942
dmapool test: size:1024 align:1024 blocks:2048 time:10964
dmapool test: size:4096 align:4096 blocks:1024 time:6101
dmapool test: size:68   align:32   blocks:8192 time:41307
```

The xarray approach shows a slight improvement in performance compared
to the maple tree approach.

FWIW, I implemented the two with slightly different semantics:
- In the maple tree implementation, I saved the `block`'s entire
`vaddr` range, allowing any `vaddr` within the `block` to be passed to
`dma_pool_free()`.
- In the xarray implementation, I saved only the `block's` base
`vaddr`, requiring `dma_pool_free()` to be called with the exact
`vaddr` returned by `dma_pool_alloc()`. This aligns with the DMA pool
API documentation, which specifies that the `vaddr` returned by
`dma_pool_alloc()` should be passed to `dma_pool_free()`.

Let me know if you'd like further adjustments.

Thanks,

Brian Johannesmeyer
