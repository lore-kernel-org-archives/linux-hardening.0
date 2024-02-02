Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D41803D
	for <linux-hardening@vger.kernel.org>; Fri,  2 Feb 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906257; cv=none; b=BC3AU+yD54U63K7fi06j+oYAcZyBQM97V1s8jmv/MxcT5nqpXJmRGFyogwjpPJacHqiSuHdHt+opIJn9nVjJYBWh3bsCQ353KHhTFDDM6mjQ76YnWQd8tUVtjNnC3Ni2kiIXNbRMr9swU35e8r4HnZmcyBqw9BuoH/OkEa9hFEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906257; c=relaxed/simple;
	bh=7Mvu1Qvmq1BUG1gJYlb4UcjxOFlgOR8rt+Lqx6uTvnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sJzusS6McpXZ9NuWrX+oOc0oiASfpBH2jjdnX/Y2UqSfYHvC4Kfx98g5p2NNoYwiAwZl9mXy+VPkTQCXqz+AG8XpJehd3ov4/m5GWjNG7lUwl9L6T+vvsfE/wq3A6nrJNl88VK0TagTfOb/MyCC/uA7jblDp/J+OLzBCCq3hvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PoC6i469; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PoC6i469"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55790581457so3661344a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 02 Feb 2024 12:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706906253; x=1707511053; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+Lf+IboQG1dTAVnxNBjsFez85NCfDl/n19nRqwUon8=;
        b=PoC6i469OIuQt/o3zqLbSMHE+ADYX+xYPTJOqaH7nTyVYLETEcBaEdPOx9T6Pdhr4/
         Ho7ZsqRWRWKAVLFHv/Sgja071fYbpgM5LlD55dL9G80q8cC4CcUXg5xt1+nR4jRMlUYf
         uCiNSzdFOUQjU69VPvdVdJZh7nrnzYhHuOZp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906253; x=1707511053;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+Lf+IboQG1dTAVnxNBjsFez85NCfDl/n19nRqwUon8=;
        b=fXDtmX4CaYPev1w+u+JDbQ8ZNhVera1lu0Ow7X0ph/ygSy+oqOdktrVbSU+6AkykEG
         TyWMWLueCO9AJQ6ozrUiKm516h+I6qc5IFv4PA2ZVSC5LM0wp5gcy4CdgeEKUMQUPqDv
         89r4rycn8nv+WlVb3TB9YtaedGq9vQj00xyu+Cmxym9UA2UtVhUYVJrgz/ZQYX6LNsCR
         J5n3q0gjKnoq0meIdJD4xOEogaaakdpfhYBmTwiM5Rb5li5vX617JcXpQEJ7Ppojkn9Y
         TXSOzx3MzR1YxC7RulB0d21dMuve7WIZPn/MQyA8+DXx2BjG4/rPMNLmF3g6D6o6nVLw
         b72w==
X-Gm-Message-State: AOJu0YyXjr71dfxU1hGVWX+FQLuK0q0ksjEJg0OeTn31F04nEB8OskP3
	EEpcyqXHFLHtik51yOh+CmwT3eIYxQRP+dV6i4FDIqYNKtsQyhEyKkwNidud8juO+pkbQNmbTZh
	N3+RQnw==
X-Google-Smtp-Source: AGHT+IEG0BlKIdRhjE1KZjYCCOBAS4xpoEYbOZsq9b4E95nzb/6sbUt25dh+H/dhFZEhIrLc/7fn/w==
X-Received: by 2002:aa7:c3d1:0:b0:55f:e4b3:4b73 with SMTP id l17-20020aa7c3d1000000b0055fe4b34b73mr483052edr.39.1706906253369;
        Fri, 02 Feb 2024 12:37:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXOHlIRRfTdUYPW2Txf3g/HMq/Gf+wuOWyCOWcAaZCEEikaTY8cJBqDQV56kz6LVoH/CHHDwRLQ9yy1ES1Rv+iDlK+t2dKDUytvDtTf3fTr
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id 12-20020a0564021f4c00b0055d37af4d20sm1118230edz.74.2024.02.02.12.37.32
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 12:37:32 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fc654a56dso8947715e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 02 Feb 2024 12:37:32 -0800 (PST)
X-Received: by 2002:a2e:9081:0:b0:2d0:643c:c2aa with SMTP id
 l1-20020a2e9081000000b002d0643cc2aamr2137336ljg.20.1706906231031; Fri, 02 Feb
 2024 12:37:11 -0800 (PST)
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
 <20240202192137.6lupguvhtdt72rbr@revolver> <85714.1706902336@cvs.openbsd.org>
In-Reply-To: <85714.1706902336@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2024 12:36:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com>
Message-ID: <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 11:32, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> Unix system calls must be atomic.
>
> They either return an error, and that is a promise they made no changes.

That's actually not true, and never has been.

It's a good thing to aim for, but several errors means "some or all
may have been done".

EFAULT (for various system calls), ENOMEM and other errors are all
things that can happen after some of the system call has already been
done, and the rest failed.

There are lots of examples, but to pick one obvious VM example,
something like mlock() may well return an error after the area has
been successfully locked, but then the population of said pages failed
for some reason.

Of course, implementations can differ, and POSIX sometimes has insane
language that is actively incorrect.

Furthermore, the definition of "atomic" is unclear. For example, POSIX
claims that a "write()" system call is one atomic thing for regular
files, and some people think that means that you see all or nothing.
That's simply not true, and you'll see the write progress in various
indirect ways (look at intermediate file size with 'stat', look at
intermediate contents with 'mmap' etc etc).

So I agree that atomicity is something that people should always
*strive* for, but it's not some kind of final truth or absolute
requirement.

In the specific case of mseal(), I suspect there are very few reasons
ever *not* to be atomic, so in this particular context atomicity is
likely always something that should be guaranteed. But I just wanted
to point out that it's most definitely not a black-and-white issue in
the general case.

             Linus
