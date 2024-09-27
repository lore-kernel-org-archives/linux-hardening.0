Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D38F15CD7A
	for <linux-hardening@vger.kernel.org>; Fri, 27 Sep 2024 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467464; cv=none; b=Fob+KneERsGihVne1BAOyo4IX6ldPrgnSX1Q1CAaQ3A280wfyozKreVzYQ5p5TG0IfpC8mdZYQChf/O5+ZFXTAbnMdlZDnbtGt2XLw667h9epxieNsxZYXQTynpg0sBXCc/lGcCpCSJ1QtIK0kh9meyXSuZqKJYcQzCYj5IUvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467464; c=relaxed/simple;
	bh=HnKC6MSKgHglh/TGJWlYxFLXbwHJpZmQilWuveifddM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhsNsTeqxH4zwmcJGsof58td67cZRo+NPDJ73AsykoLC2Q8wUVU9huF8aeyK77RZol6evnIoS5m4NrlWx7kzIPWvFs5xFyorJ7MRQdpEbnJkWV4ak7ww3bCx4K2BIOGjLc6ebUgXb+7xS1WqLlgMIL7A4ZJLcX+MznMB2ZEfSVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A++SYSB4; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A++SYSB4"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-710ddfb36aaso118923a34.1
        for <linux-hardening@vger.kernel.org>; Fri, 27 Sep 2024 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727467462; x=1728072262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnKC6MSKgHglh/TGJWlYxFLXbwHJpZmQilWuveifddM=;
        b=A++SYSB4OKOoTrTcCQAAQyTbZJbPWwDehczyQBlnPVd1Po/q3yDw6UUks4PEcsgnVv
         Q9pwhF1zdvS6Wo70UQQZftlCeWHxJvdUXwddmOuryu3bNo5Rv7583lUt3tYNspw96QwB
         efgf47ELoLSI3uihLLSeA37KQOzypH03yGCbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727467462; x=1728072262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnKC6MSKgHglh/TGJWlYxFLXbwHJpZmQilWuveifddM=;
        b=nNNnFFcndI9+6KogqXXK3MoVb73iSDSOCU/thdlzfliSmK0JDSh+6j9iPoiJZr8noj
         rj0IIE16ubodBOzWgZuL1VClD1mvHdX6zYisqwADIlRRoFmOzdoA4Rk4st4HlrgiUfL4
         PxXxIm/yd7iV/2BGDd6ahwnJikCcXdBh5B+K0bQIYOWBMinr+OPxzR3GLSlXylbywNJO
         atsj7DzkE3cywQ2pzDI1tpjPpXBKmpsyBBqdP14ldl/gw9yMsNu4XFp/IvgMppsxKX4E
         drPwvkqNnhY6tQQ+igeaT+V/wK6Pp7fvEorq7GxIgQp7dUMeZ0nXnnoQEOSSBqGS3sEq
         aXJg==
X-Forwarded-Encrypted: i=1; AJvYcCXuiqfjzURaL7wJsCIbgr19Y0OV/AMTfbH5BCLZQbXJHC4NEvaHSAxSJDn+3/34rvitgZ5+HJn8UlNdnWDA14I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2s6g0Tn53wcdY7bIbcJ6aQzhtP7I5K/pTM4BLEEMLW+d2b+uA
	8fSlNBijwJviEHyL7vGgtwPENkhgpW3R5k4LAIJc1R1JsYD/6lYpxHFGBp5JBdD9/Km0txYPgXt
	mT04N/HMNaHy5/uwaDKsJFMfvfG/we4lNcT5q
X-Google-Smtp-Source: AGHT+IHZij8h/Bs0zNvBV9/jGTKskpPZQUGEtjPMrU/0uvu017jdpSY+XqCoKWOHXIpzdPKmfa+LIn1fUkazfPsBer0=
X-Received: by 2002:a05:6870:7f0f:b0:27c:a414:c22d with SMTP id
 586e51a60fabf-28710bbb349mr1004525fac.11.1727467462492; Fri, 27 Sep 2024
 13:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927185211.729207-1-jeffxu@chromium.org> <20240927185211.729207-2-jeffxu@chromium.org>
 <20240927125853.60978e0697a317e7965a8d9c@linux-foundation.org>
In-Reply-To: <20240927125853.60978e0697a317e7965a8d9c@linux-foundation.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 27 Sep 2024 13:04:10 -0700
Message-ID: <CABi2SkUqT42Awtpty4vV=x9d-gHtHPveYg4KhBZPxVB4h5Z10g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mseal: update mseal.rst
To: Andrew Morton <akpm@linux-foundation.org>
Cc: keescook@chromium.org, corbet@lwn.net, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, pedro.falcato@gmail.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, enh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 12:58=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 27 Sep 2024 18:52:09 +0000 jeffxu@chromium.org wrote:
>
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Update doc after in-loop change: mprotect/madvise can have
> > partially updated and munmap is atomic.
>
> Fixes:what?
>
> I think 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with
> can_modify_vma")?
Yes.
We can add that fix tag if it is prefered.

>
>
