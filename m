Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7CFE571
	for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764015377; cv=none; b=An9MW69KRoixC+WAz4pCjVe06WgFKOkun4ZHzZrnHeZ/FQRINAL8n6AmtyFtzyOw7EdIKeqyUmo5kp8qpO1Na9nyGQZhhjQwcIpLeT51Gjb5QpSyJPagKirKfYGdhFKlS2thaRfWX7dpI1yQVxUOT6fMDYmnlR/n66PBi0pmLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764015377; c=relaxed/simple;
	bh=R4tPolCNS6+DjWLqZWJbOBpny9B2bt9yL0gYsMUMpqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UO8KDjXSrfgk6hwi4D06jAJmQLklur3WJqRKSUOZLasxDdmQz4+Bk4PBdR7OI95GzkXh0WJjIfRESnvUUZWnMGHy8RO4hTC/xU4FGwrPleSA65OLjVeI6QTX6MCiOOXFDcMViqLQHLYTExSgQmHKuUTHssvDTMpwG+xVOh5h/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEaU8gXQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEaU8gXQ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b725ead5800so601911866b.1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 12:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764015372; x=1764620172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z06KotmtsfB1UWZ1tUPQjTnpS7Gb0kLa+slh5Hjs72I=;
        b=LEaU8gXQe2VSme/BZ2quFaF5jcUNNBEJBVvqNmHUD1rPgw/96TbPAFYJAFKDF/V/n3
         kUwdE/Qtq9BBy5hQKFt9ZWWwdVJSfCnHC1ImEP5A4i9NzOeC82JZBj7F3OAjYAZdJFiq
         x2S1k9chJOegrbSMmV8AKjrJjgcguFYf3DcSu/ePtYZSGM3VFK5GJh03hTK49fbmB17V
         +t09AoL2m7+gEy8gm0gIG/M0CTioTe38CeIFc0MIikv3WD48TpRIl3kcIuYHVRqrbwxX
         hl7O4qHqo65FXVe7aGQCUnSV+wekKCqlYTpJwULDEw/gtcnLiN/UuJFoJnfsfDwbEA37
         ebug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764015372; x=1764620172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z06KotmtsfB1UWZ1tUPQjTnpS7Gb0kLa+slh5Hjs72I=;
        b=oo85UFL5CXUXhFSJdUSYnf41gRBXqBTg1gSa+DFuOZFi5M38KZtsdIqGyl8AXDfpiE
         rORdZhJ5KTbBi8bQpg71Q9aRKsLzyCoorgJzi8X9th+w5I6Xi25J2fWedRNlMUXRACbd
         iRllS3jb6Xt/0obPk6wJYFm6Xzq3HWHAnxfyvU2BjqttX6YE6HktubGMKBBHdwzjsQ/i
         AC8m9YDoYKzV8ZCHg8+rlFV+NnHtBS5IZPT99NYYqa3JMCO5tOMP17Nn96cIc5sB1boT
         Mx98+UHeMUkimH4kai33UdnXoCxAKywwR4SNl5Ig4y64uC+4Lf/tOy4sOEge9ladKplo
         pyAw==
X-Forwarded-Encrypted: i=1; AJvYcCVyFf66+KKemvdGQ6ojFtY4uOWVRqjN+uhMw6hWsGV2YBOroBBFD0p0hD0fnigf7VK7NUU+VQzqOl9oiIvBLhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+RAIFnmItCk0d40yH65D60iYfGxPP0RaeQviLJ2s73XDG7428
	eaMRKlec9eT3kwBKA2GJoSW3zvnQVFc5iYRB6vitIwj4est3wUE+lrH92UF6GzcUstx9oesganz
	xE/PdliazGT8SX2FNGw2LPyH/KO9Lmo2JOAIXH1o=
