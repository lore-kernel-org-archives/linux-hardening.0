Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA8C1EEE0
	for <linux-hardening@vger.kernel.org>; Sun, 14 Jan 2024 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yqkrz5kD"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-595ac2b6c59so4485857eaf.2
        for <linux-hardening@vger.kernel.org>; Sat, 13 Jan 2024 19:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705204138; x=1705808938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fi83qxC7DN9Mrs6Lcn/FzkFtPxyAqAamlzctaT7s4iw=;
        b=Yqkrz5kDxiv7/zEltjfmZnF4yjdyjTHO5kBf6lFurdpZoic3jit7KTS9IPzHyeuPHE
         pRSNWfPJcTIsReLo8+e2Y/QNzJZmixySqYa0mISR80xLx0mnoFY34fstVtZ1aJuD9xkg
         B723f0RnZH1aiAru7vUAJfh2D1Q0Twx1ES2fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705204138; x=1705808938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fi83qxC7DN9Mrs6Lcn/FzkFtPxyAqAamlzctaT7s4iw=;
        b=xOQOUfn/MPGWlUe4mYpRNnY4x2ag0ZvJKpX4uAd+FGDzFgbFmsdTCvXM9v2ikAt4Q5
         swS+kBNtkNyszGwao5+WsfsXBq8UsCcUF8jt6dcqsckxW2Ar9zqew3vfkF2GDQUak2Mz
         5Eo0WS2SHW4DLqZ71z6YtLq4/GMvkgg6LElTShaY+VX4EFjXb02rNkPSJ7hD70nO2BNj
         lsnLOyB28M5fCMye499P+bij073+mvB6kXGfEpColqM01oTws7axRHVZmhxnc6EL86pD
         c1TaRHm+RcuLCGbpD8q9HWg5WfczKFvrE2xpvCc3SygXGHDG0/YWjpzpDsTW36SI7m7M
         PdaQ==
X-Gm-Message-State: AOJu0YyKGD42mklFFRwqYOG9lOK3hiemA0KkVdRgklOttFAk7NZBSCM2
	6NZqOKIXHiHMrP+oGNLjKhJjmROA4h2LqTcH16KwUoZPN/bk
X-Google-Smtp-Source: AGHT+IGxcLy79rvnuOyBki0wllFskUd2ajI6nO0d3k/tEM6ToEF/16NmjnxfE/jV0LwfK2aFzd7ESKdMigeTSVY4LKk=
X-Received: by 2002:a05:6870:5cca:b0:202:ffc8:c6bb with SMTP id
 et10-20020a0568705cca00b00202ffc8c6bbmr5841416oab.4.1705204138403; Sat, 13
 Jan 2024 19:48:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111234142.2944934-1-jeffxu@chromium.org> <20240111234142.2944934-3-jeffxu@chromium.org>
 <202401131146.F017DB5870@keescook>
In-Reply-To: <202401131146.F017DB5870@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Sat, 13 Jan 2024 19:48:46 -0800
Message-ID: <CABi2SkXrUm-oa7bZBxFGHdL6qknAeD0OkLio2vniJw=YgDXQaA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] mseal: add mseal syscall
To: Kees Cook <keescook@chromium.org>
Cc: rdunlap@infradead.org, akpm@linux-foundation.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 11:48=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Thu, Jan 11, 2024 at 11:41:39PM +0000, jeffxu@chromium.org wrote:
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index f5a97dec5169..345667583b03 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -30,6 +30,7 @@
> >  #include <linux/kasan.h>
> >  #include <linux/memremap.h>
> >  #include <linux/slab.h>
> > +#include <uapi/linux/mman.h>
>
> I think the arm64 build failure is from this include -- it's happening
> too early and some of the arm defines aren't available yet?
>
good point, I will try fixing it.
Thanks!
-Jeff

> -Kees
>
> --
> Kees Cook
