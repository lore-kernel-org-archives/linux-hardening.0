Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9264430DEAC
	for <linux-hardening@vger.kernel.org>; Sun, 17 May 2026 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027289; cv=none; b=eLsMXHfTrmxJyiW0AGo2b9nC+5ioHEJoY1wpR+Kwfk6cQkSotvjoRgmGfoCKfT6eSmjpWdlZzs9yp14ZbnJtjmcxQokVZpO5qZSr6/d9iq0FnbK2nsKqeJMbyw0GkqV5Er76pYq5XJArouF9WesJZa3mWalXlo1tlaYrM66OHtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027289; c=relaxed/simple;
	bh=Mc2GSE058+zYJwzfLUNK+mG60GUfYotma1xSoBMmlf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZs/tWCtgbeeAmQ75kqoa9iw6EKFKpRvUaE7GzNW2fPccJQoMP5GSaW03tl5+HOOyHhMkBfhXSmaj8o496JRef0NXem2ROBh6/mzx4oR3D9vUfaK8X4jVm6y1ydYGFIoRVjPJPx82UnSf3NG+NKwOqRPo8zTc7TO0nu1G7Mrz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPtseJmh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPtseJmh"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so9164555e9.2
        for <linux-hardening@vger.kernel.org>; Sun, 17 May 2026 07:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779027287; x=1779632087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6Mpp6sTarqgUSSzKlFpcbBtlR8/lyFOiNv4FCUy/RI=;
        b=CPtseJmhXoSKrw6y4LUvqKPQRQaRGge67aR5N/dzMM/wlSUJ7xu7u33lcfTOcS7Pc0
         LujNCXW+I2CumJfYVTzjNrAooSfbD1imcxl4yBX2EEAPTZj/buL5m3hVlnXQFXVLK5RP
         pOEazda46UdGEt9IzpRcPSui+nq/VCI1xj9aOllHLofaGb51Z7UJQNnUaWZDVLGBLQ1+
         Vs/W4FOiX3fSfhQetqwxIeLxlqQXgydn5/aJ853dMbkp1MlQvVT8g6CiY0FBlhGicDQU
         epXEbkAJ58bi49ZJHCXnn1IZmjWMyW7PLMBy8RKHhOJjHDymsIfyvKmQ8XP+KtgpYxpO
         Lo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779027287; x=1779632087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6Mpp6sTarqgUSSzKlFpcbBtlR8/lyFOiNv4FCUy/RI=;
        b=sXTMdHuN2DAQ1WKps62tva2onylnV4sagJZuKeA+WOv75EpQxc8Q2wO7UZo5V4pOaT
         jOsxkq4+mz089hWDp7LPIWAN2vKXvy+MFp2AqYXqAC/9uYUomBouYRIDXdwL++mSAUsk
         CbqUppTuPOInh0/5kAHhmw4gpL2mkJCbErV7A3P5n3jQ4pNnyrMwt7YbZlmO+hHJTjW0
         MkreM8PDuRrakmGm0XK4L4u/KHRVEMV7qu4Vj7onnlttNVC4Kahwn77L5VY6iy8ETK/Y
         e+flMgGZ0MI9NMawht37RqrqGrNyHJ9iQOZ+Lt9cUP+Jo+CJm73hJYcuXbgJSdQ9OeXF
         Dkwg==
X-Forwarded-Encrypted: i=1; AFNElJ+X6AnXFwdeIeObDnbfknyTnHqkxftDWNnzySSGjYBw8kYJszqWyngYcLlHWa45mLcM58Hdald9LPdBOJW4Zsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO3xPZm8qsfjRQwyVONwjCjb8sMxZ4ecGYmKDYNULyEDLoGNBO
	dqFQmqQq+RbFCAS8FulNx2v5fnxYkl9D/jWkczitbBod9GNCseDPW/Er
X-Gm-Gg: Acq92OGjfOMRQLV47MdiFMvVX5L4nbax07eG1W4jdwewsHFw1enGvgin5xICAaXWbYH
	iMNMxOs1U/PZh0YbV3OcH7ywuCD56Xw7QZ6HcHSSMs8Y3zhUlsHKdUmIri7UFrFLBvI2BQiUO2+
	26L0d2PEuo9AlAME/srslqIR2gwgPuyVUQA8lSgP18Ahp7A7ZNCoZxdrvZKqxJiQkKN+xJLPCaK
	+bs1bwwww+Dw/jsrOrWcp1k1JDkEac+cZO5n7m3q866q4XyETkymzZJxxRROJfPwtoBAeRckyt0
	LmyDNV6Sg44b1/JXtcpdrSlokEkZ6UE6mn2tmrmtqLuEsfhXtL/GAq0ohFlr3laC4SC6UChP/rw
	WJVHLC5phCOVxbA8SOw/iJsyyUaZbiYsQ6HoNow/+O4XV4AV3bbCtSVWenSVFiswBjS9g6jldiI
	/829lvfl4fWzoCvyAnmpIqSmq3n8z2plhVRVYsdII97O1/kKIpQEYY9jJzMY8xAt8q
X-Received: by 2002:a05:600c:1389:b0:48f:fe2a:107c with SMTP id 5b1f17b1804b1-49001285b87mr50821125e9.6.1779027286837;
        Sun, 17 May 2026 07:14:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5cab882sm197265945e9.13.2026.05.17.07.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:14:46 -0700 (PDT)
Date: Sun, 17 May 2026 15:14:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, Andy Shevchenko
 <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] string: use min in sized_strscpy
Message-ID: <20260517151444.66dc4afb@pumpkin>
In-Reply-To: <agc3DrODtyc2rF27@linux.dev>
References: <20260514165601.527883-3-thorsten.blum@linux.dev>
	<CAHp75VfQNkqEYsO4Uup0c-uiYuVyAWit=tmCz2BsYLp-sjXsZw@mail.gmail.com>
	<agc3DrODtyc2rF27@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 17:09:02 +0200
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> On Fri, May 15, 2026 at 09:45:08AM +0300, Andy Shevchenko wrote:
.
> How about adding
> 
> #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
> #define bytes_to_page_end(p)	(PAGE_SIZE - offset_in_page(p))
> 
> to a new header, e.g. include/linux/page_helpers.h? There are about 50+
> direct replacements and possibly more.
> 

Why not put them in vdso/page.h just after PAGE_MASK.

-- David
