Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089935979
	for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 05:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764308157; cv=none; b=Yva4Siim8SAHR7YyfmWI60WohlR2BVvpQ4dENQ9uF6iybLG1+UM7JAF1NpV5+w2tZjQaJzbXG8RZPL5POQcAwOuIK+hmiUcxmtwtSTLijjpcdlQaJhxXFVeD1tNjyAvr2I3G3GiCMH9MMRMX5vabt1GuhkIFyKiyAtFunwHPKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764308157; c=relaxed/simple;
	bh=vs1yg4f34u5WJ1yPdJSEYZL0CSP4S2CFc9DmmbkR8AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIsvebAn8U2dvgiENwlhIKnD0p3edtRD9izZQPHC7x7VZE4lLD4oa7uHo6SUf1fp6NLEJ4mvViodWik1HcspHMpuoO/hehZDEM7o2PoixYnZO4PruRU/cRV7TbiJF2wV4G5yIcI95b1qIQJDpBrMStAg7p7vlA3Y4PfMknqR6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bdzH5s+C; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bdzH5s+C"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7277324204so255663866b.0
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 21:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764308154; x=1764912954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k+Eyw2ecIRLyY8mi8vSAM8Rof7rADC+bcj+32Ia5uSU=;
        b=bdzH5s+Crh1+0FjCihld4WXorBnEHZEG/hdNhq7nGXFGxQTfRgBz7a3PGUu199ivjl
         UA2uJzZ2D1ltaIaU6AuNfgMR/2EWQJqJAdGN0rsji5lM/Ti/uaCX4A2sAzpc5neDHYyh
         5ZjyDQDk0v+lVsraNLP8yNI9aDozW1S9V2JP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764308154; x=1764912954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+Eyw2ecIRLyY8mi8vSAM8Rof7rADC+bcj+32Ia5uSU=;
        b=Ci2udUaNU99IJUKOptz2C+WgDejgWQasqc2cw3vqQnOF9siIZBKl812a1RdRWiL+WW
         2Nk/D3maLEYB4VxVAnzC1+E5RXV8V0XBwUOi1UVvs1N4M26eSFzyo4xKafb6ameQUvhk
         l1hPWE/uyj0Py9/kIC5bpUIOWmwW9G9GQyOJ7mE0i7ZYrxUnIwqxZ5z6wbKdgQUWSAC8
         onGvOMjIMMmLEsu+TAVPxKNYeV9+VqAxufE9lh3EL6LVI71W0w1MafnS6G7zR8+mBomk
         7xSBhvSaDYRk0XgGuIfCCcRa1GcejzaUwuPfIJ5m6coiUmfEG5jERp0xgyw6z6yGb6k/
         HOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXVL/IuelEIrpJAChPdnGeK4arkWpN4q103pn5PosZlmb8bUSnhC0nJyNWSns0nzEFMo9FTwRNzWHg5NAqZyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEDBg7uaCmVXFAlJRU4PHjfYWdKnU0klY98bLw8W2qhazuRMZM
	MrKEj/19NZabaTFuXPePqDojR/Fm6FOKvqJobtnZRFZyvozUkVwxa1jCQYZlq0pMh0ZJVLxQJUV
	RmritfZ0=
X-Gm-Gg: ASbGnctmMffA57cXo7VibngGV1rpRsahb4gP8hVvJVdh3FdJaaju9K8GvNWRw/p2kS9
	ypQEqC/Ekx7NqTZxZ2oxM+xTirKCGiHl9WyFKE5dBhWeBCMAA8lgTLB9FPoiUs2HvY9loBCdmXS
	LHZpAuCpgqg2vJq/zky+krWL9uWr2jcNkZoBTof3RJE+A9TABot8DvMQtttJz+fcVKeChriaJe8
	tJeDk1W8TtO2FAyJY7Vuto376vSd/0iRmOjCDJfrWU6e7n32hta03I7c8ohB5buL2IJgbw4B/Ee
	khmWWrJLuLC13V1UrQ7OAvEqrnfeeRHx1LqDGOZ+U5owyZ1Vx5e2MLe/g06UXMEb8G6UKWHHx2C
	qrE9BtllWfZZaFPqXSNFTXHwznObf2KHyGb044aGw2oKQMFTqttt9ZfYK5CnV/WSHJYClgzuVOV
	L7rlkS75/b0Bh7A8UYQn4NVaXfjhKXCIv0WtSFAklFmO9leDDYBmPaDkRxz22S