X-Gm-Gg: ASbGnctrPPjdh7mWXBJCj5yp7nsPajr0n28S2flGB1n38WdzgNWmcLYMLxL8Zvd7esp
	3a/s9NPs05cmTA08yKmNHPccITqF3SO8HXBzmjUDfN2WahkBDd3Wwo/go1H3k1CfsTkv2/EEtLe
	sorL/WeRPUhovETQ2NQ3MtNfCooyEyPx+H8bkeJErEkrX3W28n6FqGPGEjrN4voBv+iWJNitBzo
	zeeB8OCyjfKSWyVH1b7YwBwutAu0ZnNuhhDtTLkRTyBMBptYFLO22kxjOgGmUU7UxHCL7nxVAN6
	nFM=
X-Google-Smtp-Source: AGHT+IH8BTSWpESlDk+bVNYpCBTYerkjXtzYduYOQ1ee5rVed6iH0r8+tbGf7UdNFGD02PcNrfkSjNuIBLo4OJtxfSA=
X-Received: by 2002:a17:907:7e96:b0:b6d:7b77:ff33 with SMTP id
 a640c23a62f3a-b76c53c0a57mr10512666b.19.1764015372261; Mon, 24 Nov 2025
 12:16:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121193957.1655580-1-morbo@google.com> <20251121193957.1655580-3-morbo@google.com>
 <202511211525.05CB7E1AEC@keescook> <20251122141614.80f1a845cd694b1b470107ca@linux-foundation.org>
 <202511241117.CBE8ADC2@keescook>
In-Reply-To: <202511241117.CBE8ADC2@keescook>
From: Bill Wendling <morbo@google.com>
Date: Mon, 24 Nov 2025 12:15:54 -0800
X-Gm-Features: AWmQ_bmKteXP34og9YzGqC2nViwRnhBfRt6gIUL5VMXxuRtXI7wduxj48bhexM4
Message-ID: <CAGG=3QVwhA8yca4hQD1q7c6TgPL0dT5RODpdpBHSw2yuh1x7oQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] memblock: annotate struct memblock_type with __counted_by_ptr
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 11:19=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Sat, Nov 22, 2025 at 02:16:14PM -0800, Andrew Morton wrote:
> > On Fri, 21 Nov 2025 16:30:43 -0800 Kees Cook <kees@kernel.org> wrote:
> >
> > > On Fri, Nov 21, 2025 at 07:39:44PM +0000, Bill Wendling wrote:
> > > > Add the '__counted_by_ptr' attribute to the 'regions' field of 'str=
uct
> > > > memblock_type'. The 'regions' field is an array of 'struct
> > > > memblock_region' and its size is tracked by the 'max' field, which
> > > > represents the total number of allocated regions.
> > >
> > > As part of any counted_by annotation patch, there needs to be discuss=
ion
> > > in the commit log about how it's been shown to be a safe annotation
> > > to make. e.g. in this case, if all allocations of "regions" have a
> > > corresponding "max" assignment, etc. If just "git grep" can't find th=
em
> > > all, using something like Coccinelle or CodeQL to search for struct
> > > memblock_type::regions assignments can work.
> >
> > How is anyone to know these things?  I can't find anything about this
> > in include/ or Documentation/ or in the relevant commits.
> >
> > There should be a comment at the __counted_by() definition site, please=
.
> >
> > And possibly write a Documentation/ file then change checkpatch to
> > direct people to that file if they add a counted_by?
>
> This is a fair point, yes. The documentation and discussions around
> counted_by are very big in my mind (and for Bill), so it was mostly a
> consolidation/reminder and some extra detail on prior solutions, but
> for anyone new to that annotation, we should have collected common
> guidance. I will write something up.
>
Good point. I'll add documentation for these attributes both in
Documentation/ and at the macro site. The frustrating thing is that
we're likely to have at least one other macro flavor (something like
"__counted_by_expr"), though that's the only foreseeable one. All of
these macros are wrappers around the same attribute because of
compiler skew.

-bw
