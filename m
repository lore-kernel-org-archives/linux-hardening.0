Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70912D285
	for <linux-hardening@vger.kernel.org>; Fri,  2 Feb 2024 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907436; cv=none; b=ZFys6Wzzarc0Mo+CLABIqkTZz5OI+sbUh0MTguHPGVga/R0e3w9umLPYc0p5c3cDr61uCp83dplin54ILRRRKO+ArZmQaUQJ9K9G6f9Qwkx5wBvCCEszyfj1/WFK7x1TrFxtg0puCWxg5qI/wxxgHyNTqgAvGSFcWHWMtvh0wPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907436; c=relaxed/simple;
	bh=8ocUjGK2oy01qiBgCNBpq+20kZmTzsOI10qpJvgvgtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nN4JS7UkMw77wXNl0jy/RutikrmUMaRebnvNqVN0ufYxFDdMtSTuyIlh9zFHjJsMPVOL7wK+R/TbJwAYis65djBtaF1zh31bs6CYBeQeBoaYrVtTR4wLCCv16ve9j4UVORpnyup1wP2hG8qj2Zo9PfQzVK0BtZa8Fte3ZObRZMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KACTs63E; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KACTs63E"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e1149c16d4so1035872a34.3
        for <linux-hardening@vger.kernel.org>; Fri, 02 Feb 2024 12:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706907432; x=1707512232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jd5iB2GW7u96qhDXLTaDLBHJW+CgTFsPG8xtoncLIv8=;
        b=KACTs63EtR/6LViJcdoyk8Wa0iQcMmiJlpSXahnHWJ8YGTWGJba7CB/Xa/BxDJgQqd
         ALMG2GCJR6HO3JhzBS3s9F6AiEOVher3pftcZXRr+paWn3veTNXcpEWkr0FXh8L6vLrl
         rNVPU5z+IbxFSEdq9sQsqEKAcE6aRJNfV8LrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907432; x=1707512232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jd5iB2GW7u96qhDXLTaDLBHJW+CgTFsPG8xtoncLIv8=;
        b=vMsYGfptbZY1a9dvdC/DDob0qqh8/fGEJa7a3zkd32hihyXzu274meowRX2xB6h15e
         kqwJ+SCJOJc/jx7ZS/AZ0WYOqdmH4L6e+WdoYPOgwkrEAn1IqHOqLAeP7dMH9RrOIHSI
         An/MqUi5JHu30WELPaRt3PhXBGKS//eXN28KID7f592WgmvhUcRAJQEI+2TQxUvOjWmM
         DtnbwMrNwNny30m01SGMWZvtGHBdEWvaIpvRD5Te23AJ1yKpgtfidfYiXQKrmFPybWTi
         M1rLik5OPhD3OTCbfVhOxa4jenyKlUOOxAoCOfg1hbRAmKc4+HH0Gt6OIqKA9MkpUd0N
         IUOQ==
X-Gm-Message-State: AOJu0YwJzzIxzzXsl6+VUYFwk7Kk1JnSoYdcCXyHGBIMmWrYPybuMDAT
	XfUiUfhF6rdbIchSXGhmVmsBf/8bsh+uUfJHcVUrXdL4Mxw3nnxDcYY7oaLnESFOSXNYMMhK2xO
	QlUATYz7xd91qszIGtxgczRBAEasOM/L/cpu1
X-Google-Smtp-Source: AGHT+IHD+GETF8yRafyaSp/X/xP7FsjAotm5fR7M2Zw0jtBAVo9XvmOEOv+rES1WAYdj2NtLbAOCDZfOEWCOvlbcyl4=
X-Received: by 2002:a05:6870:96a1:b0:218:d1d4:78a9 with SMTP id
 o33-20020a05687096a100b00218d1d478a9mr871537oaq.24.1706907432643; Fri, 02 Feb
 2024 12:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
 <20240202151345.kj4nhb5uog4aknsp@revolver> <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com>
 <20240202192137.6lupguvhtdt72rbr@revolver> <85714.1706902336@cvs.openbsd.org> <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com>
In-Reply-To: <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 2 Feb 2024 12:57:00 -0800
Message-ID: <CABi2SkXiRKBXQ76uygV1bEegH0UrCJJZqQLNgN=raxNSd_MdPg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, rdunlap@infradead.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 12:37=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 2 Feb 2024 at 11:32, Theo de Raadt <deraadt@openbsd.org> wrote:
> >
> > Unix system calls must be atomic.
> >
> > They either return an error, and that is a promise they made no changes=
.
>
> That's actually not true, and never has been.
>
> It's a good thing to aim for, but several errors means "some or all
> may have been done".
>
> EFAULT (for various system calls), ENOMEM and other errors are all
> things that can happen after some of the system call has already been
> done, and the rest failed.
>
> There are lots of examples, but to pick one obvious VM example,
> something like mlock() may well return an error after the area has
> been successfully locked, but then the population of said pages failed
> for some reason.
>
> Of course, implementations can differ, and POSIX sometimes has insane
> language that is actively incorrect.
>
> Furthermore, the definition of "atomic" is unclear. For example, POSIX
> claims that a "write()" system call is one atomic thing for regular
> files, and some people think that means that you see all or nothing.
> That's simply not true, and you'll see the write progress in various
> indirect ways (look at intermediate file size with 'stat', look at
> intermediate contents with 'mmap' etc etc).
>
> So I agree that atomicity is something that people should always
> *strive* for, but it's not some kind of final truth or absolute
> requirement.
>
> In the specific case of mseal(), I suspect there are very few reasons
> ever *not* to be atomic, so in this particular context atomicity is
> likely always something that should be guaranteed. But I just wanted
> to point out that it's most definitely not a black-and-white issue in
> the general case.
>
Thanks.
At least I got this part done right for mseal() :-)

-Jeff


>              Linus
>
