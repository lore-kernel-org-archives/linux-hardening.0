Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE66227387
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197309; cv=none; b=b9PXdNQr9cE6NmDwHYVCDSXrfv2dRVJiLlCRfXQdRfR5UKGDRWuOseEVmMCeZW225a5sENG61+rLiUmjKpmDPKJ28AK2YZ3cUiAt1PSPKzaLUsAcOOFt5+pIIKEIK34WqioDA7zjAEbd8MQwcmqbd6c1ZcjanhbG7FctLDAfOD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197309; c=relaxed/simple;
	bh=8dlsU4BSgea+jQl1c4v/WF9/raVOBoEHI3bZllwES5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJifiI4bF1mtXbBPPM0SsFSgFw169INw/2e6b2O7Lyvs0tDcT7cdcavPT+HfR8myzDpUiuqj2I6ekjGNXT7RLgXN/Yz0oTwszOMPT7maCOYcel9uYwmrU7YnJz0a2vIHS3Rc1nXepyWU36BED7WwI74Tj7PPHuqmO45l+cGmkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kECVH+6y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kECVH+6y"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43158124a54so1646535e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 13:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729197305; x=1729802105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dlsU4BSgea+jQl1c4v/WF9/raVOBoEHI3bZllwES5A=;
        b=kECVH+6yr6afFpXUs6MwqTx31F+MxNcZu3aZKx3+jXwc7ItPn6BMSpJiko4U5d1HWh
         fXHUCYBfbheTpnEiwVbGQLvvMs+bMfLfih2DU4MPlQdg3hRA882hZvH02MnPCosxKSSM
         7oHV/DnnnhxjbkRkVw3Mh9iJvGj2O6ogPrxKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729197305; x=1729802105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dlsU4BSgea+jQl1c4v/WF9/raVOBoEHI3bZllwES5A=;
        b=ets1mOUfMIPJVIQYI2ugW4mEkKIArBfz4mOBQj0PieoaIwQo1y3VB5Y5EefG3kZgAX
         Qw1fyVzE9OhqspQvVWr3ZUnTAEjz8ertFgTi8j52jghpGprHQ01oS45Y2SOlNtqzB3We
         i99IoyxIBZllcTfJeCpTXl+aqpTnZB4mRR6R76Vl1xwo9jgfykqpNTSHsR81wv/Ep/ut
         erdAqkhmTQs0cxTxqbzU4nvKLLkFyl14i23UZJLMfPxCHs7lEsFlmpJdCb18j3PvPe6f
         fspoI9GS1ZDka5kAa0qVZ38BwBQ6cKobIBD9KfPs/2aPlu4GptGGkLLyUYAAFWlXf5H5
         ms8g==
X-Forwarded-Encrypted: i=1; AJvYcCUzh6y8jsGXUKHmJPscqPFW0k86UH3ohMi+hvLRVUL9GcNmioiOsSKWKTwu/idYgvzn9/T2HUZNxszlxVUHQaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wBZYdpc+ThjCclMOSMwM6p8pY2Z4N4kdKjBicLmWU8RNiz6/
	U5UELr/9ReenvjxLXM5WLuQROm1xbCn3J+DIm3tkfEClnYA+WgcHoVuobPG0s06tUSC64mlIemP
	rHIpmekVavX6nIvyLSKZ04fuLIjOfs6ZXH6cI
X-Google-Smtp-Source: AGHT+IEnAVG6P37ZI7J79pIs6tetL7SrTTg3vZvZ52j79TfnZhM42LG6dLndso7dEGUcrk8ZVXHBhehUL0AgCVG4AME=
X-Received: by 2002:a05:600c:1c0d:b0:42c:ba6c:d9a7 with SMTP id
 5b1f17b1804b1-431585e5c5amr17495305e9.4.1729197305529; Thu, 17 Oct 2024
 13:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017005105.3047458-1-jeffxu@chromium.org> <20241017005105.3047458-2-jeffxu@chromium.org>
 <5svaztlptf4gs4sp6zyzycwjm2fnpd2xw3oirsls67sq7gq7wv@pwcktbixrzdo>
In-Reply-To: <5svaztlptf4gs4sp6zyzycwjm2fnpd2xw3oirsls67sq7gq7wv@pwcktbixrzdo>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 17 Oct 2024 13:34:53 -0700
Message-ID: <CABi2SkXwOkoFcUUx=aALWVqurKhns+JKZqm2EyRTbHtROK8SKg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mseal: Two fixes for madvise(MADV_DONTNEED) when sealed
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, deraadt@openbsd.org, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro

On Thu, Oct 17, 2024 at 12:37=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
>
> > For PROT_NONE mappings, the previous blocking of
> > madvise(MADV_DONTNEED) is unnecessary. As PROT_NONE already prohibits
> > memory access, madvise(MADV_DONTNEED) should be allowed to proceed in
> > order to free the page.
>
> I don't get it. Is there an actual use case for this?
>
Sealing should not over-blocking API that it can allow to pass without
security concern, this is a case in that principle.

There is a user case for this as well: to seal NX stack on android,
Android uses PROT_NONE/madvise to set up a guide page to prevent stack
run over boundary. So we need to let madvise to pass.

> > For file-backed, private, read-only memory mappings, we previously did
> > not block the madvise(MADV_DONTNEED). This was based on
> > the assumption that the memory's content, being file-backed, could be
> > retrieved from the file if accessed again. However, this assumption
> > failed to consider scenarios where a mapping is initially created as
> > read-write, modified, and subsequently changed to read-only. The newly
> > introduced VM_WASWRITE flag addresses this oversight.
>
> We *do not* need this. It's sufficient to just block discard operations o=
n read-only
> private mappings.
I think you meant blocking madvise(MADV_DONTNEED) on all read-only
private file-backed mappings.

I considered that option, but there is a use case for madvise on those
mappings that never get modified.

Apps can use that to free up RAM. e.g. Considering read-only .text
section, which never gets modified, madvise( MADV_DONTNEED) can free
up RAM when memory is in-stress, memory will be reclaimed from a
backed-file on next read access. Therefore we can't just block all
read-only private file-backed mapping, only those that really need to,
such as mapping changed from rw=3D>r (what you described)
