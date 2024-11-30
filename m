Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5311A072A
	for <linux-hardening@vger.kernel.org>; Sat, 30 Nov 2024 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732989780; cv=none; b=ju9YDh1k1DnvZ3caZQaKnGoWOYFtgly1h/FU5YHWhZ5vYkAC/QJU0zCklsYzIaTVC6fP2LM87xW1sGw0XlBrIiqcYShTZuzDeFsLEd6rC51lRHHzJrf3zzQ2Gm9Jtrn5uBPA3kZ4eo05kUpRLadGLePZlFp5yzVG/425JMqMT6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732989780; c=relaxed/simple;
	bh=5COwjKHdAiMaJwK/Hx+9BfwsgIdb3l+pVKvrV5yLzNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqMKAnp1egFZMEvDtKYo45oIdWbES9cygQIeKEYkdVXs62LrknAyGCKM7s68gAaE7VcDfEEtEKQheVpT5Qql05/W92ElzSzjaq3qLbtYFxD+qe6xIrig6/XQxs1/Yo/iXVYBZ7TmwG6JxnTv1e98sO72T7s/neIzaPOeACudKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QUbR5MoW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QUbR5MoW"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so545247366b.3
        for <linux-hardening@vger.kernel.org>; Sat, 30 Nov 2024 10:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732989777; x=1733594577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RbB2vuXpy4jWACIjXNfh0gThH+CYe3wsKjjW9mdP8c8=;
        b=QUbR5MoWd9pSEZLRhF3Z06FH3jDIa9Gb8GhLVCi2qZ1PWhCngSQQON9Qhd8oUdxuLn
         JIIqntu1/TfJWtq2pC197dvPFAELBauziBYIPOo4tprLJyr/BHcKM/UEWLh63y3eQU1Q
         QrFKW1dRKKNaq++MY4tRkrjlfoSEMnEScnJik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732989777; x=1733594577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbB2vuXpy4jWACIjXNfh0gThH+CYe3wsKjjW9mdP8c8=;
        b=A+2znscSyb7Du2LNzyaKwWu4YEmCK22o40Y0jMU/VoXZjfr9AQt+i9cYe9caWj0g4v
         7S1+C7VkP58Bd8PanuVY5+wC61NGNEiBivHM2pcIdJa/24OtA5/CzR4plP/i5qPXmG4O
         cGLV24lseTClgTsaVdcwUpxi2jWYq6SmxriMejTbQploVNChMxQv/gxR514D2llxKdQR
         BpqajHQp8o53UzK7qtZeb6TuMXkkDEU9XN5pgJ2ybSLu4T/MK+4G0DUw++VExgiPcy8j
         8NYXqHb8rl30GJjiHz/t5elQlSwywVMmLneNVetBMl4iOO00Ccr5O81iS4CRJQ+SLX7X
         cfRg==
X-Forwarded-Encrypted: i=1; AJvYcCWARf2YhVVsDVt5Ywt5iP0hj9dl8K8wAEKqZQiQjFwjWxTL6yOUQyWn8DlElUvAGoT35NaaX5HceN0j7ZzsBjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIR54+C4BjqCDwmonPXlGNDSPa2i7vks0l6lhuc99/zvqjr45
	OXK+dO3uIHYHwhCJyCjeEEat5/dpjuThC5w6cc5D59NtgwaozgdvybKqvnXLD42ctl9ol7EVl8z
	jgEh2Fw==
X-Gm-Gg: ASbGncsA8ZOKPZ07PFG1t4vciWldSPukMfhlaHugVf74tL/cTtmsURtQ8NlvbctMV6F
	QXXmHXXmC8/VydNDYHyPZ5gibe5ixIQt6mVGzXUTQHVOZGV9c2RDsFOyFr0Hh5v+rdqqLCZWTS7
	t29pMZMYbFeo6FjcgVIVMS1OmftmU6s59NYiQBqY/JCmQMiCTJTr13NxT6Y7hIigykIPJtHAY/k
	lNnp10azs6ni3x+YbivGKYVz+pzsSC5Zyq/quK+qnY1j6IqIjGtAkrNmMIM55FRRd8V5IZ4wixZ
	TLJRGGWDue0buMl8m3r88uPn
X-Google-Smtp-Source: AGHT+IHGxDXSYtwq2R/3jqvzBn/hXHCGdywjci+oYcRZxZPjqJWpGCTknGsB8t+IE4okaWcRLLX6Ew==
X-Received: by 2002:a17:906:1baa:b0:aa5:c3d3:3249 with SMTP id a640c23a62f3a-aa5c3d333b6mr170127666b.54.1732989777114;
        Sat, 30 Nov 2024 10:02:57 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599904e6csm300809966b.134.2024.11.30.10.02.54
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 10:02:54 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so521757966b.0
        for <linux-hardening@vger.kernel.org>; Sat, 30 Nov 2024 10:02:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1Y3KM72MxqqQ/dp02VxIOpRX7snXistiVfXVIBBPl6N01mWX4XTZUBT07qEWEafhDWxArMWmVNKmzwLal/bs=@vger.kernel.org
X-Received: by 2002:a17:906:1ba9:b0:aa5:cec:2785 with SMTP id
 a640c23a62f3a-aa580f50e22mr1700257566b.25.1732989774448; Sat, 30 Nov 2024
 10:02:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130045437.work.390-kees@kernel.org> <20241130-ohnegleichen-unweigerlich-ce3b8af0fa45@brauner>
In-Reply-To: <20241130-ohnegleichen-unweigerlich-ce3b8af0fa45@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2024 10:02:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=uOYxfCp+fDT0qoQnvTEb91T25thpZQYw1vkifNVvMQ@mail.gmail.com>
Message-ID: <CAHk-=wi=uOYxfCp+fDT0qoQnvTEb91T25thpZQYw1vkifNVvMQ@mail.gmail.com>
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH)
 case
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Tycho Andersen <tandersen@netflix.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 04:30, Christian Brauner <brauner@kernel.org> wrote:
>
> What does the smp_load_acquire() pair with?

I'm not sure we have them everywhere, but at least this one at dentry
creation time.

__d_alloc():
        /* Make sure we always see the terminating NUL character */
        smp_store_release(&dentry->d_name.name, dname); /* ^^^ */

so even at rename time, when we swap the d_name.name pointers
(*without* using a store-release at that time), both of the dentry
names had memory orderings before.

That said, looking at swap_name() at the non-"swap just the pointers"
case, there we do just "memcpy()" the name, and it would probably be
good to update the target d_name.name with a smp_store_release.

In practice, none of this ever matters. Anybody who uses the dentry
name without locking either doesn't care enough (like comm[]) or will
use the sequence number thing to serialize at a much higher level. So
the smp_load_acquire() could probably be a READ_ONCE(), and nobody
would ever see the difference.

            Linus