X-Google-Smtp-Source: AGHT+IF8QxQeMtipkDpxwHVVWv4clZ37ttDRzBA4MXUZ/BwYM9+W9x+YKBSie4+AhHEvjwY0WRDaZQ==
X-Received: by 2002:a17:907:7f19:b0:b76:31e6:2ee1 with SMTP id a640c23a62f3a-b76c53c1714mr1530342566b.18.1764308153697;
        Thu, 27 Nov 2025 21:35:53 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a48c7bsm356077566b.64.2025.11.27.21.35.52
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 21:35:52 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so2209794a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 21:35:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX12ArOf9Jzlx4+jR3NSAFSfOdSFkVfg5jKtlfYXcilNQlqKFj5tFuM/FKL86yc3piOni/xz3OwVTNEA4jtdCQ=@vger.kernel.org
X-Received: by 2002:a05:6402:d0d:b0:641:9aac:e4a9 with SMTP id
 4fb4d7f45d1cf-645eb26ba61mr12717665a12.15.1764308151943; Thu, 27 Nov 2025
 21:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126145249.05b1770a@gandalf.local.home> <202511262356.6FE5084CB0@keescook>
 <20251127204342.05fc985e@robin> <6219BF5A-0EC3-4111-A329-D35244C9714A@kernel.org>
 <20251127222710.324357cf@robin>
In-Reply-To: <20251127222710.324357cf@robin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Nov 2025 21:35:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiF9-vf3zW8vXoFGk+bo0=dSoJMm_nmVzsTDCerZzhGaw@mail.gmail.com>
X-Gm-Features: AWmQ_blNfUK3d20i2UnAsBf0zzgIcxgwgDs5L_j02ELWuaSJF7VpIWmt1gr56Yk
Message-ID: <CAHk-=wiF9-vf3zW8vXoFGk+bo0=dSoJMm_nmVzsTDCerZzhGaw@mail.gmail.com>
Subject: Re: [PATCH] overflow: Introduce struct_offset() to get offset of member
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Nov 2025 at 19:27, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 27 Nov 2025 18:00:01 -0800
> Kees Cook <kees@kernel.org> wrote:
>
> > If you have an instance and not a pointer, just slap on a & :)
>
> :-p
>
> I guess that would work. Although it will kinda look a bit strange.
> At least to me.

It does look a tiny bit odd, and it's not always wonderful, but there
are advantages to conceptually passing in the pointer rather than the
actual instance.

The two main advantages are that

 (a) a pointer is *usually* what you have. Not always, no, but it's
the common thing in the kernel. We have a lot fewer cases of 'struct
on stack' than we have 'pointer to struct somewhere'.

but even more so:

 (b) unless the macro makes it very *very* obvious in the name that it
only looks at the *type* of the argument, dereferencing the pointer
can easily look absolutely horrendous.

We had an example of that (b) case recently [*] where the code looked like this:

        typeof(VAR) *__obj_ptr = NULL;
        ....__can_set_flex_counter(__obj_ptr->FAM, __count) ...

and note that combination of "NULL pointer" and "dereference that pointer".

The code was *correct*, because that '__can_set_flex_counter()' macro
in that case only looked at the *type* of the first argument, so the
dereference didn't "really" happen as an actual access to any memory
behind the pointer, but it doesn't make it really look any better. We
really don't want to have those kinds of visual patterns, it just
makes people go "WHAA?!??".

Now, with proper naming, you can make that obvious. You can make it
really clear that "this is looking just at the type of that argument,
not the value of the expression it is given".

But honestly, I think that "really clear" comes close to just having
to have that "__typeof__()" pattern.

Can people learn that a name like "struct_offset()" always just takes
the type of the first argument, and get used to patterns like that?
Sure. Absolutely. But I'm not sure we really want people to learn that
pattern if there are alternatives.

So I do think that the "struct_size()" syntax - which takes the
*pointer* to the object and then does "sizeof(*(p))" internally - is
the better syntax. Not just because we *do* typically have the pointer
as the variable we are trying to get the size of, but exactly because
we do not want it to visually look like a dereference of a pointer
that may not have a valid value yet.

Put another way: yes, it's slightly conceptually odd to pass in the
pointer in order to actually get the size (or offset of a member, in
your case) of the actual *instance*, but I think "slightly
conceptually odd" is a small price to pay to not it look more regular.

And yes, I obviously do realize that 'sizeof()' and 'offsetof' and
'__alignof__' all take the actual type, not the pointer to the type.
But they are very special operations in C, and we should not make
other operations act like them unless they have some very clear and
obvious clue.

For example, we do have 'struct_size_t()' that takes the actual type,
not the pointer to the type. It _only_ takes an explicit type, and
cannot even take an instance of an object (although we could *make* it
take an instance by adding a '__typeof__()' into that macro). But at
least the '_t' part hopefully makes that obvious, and even if we did
make it take an instance, you'd never use it on the above kind of
pointer without a valid value, because then you'd use the non-_t()
version.

So that 'xyz_t()' version then gets used for things where you
explicitly state the type, and it all looks fairly obvious, eg:

        len = struct_size_t(struct pid, numbers, level + 1);

doesn't get that "WHAA?!??!" kind of reaction.

[ And so I actually think it's good that it only takes an explicit
type - if you really have an instance, I think it's better to use just
"struct_size(&instance, ...)" even if we _could_ easily make syntax
like "struct_size_t(instance, ...)" work. ]

          Linus

[*] https://lore.kernel.org/all/CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com/
