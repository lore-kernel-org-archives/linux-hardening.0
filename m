Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5EE2AE99;
	Sat, 12 Jul 2025 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353946; cv=none; b=dS3R1QJx5W6jxMEzR3ipNOxvFsW9qP2nuBipp8lirYRLccMFw1oPahsZuwnf6KkN/Wt4yPSBgQ3bNnQ7JxtkCb4JZZ5CWu/5jA0VBYG3Em1femhyB04VGjhWMEbYCx2QKa3dMeItuzZvg99ua2cJkkaojQdPWGkb1yu2yuUTlI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353946; c=relaxed/simple;
	bh=ULMT2RN2xocfDvDhwK1+Ve5ay3Krg/YRfI7ZYlsX1fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BytqPmN224KavfZneata8Ir4sqR4Iqe8q02pkSDRrLyVTWIB9uVm3xK8DHNnVeCcH8Ien/nxljSixJWHTqEpaqAAj+ntsG289tX6XbiNqTUlUOqJpfrzY1SZX894z2Q3+pTVmT6LeORvRYyIZK+q+jTulG+qgsgbfsHDxMR+tBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeFcjPOz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeFcjPOz"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so2661125a91.1;
        Sat, 12 Jul 2025 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752353944; x=1752958744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZuS0G5loQ6VTp2rtwXZCwwcpkBS4A9zfG+scNKGaJg=;
        b=LeFcjPOzMzaq/vOfsOZsrihqhh8NrlfbOcfHFB6IhVDkuVX57aKb6dLgDhji2ky1Vc
         tHcgc/5sqAkaG/NKBqfUdT5c4borg7iYQIYBFizJ5ykntX+GzYzSAViru+07lUfBgV6F
         cadyrtKSLcXT4XaLB3ZjmQtDnM16GMV1PpQDFt+uwHRNtCMT/52AvWHIHAQvI06y32NH
         nOyBXCcqd0x7iu55HxO0cEqt9A79Z2mOh0NuY/arcVESTy5AvUKdKaqSZmguGA6lZvOU
         7BcI5YDPthhhxWKv9COZO9H3ojhi8ElbFbFWyckDIRgEp9JfqnqCLLm9v1zOXaUwVJeg
         E+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752353944; x=1752958744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZuS0G5loQ6VTp2rtwXZCwwcpkBS4A9zfG+scNKGaJg=;
        b=dLXhxxsYysLznqY/wtGS8OGVGyH2+tFZeZu7v08bU+St5+TGVwSPTR9XeaD6yu/xah
         vW3l80267MxpG27jwRG/DoG1l5KP+FiFt5KM8FfXcdwjIljJE9s6Co/GLuIcu3cmBXSR
         MQ7p8yc5SezpA8mLgfCEQYDacWa+43MS5JPv/YYlFEZ6QdzKJdC/yrwGAgMn8uNnic8D
         Df7/RNea5qqqUtcgkZ8ghmmljsjsC0rqaYmAFEdekDaRcV09XoSwqpDKzS7PSBvMVI3y
         /5dS1ZgXjdbAQwkiTK6EEKo36FStVb9siuKZcIRrW/F//aklhDnTuI1sl/H3AGhli0Gr
         OYBw==
X-Forwarded-Encrypted: i=1; AJvYcCUm29b1KP4Dl5L1dun/gxmPtlIV6eNCJNY6uaf4u8FE+kMqY4V8vAw+tPjANdITmX4Mk75vjkwjB0HNc++1@vger.kernel.org, AJvYcCVTNqjbwoVgt/SRiEzMIrArSs6Bzl3IkSwmBUTg56zjI4T7mxExvs+uXE7dQN5Sx7JCHa1QstXeDKXkV2ZBlSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOY+XSyp7MNR167TDHBKQeR6vZVgRRPivMiUxloQm94b7It/6f
	r+NjD4uDy3STUw0inubS5R7vq3uVVMTb9p15luSAkNmEOD9n6c1MEpOeWU+g2bgjQMLsS22TS/w
	Nguv9ePhWPit0CPPOCsGx5tannAXoUoY=
