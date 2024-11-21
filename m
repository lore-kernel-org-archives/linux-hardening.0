Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0287155CBF;
	Thu, 21 Nov 2024 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732211313; cv=none; b=XD1LpsbeoMXOKHBcY9m6a8Qtnu/NO4HgJR450KRsl4uEBYevqk81uEiaiUwL7dZFPuERP73Hv2IVD8fQHXIpZK68Cupw2xNnRrRVDN8A669376SJ/+tJoNXRoQHZpvj+A/W+wCZgfy9CalgrGZVtFH8q6QOutUN96iWxiDKYaU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732211313; c=relaxed/simple;
	bh=2j+yGxBfMrlFHjJHbtMVDYgDj+tpJCC/bnrxR9QYfLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNjDs7kzL2drVyIB5oFDjAtccCe6enEPw3x80PJDCHrb9Rk/S3TkYEocOikVJL/Q8e+7lqoJJkU1QDNxsjt8yk+xEpDTClyuq+JoAfHULTDlY8k9rn6eGvxvwScHaF8fokNngvcQPdpmBHsrhY8f8drxWObRo+mdhXcXy6q0t8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfQZS86k; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfQZS86k"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9e44654ae3so183602166b.1;
        Thu, 21 Nov 2024 09:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732211310; x=1732816110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnv6l3zsa4uYp4FLTUryoOp7s4l9kVPgSsBQVrp4UN0=;
        b=AfQZS86kDcUinELz0BFzAItkSWYWS5JNSNdP/FZLUPkCKaKdMYK14K6fxCLxU0GoBm
         28kaWy3bw5AkQQWOtOrN8feBm+HN2gv1t7PEOdhRiVYBMxq4KN4Xa1qA9m/5Vb8G3X3z
         lGCiaRlfJHf87oTyk9wBZSIzubg90d4JV/B/34/bPz5gpfMZ3v92GdY0JjtLfEbpGWqB
         SyyjjI/ltHvm+074+ZIm7o6YFOqKyE89FcvVEJWqtDPlxtQGC2K8C18QriuQ+LwhwtIv
         Tsk+SfFIDiFzDQfhlvUcBarrh/kEmvFZpJbjBIrqN3To4g1VMraL3K29tRFp6Bs/2Khp
         7kLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732211310; x=1732816110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnv6l3zsa4uYp4FLTUryoOp7s4l9kVPgSsBQVrp4UN0=;
        b=uhAEkPhueUrwt3hT+K0+vORpLBCPeQcwMV4ANQ2fhpkmTAyeNlu3AAJjRLVEQ+dVXM
         Rpplw6AhJckwH08RTwZbkN9bZBUBxrHw3z7obENQIYEqqUfQpDybYH3fkgmwHwEyw0I8
         ra+5q+j13IB4zyxYEtgrdtBE+j4f1rdkYnaQpwSlidPJFP/oYJ7zgO0vDvSseMNrfWkv
         neH8eKv8lFKjUYcvPYwmjOPK0Rm5p7MK1sNjB/5Yp6c6S6Iu+6OWomPUPTcL/qiU04vm
         nc3kYKsw3I1N5BjjKtp8B7WvpO3cLsz3B+DqQNtg0Qxe56ycx1+KJIDnwWDbhZAZ9WBl
         ETlg==
X-Forwarded-Encrypted: i=1; AJvYcCVUsTrN9lhb81f7tqXC4rIlEHlZy8+W+e1+n7U9ZW4yhjKFtQhztqMspqQedmWYilBpjVbaHIiHUnch55xJ@vger.kernel.org, AJvYcCWtVK4CzOWXlz+SZcx9S9zGC0BG5a8hqt9AP7WsFX61YS1D2PRDDAUljpjRlYX0USscN5ZrlmHZG9u3SvYl3PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9G9oR1ozCF9gZiw7M7R+fuWacOfWFehHVHKt7hXfFy7FqzeJ9
	NZQpPWkOzVT6sj3zlYtX2mRIeyeqRHyxqOnnGVPdafRNMZGIzbUk477Vdl78KgRMnobp/Le4mUG
	aNVRWFL855q/tXrAp042hY6A/JwcOHmdUSzA=
X-Gm-Gg: ASbGncs1hZBQ1Mi+RKQCsJtCUZfb04c0etZGO0q8oWRpQiadGOcjH5iWjpaYOTlxQ97
	TNpASSpV5Bj6S18KeSqbVi926tkDBTRYg
X-Google-Smtp-Source: AGHT+IFIf76/m18OY4g7R3eEd4MmZoeaqRE4i/4+NasxdugQcUeImn0repBSl/Tiwsk+0tJruMOcKU366rRUjjCoD5k=
X-Received: by 2002:a17:906:3101:b0:a9a:dc3:c86e with SMTP id
 a640c23a62f3a-aa50990b1aamr6444766b.11.1732211309820; Thu, 21 Nov 2024
 09:48:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
 <20241119205529.3871048-2-bjohannesmeyer@gmail.com> <Zz2tzVqql2RMSFN4@infradead.org>
 <CAOZ5it2KXhBy0=ktgjAHMs8ut-Go2OXOt_vnWFiUBV7uBBH5HQ@mail.gmail.com> <Zz6_CFj-MiMk73Tm@infradead.org>
In-Reply-To: <Zz6_CFj-MiMk73Tm@infradead.org>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Thu, 21 Nov 2024 10:48:17 -0700
Message-ID: <CAOZ5it1H_bac-W7vptu5pAi=O6KhRWPCwLP8NgjD55+AyBvfwQ@mail.gmail.com>
Subject: Re: [RFC v2 1/2] dmapool: Move pool metadata into non-DMA memory
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Raphael Isemann <teemperor@gmail.com>, Cristiano Giuffrida <giuffrida@cs.vu.nl>, Herbert Bos <h.j.bos@vu.nl>, 
	Greg KH <gregkh@linuxfoundation.org>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 10:03=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> Indeed.  You'd probably need to split the linkage of the pages into
> a list of those that have free blocks and those that don't as a minimum.
>
> Can you share your current version?

Sure, I can share the current version, though fair warning---it=E2=80=99s
still quite messy.

FWIW, I wonder if the bitmap approach might be more suitable as a
separate RFC. AFAICT, the primary issue with the currently submitted
patches is their runtime overhead. I=E2=80=99ve proposed a way to address t=
his
in my recent response to [RFC v2 0/2]. Unfortunately, as I noted,
improving the memory overhead without worsening the runtime
performance is challenging---for example, removing the `next_block`
pointers would require iterating over all pages to find a free
`block`, which significantly impacts the runtime.

That said, how would you prefer I share my bitmap approach? Should I
submit it as a separate patch series or provide the patch directly in
this thread?

Thanks,

Brian Johannesmeyer
