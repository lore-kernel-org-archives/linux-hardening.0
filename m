Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8FE38BDA7
	for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943206; cv=pass; b=q0/xiFtB7PsIaKGRofbjDqcWhJeC4iZtOMbfRg04+LbD4z3tLdmABCDuyKom0lbvkne5WjmGueI79YUskRL5Cac8vZdd8uEiTY3fJvOgWJxHsvdlJCgIRVGnn8qCNhmhBLQyiTfTrS5a3mM/z+4KpSKaI6s75DasYv6bzbIb9UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943206; c=relaxed/simple;
	bh=uzTkHbmProOBNzb+9GyidfMWEO2EiRqUvgCYmYIuezM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKytPkg2NtzjCqaRlU4cq5beocl77M/qxiNbQwJc0nf/j2LDzZP/6UHWfgyXf98rpPR3DYi7j6Qm7xkW2qidh/3vlQZmJ7v+PF8YRuVBpTBTw8KT3kSNGus7RJFtjI4U7LxMDdP3lFJpt+IRm+amY6ZSKs6O2eKISJmchCl8H20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRP8WQz8; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRP8WQz8"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b86ed375d37so767714966b.3
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 13:06:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768943202; cv=none;
        d=google.com; s=arc-20240605;
        b=IQKdiK4VzV0YRi+w80y9OI6XQPSUSnfZ0OI2NNPLVGcYEmBZeaqejSy68P68/qDi9G
         3FuhoXG6fmz+VF7zwAoYJ5DcCLj6mKCS516rEc1wbqODd5WRoqmMjO9QjaHokW27bTW4
         XNX1cK4C9OSL8dFy2kq4zlTnDNGXPV8bZuXpO9UZKVpmSTCuJxm1i1raCJ4nXThpzdN3
         ar5TUoo/GztrL4K8brXLN+zORVOLLklgpPYvp9nBmmi18pbfzr+vQKJmkHJTGdnlg7XQ
         E5Zf/cE2rvUcJZvcLHS/2dyJqCnAVbNrtFrTac/uXUQ+2TkPRbcWTCfTLROWNuVtgzZg
         Pd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qm6uyV8c9i4IGocHzcVQAcu7s/WbazRCpwyhACW9O4Q=;
        fh=K5kKL/LtIa0Jatb/kV9KpZckHwtGjq59uSuQnUiNu00=;
        b=Rhd6v3edShHaRXlLtShAUqLMfz8sPH/5k+lfXJsbIhpiPLNm68Jj93dD5PlzJpAJW9
         L1CsOKHSmCSC+AjGXlwSRzvMaNz1P2bZaO2fBkKEuk+ibbvpRBzfBgJ6ztmcAmjj8Usw
         Uq4dZKO/1cghuNcLpAVrVk+FksLtdiWePdjnwQTeK2f0M93l3VLgeJRXUtyYvIswNqUm
         Q8Nn60LfIGeRnlSIoJk4w7RrjlmGXOZwa8BeZ+8qXUWx6qo/zN1baoRB+iPXya4jdJ1U
         DFSRUUUpQ7qocamEwkxf5ZMLH5Vj7HuhkLeVaZJVtY8zNFmKZPs8iP2tg+UOnMgI8//p
         MVbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768943202; x=1769548002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qm6uyV8c9i4IGocHzcVQAcu7s/WbazRCpwyhACW9O4Q=;
        b=IRP8WQz8M+nQL6s8TNHLSAx6Rc4BW5N/yViSgo+2QmuwNrktuO37Htt/LTcfJ1+eZ1
         PLtpIhf840kuczfbE6fNWCdjm4uckiPUq0Ck/3Oy6aQTK275nN2FbUOkWh3TWYQGmURK
         rX/jk14SbJWzfnIrZkCNAuEP9UUGdVDTHJOg64uHg4etb+LFm6AQpzywQb/OZ0j2l5it
         8+T4ZaeldJofQ/RbqMVBftrgQru0I2808VhV4Q6+qFk6xJKads3kXn8TIAmNauvOwto1
         3l2SV01ZNvM99dS759sA7cCVcP54IGIgVu9MNiBe5JV3qZaxxwe+suyfb+1YH7cKB/dc
         NS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768943202; x=1769548002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qm6uyV8c9i4IGocHzcVQAcu7s/WbazRCpwyhACW9O4Q=;
        b=OqOSbnFlUgJg9vuyfYcofQbTACA+yKypbuxxSbkx7MOY3SH+MSXIwSYMnJUCt+gcwS
         Te8r3P4inbzhtDzJtabyytaVWR/yAJX345iwcxYwX7e3hSQAWgRVXQCp65ZHfJNEa808
         kNRHz5AEMW9EVqg4FqyBAw0fDONkxG4QkRYsrT8TuE23F2lQuNoW4fHwKef935Dhh2xC
         CvslbaadbiczG3PwDOGffTvxo61IoiuEIbRbXiKpTtiYo0ZeMh59aQIGG0/1jF5tNRA9
         m0a9hFHzJFx5SAzm95zCntm7Um1nIt15RZa1EWxGveXHXISOuS8/2SKXcYmSQmKpyhps
         /cTg==