X-Gm-Gg: ASbGnctm85rBFS5E+M+vBaPuh5lTOQ8KV+Po2AxyEHP5fu93sO54fQ7xeE1R1LJiAbZ
	6bW525Ejt/9qEUq5RpzwNfA6eyt6gh6GFdRNYOrZMz13Bu+8IgDMFUDHA4qUwkyyCGBLP4XBBBA
	IT9ptnzmGJtCl+Fw3veTMc7/hz0Ng4U4U/OkyPOAo9Qtyalv7Eiu2SUaf+nARAMaHw2zuyOInPF
	7zmgy/8Einpyo0v5EO11ZhNft/AzEnPy9q0W2WJgNZghWxq1V8=
X-Google-Smtp-Source: AGHT+IGWc/bsSjfCk72zM+sQY+wNB8gvwjDVcV29c75JkSwrzzUlbnd+fsKQQzCW9smTm3J6SKcCBpYHBPBehSjJtRw=
X-Received: by 2002:a17:90b:5804:b0:311:b005:93d4 with SMTP id
 98e67ed59e1d1-31c50e2c50dmr10076417a91.25.1752353944580; Sat, 12 Jul 2025
 13:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751862634.git.alx@kernel.org> <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
In-Reply-To: <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
From: Christopher Bazley <chris.bazley.wg14@gmail.com>
Date: Sat, 12 Jul 2025 21:58:53 +0100
X-Gm-Features: Ac12FXzabVR3CNZ1e6s3vvkMYX7Q2knC-RQiMrmuvB567KXzcfJDo2IIzUb977w
Message-ID: <CAEHU8x9UKFWjuE2JPd99CS7wY-x_0kE0k=K3rfYUCJ29uzOSOA@mail.gmail.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Chao Yu <chao.yu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Mon, Jul 7, 2025 at 8:17=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 6 Jul 2025 at 22:06, Alejandro Colomar <alx@kernel.org> wrote:
> >
> > -       p +=3D snprintf(p, ID_STR_LENGTH - (p - name), "%07u", s->size)=
;
> > +       p =3D seprintf(p, e, "%07u", s->size);
>
> I am *really* not a fan of introducing yet another random non-standard
> string function.
>
> This 'seprintf' thing really seems to be a completely made-up thing.
> Let's not go there. It just adds more confusion - it may be a simpler
> interface, but it's another cogniitive load thing, and honestly, that
> "beginning and end" interface is not great.
>
> I think we'd be better off with real "character buffer" interfaces,
> and they should be *named* that way, not be yet another "random
> character added to the printf family".

I was really interested to see this comment because I presented a
design for a standard character buffer interface, "strb_t", to WG14 in
summer of 2014. The latest published version of that paper is
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3306.pdf (very long)
and the slides (which cover most of the important points) are
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3276.pdf

I contacted you beforehand, for permission to include kasprintf and
kvasprintf in the 'prior art' section of my paper. At the time, you
gave me useful information about the history of those and related
functions. (As an aside, Alejandro has since written a proposal to
standardise a similar function named aprintf, which I support:
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3630.txt )

Going back to "strb_t", I did not bother you about it again because I
didn't anticipate it being used in kernel space, which has its own
interfaces for most things. I'd be interested to hear what you think
of it though. My intent was to make it impossible to abuse, insofar as
that is possible. That led me to make choices (such as use of an
incomplete struct type) that some might consider strange or
overengineered. I didn't see the point in trying to replace one set of
error-prone functions with another.

Alejandro has put a lot of thought into his proposed seprintf
function, but it still fundamentally relies on the programmer passing
the right arguments and it doesn't seem to extend the functionality of
snprintf in any way that I actually need.

For example, some of my goals for the character buffer interface were:

- A buffer should be specified using a single parameter.
- Impossible to accidentally shallow-copy a buffer instead of copying
a reference to it.
- No aspect of character consumption delegated to character producers, e.g.=
:
  * whether to insert or overwrite.
  * whether to prepend, insert or append.
  * whether to allocate extra storage, and how to do that.
- Minimize the effect of ignoring return values and not require
ubiquitous error-handling.
- Able to put strings directly into a buffer from any source.
- Allow diverse implementations (mostly to allow tailoring to
different platforms).

This small program demonstrates some of those ideas:
https://godbolt.org/z/66Gnre6dx
It uses my ugly hacked-together prototype.

Chris