X-Forwarded-Encrypted: i=1; AJvYcCUU3h1rtSqHvMq1U3WXNMVktN3xYlYWjArwJ+AbUiNMQRi/AddcVh0Tb1AenbtOzn/0/H6+4rth6uuBvlrDliQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqiqhLCcVkAoCTgyxkMkX1fb2Hfw3iUS3vrhouGWLnsj6RTzRR
	OG+2ZbISN6pe51cawZ67+ZhwaRUY0EYY1XdHgVB0JxnWCtapK2t/bYEYwWtKCNRtnHQN/PtlZPo
	ixPlQ4cmd7pQ1dOst8n/ph8yt5iWyTA3nzea9xdU=
X-Gm-Gg: AZuq6aKUOdBWMFjSHRM9+uWq3alMU/Ay1bGa6jStTtLibhCD1jH6ytJObEoEYwSZsJh
	7TWH5j0iYUrXguToft8qtf4k7NXPTSZv3Xxqg+WnUl9+jmj/leYBgaCEz2V/NtO/5wXZ2mPIpOp
	Vpr9m4yMnCDAyr/+S4JZTTs9eMIIFEA9w2dWnqipi60CAqP+thyvc2iFufIX8qAxRGm2gUD/t52
	prq9kyq07EAoWgH1xdtWIW6mYcJ89WZRSpVAf5Uzs96r+wsaatqFzk+R9zofb3LUGkTYwIu5a+k
	SMlKAi0gGWDldeya9SQX7Q1IkNWJuhm4xXf+3i/ztvEVvsd93lceqfCKzIXs9A2OmfwAJc+q++h
	7pmc=
X-Received: by 2002:a17:907:9704:b0:b87:695f:d2a8 with SMTP id
 a640c23a62f3a-b88006deaafmr271902866b.55.1768943202102; Tue, 20 Jan 2026
 13:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121193957.1655580-1-morbo@google.com> <20251121193957.1655580-3-morbo@google.com>
 <202511211525.05CB7E1AEC@keescook> <20251122141614.80f1a845cd694b1b470107ca@linux-foundation.org>
 <20260116084259.GK830755@noisy.programming.kicks-ass.net>
In-Reply-To: <20260116084259.GK830755@noisy.programming.kicks-ass.net>
From: Bill Wendling <morbo@google.com>
Date: Tue, 20 Jan 2026 13:06:25 -0800
X-Gm-Features: AZwV_QjMxUUkSA0RIc2Md-zJtLCHQ4cc9T_bOZrlgL2_PJok5McD0hSVq7Vo6co
Message-ID: <CAGG=3QXU5vvgV70Kb8-KUF7f0sE7XOqnFBijVnazSN9gdgManQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] memblock: annotate struct memblock_type with __counted_by_ptr
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
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

On Fri, Jan 16, 2026 at 12:43=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
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
> There is:
>
>   https://clang.llvm.org/docs/BoundsSafety.html
>
After feedback and more consideration, I think this patch was
premature. I'm going to shelve it until we can submit an improved
version and the compilers can release the feature. :-)

-bw
